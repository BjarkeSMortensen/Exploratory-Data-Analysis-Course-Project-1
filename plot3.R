
# Calculate an rough average for how much RAM is needed to read the data.

# There are 2075259 rows and 9 columns. For ease we assume all the columns are numeric-double, which mean that each entry is 8 bytes. We want to calculate the size in megabytes, which mean we will divide the number of bytes with 2^20. Then we can do the follwing calculation.

# (2075259*9*8)/2^20

# The result is 142.5 mb. Which is approximately the 126 mb which the total dataset is after being read with the read_csv2-function.


# Load tidyverse which will be used to write the script.

library(tidyverse)


# Download, unzip and load the data

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              "getdata_dataset.zip",
              method="curl")

unzip("getdata_dataset.zip") 

data <- read_csv2("household_power_consumption.txt", na = c("?", "NA")) %>% 
  mutate(Date = dmy(Date),
         across(where(is.character), as.numeric),
         date_time = ymd_hms(paste(Date, Time))) %>% 
  filter(Date == dmy("01/02/2007") | Date ==  dmy("02/02/2007"))


# plot3

png("plot3.png", width=480, height=480)

with(data, plot(date_time, Sub_metering_1,  type = "n", ylab = "Energy sub metering", xlab = ""))
lines(data$date_time,data$Sub_metering_1)
lines(data$date_time,data$Sub_metering_2, col = "red")
lines(data$date_time,data$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="n")

dev.off()