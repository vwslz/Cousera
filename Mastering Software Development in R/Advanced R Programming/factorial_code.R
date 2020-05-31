########
# Loop #
########

Factorial_loop <- function(x) {
  stopifnot(x >= 0)
  res <- 1
  if (x > 0) {
    for (fac in seq(1, x, by = 1)) {
      res <- res * fac
    }
  }
  res
}

##########
# Reduce #
##########

Factorial_reduce <- function(x) {
  stopifnot(x >= 0)
  if (x == 0) {
    1
  }
  else {
    reduce(seq(1, x, by = 1), function(x, y){
      x * y
    })
  }
}

#############
# Recursion #
#############

Factorial_func <- function(x) {
  stopifnot(x >= 0)
  if (x == 0) {
    1
  }
  else {
    x * Factorial_func(x - 1)
  }
}

################
# Memorization #
################

fac_tbl <- c(1, rep(NA, 10))
Factorial_mem <- function(x) {
  stopifnot(x >= 0)
  if (x == 0) {
    1
  }
  else {
    if(!is.na(fac_tbl[x])){
      fac_tbl[x]
    } else {
      fac_tbl[x - 1] <<- Factorial_mem(x - 1)
      fac_tbl[x - 1] * x
    }
  }
}

##########
# Helper #
##########

toPlot <- function(data) {
  names(data) <- paste0(letters[1:10], 1:10)
  data <- as.data.frame(data)
  
  data %<>%
    gather(num, time) %>%
    group_by(num) %>%
    summarise(med_time = median(time))
  
  data
}

########
# Plot #
########

library(purrr)
library(microbenchmark)
library(tidyr)
library(magrittr)
library(dplyr)

Factorial_loop_data <- map(1:10, function(x){
  microbenchmark(Factorial_loop(x), times = 100)$time
})
Factorial_loop_data <- toPlot(Factorial_loop_data)

Factorial_reduce_data <- map(1:10, function(x){
  microbenchmark(Factorial_reduce(x), times = 100)$time
})
Factorial_reduce_data <- toPlot(Factorial_reduce_data)

Factorial_func_data <- map(1:10, function(x){
  microbenchmark(Factorial_func(x), times = 100)$time
})
Factorial_func_data <- toPlot(Factorial_func_data)

Factorial_mem_data <- map(1:10, function(x){
  microbenchmark(Factorial_mem(x), times = 100)$time
})
Factorial_mem_data <- toPlot(Factorial_mem_data)

Factorial_loop_data
Factorial_reduce_data
Factorial_func_data
Factorial_mem_data

plot(1:10, Factorial_loop_data$med_time, xlab = "Factorial", ylab = "Median Time (Nanoseconds)",
     pch = 18, bty = "n", xaxt = "n", yaxt = "n", ylim=c(0,150000))
axis(1, at = 1:10)
axis(2, at = seq(0, 150000, by = 10000))
lines(1:10 + .1, Factorial_loop_data$med_time, col = "black", lty=3)
points(1:10 + .1, Factorial_reduce_data$med_time, col = "blue", pch = 18)
lines(1:10 + .1, Factorial_reduce_data$med_time, col = "blue", lty=3)
points(1:10 + .1, Factorial_func_data$med_time, col = "red", pch = 18)
lines(1:10 + .1, Factorial_func_data$med_time, col = "red", lty = 3)
points(1:10 + .1, Factorial_mem_data$med_time, col = "yellow", pch = 18)
lines(1:10 + .1, Factorial_mem_data$med_time, col = "yellow", lty = 3)
legend(1, 150000, c("Loop", "Reduce", "Recursion", "Memoized"), pch = 18, 
       col = c("black", "blue", "red", "yellow"), bty = "n", cex = 1, y.intersp = 1.5)

###############
# Performance #
###############

Comparision <- function(x) {
  microbenchmark(
    Factorial_loop(x), 
    Factorial_reduce(x), 
    Factorial_func(x), 
    Factorial_mem(x), 
    times = 100
  )
}

for (x in c(10,100,1000)) {
  print(Comparision(x))
}

