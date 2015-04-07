## Read in data
  ## Set delimiter to ;
  ## Set NA to ?
  ## Specify that first line of file is header (variables)
cproj1 <- read.table("./household_power_consumption.txt",sep=";",na.strings="?",stringsAsFactors=F,header=T)

## Convert variable "Date" to date format
cproj1$Date <- as.Date(cproj1$Date,format="%d/%m/%Y")

## Convert variable "Time" to time format
library(chron)
cproj1$Time <- chron(time=cproj1$Time)

## Subset data set to only include data from 02/01/2007 - 02/02/2007
cproj1subset <- subset(cproj1,Date>as.Date("2007-01-31"))
cproj1subset <- subset(cproj1subset,Date<as.Date("2007-02-03"))

## Plot 1 - Global Active Power histogram
png(file="plot1.png",width=480,height=480,units="px")
hist(cproj1subset$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()
