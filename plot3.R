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

##Creates plot 3 as a png file in the working directory called "plot3.png"
png(file = "plot3.png")
plot(hpc_sub$DateTime, hpc_sub$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(hpc_sub$DateTime, hpc_sub$Sub_metering_1, col = "black")
lines(hpc_sub$DateTime, hpc_sub$Sub_metering_2, col = "red")
lines(hpc_sub$DateTime, hpc_sub$Sub_metering_3, col = "blue")
legend("topright", lwd = c(1,1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

