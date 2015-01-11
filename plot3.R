library(sqldf)
library(lattice)

filename <- "household_power_consumption.txt"
f <- file(filename)

# Read a subset of data  
data <- read.csv.sql(filename, 
                     sql = "select * from f where Date = '1/2/2007' or Date = '2/2/2007' ",
                     colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"),
                     header = TRUE, sep = ";")

plotdata <- data.frame(data$Sub_metering_1, data$Sub_metering_2, data$Sub_metering_3, strptime(paste(data$Date, data$Time), format='%d/%m/%Y %H:%M:%S'))
colnames(plotdata) <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3", "Datetime")

# Plot the line chart.
plot(plotdata$Sub_metering_1 ~ plotdata$Datetime,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering")

lines(plotdata$Sub_metering_2 ~ plotdata$Datetime, col = "red")
lines(plotdata$Sub_metering_3 ~ plotdata$Datetime, col = "blue")
legend("topright", 
       lty = c(1, 1, 1),
       col = c("black", "red", "blue"),
       cex = 0.6,
       text.width= 45000,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
