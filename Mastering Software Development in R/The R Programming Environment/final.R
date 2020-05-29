db <- read_csv("daily_SPEC_2014.csv.bz2")

mean(db$`Arithmetic Mean`[db$`State Name` == "Wisconsin" & db$`Parameter Name` == "Bromine PM2.5 LC"], na.rm = TRUE)

q1 <- db %>%
  select(`State Name`, `Arithmetic Mean`, `Parameter Name`) %>%
  filter(`State Name` == "Wisconsin" & `Parameter Name` == "Bromine PM2.5 LC") %>%
  summarize(m = mean(`Arithmetic Mean`,na.rm = TRUE))

chems <- c("EC2 PM2.5 LC", "Sodium PM2.5 LC", "OC CSN Unadjusted PM2.5 LC TOT", "Sulfur PM2.5 LC")

q2 <- db %>%
  select(`State Name`, `Arithmetic Mean`, `Parameter Name`) %>%
  filter(`Parameter Name` %in% chems) %>%
  group_by(`Parameter Name`) %>%
  summarize(m = mean(`Arithmetic Mean`,na.rm = TRUE)) %>%
  arrange(desc(m))

q3 <- db %>%
  select(`State Code`, `County Code`, `Site Num`, `Arithmetic Mean`, `Parameter Name`) %>%
  filter(`Parameter Name` == "Sulfate PM2.5 LC") %>%
  group_by(`State Code`, `County Code`, `Site Num`) %>%
  summarize(m = mean(`Arithmetic Mean`,na.rm = TRUE)) %>%
  arrange(desc(m)) %>%
  head(3)

q4_state = c("California", "Arizona")

q4_1 <- db %>%
  select(`State Name`, `Arithmetic Mean`, `Parameter Name`) %>%
  filter(`State Name` == q4_state[1] & `Parameter Name` == "EC PM2.5 LC TOR") %>%
  summarize(m = mean(`Arithmetic Mean`,na.rm = TRUE))

q4_2 <- db %>%
  select(`State Name`, `Arithmetic Mean`, `Parameter Name`) %>%
  filter(`State Name` == q4_state[2] & `Parameter Name` == "EC PM2.5 LC TOR") %>%
  summarize(m = mean(`Arithmetic Mean`,na.rm = TRUE))

abs(q4_1 - q4_2)

q5 <- db %>%
  select(Longitude, `Arithmetic Mean`, `Parameter Name`) %>%
  filter(Longitude < -100 & `Parameter Name` == "OC PM2.5 LC TOR") %>%
  summarize(m = median(`Arithmetic Mean`,na.rm = TRUE))

sites <- read_excel("aqs_sites.xlsx")

q6 <- sites %>%
  select(`Land Use`, `Location Setting`) %>%
  filter(`Land Use` == "RESIDENTIAL" & `Location Setting` == "SUBURBAN") %>%
  summarize(num = n())

q7 <- db %>%
  select(Longitude, Latitude, `Site Num`, `Arithmetic Mean`, `Parameter Name`) %>%
  filter(Longitude >= -100 & `Parameter Name` == "EC PM2.5 LC TOR") %>%
  mutate(`Site Num` = as.numeric(`Site Num`)) %>%
  rename(`Site Number` = `Site Num`) %>%
  inner_join(sites, by = c("Longitude", "Latitude", "Site Number")) %>%
  filter(`Land Use` == "RESIDENTIAL" & `Location Setting` == "SUBURBAN") %>%
  summarize(m = median(`Arithmetic Mean`,na.rm = TRUE))

q8 <- db %>%
  select(Longitude, Latitude, `Site Num`, `Arithmetic Mean`, `Parameter Name`, `Date Local`) %>%
  filter(`Parameter Name` == "Sulfate PM2.5 LC") %>%
  mutate(`Site Num` = as.numeric(`Site Num`)) %>%
  rename(`Site Number` = `Site Num`) %>%
  inner_join(sites, by = c("Longitude", "Latitude", "Site Number")) %>%
  filter(`Land Use` == "COMMERCIAL") %>%
  mutate(month = months(`Date Local`)) %>%
  group_by(month) %>%
  summarize(m = mean(`Arithmetic Mean`,na.rm = TRUE)) %>%
  arrange(desc(m)) %>%
  head(3)

c_q9 <- c("Sulfate PM2.5 LC", "Total Nitrate PM2.5 LC")

q9 <- db %>%
  select(`State Code`, `County Code`, `Site Num`, `Arithmetic Mean`, `Parameter Name`, `Date Local`) %>%
  filter(`State Code` == "06" 
         & `County Code` == "065" 
         & `Site Num` == "8001"
         & `Parameter Name` %in% c_q9) %>%
  group_by(`Date Local`, `Parameter Name`) %>%
  summarize(m = mean(`Arithmetic Mean`,na.rm = TRUE)) %>%
  group_by(`Date Local`) %>%
  summarize(s = sum(m)) %>%
  filter(s > 10) %>%
  summarize(n = n())

c_q10 <- c("Sulfate PM2.5 LC", "Total Nitrate PM2.5 LC")

q10 <- db %>%
  select(`State Code`, `County Code`, `Site Num`, `Arithmetic Mean`, `Parameter Name`, `Date Local`) %>%
  filter(`Parameter Name` %in% c_q10) %>%
  group_by(`State Code`, `County Code`, `Site Num`, `Date Local`, `Parameter Name`) %>%
  summarize(m = mean(`Arithmetic Mean`,na.rm = TRUE))
q10_s <- q10 %>%
  filter(`Parameter Name` == c_q10[1])
q10_t <- q10 %>%
  filter(`Parameter Name` == c_q10[2])
q10_c <- q10_s %>%
  full_join(q10_t, by = c("State Code", "County Code", "Site Num", "Date Local")) %>%
  group_by(`State Code`, `County Code`, `Site Num`) %>%
  summarise(r = cor(m.x, m.y)) %>%
  arrange(desc(r)) %>%
  head(3)
  