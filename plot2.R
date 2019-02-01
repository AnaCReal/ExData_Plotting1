#Code for creating the second plot in R

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

#Convert Global active power to numeric

data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
transform(data, Global_active_power = (Global_active_power/500))

#Plot Global active power by day

plot(Day, data$Global_active_power, type = "l", xlab="", ylab="Global Active Power (kilowatts)")

#Export in a png file

dev.copy(png, file = "plot2.png", width=480, height=480)
dev.off()


