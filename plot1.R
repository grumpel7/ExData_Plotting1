# Please note that this R script will include coding to reading the file "household_power_consumption .txt"
# (The assumption is that the file has been downloaded and unzipped into the working directory)

power <- read.csv2("household_power_consumption.txt")
power$Date <- as.Date(power$Date, "%d/%m/%Y")
selected <- subset(power, power$Date == "2007-02-02" | power$Date == "2007-02-01")
# create a new column datetime to store a combined date and time variable in the POSIXct class
selected["datetime"] <- NA
# now merge the two fields Date and Time
selected$datetime <- paste(selected$Date, selected$Time)
selected$datetime <- strptime(selected$datetime, "%Y-%m-%d %H:%M:%S")

# assigning numeric classes to specific variables
selected$Global_active_power <- as.numeric(as.character(selected$Global_active_power))
selected$Global_reactive_power <- as.numeric(as.character(selected$Global_reactive_power))
selected$Voltage <- as.numeric(as.character(selected$Voltage))
selected$Global_intensity <- as.numeric(as.character(selected$Global_intensity))
selected$Sub_metering_1 <- as.numeric(as.character(selected$Sub_metering_1))
selected$Sub_metering_2 <- as.numeric(as.character(selected$Sub_metering_2))
selected$Sub_metering_3 <- as.numeric(as.character(selected$Sub_metering_3))

# drawing the first plot as PNG
png(file="plot1.png") 
hist(selected$Global_active_power, main="Global Active Power",  xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
dev.off()