### R_code_EBVs.r
# measure the standar deviation from a satellite imagine 

setwd("C:/lab/")

library(raster)
library(Rstoolbox) #for PCA

snt <- brick("snt_r10.tif") #brick function is used to create a multi-layer file
plot(snt)

#remember that:
#B1 blue
#B2 green
#B3 red
#B4 NIR

#R3 G2 B1
plotRGB(snt, 3,2,1, stretch="lin")
plotRGB(snt, 4,3,2, stretch="lin")

pairs(snt) #Scatterplot matrices

### PCA analysis
sntpca <- rasterPCA(snt) # rasterPCA calculates R-mode PCA 
sntpca
summary(sntpca$model)

#70% of information
plot(sntpca$map) 
# make a Red-Green-Blue plot based on three layers
plotRGB(sntpca$map, 1,2,3, stretch="lin") 

#calculate the standard deviation 
#set the moving window
window <- matrix(1, nrow=5, ncol=5) #matrix function is used to create a matrix defined by the arguments nrow and ncol
window

#focal function calculates values for the neighborhood of focal cells component
sd_snt <- focal(sntpca$map$PC1, w=window, fun=sd) #fun=the function to be applied
cl <- colorRampPalette(c("dark blue", "green", "orange", "red"))(100)
plot(sd_snt, col=cl)

par(mfrow=c(1,2))
plotRGB(snt,4,3,2, stretch="lin", main="original image") 
plot(sd_snt, col=cl, main="diversity")

############### day 2
### Focal on Cladonia stellaris 

library(raster)
library(RStoolbox)

setwd("C:/lab/")

#to import the file we can use the raster function (that imports a single layer) or brick function (that imports different layers) 
clad <- brick("cladonia_stellaris_calaita.JPG")  

#matrix of 3 by 3 pixels, number 1 doesn't impact the calculation 
window <- matrix(1, nrow = 3, ncol = 3)
window

# PCA analysis for Cladonia 
cladpca <- rasterPCA(clad)
cladpca #to see all the data that are output of this function 
summary(cladpca$model) #we can see that the proportion of variance is 0.98 that means the 98% of the first component 

#see how much information is explained by the PCA 
#98%
plotRGB(cladpca$map, 1,2,3, stretch="lin")

#set the moving window
window <- matrix(1, nrow=5, ncol=5)
window

#focal function is going to calculate values for neighborhood of focal cells
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
cl <- colorRampPalette(c('yellow','violet','black'))(100) 
plotRGB(clad, 1,2,3, stretch="lin")
plot(sd_clad, col=cl)

dev.off()
q()

