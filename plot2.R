# project 2 for EDA 
## **Note: using same initial code for all 6 plots

# set wd in exploratoryDataAnalysis
# setwd("exploratoryDataAnalysis")

# load necessary libraries
library(ggplot2)
library(plyr)

# the initial code given in instructions:

# read data 
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

# get data for Baltimore City
BaltCity <- subset(NEI, fips == "24510")

# gather plotting data
my_data2 <- aggregate(BaltCity[c("Emissions")], list(year = BaltCity$year), sum)

# create .png file
png("plot2.png", width=480, height=480)

# plot the data
plot(my_data2$year, my_data2$Emissions, type = "l", main = "Total Emissions from PM2.5 in Baltimore City",
     xlab = "Year", ylab = "Emissions")

dev.off()