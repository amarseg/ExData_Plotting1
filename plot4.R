####
rm(list = ls())
library(lubridate)
library('tidyverse')
setwd('C:/Users/liama/Documents/data_science/plotting_data/project1/')

consum_data <- read.delim(file = 'household_power_consumption.txt', sep = ';', header = T, strings = F)
#change missing values (coded as ?) to NAs
#consum_data[which(consum_data == '?'),] <- NA

consum_data$Date <- dmy(consum_data$Date)
consum_data$date_time <- strptime(x = paste(consum_data$Date, consum_data$Time, sep = ' '), format = "%Y-%m-%d %H:%M:%S")


##We are only interested in data from 2007-02-01 and 2007-02-02
##I subset the data and remove the original to get more space in memory
interesting_data <- consum_data[which(consum_data$Date == ymd('2007-02-01') | consum_data$Date == ymd('2007-02-02')),]
rm(consum_data)

#png dimensions
w <- 480
h <- 480



png('plot4.png', width = w, height = h, units = 'px')
par(mfrow = c(2,2))
#p1
plot(x = interesting_data$date_time, y = interesting_data$Global_active_power, type ='l', ylab= 'Global Active Power (kilowatts)', xlab = '')
#p2
plot(x = interesting_data$date_time, y = interesting_data$Voltage, type ='l', ylab= 'Voltage', xlab = '')
#p3
plot(x = interesting_data$date_time, y = interesting_data$Sub_metering_1, type ='l', ylab= 'Energy sub mettering', xlab = '', lty = 1)
lines(x = interesting_data$date_time, y = interesting_data$Sub_metering_2, col = 'red', type = 'l', lty = 1)
lines(x = interesting_data$date_time, y = interesting_data$Sub_metering_3, col = 'blue', type = 'l', lty = 1)
legend('topright', legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), fill  = c('black', 'red','blue'))
#p4
plot(x = interesting_data$date_time, y = interesting_data$Global_reactive_power, type = 'l', xlab = 'datetime', ylab = 'Global_reactive_power')

dev.off()

#reset plotting device
par(mfrow = c(1,1))