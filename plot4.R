library(sqldf)
library(lattice)

filename <- "household_power_consumption.txt"
f <- file(filename)

# Read a subset of data  
data <- read.csv.sql(filename, 
                     sql = "select * from f where Date = '1/2/2007' or Date = '2/2/2007' ",
                     colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"),
                     header = TRUE, sep = ";")

plotdata <- data.frame(data$Global_active_power,
                       data$Global_reactive_power,
                       data$Voltage,
                       data$Sub_metering_1,
                       data$Sub_metering_2,
                       data$Sub_metering_3,
                       strptime(paste(data$Date, data$Time), format='%d/%m/%Y %H:%M:%S'))
colnames(plotdata) <- c("Global_active_power", "Global_reactive_power", "Voltage", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3", "Datetime")

# Save a copy for debugging purpose.
#write.csv(plotdata, file = "household_power_consumption.plotdata.csv")

# Set up the global plot parameters.
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1))

# Plot Global Active Power at the top left area.
plot(plotdata$Global_active_power ~ plotdata$Datetime, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power",
     cex.lab = 0.8)

# Plot Global Active Power at the top right area.
plot(plotdata$Voltage ~ plotdata$Datetime, 
     type = "l",
     xlab = "datetime",
     ylab = "Voltage",
     cex.lab = 0.8)

# Plot the sub metering at the bottom left area.
plot(plotdata$Sub_metering_1 ~ plotdata$Datetime,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering",
     cex.lab = 0.8)

lines(plotdata$Sub_metering_2 ~ plotdata$Datetime, col = "red")
lines(plotdata$Sub_metering_3 ~ plotdata$Datetime, col = "blue")
legend("topright", 
       lty = c(1, 1, 1),
       col = c("black", "red", "blue"),
       bty = "n",
       cex = 0.6,
       text.width= 80000,
       y.intersp = 0.8,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Plot Global Active Power at the bottom right area.
plot(plotdata$Global_reactive_power ~ plotdata$Datetime, 
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power",
     cex.lab = 0.8)

