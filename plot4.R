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

# drawing the fourth set of plots as PNG
png(file="plot4.png") 
par(mfrow=c(2,2))
with (selected,{
        plot(datetime,Global_active_power,type="l",xlab="", ylab="Global Active Power")
        plot(datetime,Voltage, type="l")
        plot(datetime,Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
             lines(datetime, Sub_metering_1, type="l", col ="black")
             lines(datetime, Sub_metering_2, type="l", col ="red")
             lines(datetime, Sub_metering_3, type="l", col ="blue")
             legend("topright", bty = "n", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1),lwd=c(2.5,2.5,2.5),col=c("black","red", "blue"))
        plot(datetime,Global_reactive_power,type="l")
})
dev.off()