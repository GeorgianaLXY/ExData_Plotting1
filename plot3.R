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

#plot
png(filename = "plot3.png")
with(data_clean, plot(time, Sub_metering_1, type = "l",xlab = "", ylab = "Energy sub metering"))
with(data_clean, lines(time, Sub_metering_2, col = "red"))
with(data_clean, lines(time, Sub_metering_3, col = "blue"))
legend("topright", col = c("black","blue", "red"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), pch = c(NA, NA,NA ),merge = TRUE, lty = 1)
dev.off()
