###get data
project_data<-read.table("household_power_consumption.txt", header = T, sep=";", na.strings = "?")

####load lubridate and dply, convert dates and combine to data###
library(lubridate)
library(dplyr)
project_data_dates<-filter(project_data, Date=="1/2/2007" | Date=="2/2/2007")
date_corrected<-dmy(project_data_dates$Date)
time_corrected<-hms(project_data_dates$Time)
datetime<-as.POSIXct(paste(project_data_dates$Date,project_data_dates$Time), format= "%d/%m/%Y %H:%M:%S")
project_data_corr<-cbind(date_corrected,time_corrected, datetime, project_data_dates)

###plot 4
png(file="plot4.png", width=480, height=480)
par(mfrow=c(2,2))
with(project_data_corr, {
        plot(datetime, Global_active_power, type = "l", xlab = " ", ylab="Global Active Power (kilowatts)")
        plot(datetime, Voltage, type="l")
        plot(project_data_corr$datetime, project_data_corr$Sub_metering_1, type="l", ylab = "Energy sub metering", xlab=" ")
        lines(project_data_corr$datetime, project_data_corr$Sub_metering_2, col = "red")
        lines(project_data_corr$datetime, project_data_corr$Sub_metering_3, col = "blue")
        legend("topright", box.lwd = 0, col=c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1)
        plot(datetime, Global_reactive_power, type = "l")
        })
dev.off()