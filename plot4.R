##Assuming the household_power_consumption data file is in the working directory,
##this line creates a data frame called "hpc" out of said data file.
hpc <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?",
                  colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

##Combines Date and Time variables into a new single column and converts to POSIXlt class
DateTime <- paste(hpc[,1], hpc[,2], sep = " ")
DateTime <- strptime(DateTime, format = "%d/%m/%Y %H:%M:%S") 
hpc$DateTime <- DateTime

##Creates subset of data for just the dates 2007-02-01 and 2007-02-02
hpc_sub <- subset(hpc, "2007-01-31 23:59:59" < DateTime)
hpc_sub <- subset(hpc_sub, DateTime < "2007-02-03")

##Creates 4 separate plots as one png file in the working directory called "plot4.png"
png(file = "plot4.png")
par(mfcol = c(2, 2))
  
##Upper Left Plot
plot(hpc_sub$DateTime, hpc_sub$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(hpc_sub$DateTime, hpc_sub$Global_active_power)

##Lower Left Plot
plot(hpc_sub$DateTime, hpc_sub$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(hpc_sub$DateTime, hpc_sub$Sub_metering_1, col = "black")
lines(hpc_sub$DateTime, hpc_sub$Sub_metering_2, col = "red")
lines(hpc_sub$DateTime, hpc_sub$Sub_metering_3, col = "blue")
legend("topright", cex = 0.75, bty = "n", lwd = c(1,1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

##Upper Right Plot
plot(hpc_sub$DateTime, hpc_sub$Voltage, type = "n", xlab = "datetime", ylab = "Voltage")
lines(hpc_sub$DateTime, hpc_sub$Voltage)

##Lower Right Plot
plot(hpc_sub$DateTime, hpc_sub$Global_reactive_power, type = "n", xlab = "datetime", ylab = "Global_reactive_power")
lines(hpc_sub$DateTime, hpc_sub$Global_reactive_power)

dev.off()

