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








