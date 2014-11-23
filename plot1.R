# project 2 for EDA
# set wd in exploratoryDataAnalysis
# setwd("exploratoryDataAnalysis")

# load necessary libraries
library(ggplot2)
library(plyr)

# the initial code given in instructions:
# read data 
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

# gather desired data
my_data <- aggregate(NEI[c("Emissions")], list(year = NEI$year), sum)

# create png file (thanks everyone from the last project for pointing out the png, rather 
# than copying from the screen
png("plot1.png", width = 480, height = 480)

# plot the data
plot(my_data$year, my_data$Emissions, type = "l", main = "Total Emissions from PM2.5 in US", xlab = "Year", ylab = "Emissions")

dev.off()