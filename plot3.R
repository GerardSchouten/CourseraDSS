## Construct a scatter plot of the energy sub metering over a 2 day period 
## in February 2007, and save it to a png file (480 x 480 pixels)

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
   epcSmall$Sub_metering_3 != "?"
epcSmallValid <- epcSmall[NAfilter, ]

## Data to be used as independent variable (date-times)
dates <- epcSmallValid$Date         ## Like: c("27/02/1992", 14/01/2012")
times <- epcSmallValid$Time         ## Like: c("23:03:20", "22:29:56")
x <- paste(dates, times)
xDateTime <- strptime(x, "%d/%m/%Y %H:%M:%S")

## Data to be used as dependent variable
ySM1 <- as.numeric(epcSmallValid$Sub_metering_1)
ySM2 <- as.numeric(epcSmallValid$Sub_metering_2)
ySM3 <- as.numeric(epcSmallValid$Sub_metering_3)

## Open png graphics device
png(file = "plot3.png")

## Create scatterplot
plot(xDateTime, ySM1, xlab = "", ylab = "Energy sub metering", 
     type = "n")        # Suppress plotting of the points
lines(xDateTime, ySM1)  # Add (x,y) values joined by straight lines
lines(xDateTime, ySM2, col = "red")
lines(xDateTime, ySM3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Close the PNG file device
dev.off()
