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

## Construct histogram
plot1 <- hist(data[,3], breaks=12, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")

## Create PNG file
dev.copy(png, file="plot1.PNG", height=480, width=480)
dev.off()