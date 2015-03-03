complete <- function(directory, id){
    tmpdata  <- data.frame()   
    nobsvector  <- numeric()
    idvector  <- numeric()
    files  <- list.files(directory, full.names=TRUE)
    for(i in id){
        print(i)
        tmpdata <- read.csv(files[i])
        sulfateCol  <- tmpdata$sulfate
        idCol  <- tmpdata$ID
        nobsvector[i] <- length(sulfateCol[!is.na(sulfateCol)])
        idvector[i]  <- idCol[i]
    }
    nobsdata  <- data.frame(numeric(length=length(na.omit(nobsvector))))
    # nobsdata$nobs  <- na.omit(nobsvector)
    #  nobsdata$id  <- na.omit(idvector) 
    nobsdata$nobs  <- nobsvector #[complete.cases(nobsvector)]
    nobsdata$id  <- idvector #[complete.cases(idvector)] 
    View(nobsdata)    
}