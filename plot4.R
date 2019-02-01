#Code for creating the fourth plot in R

#Reading the data

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, "power_consumption.zip")
unzip("power_consumption.zip")

data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

#Extracting the days we want overwritting to save RAM

data <- data[data$Date=="1/2/2007" | data$Date=="2/2/2007",]

#Convert to Date format and Time format

Sys.setlocale("LC_TIME", "C")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
Day <- as.POSIXct(paste(data$Date, data$Time), "%d/m%/Y% %H:%M:%S")

#Create a 2 x 2 space
par(mfrow=c(2,2))

#Convert Global active power to numeric

data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
transform(data, Global_active_power = (Global_active_power/500))

#Convert Voltaje to numeric

data$Voltage <- as.numeric(as.character(data$Voltage))

#Convert Sub metering columns to numeric

data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))

#Convert Global Reactive Power to numeric

data$Global_reactive_power <- as.numeric(as.character(data$Global_reactive_power))

#Plot Global active power by day

plot(Day, data$Global_active_power, type = "l", xlab="", ylab="Global Active Power (kilowatts)")

#Plot Voltage by day

plot(Day, data$Voltage, type="l", xlab="datetime", ylab="Voltage")

#Plot each Sub metering by day

plot(Day, data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(Day, data$Sub_metering_2, col="red")
lines(Day, data$Sub_metering_3, col="blue")
legend("topright", inset=0.001,lty=c(1,1), lwd=c(1,1), col=c("black","red","blue"), c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), bty="n", cex = 0.6)

#Plot Global reactive power

plot(Day, data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

#Export in a png file

dev.copy(png, file = "plot4.png", width=480, height=480)
dev.off()
