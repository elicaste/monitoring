### R_code_pcs_remote_sensing.r

setwd("/Users/utente/lab")
library(raster)
library(RStoolbox)
library(ggplot2)


p224r63_2011 <- brick("p224r63_2011_masked.grd")

#B1 blue
#B2 green
#B3 red
#B4 NIR
#B5 SWIR
#B6 thermal infrared 
#B7 SWIR
#B8 panchromatic

#RGB: 
plotRGB(p224r63_2011, r=5, g=4, b=3, stretch="Lin")
ggRGB(p224r63_2011,5,4,3)

#do the same, with the 1988 image
p224r63_1988 <- brick("p224r63_1988_masked.grd")
plotRGB(p224r63_1988, r=5, g=4, b=3, stretch="Lin")
ggRGB(p224r63_1988,5,4,3)

#plot together
par(mfrow=c(1,2))
plotRGB(p224r63_1988, r=5, g=4, b=3, stretch="Lin")
plotRGB(p224r63_2011, r=5, g=4, b=3, stretch="Lin")

names(p224r63_2011)
# "B1_sre" "B2 sre" "B3_sre" "B4_sre", "B5_sre", B6_bt"

plot(p224r63_2011$B1_sre,p224r63_2011$B1_sre) #if these bands are correlated 
#the minimum correlation is -1 and the higher correlation is 1

# PCS
#decrease the resolution 
p224r63_2011_res <- aggregate(p224r63_2011, fact=10)
#library (RStoolbox) is now needed
p224r63_2011_pca <- rasterPCA(p224r63_2011_res) 

plot(p224r63_2011_pca$map) #in this way we have the default color palette

cl <- colorRampPAlette(c("dark grey","grey","light grey"))(100)
plot(p224r63_2011_pca$map, color=cl) #grey plot


summary(p224r63_2011_pca$model)
#PC1 99.83% of the whole variation 

#plot the first 3 components
pairs(p224r63_2011)
plotRGB(p224r63_2011_pca$map, r=1, g=2, b=3, stretch="Lin")

#----1988
p224r63_1988_res <- aggregate(p224r63_1988, fact=10)
p224r63_1988_pca <- rasterPCA(p224r63_1988_res) 
plot(p224r63_1988_pca$map, color=cl) 
summary(p224r63_1988_pca$model)
pairs(p224r63_1988)

#difference
diffpca <- p224r63_2011_pca$map - p224r63_1988_pca$map
plot(diffpca)
cldif <-colorRampPalette(c('blue','black','yellow'))(100) 
plot(diffpca, color=cldif)
