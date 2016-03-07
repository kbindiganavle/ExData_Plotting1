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

#plot
png("plot2.png", width=480, height=480)
plot(relevantData$timestamp, relevantData$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()