# R_code_exam.r

# 1. R code first
# 2. R spatial 
# 3. R multipanel 
# 4. R point patterns analysis
# 5. R multivariate analysis 
# 6. R remote sensing
# 7. R ecosystem function
# 8. R pcs remote sensing 
# 9. R radiance
# 10. R code faPAR
# 11. R code EBV
# 12. R NO2 
# 13. R crop
# 14. R snow
# 15. R interpolation
# 16. R sdm

########################################################################
########################################################################
########################################################################
########################################################################

# 1. R code first

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

########################################################################
########################################################################
########################################################################
########################################################################


# 2. R spatial 

install.pakages("sp")
library(sp)

data(use)
head(meuse)

#coordinates
coordinates(meuse)= ~ x+y #equal the group of X and  Y

plot(meuse)

#using the plot we just say the points, with spplot we introduce a new variable 
spplot(meuse, "zinc")          #declare whicha dataset we want to use and add a variable 
#the zinc is concentrated in the yellow part (upper part of the graph), the numbers in the graph are the measurments (amount of the element)

#EXERCISE:plot the spatial amount of copper
spplot(meuse, "copper", main="Copper concentration") #main="title"

bubble(meuse, "zinc", main="Zinc concentration")

#EXERCISE: bubble copper in red
bubble(meuse, "copper", col="red", main="Copper concentration")

###IMPORTING NEW DATA
# download covid_agg-cvs from out teaching site and buld a folder called "lab" into C:
#put the covid_agg.csv dile into the folder lab

# setting the working directory: lab
setwd("C:/lab/") # Windows users 

#Mac users: setwd("Users/yourname/lab"
#Linux users: setwd("~/lab")

#import data
covid <- read.table("covid_agg.csv", head=TRUE ) #the second argument means that the first line isn't data, but is just the title 
                                                 #head=TRUE or head=T
head(covid)

attach(covid)
plot(country,cases)
#plot(covid$country, covid$cases)

#this graph doesn't show all the countries, so we have to change type of graph
plot(country,cases, las=0) #las=0 parallel labels to axes
plot(country,cases, las=1) #las=1 horizontal labels to axes
plot(country,cases, las=2) #las=2 perpendicular labels to axes
plot(country,cases, las=3) #las=3 vertical labels to axes

#decrease the size of the axes label with cex.axis=0.5 
plot(country,cases, las=3, cex.axis=0.5) 

#plot spatially with ggplot 
install.packages("ggplot2")
library(ggplot2)
data(mpg)
head(mpg)

####save project
# day 2
#### load the previous data "spatial.RData"

load("spatial.RData")
ls() #list: to show all the data we have

#if it's not just installed : intall.packaged("ggplot2")
library(ggplot2) #require(ggplot2)

data(mpg)
head(mpg)

#3 component:DATA, set of AESTHETIC MAPPING (variables in the data and visual properties), GEOMETRICAL layer

ggplot(mpg, aes(x=displ,y=hwy))+geom_point() #(first: data, second: aes(x variable= displ, yvariable) ) + third: geometry: geom_point
ggplot(mpg, aes(x=displ,y=hwy))+geom_line() #changing in type of graph: linear graph
ggplot(mpg, aes(x=displ,y=hwy))+geom_polygon() 

head(covid)

# ggplot of covid
ggplot(covid, aes(x=lon,y=lat,size=cases))+geom_point() 
#size= the size of the point changes according to the n° of cases in each country


########################################################################
########################################################################
########################################################################
########################################################################

# 3. 

########################################################################
########################################################################
########################################################################
########################################################################

# 4.

########################################################################
########################################################################
########################################################################
########################################################################

# 5.

########################################################################
########################################################################
########################################################################
########################################################################

# 6.

########################################################################
########################################################################
########################################################################
########################################################################

# 7.

########################################################################
########################################################################
########################################################################
########################################################################

# 8.

########################################################################
########################################################################
########################################################################
########################################################################

# 9.

########################################################################
########################################################################
########################################################################
########################################################################

# 10.

########################################################################
########################################################################
########################################################################
########################################################################

# 11.

########################################################################
########################################################################
########################################################################
########################################################################

# 12.

########################################################################
########################################################################
########################################################################
########################################################################

# 13.

########################################################################
########################################################################
########################################################################
########################################################################

# 14.

########################################################################
########################################################################
########################################################################
########################################################################

# 15.

########################################################################
########################################################################
########################################################################
########################################################################

# 16.



