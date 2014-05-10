# === Set working directory ====================================
# This code assumes you have household_power_consumption.txt
# in your working directory

# INSERT YOUR WORKING DIRECTORY BELOW
setwd("~/data_science_coursera/eda")


# === Load data ================================================
data <- read.table("household_power_consumption.txt", 
                   sep = ";",
                   header = T, 
                   na.strings = c("", "?"),
                   stringsAsFactors = FALSE
                   )
# === Subset data to 2007-02-01 and 2007-02-02 =================
# Date is a character variable at this point
dt <- data[data$Date == '1/2/2007' | data$Date == '2/2/2007', ]

# === Check data ===============================================
str(dt)
names(dt)
lapply(dt, table)
lapply(dt, function(x) sum(is.na(x)))
lapply(dt, function(x) sum(x == "?" | x == ""))
lapply(data, table)
lapply(data, function(x) sum(is.na(x)))
lapply(data, function(x) sum(x == "?" | x == ""))

# === Combine Date and Time into one POSIX datetime variable ===
dt$datetime <- paste(dt$Date, dt$Time)
head(dt$datetime)

# Convert using strptime()
dt$datetime <- strptime(dt$datetime, "%d/%m/%Y %H:%M:%S")
head(dt$datetime)
class(dt$datetime)

# === Plot time series of sub metering 1-3 to PNG Device =======
# Launch png device and set size 
# Although 480 is already the default, it is spelt out here
# for demonstration 
png(filename = "plot3.png",
    width = 480, height = 480,
    bg = "transparent")                             # transparent background

# Use plot() of the base graphics system to plot
with(dt, plot(datetime, Sub_metering_1,             # plot sub_meter_1 line
              xlab = "",                            # remove x label
              ylab = "Energy sub metering",         # change y label
              type = "l",                           # line graph
              lwd = 1))                             # set line width

with(dt, lines(datetime, Sub_metering_2,            # add sub_meter_2 line   
               col = "red"))

with(dt, lines(datetime, Sub_metering_3,            # add sub_meter_3 line 
               col = "blue"))

legend("topright",                                  # position legend at topright 
       legend = c("Sub_metering_1",                 # add legend text
                  "Sub_metering_2", 
                  "Sub_metering_3"), 
       lty = 1,                                     # set legend as solid line
       col=c("black", "red", "blue"),               # set line colors
       xjust = 1)                                   # right justify legend

# Turn device off
dev.off()
