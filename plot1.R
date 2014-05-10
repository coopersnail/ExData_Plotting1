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


# === Plot histogram of Global Active Power to PNG Device ======
# Launch png device and set size 
# Although 480 is already the default, it is spelt out here
# for demonstration 
png(filename = "plot1.png",
    width = 480, height = 480, 
    bg = "transparent")         # transparent background
                                # NOTE: the reference plots have transparent background

# Use hist() of the base graphics system to plot
hist(dt$Global_active_power,                    # data
     main = "Global Active Power",              # change title
     xlab = "Global Active Power (kilowatts)",  # change x label
     col = "red")                               # change fill color

# Turn device off
dev.off()
