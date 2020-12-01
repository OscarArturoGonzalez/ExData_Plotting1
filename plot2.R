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

## PLOT 2
plot(table$Global_active_power~table$dTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

## Save
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()
