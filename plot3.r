###Read data into memory and replace ? as NA###
project_data<-read.table("household_power_consumption.txt", header = T, sep=";", na.strings = "?")

####load lubridate and dply, convert dates and combine to data###
library(lubridate)
library(dplyr)
project_data_dates<-filter(project_data, Date=="1/2/2007" | Date=="2/2/2007")
date_corrected<-dmy(project_data_dates$Date)
time_corrected<-hms(project_data_dates$Time)
datetime<-as.POSIXct(paste(project_data_dates$Date,project_data_dates$Time), format= "%d/%m/%Y %H:%M:%S")
project_data_corr<-cbind(date_corrected,time_corrected, datetime, project_data_dates)

##plot 3
png(file="plot3.png", width=480, height=480)
plot(project_data_corr$datetime, project_data_corr$Sub_metering_1, type="l", ylab = "Energy sub metering", xlab=" ")
lines(project_data_corr$datetime, project_data_corr$Sub_metering_2, col = "red")
lines(project_data_corr$datetime, project_data_corr$Sub_metering_3, col = "blue")
##need to add legend
legend("topright", col=c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1)
dev.off()