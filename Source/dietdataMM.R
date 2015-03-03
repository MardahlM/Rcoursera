remove(list = ls())
getwd()
setwd("/Volumes/MARDAHL/Resources/Workshops/Online R course")

dataset_url <- "http://s3.amazonaws.com/practice_assignment/diet_data.zip"
download.file(dataset_url, "diet_data.zip")
unzip("diet_data.zip", exdir = "diet_data")



andy  <-  read.csv("diet_data/Andy.csv")
list.files("diet_data")

head(andy) #"Patient.Name" "Age" "Weight" "Day"

length(andy$Day) #30
dim(andy)
str(andy)
summary(andy)
names(andy)

andy[1, "Weight"] #140
andy[30,"Weight"] #135

andy[which(andy$Day == 30), "Weight"] #135 subset of weight where day is 30
andy[which(andy[,"Day"] == 30), "Weight"] #135 creates a subset as above
subset(andy$Weight, andy$Day==30) #135 and the same again

andy_start  <- andy[1,"Weight"]
andy_end  <- andy[30,"Weight"]
andy_loss  <- andy_start - andy_end
andy_loss #5 pounds over the 30 days

#how to look at everyone as once
files  <- list.files("diet_data")
files

files[3:5]

head(read.csv(files[3])) #will not work

files_full <- list.files("diet_data", full.names=TRUE)
files_full

head(read.csv(files_full[25])) 

#create one big data frame with everybody's data in it

andy_david <- rbind(andy, read.csv(files_full[2]))

head(andy_david)
tail(andy_david)

day_25  <- andy_david[which(andy_david$Day == 25),]
day_25

for (i in 1:332) {
        dat <- rbind(dat, read.csv(files_full[i]))
}
dat
dat <- data.frame()
for (i in 1:5) {
        dat <- rbind(dat, read.csv(files_full[i]))
}
str(dat)

median(dat$Weight, na.rm=TRUE) #190

dat_30 <- dat[which(dat[, "Day"] == 30),]
dat_30
median(dat_30$Weight)

weightmedian <- function(directory, day)  {
        files_list <- list.files(directory, full.names=TRUE)   #creates a list of files
        dat <- data.frame()                             #creates an empty data frame
        for (i in 1:5) {                                
                #loops through the files, rbinding them together 
                dat <- rbind(dat, read.csv(files_list[i]))
        }
        dat_subset <- dat[which(dat[, "Day"] == day),]  #subsets the rows that match the 'day' argument
        median(dat_subset[, "Weight"], na.rm=TRUE)      #identifies the median weight 
        #while stripping out the NAs
}

weightmedian(directory = "diet_data", day = 20)
weightmedian("diet_data", 4)
weightmedian("diet_data", 17)
