library(dplyr)

## clear current workspace
rm(list = ls())

## source the download data script
source("./load_data.R")

## Get date and time as one variable
powerData <- mutate(powerData, DateTime = paste(Date, Time, sep = " "))
powerData$DateTime <- strptime(powerData$DateTime, "%Y-%m-%d %H:%M:%S" )

## make sure all data is numeric
powerData$Sub_metering_1 <- as.numeric(powerData$Sub_metering_1)
powerData$Sub_metering_2 <- as.numeric(powerData$Sub_metering_2)
powerData$Sub_metering_3 <- as.numeric(powerData$Sub_metering_3)

## Create Plot 3
png("plot3.png", width=480, height=480)
with(powerData, { 
    plot(DateTime,Sub_metering_1,col="black",
         type="l",xlab="",ylab="Energy sub metering")
    lines(DateTime,Sub_metering_2,col="red")
    lines(DateTime,Sub_metering_3,col="blue")
    legend("topright",
           c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
           lty=1,lwd=2,col=c("black","red","blue"),bty="o")
})

dev.off()