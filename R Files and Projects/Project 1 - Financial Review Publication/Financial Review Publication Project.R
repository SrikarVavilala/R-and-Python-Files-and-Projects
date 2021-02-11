#Srikar Vavilala
#09/20/2020
#Understanding and implementing Data Preparation
# "Fortune 500 publication" project

# #Project overview and devliverables:
# a list of 500 companies will be used to create visualizations for
# an upcoming online publication.
# They have requested the following charts:
# 1. A scatterplot classified by industry showing revenue, expenses, profit
# 2. A scatterplot that includes industry trends for the expenses~revenue relationship
# 3. BoxPlot showing growth by industry


#Analyze csv file to understand data formatting
fin <- read.csv("P3-Future-500-The-Dataset.csv", na.strings=c("")) #na.strings=c() further defines what NA's look like
fin
head(fin)
str(fin)
summary(fin)

#reformat columns as factors
fin$ID <- factor(fin$ID)
fin$Inception <- factor(fin$Inception)
fin$Name <- as.factor(fin$Name)
fin$Industry <- as.factor(fin$Industry)
fin$State <- as.factor(fin$State)
fin$City <- as.factor(fin$City)
fin$Revenue <- as.factor(fin$Revenue)
fin$Expenses <- as.factor(fin$Expenses)
fin$Growth <- as.factor(fin$Growth)

## Factor Variable Trap (understanding issues)
#converting into Numerics for Characters:
# a<- c("12","13", "14", "12", "12")
# a  
# typeof(a)  
# b <- as.numeric(a)  
# b
# typeof(b)  
# #Converting into Numerics for Factors:
# z <- factor(c("12","13", "14", "12", "12"))
# z
# y <- as.numeric(c(z))  
# y                            #R sees this as 1 2 3 1 1
# typeof(y)  
# #--------  Correct way:
# x <- as.numeric(as.character(z))
# x
# typeof(x)


#sub() and gsub(), reformatting data to desired format:
?sub
fin$Expenses <- gsub("Dollars","",fin$Expenses)
fin$Expenses <- gsub(",","",fin$Expenses)
head(fin)

fin$Revenue <- gsub("\\$","",fin$Revenue)
fin$Revenue <- gsub(",","",fin$Revenue)
head(fin)

fin$Growth <- gsub("%","",fin$Growth)

fin$Expenses <- as.numeric(fin$Expenses)
fin$Revenue <- as.numeric(fin$Revenue)
fin$Growth <- as.numeric(fin$Growth)


## What is an NA?
?NA

#NA is a logical operator
NA == TRUE            #NA
NA == FALSE           #NA
#NA == NA              #NA



## Locating Missing Data:
head(fin,24)
complete.cases(fin)      #checks if rows have NA values/are complete, returns logical values

fin[!complete.cases(fin),]  #returns rows that have NA values, w/o '!' it would return rows that DO NOT have NA values
                            #not all rows are returning right now b/c R thinks that "blank" values are meant to be blank



## Filtering: using which() for non-missing data
head(fin)
fin[fin$Revenue == 9746272,]        #returns a few NA rows b/c the value is empty
?which
which(fin$Revenue == 9746272)       #returns indices where the condition is true
fin[which(fin$Revenue == 9746272),] #returns rows based on returned indices retrieved from which()
fin[fin$Employees == 45,]
fin[which(fin$Employees == 45),]


## Filtering: using is.na() for missing data

#a <- c(1,24,543,NA,76,NA)
#is.na(a)

is.na(fin$Expenses)
fin[is.na(fin$Expenses),]

fin[is.na(fin$State),]


## Removing records that have missing data
fin_backup <- fin
fin[!complete.cases(fin),]
fin_backup <- fin[!is.na(fin$Industry),]
fin_backup




## Resetting the dataframe index
rownames(fin) <- 1:nrow(fin)    #another way to do this is rownames(fin) <- NULL


## Replacing Missing Data: Factual Analysis
fin[!complete.cases(fin),]
fin[is.na(fin$State) & fin$City=="New York","State"] <- "NY" #Isolating a col within a subset, and assigning it "NY"
fin[is.na(fin$State) & fin$City=="San Francisco","State"] <- "CA"
#check:
fin[c(11,379),]


## Replacing Missing Data: Median Imputation Method (Part 1)
fin[!complete.cases(fin),]
median(fin[,"Employees"], na.rm=TRUE)
mean(fin[,"Employees"], na.rm=TRUE)

median(fin[fin$Industry=="Retail","Employees"], na.rm=TRUE)
mean(fin[fin$Industry=="Retail","Employees"], na.rm=TRUE)

med_empl_retail <- median(fin[fin$Industry=="Retail","Employees"], na.rm=TRUE)

fin[is.na(fin$Employees) & fin$Industry=="Retail","Employees"] <- med_empl_retail

#check:
fin[3,]

med_empl_finserv <- median(fin[fin$Industry=="Financial Services","Employees"], na.rm=TRUE)
med_empl_finserv

fin[is.na(fin$Employees) & fin$Industry=="Financial Services","Employees"] <- med_empl_finserv
fin[332,]



## Replacing Missing Data: Median Imputation Method (Part 2)
fin[!complete.cases(fin),]

med_growth_constr <- median(fin[fin$Industry=="Construction","Growth"], na.rm=TRUE)
med_growth_constr
fin[is.na(fin$Growth) & fin$Industry=="Construction",]
fin[is.na(fin$Growth) & fin$Industry=="Construction","Growth"] <- med_growth_constr
#check:
fin[8,]



## Replacing Missing Data: Median Imputation Method (Part 3)
med_rev_constr <- median(fin[fin$Industry=="Construction","Revenue"], na.rm=TRUE)
fin[is.na(fin$Revenue) & fin$Industry=="Construction","Revenue"] <- med_rev_constr

med_exp_constr <- median(fin[fin$Industry=="Construction","Expenses"], na.rm=TRUE)
fin[is.na(fin$Expenses) & fin$Industry=="Construction" & is.na(fin$Profit),"Expenses"] <- med_exp_constr


## Replacing Missing Data: Deriving Values
fin[is.na(fin$Profit), "Profit"] <- fin[is.na(fin$Profit), "Revenue"] - fin[is.na(fin$Profit), "Expenses"]
fin[is.na(fin$Profit), "Expenses"] <- fin[is.na(fin$Profit), "Revenue"] - fin[is.na(fin$Profit), "Profit"]

fin[!complete.cases(fin),]


#Vizualizing:
library(ggplot2)

#a scatterplot classified by industry showing revenue, expenses, profit
p <- ggplot(data=fin)
p + geom_point(aes(x=Revenue, y=Expenses, color=Industry, size=Profit)) + ggtitle("Expenses by Revenue, showing revenue/profit")

# a scatterplot that includes industry trends 
d <- ggplot(data=fin,aes(x=Revenue, y=Expenses, color=Industry))

d + geom_point() + geom_smooth(fill=NA,size=1.2) + ggtitle("Expenses by Revenue, showing industry trends")

#boxplot showing growth by industry
f <- ggplot(data=fin,aes(x=Industry, y=Expenses, color=Industry))
f + geom_boxplot(size=1) + ggtitle("Expenses by Industry, showing growth")


#Extra, showing "jittered" datapoints
f + geom_jitter() + geom_boxplot(size = 1, alpha=0.5, outlier.color = NA) + ggtitle("Expenses by Revenue, with jitter")

