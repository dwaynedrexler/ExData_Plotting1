# Download and unzip the file to the top-level directory
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                        destfile = "household_power_consumption.zip")
unzip(zipfile = "household_power_consumption.zip", 
      files = c("household_power_consumption.txt"),
      overwrite = TRUE, exdir = ".")

# Read the data
dat <- read.table("household_power_consumption.txt", 
                  sep = ";",
                  na.strings = c("?"),
                  stringsAsFactors = F, 
                  header = T, 
                  colClasses = c(rep("character", 2), 
                                 rep("numeric", 7)))
# Convert time field to a date-time object
dat$datetime <- strptime(paste(dat$Date, dat$Time, sep = " "), 
                     format = "%e/%m/%Y %H:%M:%S")
# Convert date field from text to Date object
dat$Date <- as.Date(strptime(dat$Date, format = "%e/%m/%Y"))
# Subset the data or only the days in focus per instructions
dat <- subset(dat, Date >= as.Date("2007/02/01") & Date <= as.Date("2007/02/02"))

#Create the plot
png("plot2.PNG", width = 480, height = 480)
plot(dat$datetime, dat$Global_active_power, type = "n", xlab = "", 
     ylab = "Global Active Power (kilowatts)")
lines(dat$datetime, dat$Global_active_power)
dev.off()
