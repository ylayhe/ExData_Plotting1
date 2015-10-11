## Read txt file and return only rows that correspond to specified time frame  
## Read from 66638 to 69517  
## Assign column names as well and missing values (?) as NA
data <- read.table("household_power_consumption.txt", sep=";", na.strings=c("?", ""), 
                   header=FALSE, skip=66637, nrows=2880, col.names = c("Date", "Time", 
                                                                       "Global_active_power", "Global_reactive_power", 
                                                                       "Voltage", "Global_intensity", "Sub_metering_1",
                                                                       "Sub_metering_2", "Sub_metering_3"))

## Transform Date column to Date data type
data$Date <- as.Date(data$Date, format="%d/%m/%Y") 
## Create Timestamp value by combining Date and Time
data$Timestamp <- paste(data$Date, data$Time)
## Transform Time column into POSIXlt data type 
data$Time <- strptime(data$Timestamp, format="%Y-%m-%d %H:%M:%S")

## Set global parameters
png("plot4.png", width=480, height=480, type="windows")
par(mfrow=c(2,2), mar = c(4, 4, 2, 2), oma = c(0, 0, 2, 0))
with(data, {
  ## Create first plot
  plot(x=data[,2], y=data[,3], type="l", xlab="", ylab="Global Active Power")
  ## Create second plot
  plot(x=data[,2], y=data[,5], type="l", xlab="datetime", ylab="Voltage")
  ## Create third plot
  plot(x=data[,2], y=data[,7], type="l", xlab="", ylab="Energy sub metering")
  lines(x=data[,2], y=data[,8], type="l", col="red")
  lines(x=data[,2], y=data[,9], type="l", col="blue")
  legend("topright", c(colnames(data[7]), colnames(data[8]), colnames(data[9])), 
         lty=1, col=c("black", "red", "blue"), bty="n")
  ## Create fouth plot
  plot(x=data[,2], y=data[,4], type="l", xlab="datetime", ylab=colnames(data[4]))
})

## Close graphics
dev.off()
