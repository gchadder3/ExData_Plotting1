## plot4.R -- fourth plot script for Week 1 assignment
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

## Generate the graph (a 2 by 2 panel of plots).
par(mfcol=c(2,2))

## Generate the upper-left plot (a line graph of global active power vs. 
## datetime).
plot(powerUse$datetime, powerUse$Global_active_power, type="l", xlab="", 
     ylab="Global Active Power (kilowatts)")

## Generate the lower-left plot (a multi-line graph of the separated out meter 
## readings vs. datetime).
plot(powerUse$datetime, powerUse$Sub_metering_1, type="l", xlab="", 
     ylab="Energy sub metering")
lines(powerUse$datetime, powerUse$Sub_metering_2, col="red")
lines(powerUse$datetime, powerUse$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", 
    "Sub_metering_3"), col=c("black", "red", "blue"), lty="solid", bty="n")

## Generate the upper-right plot (a line graph of voltage vs. 
## datetime).
plot(powerUse$datetime, powerUse$Voltage, type="l", xlab="datetime", 
     ylab="Voltage")

## Generate the lower-right plot (a line graph of global reactive power vs. 
## datetime).
plot(powerUse$datetime, powerUse$Global_reactive_power, type="l", 
     xlab="datetime", ylab="Global_reactive_power")


## Create a png file as a copy of the windows graph.
dev.copy(png, file="plot4.png")

## Close the PNG device.
dev.off()
