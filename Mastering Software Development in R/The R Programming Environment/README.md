# Setup

install.packages("swirl") // in lecture notes, should change "installed" to "install"
library(swirl)
install_course("The R Programming Environment")
swirl()

# Programming

## Basic

- Assignment: <-

## Objects

### Atomic class
- Character
- Numeric (real numbers)
  - Integer: append L at the end
  - Inf
  -	NaN: not a number
- Integer
-	Complex
-	Logical (True/False)

###Type
- Vector
  - similar to array in Java, can only contain objects of the same class
- Matrices
	- vectors with a dimension attribute.
  
					m <- matrix(nrow = 2, ncol = 3) 
					m
					     [,1] [,2] [,3]
					[1,]   NA   NA   NA
					[2,]   NA   NA   NA
					dim(m)
					[1] 2 3
					attributes(m)
					$dim
					[1] 2 3
          
  - Column-wise
  
					m <- matrix(1:6, nrow = 2, ncol = 3) 
					m
					     [,1] [,2] [,3]
					[1,]    1    3    5
					[2,]    2    4    6
          
  - Add dimension attribute
  
					dim(nrow, ncol) for m <- a:b
          
  - Outjoin: cbind() and rbind()
  
					x <- 1:3
					y <- 10:12
					cbind(x, y)
					     x  y
					[1,] 1 10
					[2,] 2 11
					[3,] 3 12
					rbind(x, y) 
					  [,1] [,2] [,3]
					x    1    2    3
					y   10   11   12
          
- List

Compared to vector, can contain different objects [[1]], [[2]]…
			
- Data frame

	Compared to matrices,  can store different classes of objects in each column
  
				row.names
					x <- data.frame(foo = 1:4, bar = c(T, T, F, F)) 
					x
					  foo   bar
					1   1  TRUE
					2   2  TRUE
					3   3 FALSE
					4   4 FALSE
					nrow(x)
					[1] 4
					ncol(x)
					[1] 2
          
## Function

### c()

Create vectors of objects by concatenating things together
      
### vector() 
			
- Initialize vector sample

				x <- vector("numeric", length = 10) 
				x
				[1] 0 0 0 0 0 0 0 0 0 0
        
### factor()
- represent categorical data and can be unordered or ordered

				x <- factor(c("yes", "yes", "no", "yes", "no")[, levels = c("yes", "no")]) 
				x
				[1] yes yes no  yes no 
				Levels: no yes
				table(x) 
				x
				no yes 
				2   3
        
### names()
- Objects can have names
- Object	Set column names	Set row names
  - data frames	names()	row.names()
  - matrix	colnames()	rownames()
  
				x <- 1:3
				names(x)
				NULL
				names(x) <- c("New York", "Seattle", "Los Angeles") 
				x
				   New York     Seattle Los Angeles 
				          1           2           3 
				names(x)
				[1] "New York"    "Seattle"     "Los Angeles"
        
### seq
- by

				seq(0, 10, by=0.5)
				 [1]  0.0  0.5  1.0  1.5  2.0  2.5  3.0  3.5  4.0  4.5  5.0  5.5  6.0  6.5  7.0  7.5  8.0  8.5  9.0  9.5 10.0
         
- length

				seq(5, 10, length=30)
				 [1]  5.000000  5.172414  5.344828  5.517241  5.689655  5.862069  6.034483  6.206897  6.379310  6.551724  6.724138
				[12]  6.896552  7.068966  7.241379  7.413793  7.586207  7.758621  7.931034  8.103448  8.275862  8.448276  8.620690
				[23]  8.793103  8.965517  9.137931  9.310345  9.482759  9.655172  9.827586 10.000000
			seq_along(my_seq) | seq(along.with = my_seq) | 1:length(my_seq)
      
### rep

- times
      
				rep(c(0,1,2), times = 2)
				[1] 0 1 2 0 1 2
        
- each
      
				rep(c(0,1,2), each = 2)
				[1] 0 0 1 1 2 2
        
### paste

			collapse
				paste(my_char, collapse = " ") // my_char: [1] "My"   "name" "is" 
				[1] "My name is"
        
