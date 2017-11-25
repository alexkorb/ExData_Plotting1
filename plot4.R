library("lubridate")

setData<-function(dir=".", infile="household_power_consumption.txt" ) {
  setwd(dir)
  #I don't need more than 70K rows since all the data we want is in rows 66637 to 69517
  x<-read.table("household_power_consumption.txt", header= TRUE, nrows = 70000, sep = ";", na.strings = "?")
  #Reformat the dates
  x$Date<-dmy(x$Date)
  x$datetime<-with (x, as.POSIXct(paste(Date, Time))) 
  #Select only February 1st and 2nd, 2007
  z<-x[x$Date=="2007-2-2" | x$Date=="2007-2-1",]
}

#Plot4
z<-setData()
png("plot4.png", width=480,height=480)
par(mfrow=c(2,2))
#1 
plot(Global_active_power ~ datetime, z, xlab = "" , ylab = "Global Active Power", type="l")

#2
plot(Voltage ~ datetime, z, type="l")
#3
plot(Sub_metering_1 ~ datetime, z, xlab = "" , ylab = "Energy sub metering", type="l")
points(Sub_metering_2 ~ datetime, z, type="l", col="Red")
points(Sub_metering_3 ~ datetime, z, type="l", col="Blue")
legend("topright", lty=1, lwd=1, col=c("Black", "Red", "Blue"), bty="n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#4
plot(Global_reactive_power ~ datetime, z, type="l")
dev.off()

