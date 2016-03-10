## plot1.R -- first plot script for Week 1 assignment
##
## Last update: 3/10/16 (George Chadderdon)

## Load in the data.

## Read in the complete dataset (was 126.8 MB).
powerUse <- read.table("data/household_power_consumption.txt", header=TRUE, 
    sep=";", na.strings="?")
# print(object.size(powerUse), units="Mb")

## Convert the dates into a proper date type (size goes up to 221.8 MB).
powerUse$Date <- strptime(powerUse$Date, format="%d/%m/%Y")
# print(object.size(powerUse), units="Mb")

## Convert the times into proper time types (size goes up to 316.7 MB).
powerUse$Time <- strptime(powerUse$Time, format="%H:%M:%S")
# print(object.size(powerUse), units="Mb")

## Remove all data except for at the dates of interest (2/1 - 2/2, 2007).
powerUse <- subset(powerUse, Date %in% c("2007-02-01", "2007-02-02"))

## Create a datetime column that has the correct date and time.

## Start with extracting the correct time from the Time column.
powerUse$datetime <- powerUse$Time

## Extract the right date information from the Date column.
powerUse$datetime$mon <- powerUse$Date$mon
powerUse$datetime$mday <- powerUse$Date$mday
powerUse$datetime$year <- powerUse$Date$year


## Open a full windows() graphics device.
windows()

## Generate the plot (a histogram of all of the global active power values).
hist(powerUse$Global_active_power, col="red", main="Global Active Power", 
    xlab="Global Active Power (kilowatts)")

## Create a png file as a copy of the windows graph.
dev.copy(png, file="plot1.png")

## Close the PNG device.
dev.off()
