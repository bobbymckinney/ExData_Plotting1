library(dplyr)

## clear current workspace
rm(list = ls())

## source the download data script
source("./load_data.R")

## Get date and time as one variable
powerData <- mutate(powerData, DateTime = paste(Date, Time, sep = " "))
powerData$DateTime <- strptime(powerData$DateTime, "%Y-%m-%d %H:%M:%S" )

## make sure all data is numeric
powerData$Global_active_power <- as.numeric(powerData$Global_active_power)
powerData$Global_reactive_power <- as.numeric(powerData$Global_reactive_power)
powerData$Voltage <- as.numeric(powerData$Voltage)
powerData$Sub_metering_1 <- as.numeric(powerData$Sub_metering_1)
powerData$Sub_metering_2 <- as.numeric(powerData$Sub_metering_2)
powerData$Sub_metering_3 <- as.numeric(powerData$Sub_metering_3)

## Create Plot 4 with 4 subplots
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

with(powerData, {
    plot(DateTime,Global_active_power,type="l",
         xlab="",ylab="Global Active Power (kilowatts)")
    plot(DateTime,Voltage,type="l",
         xlab="",ylab="Voltage")
    plot(DateTime,Sub_metering_1,col="black",
         type="l",xlab="",ylab="Energy sub metering")
    lines(DateTime,Sub_metering_2,col="red")
    lines(DateTime,Sub_metering_3,col="blue")
    legend("topright",
           c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
           lty=1,lwd=2,col=c("black","red","blue"),bty="o")
    plot(DateTime,Global_reactive_power,type="l",
         xlab="",ylab="Global Rective Power (kilowatts)")
})
dev.off()