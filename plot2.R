library(dplyr)

## clear current workspace
rm(list = ls())

## source the download data script
source("./load_data.R")

## Get date and time as one variable
powerData <- mutate(powerData, DateTime = paste(Date, Time, sep = " "))
powerData$DateTime <- strptime(powerData$DateTime, "%Y-%m-%d %H:%M:%S" )

## Create Plot 2
png("plot2.png", width=480, height=480)
with(powerData,
     plot(DateTime,Global_active_power,type="l",
          xlab="",ylab="Global Active Power (kilowatts)"))
dev.off()