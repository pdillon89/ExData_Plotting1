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

###create histogram plot1 and save as png file
hist(project_data_corr$Global_active_power, col = "red", main = "Global Active Power", xlab =  "Global Active Power (kilowatts)")
dev.copy(png, "plot1.png", width=480, height=480)
dev.off()
