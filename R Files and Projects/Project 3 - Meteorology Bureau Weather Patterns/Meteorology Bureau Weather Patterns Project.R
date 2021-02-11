#Srikar Vavilala
#Understanding/using the Apply() family of functions
# "Weather Patterns meteorology bureau" project

## Project Overview:
# You are working on a project for a meteorology bureau. You have been supplied
# weather data for 4 cities in the US: Chicago, NewYork, Houston and SanFrancisco.


## Deliverables:
#1. A table showing the annual averages of each observed metric for every city 
#2. A table showing by how much temperature fluctuates each month from min to
#max (in %). Take min temperature as the base
#3. A table showing the annual maximums of each observed metric for every city
#4. A table showing the annual minimums of each observed metric for every city
#5. A table showing in which months the annual maximums of each metric were
#observed in every city (Advanced)


Chicago <- read.csv("Chicago-F.csv", row.names=1)
Houston <- read.csv("Houston-F.csv", row.names=1)
NewYork <- read.csv("NewYork-F.csv", row.names=1)
SanFrancisco <- read.csv("SanFrancisco-F.csv", row.names=1)

is.data.frame(Chicago)
#Convert to matrices
Chicago <- as.matrix(Chicago)
Houston <- as.matrix(Houston)
NewYork <- as.matrix(NewYork)
SanFrancisco <- as.matrix(SanFrancisco)

Chicago
#put all of them into a list
Weather <- list(Chicago=Chicago, Houston=Houston,NewYork=NewYork, SanFrancisco=SanFrancisco)
Weather
Weather[2]
Weather[[2]]
Weather$Houston

#apply(M, 1, mean) -- M is the matrix, 1 means row-wise, mean is the function. 2 instead of 1 means column-wise

#Using apply()
apply(Chicago, 1, mean)
mean(Chicago["DaysWithPrecip",])
#Compare:
apply(Chicago, 1, mean)
apply(Houston, 1, mean)
apply(NewYork, 1, mean)
apply(SanFrancisco, 1, mean)


## Find the mean of every row:

#Method 1. via loops
output <- NULL
for(i in 1:5){
  output[i] <- mean(Chicago[i,])
  
}
output

#Method 2. via apply()
apply(Chicago, 1, mean)



## using lapply()
?lapply
#ex 1. transposing each matrix in a list using lapply()
lapply(Weather, t)

#ex 2. rbind()
lapply(Weather, rbind, NewRow=1:12)

#ex 3. rowMeans
?rowmeans
rowMeans(Chicago) #identical to: apply(Chicago, 1, mean)
lapply(Weather, rowMeans)






## combining lapply with the [] operator
Weather
Weather[[1]][1,1]
Weather$Chicago[1,1]

lapply(Weather, "[", 1, 1)     #lapply(Weather,... is Weather[[]], ...,"[", 1, 1) is ...[1,1]
lapply(Weather, "[", 1, )      #returns first row of each matrix in Weather
lapply(Weather, "[", ,1)       #returns first col of each matrix in Weather








## Adding your own functions
lapply(Weather, rowMeans)
lapply(Weather, function(x) x[1,])        #the content following function(x) is the body of the function
lapply(Weather, function(x) x[,12])
lapply(Weather, function(z) z[1,]-z[2,])  #avg. high - avg. low for each month in each matrix
lapply(Weather, function(z) round((z[1,]-z[2,])/z[2,],2) )








## Using sapply()
?sapply

#AvgHigh_F for July:
lapply(Weather, "[", 1, 7)
sapply(Weather, "[", 1, 7)
#AvgHigh_F for 4th quarter:
lapply(Weather, "[", 1, 10:12)
sapply(Weather, "[", 1, 10:12)
#Another example:
lapply(Weather, rowMeans)
sapply(Weather, rowMeans)
round(sapply(Weather, rowMeans), 2)                         #DELIVERABLE 1
sapply(Weather, function(z) round((z[1,]-z[2,])/z[2,],2) )  #DELIVERABLE 2
# sapply vs. lapply:
sapply(Weather, rowMeans, simplify=FALSE)    #same as lapply(Weather, rowMeans)






## Nesting Apply Functions
apply(Chicago, 1, max)
#apply across whole list:
lapply(Weather, apply, 1, max)
#tidy up:
sapply(Weather, apply, 1, max)                                  #DELIVERABLE 3
sapply(Weather, apply, 1, min)                                  #DELIVERABLE 4






## which.max()
?which.max
Chicago[1,]
which.max(Chicago[1,])
names(which.max(Chicago[1,]))
#we will have apply to iterate over rows of the matrix
#we will have lapply/sapply to iterate over components of the list
apply(Chicago, 1, function(x) names(which.max(x)))
lapply(Weather, function(y) apply(y, 1, function(x) names(which.max(x))) )
sapply(Weather, function(y) apply(y, 1, function(x) names(which.max(x))) )  #DELIVERABLE 5
