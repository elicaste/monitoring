# R_code_EBVs.r
# measure the standar deviation from a satellite imagine 

setwd("C:/lab/")

library(raster)
library/Rstoolbox) #for PCA

snt <- brick("snt_r10.tif")
plot(snt)

#B1 blue
#B2 green
#B3 red
#B4 NIR

#R3 G2 B1
plotRGB(snt, 3,2,1, stretch="lin")
plotRGB(snt, 4,3,2, stretch="lin")

pairs(snt)

### PCA analysis

sntpca <- rasterPCA(snt)
sntpca
summary(sntpca$model)
#70% of information
plot(sntpca$map)
plotRGB(sntpca$map, 1,2,3, stretch="lin")

# calculate the standard deviation 
#set the moving window
window <- matrix(1, nrow=5, ncol=5)
window

#focal function                   #first principal component
sd_snt <- focal(sntpca$map$PC1, w=window, fun=sd)
cl <- colorRampPalette(c("dark blue", "green", "orange", "red"))(100)
plot(sd_snt, col=cl)

par(mfrow=c(1,2))
plotRGB(snt,4,3,2, stretch="lin", main="original image") 
plot(sd_snt, col=cl, main="diversity")

############### day 2
# Focal on Cladonia stellaris 

library(raster)
library(RStoolbox)

setwd("C:/lab/")

#to import the file we can cuse the raster function (that imports a single layer) or brick function (that imports different layers) 
clad <- brick("cladonia_stellaris_calaita.JPG")  

#matrix of 3 by 3 pixels, numer 1 doesn't impact the calculation 
window <- matrix(1, nrow = 3, ncol = 3)
window

# PCA analyssis for Cladonia 
cladpca <- rasterPCA(clad)
cladpca #to see all the data that are output of this function 
summary(cladpca$model) #we can see that the proportion of variance is 0.98 that means the 98% of the first component 

#see how much information is explained by the PCA 
#98%
plotRGB(cladpca$map, 1,2,3, stretch="lin")

#set the moving window
window <- matrix(1, nrow=5, ncol=5)
window

# focal function is going to calculate values for neighborhood of focal cells
sd_clad <- focal(cladpca$map$PC1, w=window, fun=sd) 
#aggregate function
PC1_agg <- aggregate(cladpca$map$PC1, fact=10)
sd_clad_agg <- focal(PC1_agg, w=window, fun=sd) 

par(mfrow=c(1,2)) #to see different gaphs together in one final image 
cl <- colorRampPalette(c('yellow','violet','black'))(100) 
plot(sd_clad,col=cl) 
plot(sd_clad_agg,col=cl)  #cladonia set aggregated 

#plot the calculation 
par(mfrow=c(1,2)) 
cl <- colorRampPalette(c('yellow','violet','black'))(100) #
plotRGB(clad, 1,2,3, stretch="lin")
plot(sd_clad, col=cl)

q()


cl <- colorRampPalette(c('yellow','violet','black'))(100) #


plot()


plotRGB(clad, 1,2,3, stretch="lin")


plot(sd_clad, col=cl)
# plot(sd_clad_agg, col=cl)

#we saw 

dev.off()
q()

