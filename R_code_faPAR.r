# R_code_faPAR.r

setwd("C:/lab/")

library(raster)
library(rasterVis)
library(rasterdiv)

plot(copNDVI)
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))

levelplot(copNDVI)
faPAR10 <- raster("farPAR10.tif") #import the file

levelpot(farPAR10)

#save the plot as pdf
pfd("copNDVI.pdf")
levelplot(coNDVI)
dev.off()

pdf("faPAR.pdf")
levelplot(faPAR10)
dev.off()

####################################################### day 2

setwd("C:/lab/") 
load("faPAR.RData")
library(raster)
library(rasterdiv)
library (rasterVis)

#the original faPAR from Copernicus is  2GB
# let's see how much space is needed for an 8-bit set

writeRaster( copNDVI, "copNDVI.tif")
# 5.3 MB

# to make the level plot of the faPAR
levelplot(faPAR10) #faPAR = fraction of the solar radiation absorbed by live leaves 

########## regression model between faPAR and NDVI
erosion <-  c(12,14,16,24,26,40, 55,67) #ex. amount of erosion in a certain area
hm <- c(30,100,150,200,260,340,,460,600) #ex. amount of heavy metals

plot(erosion, hm, col="red", pch=19,
     xlab="erosion", ylab="heavy metals")

#we can make a LINEAR MODEL -> function lm(y~x)
model1 <- lm(hm ~  erosion)
summary(model1)
abline(model1) #line related to the erosion and number of heavy metals


## faPAR vs NDVI model
library(raster)
setwd("C:/lab/")
faPAR10 <- raster("farPAR10.tif")
plot(faPAR10)
plot(copNDVI)

copNDVI <- reclassify(copNDVI, cbind(253:255, NA), right=TRUE)

#we have 2 parameters and we want how the the variables are related
# RANDOM SAMPLES
library(sf) # to call st_* functions
random.points <- function(x,n)  # x is the raster file, n is the number of the random points
{
lin <- rasterToContour(is.na(x))
pol <- as(st_union(st_polygonize(st_as_sf(lin))), 'Spatial') 
pts <- spsample(pol[1,], n, type = 'random')
}

pts <-  random.points(faPAR10, 1000) #ex. we select 1000 points from faPAR10
plot(faPAR10)
points(pts,col="red",pch=19)
 
#function to EXTRACT a point from a raster
copNDVIp <-extract (copNDVI, pts)
faPAR10p <-extract (faPAR10, pts)
  #some points are in the sea and they are represented with NA

# model PHOTOSYNTHESIS vs BIOMASS
model2 <- lm(faPAR10p ~ copNDVIp)
plot(copNDVIp, faPAR10p, col="green"
     xlab="biomass", ylab="photosynthesis")
abline(model2, col="red")










