## Construct a histogram plot of Global Active Power over a 2 day period 
## in February 2007, and save it to a png file (size 480 x 480 pixels)

## Preparation: Set working directory to the folder where the data is stored

## Read data file (check if there is enough memory), everything as character
epcFull <- read.table("household_power_consumption.txt", sep = ";", 
                      header = TRUE, colClasses = "character")

## Note: The data frame epcFull has 2075259 obs. of 9 variables

## Make a subset of 2 (arbitray) days in Feb 2007
epcSmall <- subset(epcFull, (as.Date(Date, "%d/%m/%Y") > '2007-02-14') &
                      (as.Date(Date, "%d/%m/%Y") < '2007-02-17'))
## Note: The data frame epcSmall has 2880 obs. of 9 variables


## Make a valid subset (remove possible "?" in the data)
epcSmallValid <- epcSmall[epcSmall$Global_active_power != "?",]

## Open png graphics device
png(file = "plot1.png")

## Create histogram
hist(as.numeric(epcSmallValid$Global_active_power), col = "red", 
     xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

## Close the PNG file device
dev.off()
