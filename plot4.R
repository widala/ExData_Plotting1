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

## Create new variable containing Datetime
cproj1subset$Datetime <- as.POSIXct(paste(cproj1subset$Date,cproj1subset$Time))

## Plot 4
png(file="plot4.png",width=480,height=480,units="px")
par(mfrow=c(2,2))
with(cproj1subset, {
  plot(cproj1subset$Datetime,cproj1subset$Global_active_power,type="S",ylab="Global Active Power",xlab="")
  plot(cproj1subset$Datetime,cproj1subset$Voltage,type="S",ylab="Voltage",xlab="datetime")
  plot(cproj1subset$Datetime, cproj1subset$Sub_metering_1,type="S",ylab="Energy sub metering",xlab="",col="black")
  lines(cproj1subset$Datetime, cproj1subset$Sub_metering_2,type="S",ylab="Energy sub metering",xlab="",col="red")
  lines(cproj1subset$Datetime, cproj1subset$Sub_metering_3,type="S",ylab="Energy sub metering",xlab="",col="blue")
  legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  plot(cproj1subset$Datetime,cproj1subset$Global_reactive_power,type="S",ylab="Global_reactive_power",xlab="datetime")
})
dev.off()
