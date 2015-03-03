remove(list = ls())
getwd()
setwd("/Volumes/MARDAHL/Resources/Workshops/Online R course")

#R is based on the S language

#R objects and Attributes
# EVERYTHING IN R IS AN OBJECTS. "atomic" classes of objects are
# character
# numeric (real numbers)
# integer (by default shown as 1.00 - 1 gives you a numeric object, 1L gives you an integer!)
# complex 
# logical (true/false)
 
# most basic object is a vector
# A vector can only contain objects of the same class.
#x  <- c(true/false)
# Should it contain objects of different classes 
# it will by coerce the vector to be the class that is the least common denominator
#explicit coercion can force a vector to be converted to another class as.numeric(x)
# A list can contain values from different classes - they look like [[1]] and not [1]

#Matrices are just a 2D vector. It is by default column organized. 

#Factors are categorial data ordered or unordered (f/m, y/n)
#Factors are treated by modelling functions like lm() and glm()
#more descriptive than integer values
#Factors can be created with the factor function
#x  <- factor(c("yes", "no"))
#creates an integer vector with the level attributes yes and no.
#baseline level is the first level that is encountered (alphabetical by default - no before yes)
#circumvent this by determining the order of the levels: 
# x  <- factor(c("yes", "no")),
# Levels = c("yes","no"))

#Treating missing values:
#find them using is.na(x) it will return TRUE for those values that are NA values. 

#Dataframes: Key way to keep the data in R. The different vectors in dataframes
#can contain objects of different classes but they must be of the same vector length.
#x <- data.frame(foo=1:4, bar = c(T,T,F,F)) 
#then ask for nrow(x), and ncol(x)

#Names Attributes
#R can have names that are useful for writing readable code and self-decribing objects.
# names of columns can then be called. In matrices the names of the rows and columns can be names
# this is calles dimnames dimnames(m)  <- list(c("a","b"), c("c","d"))

#reading and wrting data in R.

#reading data
#read.table, read.csv - tabular data (automatically designates classes to the variables in the table
#telling R explicitly makes R run faster and more efficiently - header by default is set to true)
#readLines, reads lines of text into R
#source, reads in R code files (inverse of dump)
#dget, same but deparsed R code (inverse of dput)
#load and unserialize read binary functions into R

#writing data
#write.table, writeLines, dump, dput, save, serialize

#how to read data in
#file - name of file.
#header - has variable names, not a piece of data
#sep - a string that indicates how the columns are separated (comma or dot)
#colClasses - itself a character vector that lists the class of each column
#nrows - number of rows in the dataset
#comment.char - a character string that indicates the comment character
#skip - number of lines to skip from the beginning
#stringsAsFactors, should character variables be coded as factors? encoding character 
#values as a factors by default - otherwise = FALSE

##reading large tables into R
#read the help page: ??read.table or memorize it
#set comment.char = "" if there are no commented lines in your file


#colClasses argument is very important - if not used R goes through the columns and tries to figure out what type of data is in each column - makes R slow. 
#save yourself time and just tell R what the classes are. 
# initial  <- read.table("datatable.txt", nrows = 100)
# classes  <- sapply(initial, class)
#tabALL  <- read.table("datatable.txt", colClasses = classes)
#set nrows. helps with memory usage. unix tool wc can calculate how many rows are in the table.

#how much memory do you have? what other applications are in use? 
#are other users logged into the system that are slowing it down
#operating system - 32-bit or 64-bit? 64-bit better of course
#do a rough calculation for the following table
#dataframe with 1,500,000 rows and 120 columns. How much memory is required to store this dataframe?
1500000*120*8 # 8 bytes/numeric
#1,44e+09 bytes
1.44e+09/2^20 #2^20bytes/MB
#1373,291 MB = 1,34 GB
# if you read in using read.table R requires twice the ram necessary to store the table. 

