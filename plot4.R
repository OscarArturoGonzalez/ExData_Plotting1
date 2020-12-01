## 1. Read the data from the source
## 2. Change date to Type Date
## 3. Subtract from data set from Feb. 1, 2007 to Feb. 2, 2007
## 4. Remove incomplete observation
## 5. Combine columns Date and Time in dTime
## 6. Name dTime vector as "DateTime" 
## 7. Remove columns: Date and Time
## 8. Add column: dTime
## 9. Format dTime column

table <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

table$Date <- as.Date(table$Date, "%d/%m/%Y")

table <- subset(table,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

table <- table[complete.cases(table),]

dTime <- paste(table$Date, table$Time)

dTime <- setNames(dTime, "DateTime")

table <- table[ ,!(names(table) %in% c("Date","Time"))]

table <- cbind(dTime, table)

table$dTime <- as.POSIXct(dTime)

## PLOT 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(table, {
  plot(Global_active_power~dTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~dTime, type="l", 
       ylab="Voltage (volt)", xlab="datetime")
  plot(Sub_metering_1~dTime, type="l", 
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~dTime,col='Red')
  lines(Sub_metering_3~dTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dTime, type="l", 
       ylab="Global_reactive_power (kilowatts)",xlab="datetime")
})

## Save
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()