### sep

				paste(1:3, c("X", "Y"), sep = "")
				[1] "1X" "2Y" "3X"
        
### rnorm

- Standard normal distribution

### identical

- identical(obj1, obj2)

### class

- Get the class of input parameter

### which

- Take a logical vector as an argument and returns the indices of the vector that are TRUE

### any

- If any of the element follows the logical

### all

- If all of the elements follow the logical

### Getwd()

- Similar to pwd in linux

### ls

- Get all values

### args()

- Get the arguments for a function

### dir.create(somepath[, recursive = TRUE])

- Recursive = TRUE for subfolder

### read_csv 

- col_types // with standard format, The '-' character can be used to indicate that a column should be skipped. (replace that column with '-')
- n_max
	
## Missing Values

- is.na()
- is.nan()
- NA values have a class also, so there are integer NA, character NA, etc.
- A NaN value is also NA but the converse is not true
    
## Attributes

- Names, dimnames
- Dimensions
- Class
- Length
- Other user-defined attributes/metadata

## Tidy data

- Defination
  1. Each variable forms a column.
  2. Each observation forms a row.
  3. Each type of observational unit forms a table.
- Tidyverse
  - Packages
    - Ggplot2, magrittr, dplyr, tidyr
## Packages

### readr

- library(readr)
  - readr function	Use
  - read_csv	Reads comma-separated file
  - read_csv2	Reads semicolon-separated file
  - read_tsv	Reads tab-separated file
  - read_delim	General function for reading delimited files
  - read_fwf	Reads fixed width files
  - read_log	Reads log files
  - xxx <- read_csv("xxx.csv/.gz"[, col_types = "cc", nmax = n])
  - cc indicates that the first column ischaracter and the second column is character and there are only two columns
  - col_types = cols_only(date = col_date())
  
## Logical
- &&
  - TRUE && c(TRUE, FALSE, FALSE)
  - TRUE // TRUE is only evaluated with the first element in c(…)
- xor
  - T,T -> F
- %in%
  - Included in

# Data Manipulation

## Objective

- Transform non-tidy data into tidy data
- Manipulate and transform a variety of data types, including dates, times, and text data
## Sample
		
- ext_file <- filepath
- ext_widths <- c(col_lengths)
- ext_colnames <- c(col_names)
- ext <- read_fwf(ext_file, fwf_widths(ext_widths, _colnames), na = "-99")
## Piping
- // Without piping
  - function(dataframe, argument_2, argument_3)
- // With piping
  - dataframe %>%
  - function(argument_2, argument_3)
## Summarizing data // 把rows信息集中到一行
- ext_tracks %>%
  - summarize(n_obs = n(),
    - worst_wind = knots_to_mph(max(max_wind)),
    - worst_pressure = min(min_pressure))
    
		# A tibble: 1 × 3
			n_obs worst_wind worst_pressure
			<int>      <dbl>          <int>
			1 11824     184.32              0
      
## Selecting and filtering
- Similar to database sql

## Edit columns
- mutute(), rename()
    
## Spreading and gathering data
- gather() // 重新排版
    
## Merging datasets
- Join
  - left_join, right_join, inner_join, full_join
      
## Date or date-time class
- Conversion

			library(lubridate)
			ymd("2006-03-12"/"'06 March 12")
			[1] "2006-03-12"
			ymd_hm("06/3/12 6:30 pm")
			[1] "2006-03-12 18:30:00 UTC"
      
## Packages
- dplyr
    
## Helpful samples
- Categorize column data

# Text Processing

## grepl

### Regular expression
			
- Metacharacter	Meaning
			
.	Any Character
\w	A Word
\W	Not a Word
\d	A Digit
\D	Not a Digit
\s	Whitespace
\S	Not Whitespace
[xyz]	A Set of Characters
[^xyz]	Negation of Set
[a-z]	A Range of Characters
^	Beginning of String
$	End of String
\n	Newline
+	One or More of Previous
*	Zero or More of Previous
?	Zero or One of Previous
|	Either the Previous or the Following
{5}	Exactly 5 of Previous
{2, 5}	Between 2 and 5 or Previous
{2, }	More than 2 of Previous

## stringr

“data first” approach to functions