##textual formates
#dumping and dputing will include the class of each column of the dataframe. 
#advantage: still textual format but includes metadata (type of class) - doesn't get lost 
#when you transfer the R file to someone else. They will then use source or dget to read the file
#into R. This type of format is not very space-efficient and needs to be decompressed. 
#It can also be useful for GIT. 
#so you can track data changes meaningfully.
#dput(y, file = "y.R") 
#new.y  <- dget("y.R") creates a file with meaningful text which can be used to reconstruct an R object.
#dump can be used to write multiple objects. Dget only for a single R object. 
#source is used to read a dump back in R

#data are read in using connection interfaces. Connections to files: 
#file, gzfile (gzip), bzfile (bzip2), url

##subsetting in R
#[ returns a value of the same class as the original (list)
#[[ extracts a single element (sequence) of a list or dataframe, may or may not be the same class as the original vector
#$ extracts elements of a list or dataframe by name; semantics are similar to that of [[.

#example subsetting nested elements of a list 
x  <- list(a=list(10,12,14), b=c(3.14,2.81))
x[[c(1,3)]]
#14
x[[1]][[3]]
#14
x[[c(2,1)]]
#3.14

#matrices first index is the row index and the second index is the column index. 
#[1,] gives the first row of the matrix as a vector. Keep the 2D format by including , drop = FALSE

#Partial matching saves time and writing as fast as you can.
#x$aardvark can be reduced to x[["a", exact = FALSE]] 

#removing missing values (NAs)
#create a logical vectors to identify the NAs
x <- c(1,2,NA,4,NA,5)
bad  <- is.na(x)
x[!bad] #gives you back the good values
#[1] 1 2 4 5 
y  <- c("a", "b", NA, "d", NA, "f")
good  <- complete.cases(x,y)
length(good)
# [1] TRUE TRUE FALSE TRUE FALSE TRUE
x[good]
# [1] 1 2 4 5 
y[good]
# [1] "a" "b" "d" "f"

#complete.cases is very good to remove rows where you have missing values

#vectorized Operation
#feature of R language that makes it easy without looping to write scripts in R
#idea: parallel computation
#adding two vectors together or subtract without looping
#multiplication of each element - not two matrices. %*% is matrix multiplication

#statistics with interactive R learning - SWIRL module

#Quiz week 1

x  <- read.csv("hw1_data.csv", header = TRUE, sep = ",")
colnames(x)
x[1:2,] #returns two first rows
nrow(x) #the number of rows in the quiz data
x[152:153,] #gets last two rows
x[47,] #to get value of ozone in the 47th row

x$Ozone
bad <- is.na(x$Ozone) #creates a logical vector with TRUE FALSE for NA values
length(bad[bad==TRUE]) #returns the sum of FALSE (NA values)
mean.Ozone  <- mean(x$Ozone, na.rm = TRUE)
mean.Ozone #42.1
mean.Ozone  <- mean(x$Ozone[good]) #another way
mean.Ozone #42.1

newdata  <- subset(x, Ozone>31, drop = FALSE) #create a subset of Ozone values without NA, keep 2D
newdata1  <- subset(newdata, Temp>90, drop= FALSE) # same for Temp
newdata1 # see the subset

solarm  <- mean(newdata1$Solar.R) #take mean of Solar.R column of this subset
solarm # see this mean value displayed

#get the mean of temp when month is 6
mo6mTemp <- subset(x, Month==6, drop = FALSE)
mo6m<- mean(mo6mTemp$Temp)
mo6m

#get maximum value
mo5mOzoneMax <- subset(x, Month==5, drop = FALSE)
mo5mOzoneMax
max(mo5mOzoneMax$Ozone, na.rm = TRUE)









#WEEK TWO

##Control Structures - for writing programmes! 
# if.else, for, while, repeat, break, next, return
#control the flow of execution of the program. 

#If else: 

#if(<condition>) {
##do something
#} else {
  ##do something else
