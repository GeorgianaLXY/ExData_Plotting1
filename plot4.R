setwd("~/Desktop/coursera data science class")

#load data
data <- read.table('household_power_consumption.txt',sep = ';',header = TRUE)

#convert date_time
data["date,time"] = paste(data[,1], data[,2])
data["time"] = lapply(data["date,time"], strptime, format = "%d/%m/%Y %H:%M:%S")
data = data[, c(-1,-2)]

#select designated time_period
start_point <- strptime("31/01/2007 23:59:00", format = "%d/%m/%Y %H:%M:%S")
end_point <- strptime("03/02/2007 00:00:00", format = "%d/%m/%Y %H:%M:%S")
data_clean = data[which((data$time > start_point) & (data$time < end_point)),]

#transfortation of data
Global_active_power = data_clean["Global_active_power"][[1]]
data_clean["Global_Active_Power"] = as.numeric(levels(Global_active_power)[Global_active_power])
Global_reactive_power = data_clean["Global_reactive_power"][[1]]
data_clean["Global_Reactive_Power"] = as.numeric(levels(Global_reactive_power)[Global_reactive_power])


#plot

png(filename = "plot4.png")
par(mfcol = c(2,2))
with(data_clean,{
    plot(time, Global_Active_Power, type = "l",xlab = "", ylab = "Global Active Power") 
    plot(time, Sub_metering_1, type = "l",xlab = "", ylab = "Energy sub metering")
    lines(time, Sub_metering_2, col = "red")
    lines(time, Sub_metering_3, col = "blue")
    legend("topright", col = c("black","blue", "red"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), pch = c(NA, NA,NA ),merge = TRUE, lty = 1)
    plot(time, Voltage, type = "l",xlab = "", ylab = "Voltage")
    plot(time, Global_Reactive_Power, type = "l",xlab = "", ylab = "Global Reactive Power")
})
dev.off()
