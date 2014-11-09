## Construct a scatter plot of Global Active Power over a 2 day period 
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
epcSmallValid <- epcSmall[epcSmall$Global_active_power != "?",]

## Data to be used as independent variable (date-times)
dates <- epcSmallValid$Date         ## Like: c("27/02/1992", 14/01/2012")
times <- epcSmallValid$Time         ## Like: c("23:03:20", "22:29:56")
x <- paste(dates, times)
xDateTime <- strptime(x, "%d/%m/%Y %H:%M:%S")

## Alternative:
# xDatetime <- ISOdatetime(df$Year, df$Month, df$Day, df$Hour, df$Minute, 0)

## Data to be used as dependent variable
yGAP <- as.numeric(epcSmallValid$Global_active_power)

## Open png graphics device
png(file = "plot2.png")

## Create scatterplot
plot(xDateTime, yGAP, xlab = "", ylab = "Global Active Power (kilowatts)", 
     type = "n")        # Suppress plotting of the points
lines(xDateTime, yGAP)  # Add (x,y) values joined by straight lines

## Close the PNG file device
dev.off()