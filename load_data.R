library(downloader)
library(dplyr)

## clear current workspace
rm(list = ls())

if (!file.exists("./data/powerData.csv")){ 
    ## get the current working directory and define the data folder
    mainDir <- getwd()
    dir.create(file.path(mainDir, "data"), showWarnings = FALSE)
    
    ## download the data
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    zipfile <- "./data/dataset.zip"
    download(url, dest=zipfile, mode="wb") 
    unzip (zipfile, exdir = "./data")
    datafile <- paste("./data/",list.files(path = "./data")[2],sep="")
    
    ## Calculate memory required and prompt user whether or not to proceed
    memory_required <- 9 * 2075259 * 8
    print(paste("Memory required: ",round(memory_required/2^20,digits = 1)," MB",sep=""))
    
    if (readline(prompt="Proceed with data read (Y or N)? ") == "Y") {
        ## read in the data to a data frame
        totalData <- read.table(datafile,header=TRUE,sep=";")
        
        ## subset the data for the dates in question
        totalData <- filter(totalData, Date != "?")
        totalData$Date <- as.Date(totalData$Date,format="%d / %m / %Y")
        dates <- as.Date(c("1/2/2007","2/2/2007"),format="%d / %m / %Y")
        powerData <- filter(totalData, Date %in% dates) 
        write.table(powerData,file="./data/powerData.csv")
    }
    
    ## remove totalData in order to save memory
    remove(totalData)
}

## read power data from csv
powerData <- read.csv("./data/powerData.csv",header=TRUE,sep="")





