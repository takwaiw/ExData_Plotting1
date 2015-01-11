library(sqldf)
library(lattice)

filename <- "household_power_consumption.txt"
f <- file(filename)

# Read a subset of data  
data <- read.csv.sql(filename, 
                     sql = "select * from f where Date = '1/2/2007' or Date = '2/2/2007' ",
                     colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"),
                     header = TRUE, sep = ";")

plotdata <- data.frame(data$Global_active_power, strptime(paste(data$Date, data$Time), format='%d/%m/%Y %H:%M:%S'))
colnames(plotdata) <- c("Global_active_power", "Datetime")

# Plot the line chart.
plot(plotdata$Global_active_power ~ plotdata$Datetime, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
