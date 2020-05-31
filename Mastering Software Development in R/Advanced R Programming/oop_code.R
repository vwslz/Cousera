#################################
# install.packages("tidyverse") #
# install.packages("dplyr")     #
# library(tidyr)                #
# library(dplyr)                #
#################################

###########
# Classes #
###########

LongitudinalData <- setClass(
  "LongitudinalData",
  slots = list(
    data = "data.frame"
  )
)

Subject = setClass(
  "Subject",
  slots = list(
    id = "numeric",
    data = "data.frame"
  )
)

Visit = setClass(
  "Visit",
  slots = list(
    id = "numeric",
    visit = "numeric",
    data = "data.frame"
  )
)

Room = setClass(
  "Room",
  slots = list(
    id = "numeric",
    visit = "numeric",
    room = "character",
    data = "data.frame"
  )
)

############
# Function #
############

make_LD = function(x = read_csv("MIE.csv")) {
  LongitudinalData(
    data = x
  )
}

###########
# Generic #
###########

setGeneric(
  "subject",
  function(x, y) {
    standardGeneric("subject")
  })

setGeneric(
  "visit",
  function(x, y) {
    standardGeneric("visit")
  })

setGeneric(
  "room",
  function(x, y) {
    standardGeneric("room")
  })

setGeneric("print")

setGeneric("summary",
   function(x) {
     standardGeneric("summary")
   })

###########
# Methods #
###########

setMethod(
  "print",
  c(x = "LongitudinalData"),
  function(x){
    paste("Longitudinal dataset with", length(unique(x@data$id)), "subjects")
  })

setMethod(
  "print",
  c(x = "Subject"),
  function(x){
    if (is.null(x)) { NULL }
    else {
      paste("Subject ID:", x@id)
    }
  })

setMethod(
  "print",
  c(x = "Visit"),
  function(x){
    if (is.null(x)) { NULL }
    else {
      paste("Visit ID:", x@visit)
    }
  })

setMethod(
  "print",
  c(x = "Room"),
  function(x){
    if (is.null(x)) { NULL }
    else {
      cat(
        paste("ID:", x@id),
        paste("Visit:", x@visit),
        paste("Room:", x@room),
        sep = '\n')
    }
  })

setMethod(
  "subject",
  c(x = "LongitudinalData", y = "numeric"),
  function(x, y){
    if (y %in% x@data$id) {
      Subject(id = y, data = subset(x@data, id == y, select=visit:timepoint))
    }
    else {NULL}
  })

setMethod(
  "visit",
  c(x = "Subject", y = "numeric"),
  function(x, y){
    if (y %in% x@data$visit) {
      Visit(id = x@id, visit = y, data = subset(x@data, visit == y, select=room:timepoint))
    }
    else {NULL}
  })

setMethod(
  "room",
  c(x = "Visit", y = "character"),
  function(x, y){
    if (y %in% x@data$room) {
      Room(
        id = x@id,
        visit = x@visit,
        room = y,
        data = subset(x@data, room == y, select=value:timepoint))
    }
    else {NULL}
  })

setMethod(
  "summary",
  c(x = "Subject"),
  function(x){
    x@data %>% 
      group_by(visit, room) %>% 
      summarize(m =mean(value))%>% 
      spread(room, m)
  })

setMethod(
  "summary",
  c(x = "Room"),
  function(x){
    if (is.null(x)) { NULL }
    else {
      print(paste("ID: ", x@id))
      print(quantile(pull(x@data, value), c(0, 0.25, 0.5, 0.75, 1), type = 1))
    }
  })