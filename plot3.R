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
my_data3 <- aggregate(BaltCity[c("Emissions")], list(type = BaltCity$type, year = BaltCity$year), sum)

# create .png file
png("plot3.png", width=480, height=480)

# plot data
myPlot3 <- ggplot(my_data3, aes(x = year, y = Emissions, colour = type)) + geom_point(alpha = 0.3) +
     geom_smooth(alpha = 0.2, size = 1, method = "loess") + ggtitle("Total Emissions by Type in Baltimore City")

print(myPlot3)

dev.off()