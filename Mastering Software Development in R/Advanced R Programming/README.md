# Programming (Continued)

## Control Structure and function
Similar to python

## Function

### Input

…

### Anonymous Function

evaluate(function(x){x[1]}, c(8, 4, 0))

### Arguments

In function:
- args <- list(...)
- place <- args[["place"]]
- adjective  <- args[["adjective"]]
- noun  <- args[["noun"]]

Call
- mad_libs(place = "home", adjactive = "happily", noun = "book")

User-defined binary operator
- %[whatever]% 
- "%whatever%" <- function(left, right){…}

### Common Functions

Search
- contains
- detect
- detec_index

Filter
- keep
- discard
- every
- some

Compose
- n_unique
- rep
			
## Data structure in R.

Create
- New.nev()

Property
- Environment$property
		
## Error

### Type

Warning
- Indicate that something seems to have gone wrong in your program which should be inspected.

Message
- Print test to the R console.
	
### Generate

stop()

stopifnot()

warning()

message()

### Handle

tryCatch()

### Cons

Slow
		
## Debugging

### Built-in

browser()

- allows you to step through code one expression at a time

debug() / debugonce()
- initiates the browser within a function
trace()
- temporarily insert pieces of code into other functions to modify their behavior
recover()
- navigate the function call stack after a function has thrown an error
traceback()
- prints out the function call stack after an error occurs
      
 ### Microbenchmark
- useful for running small sections of code to assess performance
- library(microbenchmark)
- microbenchmark(a <- rnorm(1000), 
		               b <- mean(rnorm(1000)))
		
## Class
Reference class (inherited in java)
