#preliminaries
#remove all objects from R
rm(list=ls())
library("utils")
setwd("C:/Users/Dan-LAP/repositorios/r_edx_course/Gender_Stats_csv")

#getting the data
gender_data <- read.csv("Gender_StatsData.csv")
teenager_fr <- subset(gender_data, Indicator.Code=="SP.ADO.TFRT")
#remove the dataframe: gender_data from R environment
rm(gender_data)

#seing the structure of a dataframe
#overview of the dataframe
str(teenager_fr)
#first 6 rows
head(teenager_fr) 
#last 6 rows
tail(teenager_fr)

#computing the mean of a column
mean(teenager_fr$X1975, na.rm = TRUE) #skiping NA values
mean(teenager_fr$X1960, na.rm = TRUE)
sd(teenager_fr$X1960, na.rm = TRUE) #standar derivation
mean(teenager_fr$X2000, na.rm = TRUE)
sd(teenager_fr$X2000, na.rm = TRUE)

#plotting the mean, and the value for low income, middle income, and high income countries
low_income <- subset(teenager_fr, Country.Code == "LIC")
middle_income <- subset(teenager_fr, Country.Code == "MIC")
high_income <- subset(teenager_fr, Country.Code == "HIC")
# 5 rows (year, mean, avg lic, avg mid, avg hig), 55 columns (fertility rate from 1960 to 2014)
plot_frame <- matrix(NA, 5, 55)
for (i in 5:59){
  k <- i-4
  j <- i+1955
  plot_frame[1,k] <- j
  plot_frame[2,k] <- mean(teenager_fr[, i], na.rm = TRUE)
  plot_frame[3,k] <- low_income[, i]
  plot_frame[4,k] <- middle_income[, i]
  plot_frame[5,k] <- high_income[, i]
}
xlim <- range(c(plot_frame[1,]))
ylim <- range(c(plot_frame[2,], plot_frame[3,], plot_frame[4,], plot_frame[5,]))
plot(plot_frame[1,],plot_frame[2,],type="l", col="black", xlim=xlim, ylim=ylim, main="Evolution of Adolescent Fertility Rate", xlab="year", ylab="rate")
lines(plot_frame[1,], plot_frame[3,],col="red")
lines(plot_frame[1,], plot_frame[4,],col="blue")
lines(plot_frame[1,], plot_frame[5,],col="yellow")

#histograma
p1 <- hist(teenager_fr$X1960)
p2 <- hist(teenager_fr$X2000)
plot(p2, col=rgb(1,0,1,1/4),xlim = c(0,250), main="Change in the distribution", xlab="values")
plot(p1, col=rgb(0,0,1,1/4),xlim = c(0,250), add=TRUE)
legend("topright", ncol = 2,legend = c("2000", "1960"))
fill=c(rgb(1,0,1,1/4),rgb(0,0,1,1/4), text.width=20)
png("histogram")
#adding kernels
p1 <- hist(teenager_fr$X1960, freq = FALSE, breaks = 20)
p2 <- hist(teenager_fr$X2000, freq = FALSE, breaks = 20)
p1$counts = p1$density
p2$counts = p2$density
p3 <- density(teenager_fr$X1960, na.rm = TRUE)
p4 <- density(teenager_fr$X2000, na.rm = TRUE)
plot(p2, col = rgb(1,0,1,1/4), xlim = c(0,250), main = "Change in the distribution", xlab = "values", ylab = "Density")
plot(p1, col = rgb(0,0,1,1/4), xlim = c(0,250), add = TRUE)
lines(p4, col=rgb(1,0,1,1/4), xlim = c(0,250), lwd = 5)
lines(p3, col=rgb(0,0,1,1/4), xlim = c(0,250), lwd = 5)
legend("topright", ncol = 2, legend = c("2000", "1960"))
fill = c(rgb(1,0,1,1/4), rgb(0,0,1,1/4), text.width = 20)