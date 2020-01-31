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

#plot histogram
Global_active_power = data_clean["Global_active_power"][[1]]
Global_active_power = as.numeric(levels(Global_active_power)[Global_active_power])
png(filename = "plot1.png")
hist(Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
