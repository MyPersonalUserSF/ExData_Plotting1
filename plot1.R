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

# Generate the histogram of Global Active Power
hist(hpcData$GblActivePower, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

# Copy the plot to a png file
dev.copy(png, file="plot1.png")
dev.off()

# Produce the png file
