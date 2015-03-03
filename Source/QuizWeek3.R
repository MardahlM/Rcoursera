remove(list = ls())
getwd()
setwd("/Volumes/MARDAHL/Resources/Workshops/Online R course")

#question 1
library(datasets)
data(iris)
?iris
head(iris)

s  <-  split(iris, iris$Species)
mean(s$virginica$Sepal.Length)

#question 2 
apply(iris[, 1:4], 2, mean)

#question 3

library(datasets)
data(mtcars)
head(mtcars)
View(mtcars)

mean(mtcars$mpg, mtcars$cyl)
sapply(mtcars, cyl, mean)
0
with(mtcars, tapply(mpg, cyl, mean))

#question 4

temp <- with(mtcars, tapply(hp, cyl, mean))
temp[3]
View(temp)
absDiff  <- temp[3,] 
