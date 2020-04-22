#R code for remote sensing data analysis - per analisi di immagini satellitali

setwd("C:/lab/") 

#raster --> rastrum= aratro
  
install.packages("raster")
install.packages("RStoolbox")
library(raster) 

p224r63_2011 <- brick("p224r63_2011_masked.grd") #importe the image 
plot(p224r63_2011)

#to change the color ramp palette 
cl <- colorRampPalette(c('black','grey','light grey'))(100) 
plot(p224r63_2011, col=cl)

#Exercise: plot the image with the new color ramp palette
cl <- colorRampPalette(c('red','blue'))(100) 
plot(p224r63_2011, col=cl)

# Bands of landsat
# B1: blue band
# B2: green band
# B3: red band
# B4: NIR (infrared) band 

# these bands can be plotted in different ramp palette

dev.off()
 
#multiframe of different plots
par(mfrow=c(2,2)) #number of column and row

# B1: blue band
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) 
plot(p224r63_2011$B1_sre, col=clb)     #$ is used to link every single band to an image

# B2: green band
clb <- colorRampPalette(c('dark green','bgreen','light green'))(100) 
plot(p224r63_2011$B2_sre, col=clb)  

# B3: red band
#R code for remote sensing data analysis - per analisi di immagini satellitali

setwd("C:/lab/") 

#raster --> rastrum= aratro
  
install.packages("raster")
install.packages("RStoolbox")
library(raster) 

p224r63_2011 <- brick("p224r63_2011_masked.grd") #importe the image 
plot(p224r63_2011)

#to change the color ramp palette 
cl <- colorRampPalette(c('black','grey','light grey'))(100) 
plot(p224r63_2011, col=cl)

#Exercise: plot the image with the new color ramp palette
cl <- colorRampPalette(c('red','blue'))(100) 
plot(p224r63_2011, col=cl)

# Bands of Landsat
# B1: blue band
# B2: green band
# B3: red band
# B4: NIR (infrared) band 

# these bands can be plotted in different ramp palette

dev.off()
 
#multiframe of different plots
par(mfrow=c(2,2)) #number of row x column

# B1: blue band
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) 
plot(p224r63_2011$B1_sre, col=clb)     #$ is used to link every single band to an image

# B2: green band
clg <- colorRampPalette(c('dark green','green','light green'))(100) 
plot(p224r63_2011$B2_sre, col=clg)  

# B3: red band
clr <- colorRampPalette(c('dark red','red','pink'))(100) 
plot(p224r63_2011$B3_sre, col=clr)  

# B4: NIR band
cln <- colorRampPalette(c('red','orange','yellow'))(100) 
plot(p224r63_2011$B4_sre, col=cln)  

#to see all the colors available on R we can write Color() on R

# We can change all the images one up of the other --> graph with 4 rows and 1 column
par(mfrow=c(4,1))

clb <- colorRampPalette(c('dark blue','blue','light blue'))(100)  
plot(p224r63_2011$B1_sre, col=clb)

clg <- colorRampPalette(c('dark green','green','light green'))(100)  
plot(p224r63_2011$B2_sre, col=clg)

clr <- colorRampPalette(c('dark red','red','pink'))(100)  
plot(p224r63_2011$B3_sre, col=clr)

cln <- colorRampPalette(c('red','orange','yellow'))(100)  
plot(p224r63_2011$B4_sre, col=cln)

# in the computer there are 3 components that make the colors visible: RGB system
# R --> we associate the 3rd red band to R
# G --> we associate the 2nd green band to G
# B --> we associate the 1st blu band to B

dev.off() # esc from other graph

#plotRGB
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
#name of the images/ correspondence between the RGB system and the bands of landsat/ the color is stretched linearily 

#we want to use NIR band so we shift every bands
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

# Exercise: NIR on top of the G component of the RGB 
# invert 4 with 3
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin") 

plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")







