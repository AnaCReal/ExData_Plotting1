#Code for creating the first plot in R

#Reading the data
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, "power_consumption.zip")
unzip("power_consumption.zip")

data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

#Extracting the days we want overwritting to save RAM

data <- data[data$Date=="1/2/2007" | data$Date=="2/2/2007",]

#Convert to Date format and Time format

data$Date <- as.Date(data$Date, format="%d/%m/%Y")

#Convert Global_active_power to numeric

data$Global_active_power <- as.numeric(as.character(data$Global_active_power))

#Plot histogram

hist(data$Global_active_power, col = "red", main="Global Active Power", xlab = "Global Active Power (kilowatts)")

#Export in a png file

dev.copy(png, file = "plot1.png", width=480, height=480)
dev.off()

