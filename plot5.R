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

# get desired subset data from our two data sets
SCC.vehicle <- grep("motor", SCC$Short.Name, ignore.case = TRUE)
SCC.motor <- SCC[SCC.vehicle, ]
SCC.data <- as.character(SCC.motor$SCC)
NEI$SCC <- as.character(NEI$SCC)
NEI.motor <- NEI[NEI$SCC %in% SCC.data, ]

# get Baltimore City data
BaltCity <- NEI.motor[which(NEI.motor$fips == "24510"), ]
aggregate.BaltCity <- with(BaltCity, aggregate(Emissions, by = list(year), sum))

# create .png file
png("plot5.png", width=480, height=480)

# plot the data
plot(aggregate.BaltCity, type = "o", xlab = "Year", ylab = expression("Total Emissions, PM"[2.5]), 
     main = "Total Emissions Vehicles in Baltimore City")

dev.off()