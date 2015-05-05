## Read the Household Power Consumption data and cache it for later use.
if (length(grep("hpcData", ls(1)))==0) {
	# Cache hcpData into parent.env
	hpc.c<-file("~/Coursera/exdata-014/household_power_consumption.txt")
	open(hpc.c)
	# Read just the data for 2007-02-01 and 2007-02-02 
	## nrows = 2,880 which is 2 days of a measurement in minute of the day (1,440 = 60 x 24)
	hpcData <- read.table(hpc.c, skip=66637, nrows=2880, sep=";", stringsAsFactors=FALSE)
	close(hpc.c)
	colnames(hpcData) <- c("Date", "Time", "GblActivePower", "GblReactivePower", "Voltage", "GblIntesity", "SubMeter1", "SubMeter2", "SubMeter3")
	hpcData$DateTime <- strptime((paste(hpcData[, 1], hpcData[, 2])), format="%d/%m/%Y %H:%M:%S")
	} else {	
	print("Using prior load of Household Power Consumption data")
	}


## Generate directly to PNG, as dev.copy distorts the image.
png(filename="plot4.png")

## Set for 4 plots on the page, set the margins and text size
par(mfrow=c(2, 2), mar=c(4, 4, 2, 2), cex=0.8)

# Generate the a line plot of Global Active Power by day of the week
## Axis information will be added manually, so turn off auto generation
plot(hpcData$GblActivePower, type="l", ylab="Global Active Power", xlab="", axes=FALSE)
box()
axis(1, at=c(1, 1500, 2900), lab=c("Thu", "Fri", "Sat"))
axis(2, at=c(0, 2, 4, 6), lab=c("0", "2", "4", "6"))

# Generate the a line plot of Voltage by day of the week
## Axis information will be added manually, so turn off auto generation
plot(hpcData$Voltage, type="l", ylab="Voltage", xlab="datetime", axes=FALSE)
box()
axis(1, at=c(1, 1500, 2900), lab=c("Thu", "Fri", "Sat"))
axis(2, at=c(234, 238, 242, 246), lab=c("234", "238", "242", "246"))

# Generate the a line plot of Sub Metering data by day of the week
## Axis information will be added manually, so turn off auto generation
plot(hpcData$SubMeter1, type="l", ylab="Energy sub metering", xlab="", axes=FALSE)
lines(hpcData$SubMeter2, type="l", col="red")
lines(hpcData$SubMeter3, type="l", col="blue")
box()
axis(1, at=c(1, 1500, 2900), lab=c("Thu", "Fri", "Sat"))
axis(2, at=c(0, 10, 20, 30, 40), lab=c("0", "10", "20", "30", "40"))
legend("topright", bty="n", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1, 1, 1), col=c("black", "red", "blue"), cex=0.9)

# Generate the a line plot of Global Reactive Power by day of the week
## Axis information will be added manually, so turn off auto generation
plot(hpcData$GblReactivePower, type="l", ylab="Global_rective_power", xlab="datetime", axes=FALSE)
box()
axis(1, at=c(1, 1500, 2900), lab=c("Thu", "Fri", "Sat"))
axis(2, at=c(0.0, 0.1, 0.2, 0.3, 0.4, 0.5), lab=c("0.0", "0.1", "0.2", "0.3", "0.4", "0.5"), cex=0.5)

# Produce the png file
## Not using dev.copy, as dev.copy distorts the image.
#dev.copy(png, file="plot4.png")
dev.off()
