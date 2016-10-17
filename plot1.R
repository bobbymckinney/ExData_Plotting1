library(dplyr)

## clear current workspace
rm(list = ls())

## source the download data script
source("./load_data.R")

powerData$Global_active_power <- as.numeric(powerData$Global_active_power)

## Create Plot 1
png("plot1.png", width=480, height=480)
with(powerData,
     hist(Global_active_power,col='Red',
          main="Global Active Power",
          xlab = "Global Active Power (kilowatts)"))

dev.off()
    