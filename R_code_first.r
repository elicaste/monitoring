### R_code_first.r

install.packages("sp")

library(sp)
data(meuse)

#let's see how the meuse dataset is structured
meuse 

#let's look at the first row of the set
head(meuse)

#let's plot two variables
#let's see if the zinc concentration is realte to that of copper

attach(meuse) #the function attach allows to access variables of a data.frame (meuse) without calling the it
plot(zinc,copper) 
plot(zinc,copper,col="green") #modify the color of the symbols 
plot(zinc,copper,col="green",pch=19) #pch is used to specify point shapes
plot(zinc,copper,col="green",pch=19,cex=2) #symbols are scaled: 1=default, 1.5 is 50%largers, 0.5=is 50% smaller
