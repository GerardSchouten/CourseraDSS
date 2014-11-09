## Construct 4 scatter plots of a household electric power consumption over a 
## 2 day period in February 2007, and save it to a png file (480 x 480 pixels)

## Preparation: 
# 1. Set working directory to the folder where the data is stored
# 2. Set LC_TIME to English (otherwise I get the weekdays in Dutch).  

# Sys.setlocale("LC_TIME","English")

## Read data file (check if there is enough memory), everything as character
epcFull <- read.table("household_power_consumption.txt", sep = ";", 
                      header = TRUE, colClasses = "character")

## The data frame epcFull has 2075259 obs. of 9 variables

## Make a subset of 2 (arbitray) days in Feb 2007
dateFilter <- (as.Date(epcFull$Date, "%d/%m/%Y") > '2007-02-14') &
   (as.Date(epcFull$Date, "%d/%m/%Y") < '2007-02-17')    # Logical vector
epcSmall <- epcFull[dateFilter, ]

## The data frame epcSmall has 2880 obs. of 9 variables

## Make a valid subset (remove possible "?" in the data)
NAfilter <- epcSmall$Sub_metering_1 != "?" & epcSmall$Sub_metering_2 != "?" & 
   epcSmall$Sub_metering_3 != "?" & epcSmall$Voltage != "?" &
   epcSmall$Global_active_power != "?" &
   epcSmall$Global_reactive_power != "?"

epcSmallValid <- epcSmall[NAfilter, ]

## Data to be used as independent variable (date-times)
dates <- epcSmallValid$Date         ## Like: c("27/02/1992", 14/01/2012")
times <- epcSmallValid$Time         ## Like: c("23:03:20", "22:29:56")
x <- paste(dates, times)
xDateTime <- strptime(x, "%d/%m/%Y %H:%M:%S")

## Data to be used as dependent variable for plot 1
yGAP <- as.numeric(epcSmallValid$Global_active_power)

## Data to be used as dependent variable for plot 2
ySM1 <- as.numeric(epcSmallValid$Sub_metering_1)
ySM2 <- as.numeric(epcSmallValid$Sub_metering_2)
ySM3 <- as.numeric(epcSmallValid$Sub_metering_3)

## Data to be used as dependent variable for plot 3
yVolt <- as.numeric(epcSmallValid$Voltage)

## Data to be used as dependent variable for plot 4
yGRP <- as.numeric(epcSmallValid$Global_reactive_power)

## Open png graphics device
png(file = "plot4.png")

par(mfcol = c(2, 2))

## Create scatterplot 1
plot(xDateTime, yGAP, xlab = "", ylab = "Global Active Power", 
     type = "n")        # Suppress plotting of the points
lines(xDateTime, yGAP)  # Add (x,y) values joined by straight lines

## Create scatterplot 2
plot(xDateTime, ySM1, xlab = "", ylab = "Energy sub metering", 
     type = "n")        
lines(xDateTime, ySM1)  
lines(xDateTime, ySM2, col = "red")
lines(xDateTime, ySM3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Create scatterplot 3
plot(xDateTime, yVolt, xlab = "datetime", ylab = "Voltage", type = "n")        
lines(xDateTime, yVolt) 

## Create scatterplot 4
plot(xDateTime, yGRP, xlab = "datetime", ylab = "Global_rective_power", 
     type = "n")        
lines(xDateTime, yGAP)  

## Close the PNG file device
dev.off()