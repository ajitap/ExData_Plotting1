
##This R Script would select required data from household_power_consumption.txt
##assumption is the txt file is in exdata_data_household_power_consumption directory under working
##directory. In this example sqldf used to extract the required data for ploting plot1
#Include libraries. If any library not found then install the corresponding package
library(sqldf)
library(datasets)
##Read Data from the .txt file
epcData <- read.table("exdata_data_household_power_consumption/household_power_consumption.txt", header = TRUE, sep=";",  na.strings = "?")

##Create a new attribute newDate that will be used to compare the data
epcData$newDate <- as.character(as.Date(epcData$Date, format = "%d/%m/%Y"))

##use qsldf to extract records between "2007-02-01" and "2007-02-02"
selectedData <- sqldf('select * from epcData where newDate between "2007-02-01" and  "2007-02-02"')

##Open PNG Device
png(filename = "plot1.png", width = 480, height = 480, units = "px")
##Graph1 Plot1 
hist(selectedData$Global_active_power, xlab="Global Active Power (Kilowatt)", col="red1", main="Global Active Power")
##Close the pngdevice
dev.off()

