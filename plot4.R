#If required source data can be obtained from: 
#"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#Extract the data file "household_power_consumption.txt" to the working directory 

#Read data in
household <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings="?")

#Convert Date variable from factor to Date variable class
household$Date <- as.Date(household$Date, format="%d/%m/%Y")

#Subset to leave only required dates and then remove the original data to free up memory
datasubset <- household[(household$Date=="2007-02-01") | (household$Date=="2007-02-02"),]
rm(household)

#Concatenate date and time variables and convert to a POSIXit variable class
#Create a new variable with a more meaningful name. This variable will be used in the plots
#The temp variable used during conversion is then removed
datasubset$temptime <- paste(datasubset$Date, datasubset$Time)
datasubset$Time <- strptime(datasubset$temptime, format = "%Y-%m-%d %H:%M:%S")
datasubset$datetime <- datasubset$Time
datasubset <- datasubset[-10]

#Create plot 4 to specified size. Plot is set transparent to match original.
png("plot4.png", width=480, height=480, bg="transparent")
par(mfrow=c(2,2))
plot(datasubset$datetime, datasubset$Global_active_power, type="l", xlab="", ylab="Global Active Power")
plot(datasubset$datetime, datasubset$Voltage, type="l", xlab="datetime", ylab="Voltage")
plot(datasubset$datetime, datasubset$Sub_metering_1, xlab="", ylab="Energy sub metering", type="l")
lines(datasubset$datetime, datasubset$Sub_metering_2, col="red")
lines(datasubset$datetime, datasubset$Sub_metering_3, col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd=1, col=c("black","red","blue"), bty="n", cex=0.8)
plot(datasubset$datetime, datasubset$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()