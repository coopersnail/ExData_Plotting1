# === Set working directory ====================================
# This code assumes you have household_power_consumption.txt
# in your working directory

# INSERT YOUR WORKING DIRECTORY BELOW
setwd("~/data_science_coursera/eda")


# === Load data ================================================
# This code assumes you have enough RAM to read the data.
# If you want to selective read rows, use skip and nrows

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

# If you want to further investigate the data, use the follow code.

#lapply(dt, table)
#lapply(dt, function(x) sum(is.na(x)))
#lapply(dt, function(x) sum(x == "?" | x == ""))
#lapply(data, table)
#lapply(data, function(x) sum(is.na(x)))
#lapply(data, function(x) sum(x == "?" | x == ""))

# === Combine Date and Time into one POSIX datetime variable ===
dt$datetime <- paste(dt$Date, dt$Time)
head(dt$datetime)

# Convert using strptime()
dt$datetime <- strptime(dt$datetime, "%d/%m/%Y %H:%M:%S")
head(dt$datetime)
class(dt$datetime)

# === Plot 4 plots to PNG Device ===============================
# Launch png device and set size 
# Although 480 is already the default, it is spelt out here
# for demonstration 
png(filename = "plot4.png",
    width = 480, height = 480,
    bg = "transparent")         # transparent background
                                # NOTE: the reference plots have transparent background 

# Partition plotting space into 4 sections
par(mfcol = c(2, 2))

# First plot at upper left
with(dt, plot(datetime, Global_active_power,        # data
              xlab = "",                            # remove x label
              ylab = "Global Active Power ",        # change y label
              type = "l",                           # line graph
              lwd = 1))                             # set line width


# Second plot at lower left
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
       
       bty = "n",
       xjust = 1)                                   # right justify legend


# Third plot at upper right
with(dt, plot(datetime, Voltage,                    # data
              type = "l",                           # line graph
              lwd = 1))                             # set line width

# Fourth plot at lower right
with(dt, plot(datetime, Global_reactive_power,      # data
              type = "l",                           # line graph
              lwd = 1))                             # set line width

# Turn device off
dev.off()
