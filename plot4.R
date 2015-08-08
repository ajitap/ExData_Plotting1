
##This R Script would select required data from household_power_consumption.txt
##assumption is the txt file is in exdata_data_household_power_consumption directory under working
##directory. In this example sqldf used to extract the required data for ploting plot2
library(sqldf)

##Read Data from the .txt file
epcData <- read.table("exdata_data_household_power_consumption/household_power_consumption.txt", header = TRUE, sep=";",  na.strings = "?")

##Create a new attribute newDate that will be used to compare the data
epcData$newDate <- as.character(as.Date(epcData$Date, format = "%d/%m/%Y"))

##use qsldf to extract records between "2007-02-01" and "2007-02-02"
selectedData <- sqldf('select * from epcData where newDate between "2007-02-01" and  "2007-02-02"')

seldatetime <- strptime(paste(selectedData$Date, selectedData$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

##Open PNG Device
png(filename = "plot4.png", width = 480, height = 480, units = "px")
##Partition the graph into two rows
par(mfrow = c(2, 2)) 
##Graph4 Plot4
##Plot first row Global Active Power and Voltage
##cex  number indicating the amount by which plotting text and symbols 
##should be scaled relative to the default. 1=default, 0.5 is 50% smaller so adjust accordingly
##First row first column
plot(seldatetime, as.numeric(selectedData$Global_active_power), type="l", xlab="", ylab="Global Active Power", cex=0.3)
##First row second column
plot(seldatetime, as.numeric(selectedData$Voltage), type="l", xlab="datetime", ylab="Voltage")

##2nd row Energy sub metering and Global Reactive Power
##Second row first column
plot(seldatetime, as.numeric(selectedData$Sub_metering_1), type="l", xlab="", ylab="Energy sub metering", cex=0.3)
lines(seldatetime,as.numeric(selectedData$Sub_metering_2), type="l", col="red" )
lines(seldatetime,as.numeric(selectedData$Sub_metering_3), type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2, col=c("black", "red", "blue"))
##second row seond column
plot(seldatetime, as.numeric(selectedData$Global_reactive_power), type="l", xlab="datetime", ylab="Global_reactive_power")

##Close the pngdevice
dev.off()

