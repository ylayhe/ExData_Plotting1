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

## Create plot
png("plot3.png", width=480, height=480, type="windows")
plot(x=data[,2], y=data[,7], type="l", xlab="", ylab="Energy sub metering")
lines(x=data[,2], y=data[,8], type="l", col="red")
lines(x=data[,2], y=data[,9], type="l", col="blue")
legend("topright", c(colnames(data[7]), colnames(data[8]), colnames(data[9])), 
       lty=1, col=c("black", "red", "blue"), cex=0.8)

## Close graphics 
dev.off()