#}
#if(<condition1>) {
## do something
# } else if(<condition2>) {
#   ## do something different
# } else {
#   ## do something different
# }

#example: different from other languages
# if(x>3) {
#   y<- 10
# } else{
#   y<-0
# }
# #also valid
# y <- if(x>3) {
#   10
# } else{
#   0
# }
# y = (x>3) ? 10 : 0 #rickis m??de at g??re det p?? i mange andre sprog

#The entire if else construct is all about assigning a value to y.
#else is not mandatory

# For loops: 
#   takes an iterator variable (called i) and assign it successive values from a sequence or vector.
# for(i in 1:10) {
#   print(i)
# } # printing out i at each iteration.
# 
# #The following for loops prints each element in the vector
# x  <- c("a", "b", "c", "d")

# for(i in 1:4){
#   print(x[i])
# }  #like c
# 
# for(i in seq_along(x)) {
#   print(x[i])
# } #uses seq_along function. Takes vector as input and creates an integer sequence that is = length of the vector.
# 
# for(letter in x) {
#   print(letter)
# } #index(the word letter) is going to take value from the vector itself
# 
# for(i in 1:4) print(x[i]) #more compact
# 
# #Nested for loops - nesting beyond 2-3 levels is often difficult to understand and could be replaced with functions
# Matrix that has 2 dimensions
 x  <-  matrix(1:6, 2, 3) #3 columns
x# 
for(i in seq_len(nrow(x))) { #loop over the rows (1,3,5)
  for(j in seq_len(ncol(x))){ #loop over the columns (2,4,6)
    print(x[i, j]) 
  }
}# prints all elements of the matrix going from top left - top right - bottom left and bottom right.
#in each row gets the value of each column. then moves to the next row.

#While loops - takes a logical expression: ex: while any count is below 10 it will print. then go onto the next bulk of code.
#are continuous/infinite loops and therefore it is often safer to use a for loop where there is a hard limit. 

# count <- 0
# while(count<10) {
#   print(count)
#   count<- count+1
# }
# 
# example! test the conditions of a test by using logical operators: 
#   z  <-  5 
# 
# while(z >=3 && z<=10) {
#   print(z)
#   coin<-rbinom(1,1,0.5) # (1 is the number of observations, 1 is the size(number of trials) and 0.5 means fair probability)
#   
#   if(coin==1) { # random walk zig-zag'ing up and down until it hits 3 or 10
#     z  <- z+1
#   } else {
#     z <- z-1
#   }
# }
# 
# #repeat (infinite loop), break it to stop the loop
# #commonly used control structure in R
# #
# x0  <-  1 #x0 is 1
# tol  <- 1e-8
# 
# repeat {
#   x1  <- computeEstimate() #computeEstimate is NOT a function
#   
#   if(abs(x1-x0)<tol) {
#     break
#   }else {
#     x0  <- x1
#   }
# } #recycle until the two values are close

#next, return is used in any loop or construct where you want to skip an iteration
# for(i in 1:100) {
#   if(i<20){
#     ##skip the first 20 iterations
#     next
#   }
#   ## do something here
# }
#return signals that a function should exit and return a given value

##Your first R function
#add 2 values: 
add2  <- function(x,y) {
  x+y
}
add2(3,5)

#next function more complicated that is explained by the teacher in Rstudio
#any number above 10 will be returned
above10  <- function(x) {
  use  <- x > 10
  x[use]
}

above  <- function(x,n) {
  use  <- x > n
  x[use]
}
x  <- 1:20
above(x)

above(x,12)

above  <- function(x, n=10) {
  use  <- x > n
  x[use]
}
above(x)

