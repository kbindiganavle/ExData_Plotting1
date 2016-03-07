# download and unzip dataset
dataDir <- "./data"
destFile <- paste(dataDir, "/courseProjectDataSet.zip", sep="")
if (!file.exists(dataDir)) {
    dir.create(dataDir)
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = destFile, method = "curl")
}

# read data
file <- unzip(destFile, exdir = dataDir)
data <- read.table(file, sep=";", header = TRUE, na.strings = "?")

#change factor of Date column to Date
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

#subset data
relevantData <- subset(data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

#combine date and time to create timestamps
relevantData$timestamp <- strptime(paste(relevantData$Date, relevantData$Time), format = "%Y-%m-%d %H:%M:%S")

#plot into a png file
png("plot3.png", width=480, height=480)
plot(relevantData$timestamp, relevantData$Sub_metering_1, type="l", xlab="", ylab="Energy Submetering")
lines(relevantData$timestamp,relevantData$Sub_metering_2,col="red")
lines(relevantData$timestamp,relevantData$Sub_metering_3,col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1, lwd=2)
dev.off()