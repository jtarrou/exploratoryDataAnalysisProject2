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