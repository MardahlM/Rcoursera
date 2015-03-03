remove(list = ls())
getwd()
setwd("/Volumes/MARDAHL/Resources/Workshops/Online R course")

# sentence <- c("Hello", "World", "!")
# for (word in sentence) {
#     print(word)
# }

#Pollution Assignment Part I

#Write a function that looks like:
#pollutionmean <- function(specdata, pollutant, id = 1:332)

pollutantmean  <- function(directory, pollutant, id) {
    data  <- data.frame()
    files <- list.files(directory, full.names=TRUE)
    for (i in id) {
        data <- rbind(data, read.csv(files[i]))
    }
    mean(data[,pollutant], na.rm=TRUE) #3.19
}
mean1  <- pollutantmean("specdata", "nitrate", 1:10)
mean2  <- pollutantmean("specdata", "nitrate", 70:72)
mean3  <- pollutantmean("specdata", "nitrate", 23)

#Pollution Assignment Part II
#Write a function that looks at complete_cases
#complete <- function(directory, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return a data frame of the form:
    ## id nobs
    ## 1  117
    ## 2  1041
    ## ...
    ## where 'id' is the monitor ID number and 'nobs' is the
    ## number of complete cases
#}

complete <- function(directory, id){
    tmpdata  <- data.frame()   
    nobsvector  <- numeric()
    idvector  <- numeric()
    files  <- list.files(directory, full.names=TRUE)
    for(i in id){
        #print(i)
        tmpdata <- read.csv(files[i])
        sulfateCol  <- tmpdata$sulfate
        idCol  <- tmpdata$ID
        nobsvector[i] <- length(sulfateCol[!is.na(sulfateCol)])
        idvector[i]  <- idCol[i]
    }
    nobs  <- na.omit(nobsvector)
    id  <- na.omit(idvector) 
    nobsdata  <- data.frame(id, nobs)
    #View(nobsdata)    
}

complete("specdata", 1:10)  
complete("specdata", c(2,4,8,10,12)) 
complete("specdata", c(30:25))
complete("specdata", 3)
    
#Pollutant Assignment Part III:
#corr <- function(directory, threshold = 0) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0
    
    ## Return a numeric vector of correlations
#}

importData  <- function(directory, id, removeNA = FALSE){
    resultsData  <- data.frame()
    files  <- list.files(directory, full.names=TRUE)
    for(i in id){
        resultsData  <- rbind(resultsData, read.csv(files[i]))
    }
    if (removeNA) {
        return(na.omit(resultsData))
    }
    return(resultsData)    
}

result  <- importData("specdata", 1, TRUE)
result

#find locations with complete cases greater than threshold.
#calculate correlations.
#gather correlations in vector
#return vector

corr <- function(directory, threshold = 0){
    completeCases  <- complete(directory, 1:332) #loads nobsdata as completeCases
    completeCases  <- subset(completeCases, completeCases$nobs >= threshold)
    correlations  <- vector("numeric", length = 0)
    
    for(i in completeCases$id){
        tmpData  <- importData(directory, i, TRUE)
        correlations  <- append(correlations, cor(tmpData$sulfate, tmpData$nitrate), after = length(correlations))
    }
        
    return(na.omit(correlations))
}
 
correlationsData <- corr("specdata")
head(correlationsData)
summary(correlationsData, na.rm = TRUE)
length(correlationsData)
