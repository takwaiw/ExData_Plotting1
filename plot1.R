library(sqldf)

filename <- "household_power_consumption.txt"
f <- file(filename)

# Read a subset of data  
data <- read.csv.sql(filename, 
                     sql = "select * from f where Date = '1/2/2007' or Date = '2/2/2007' ",
                     colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"),
                     header = TRUE, sep = ";")

data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# Plot the histogram.
#par(mfrow = c(1, 1))
hist(data$Global_active_power, 
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)" )
