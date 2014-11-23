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

#######################################

# get data for Baltimore City
BaltCity <- subset(NEI, fips == "24510")

# gather plotting data
my_data2 <- aggregate(BaltCity[c("Emissions")], list(year = BaltCity$year), sum)

# create .png file
png('plot2.png', width=480, height=480)

# plot the data
plot(my_data2$year, my_data2$Emissions, type = "l", main = "Total Emissions from PM2.5 in Baltimore City",
     xlab = "Year", ylab = "Emissions")

dev.off()

#########################################

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

##########################################

# get desired data from two data sets
SCCcoalCumbust <- grep("coal", SCC$Short.Name, ignore.case = TRUE)
SCCcoalCumbust <- SCC[SCCcoalCumbust, ]
SCC.data <- as.character(SCCcoalCumbust$SCC)

NEI$SCC <- as.character(NEI$SCC)
NEIcoalCumbist <- NEI[NEI$SCC %in% SCC.data, ]

# gather plotting data
my_data4 <- with(NEIcoalCumbist, aggregate(Emissions, by = list(year), sum))
colnames(my_data4) <- c("year", "Emissions")

# create .png file
png("plot4.png", width=480, height=480)

# plot data
plot(my_data4, type = "o", xlab = "Year", ylab = expression("Total Emissions, PM"[2.5]), 
     main = "Coal Combustion Emissions in United States", xlim = c(1999, 2008))

dev.off()

#############################################

# get desired data from our two data sets
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

#################################################

# get desired subset data from the two data sets
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

####################################################


	 