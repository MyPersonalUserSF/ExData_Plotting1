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

# Generate the a line plot of Global Active Power by day of the week
## Set the margins
par(mar = c(5, 5, 3, 1))
## Axis information will be added manually, so turn off auto generation
plot(hpcData$GblActivePower, type="l", ylab="Global Active Power (kilowatts)", xlab="", axes=FALSE)
box()
axis(1, at=c(1, 1500, 2900), lab=c("Thu", "Fri", "Sat"))
axis(2, at=c(0, 2, 4, 6), lab=c("0", "2", "4", "6"))

# Produce the png file
dev.copy(png, file="plot2.png")
dev.off()