#using for loop
columnmean  <- function(y){
  nc  <- ncol(y) #finds the number of columns
  means  <- numeric(nc) # for now is an empty vector
  for(i in 1:nc){
    means[i] <- mean(y[,i])
  }
  means #returns vector of means
}
columnmean(airquality) #will return some NAs because there are some NA values in some vectors
columnmean  <- function(y, removeNA = TRUE){
  nc  <- ncol(y) #finds the number of columns
  means  <- numeric(nc) # for now is an empty vector
  for(i in 1:nc){
    means[i] <- mean(y[,i], na.rm = removeNA)
  }
  means #returns vector of means
}
columnmean(airquality)

##FUNCTIONS
#functions transfer a user into the programming of R

#basics of how to write 

f  <- functions(<arguments>) { #function is a first class object in R
  ##do something interesting
}

#explains sd function

#argument matching
#you can mix positional matching with matching by name. When an argument
#is matched by name, it is "taken out" of the argument list and the remaining
# unnamed arguments are matched in the order that they are listed in the function defininion.

>args(lm)
function(formula,data,subset, weights, na.action,
         method="qr", model=TRUE, x=FALSE, 
         y=FALSE, qr=TRUE, singular.ok=TRUE,
         contrasts=NULL, offset,...)
  
#the following two are equivalent:
  lm(data=mydata, y~x, model=FALSE, 1:100)
  lm(y~x, mydata, 1:100, model = FALSE)
  
  #named arguments are useful if you can't remember which argument number you need to not have default. 
#useful during plotting where the plotting functions have a lot of arguments.

#you can also type part of the argument name and R will match and assign the value to the correct argument.

#Defining a Function
f  <- function(a, b=1, c=2,d=NULL) #here is a function with 4 arguments. "a" has no default value. The others have
  #NULL usually means there is nothing there
  
  #key feature of functions in R: LAZY evaluation - only as needed
  f <- function(a,b){
    a^2
  }
f(2) #what about b? nothing happens because the function doesn't use b
#so there is nothing evaluated even though the argument is there. 

f <- function(a,b){
  print(a)
  print(b)
}
  f(45)
#error only occurs after the 45 that means it will execute until it gets to the part of the function with an error

#the "..." argument - indicate a variable number of arguments usually passed on to other functions
#othen used when extending another function and you don't want to copy the 
#the entire argument list of the original function

myplot  <- function(x,y,type="l",...){ #... absorbs the other arguments
  plot(x,y, type=type, ...) #the ... put the arguments here..
} #comes again in object oriented programming
#dispatch extra arguments to methods 

#the paste funtion concatenates a set of strings 
args(paste)
function(...,sep=" ", collapse = NULL)
  
  args(cat)
function(...,file = "", sep =" ", fill = FALSE, labels = NULL, append = FALSE)
#concatenating a string
  
  #you cannot use positional or partial matching using the ... argument
  >args(paste)
function(..., sep = " ", collapse = NULL)
  >paste ("a", "b", sep = ":")
[1] "a:b"
>paste ("a", "b", se = ":")
[1] "a b :"

##Scoping rules - symbol binding

#A diversion on binding values to symbol
#when a function sees a symbol, how does it assign a value to that symbol?

lm  <- function(x) {x*x}
lm
function(x){x*x}
#how does R differentiate between this lm function and the lm function inherent in the R programe. 
# 
# A diversion on binding values to symbok: 
#   #when R tries to bin a value to a symbol, it searches through a series of environments 
#   to find the approprate value. When you are working on the command line and 
# need to retrieve the value of an R object, the order is roughly: 
#   1. SEarch the global environment for a symbol name matching the one requested.
# 2. Search the namespaces of each of the packages, currently loaded into R on the search list. 
# 
# The search list can be found using the search function ">search()"
#global environment is searched first and goes through the packages in the order they are loaded in the given session.
#the base package is searched last
#searching the namespace will come after the global search

#Scoping Rules (originates from the S language)
#determine how a value is bound to a free variable in R
#R uses lexical or static scoping to bind a value to a symbol. Common alternative is dynamic scoping. 
#lexical scoping turns out to be particularly useful for simplifying statistical calculations

