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

#Plot1
z<-setData()
gaplabel<-"Global Active Power (kilowatts)"
png("plot1.png", width=480,height=480)
hist(z$Global_active_power, main = "Global Active Power", xlab = gaplabel, col = "Red")
dev.off()
