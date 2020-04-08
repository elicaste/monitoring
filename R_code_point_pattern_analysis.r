### POINT PATTERN ANALYSIS: DENSITY MAP

install.packages("spatstat")
library(spatstat)

attach(covid)
head(covid)

# give a name to the object we are goingo to prepare
covids <-ppp(lon,lat,c(-180,180), c(-90,90))  
# ppp(x,y, range of longiture, range of latitude) -> point pattern dataset in the two-dimensional plane

# without attaching the covid set
# the ppp commang becomes: covids <-ppp(covid$lon, covid$lat,c(-180,180), c(-90,90))  

#######FUNCTION DENSITY
d<-density(covids)

plot(d) #to show the density graph
points(covids)

#--- 08/04/2020
setws("C:/lab/") #windows
load("point_pattern.RData")
ls()
#covids:point pattern
#d: density map
library(spatstat) 
install.packages("rgdal")
library(rgdald)

plot(d) 
points(covids)

#let's input vector lines (xoyo, x1y1, x2y2)
#import coastline
coastlines<- readOGR("ne_10m_coastline.shp") #OGR is written in capital letter!

plot(d)
points(covids)
plot(coastline, add=T)

# Change the colour and make the graph beautiful
cl <- colorRampPalette (c("yellow","orange","red"))(100) #color scheme :series of colors
                                                         #100 colors between yellow to red (range of colors)
plot(d, col=clr, main="Densities of covid-19") #title of the map
plot(d,col=cl)
points (covids)
plot(coastlines, add=T)

# EXERCISE: new colour ramp palette
cl <- colorRampPalette (c("blue","green","yellow"))(100)

plot(d,col=cl)
points (covids)
plot(coastlines, add=T)

# export graph
pdf("covid_density.pdf")  # or png ()

# we nee to copy all the functions used to define the plot
cl <- colorRampPalette (c("yellow","orange","red"))(100)
plot(d, col=clr, main="Densities of covid-19")
plot(d,col=cl)
points (covids)
plot(coastlines, add=T)
dev.off () #dev=device 






