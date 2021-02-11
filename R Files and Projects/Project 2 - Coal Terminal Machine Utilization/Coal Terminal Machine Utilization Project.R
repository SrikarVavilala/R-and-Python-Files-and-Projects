#Srikar Vavilala
#10/18/2020
#Understanding and using Lists
# "Coal Terminal machine-utilization" project

## Project Overview:
# You have been engaged as a Data Science consultant by a coal terminal. They would
# like you to investigate one of their heavy machines - RL1.
# You have been supplied one month worth of data for all of their machines. The
# dataset shows what percentage of capacity for each machine was idle (unused) in any
# given hour. You are required to deliver an R list with specific components.


## Deliverable - a list with the following components:
#Character: Machine name
#Vector:    (min, mean, max) Utilization for the month (excluding unknown hours)
#Logical:   has utilization ever fallen below 90% ? TRUE/FALSE
#Vector:    All hours where utilization is unknown (NA's)
#Dataframe: For this machine
#Plot:      For all machines



util <- read.csv("machine-utilization.csv")
head(util,12)
str(util)

util$Machine <- factor(util$Machine)







## Derive utilization column
util$Utilization = 1 - util$Percent.Idle    #this replaces P.Idle w/ active %
head(util,15)








## Handling Date-Times in R
tail(util)      #may be used to tell what format the date is in, unreliable

?POSIXct        #Has a standard for time that can be used across devices/programs
util$PosixTime <- as.POSIXct(util$Timestamp, format="%d/%m/%Y %H:%M")
head(util,10)

#TIP: how to rearrange cols in a df:
util$Timestamp <- NULL
util <- util[,c(4,1,2,3)]
head(util,10)






## Understanding lists
RL1 <- util[util$Machine=="RL1",]
RL1$Machine <- factor(RL1$Machine)
str(RL1)

#      Construct List:
#Character: Machine name
#Vector:    (min, mean, max) Utilization for the month (excluding unknown hours)
#Logical:   has utilization ever fallen below 90% ? TRUE/FALSE
util_stats_rl1 <- c(min(RL1$Utilization, na.rm=1),
                    mean(RL1$Utilization, na.rm=1),
                    max(RL1$Utilization, na.rm=1))

util_under_90_flag <- length(which(RL1$Utilization < 0.90)) > 0 #any machines under 90% util?
util_under_90_flag


list_rl1 <- list("RL1", util_stats_rl1, util_under_90_flag)
list_rl1


#Naming components of a list
list_rl1
names(list_rl1) <- c("Machine", "Stats", "LowThreshold")
list_rl1

#Another way, like with dataframes:
rm(list_rl1)
list_rl1 <- list(Machine="RL1", Stats=util_stats_rl1, 
                 LowThreshold=util_under_90_flag)
list_rl1






## Extracting components of a list:
#1) [] - will always return a list
#2) [[]] - will always return the actual object
#3) $ - same as [[]] but better formatted
list_rl1
list_rl1[1]
list_rl1[[1]]
list_rl1$Machine

typeof(list_rl1[1])
typeof(list_rl1[[1]])
typeof(list_rl1$Machine)

#how would you access the 3rd element of the vector (max util.)?
list_rl1[[2]][3]
list_rl1$Stats[3]






## Adding and Deleting components in a list
list_rl1
list_rl1[4] <- "New Information"

#another way, via $
#Vector:    All hours where utilization is unknown (NA's)

list_rl1$UnknownHours <- RL1[is.na(RL1$Utilization), "PosixTime"]

#removing a component, use the NULL method:
list_rl1[4] <- NULL
list_rl1
#!!Notice: numeration has shifted for lists, unlike in dataframes
list_rl1[4]

#add another component:
#Dataframe: For this machine
list_rl1$Data <- RL1
summary(list_rl1)







## Subsetting a list
# list_rl1[1]
# list_rl1[1:3]
# list_rl1[c(1,4)]
# sublist_rl1 <- list_rl1[c("Machine","Stats")]
# sublist_rl1[[2]][2]
#Double Square Brackets are NOT for subsetting!








#Building a timeseries plot:
#Plot:      For all machines
library(ggplot2)

p <- ggplot(data=util)
myplot <- p + geom_line(aes(x=PosixTime, y=Utilization, color=Machine), size=1.2) +
  facet_grid(Machine~.) +
  geom_hline(yintercept = 0.90, color="Gray", size= 1.2, linetype=2) +
  ggtitle("Machine Utilization Over Time")

list_rl1$Plot <- myplot
list_rl1
summary(list_rl1)
