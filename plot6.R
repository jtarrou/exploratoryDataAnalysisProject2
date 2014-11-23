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

# get desired data
SCC.vehicle <- grep("motor", SCC$Short.Name, ignore.case = TRUE)
SCC.motor <- SCC[SCC.vehicle, ]
SCC.data <- as.character(SCC.motor$SCC)
NEI$SCC <- as.character(NEI$SCC)
NEI.motor <- NEI[NEI$SCC %in% SCC.data, ]

# get Baltimore City data
BaltCity <- NEI.motor[which(NEI.motor$fips == "24510"), ]
aggregate.BaltCity <- with(BaltCity, aggregate(Emissions, by = list(year), sum))
aggregate.BaltCity$group <- rep("Baltimore City", length(aggregate.motor.24510[, 1]))

# get LA data
LA <- NEI.motor[which(NEI.motor$fips == "06037"), ]
aggregate.LA <- with(LA, aggregate(Emissions, by = list(year), sum))
aggregate.LA$group <- rep("Los Angeles County", length(aggregate.LA[, 1]))

# combine data with rbind
BaltCity_LA <- rbind(aggregate.LA, aggregate.BaltCity)
BaltCity_LA$group <- as.factor(BaltCity_LA$group)
colnames(BaltCity_LA) <- c("Year", "Emissions", "Group")

# create .png file
png("plot6.png", width=480, height=480)

# plot data
qplot(Year, Emissions, data = BaltCity_LA, group = Group, color = Group, 
      geom = c("point", "line"), xlab = "Year", ylab = expression("Total Emissions, PM"[2.5]), 
      main = "Comparison of Emissions Baltimore City vs LA County")

dev.off()