#example: 
f<- function(x,y) {
x^2 + y/z
}
#in this case z is a free value

#lexical scoping in R means that: 
#"The values of free variables are searched for in the environment in which the function was defined. 
# what is an environment?
# - a collection of (symbol,value) pairs, i.e. x is a symbol and 3.14 might be its value
# - Every environment has a parent environment; it is possible for an environment to have several
#environment children
# - the only environment without a parent is the empty environment
# - a function + an environment = closure or function closure

#searching for the value for a free variable: 
# if not in the global environment then continues to search the parent environment
# continue down the sequence of parent environments until we hit the top-level environment
#top-level is normally the global environment (workspace) or the namespace of a package
#then the empty. 
#if the value has not been found for the particular symbol - it will state it cannot find it. 

##R scoping rules
#why does scoping matter? 
# values of free variables are normally in your workspace defined by you as you work.
# you can define one function inside another function in R. 
#then the function that gets returned was defined inside another function and not the global enviroment
#this is when scoping rules come in

make.power  <- function(n) {
pow <- function(x) {
  x^n
}
pow
}

cube  <- make.power(3)
square  <- make.power(2)
cube(3)
square(3)

#Exploring a Function closure

ls(environment(cube))
get("n", environment(cube))
ls(environment(square))
get("n", environment(square))

#Lexical vs. Dynamic scoping
y  <- 10

f  <-  function(x) {
  y  <- 2
  y^2 + g(x)
}

g  <-  function(x) {
  x*y
}

f(3)
#lexical scoping searched the value of y from the function g in the environment in which the function 
#was defined, in this case the global environment #34 (with value of 10 from the global environment search)

#with dynamic scoping (as used in other programming languages)
#the value is looked up in the environment from which the function was called (function f)
# in R the calling environment is known as the parent frame. - and here the value of y would be 2. 
Lexical f(3) would be 2^2+3*10 (34)
dynamic?

#when a function is defined in the global environment and is subsequently called from the global environment, then the defining
#environemtn and the calling environment are the same. This can sometimes give the 
#appearance of dynamic scoping.
remove(list = ls())

g <- function(x) {
   a <- 3
   x+a+y (a is a local value, y is a free variable)
  }
g(2)

y  <- 3  
g(2)

#other languages support lexical scoping: scheme, perl, python, common LISP
#consequences of scoping in R - all objects must be stored in memory! 
#large datasets is a challenge if everything should be kept in the memory. 
#pointer to the defining environment for each symbol

#Scoping Rules - Optimization Example (OPTIONAL)

# optim, nlm, and optimize routines in R
# take an objective function and tries to minimize or maximize over. 
# holding certain parameters fixed. 

#Coding standards in R
#always use text file/editor (ASCII)
#indent your code
#limit the width of your code (80 columns)
#limit the size of functions so they are separated in logical parts

#example; every indent scheme should be to tab width 8

#Dates and Times in R
#Dates "Date" class
#Times POSIXct or POSIClt class
#dates days since 1970-01-01
#times are stored internally as seconds since 1970

x  <- as.Date("1970-01-01")
x
unclass(x)

# times in POSIXct large integer - to store times in a dataframe
# POSIXlt list 
#?strptime

#Quiz week2
cube  <- function(x,n) {
        x^3
}

# cube(3+) #27, because n is not asked for
# 
# x  <- 1:10 #defines a vector
# if(x > 5) { #asks if the vector is over 5 put x to 0
#         x <- 0 #illogical. X is a vector and if can only 
# } #test one logical statement

p <- function(j) {
        m <- function() {
                o <- cube(l)
        }
        l<-2
        m()
        j+o
}
o <- 4
p(1)

f  <- function(x) {
        g  <- function(y) {
                y+z
        }
        z <- 4
        x+g(x)
}
#z  <- 10
f(3)

#Question 4
x  <- 5
y  <- if(x < 3) {
        NA
} else {
        10
}








