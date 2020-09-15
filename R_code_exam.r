# R_code_exam.r

# 1. R code first
# 2. R code spatial 
# 3. R code multipanel 
# 4. R code point pattern analysis
# 5. R code multivariate analysis 
# 6. R code remote sensing
# 7. R code ecosystem function
# 8. R code pca remote sensing 
# 9. R code radiance
# 10. R code faPAR
# 11. R code EBV
# 12. R code NO2 
# 13. R code snow
# 14. R code crop
# 15. R code interpolation
# 16. R code sdm
# 17. R cose exam project 

########################################################################
########################################################################
########################################################################
########################################################################

# --------------------------------- 1. R code first

install.packages("sp") #shows the points in a map
library(sp) # attach an add-on package
data(meuse) # to load specific dataset

#let's see how the meuse dataset is structured
meuse 

#let's look at the first row of the set
head(meuse)

#let's plot two variables
#let's see if the zinc concentration is related to that of copper

attach(meuse) #the function attach allows to access variables of a data.frame (meuse) without calling the it
plot(zinc,copper) 
plot(zinc,copper,col="green") #modify the color of the symbols 
plot(zinc,copper,col="green",pch=19) #pch is used to specify point shapes
plot(zinc,copper,col="green",pch=19,cex=2) #cex: symbols are scaled: 1=default, 1.5 is 50%largers, 0.5=is 50% smaller

########################################################################
########################################################################
########################################################################
########################################################################

# --------------------------------- 2. R code spatial 

install.pakages("sp")
library(sp)

data(use)
head(meuse)

#coordinates
coordinates(meuse)= ~ x+y #equal the group of X and Y

plot(meuse)

#using the plot we just say the points, with spplot we introduce a new variable 
spplot(meuse, "zinc")          #declare which dataset we want to use and add a variable 
#the zinc is concentrated in the yellow part (upper part of the graph), the numbers in the graph are the measurments (amount of the element)

#EXERCISE: plot the spatial amount of copper
spplot(meuse, "copper", main="Copper concentration") #main="title"

bubble(meuse, "zinc", main="Zinc concentration")

#EXERCISE: bubble copper in red
bubble(meuse, "copper", col="red", main="Copper concentration")

###IMPORTING NEW DATA
# download covid_agg-cvs from the teaching site and buld a folder called "lab" into C:
# put the covid_agg.csv file into the folder lab

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

#save project

############## day 2
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
ggplot(mpg, aes(x=displ,y=hwy))+geom_polygon() #polygon geometry

head(covid)

# ggplot of covid
ggplot(covid, aes(x=lon,y=lat,size=cases))+geom_point()  #size= the size of the point changes according to the n° of cases in each country

########################################################################
########################################################################
########################################################################
########################################################################

# --------------------------------- 3. R code multipanel 

install.packages("sp")
install.packages("GGally") #this is used for the function ggpairs() 

library(sp) #require(sp) is the same 
library(GGally) 

data(meuse) #there is a dataset available named meuse
attach (meuse)

#EXERCISE: see the names of the variabes and plot cadmium versus zinc
#there are two ways to see the names of the variables:
#the fist is
names (meuse)
#the second is: head (meuse)

plot(cadmium,zinc,pch=15,col="red",cex=2)

#EXERCISE: make all the possible paiwis plots of the dataset
#plot(x,cadmium)
#plot(x,zinc)
#plot...
#plot isn't a god idea --> we use pairs(meuse)
pairs(meuse) # create a matrix of scatterplot

#the result is a multipanel: all the graphs are shown in only one figure 
#in case you receive the error "the size is too large", you have to reshape with the mouse the graph window

pairs(~ cadmium+copper+lead+zinc, data=meuse)  #grouping variabiles; "~" called "tilde" --> blocnum alt+126 ; comma separates different arguments

# another way to do that is
pairs(meuse[,3:6]) #name of dataset + make the subset of the dataset  "," comma means "start from" ":" means "until"

#EXERCISE: prettify this graph = modify the characteristics of the graph
pairs(meuse[,3:6], col="blue", pch=4, cex=1)

#go up at the beginning of the code and istall another package: GGally
#GGally package will prettify the graph
#install the package and use the library(GGally)
ggpairs(meuse[,3:6])

#reading of the graph: cadium and copper have very high correlation (0<correlation<1)

########################################################################
########################################################################
########################################################################
########################################################################

# --------------------------------- 4. R code point pattern analysis (density map)

install.packages("spatstat") 
# Spatial Point Pattern Analysis: statystical analysis of spatial point pattern

library(spatstat)

# attach the Covid dataset
attach(covid)
head(covid)

# give a name to the object we are goingo to prepare
covids <-ppp(lon,lat,c(-180,180), c(-90,90))  
# ppp(x,y, range of longiture, range of latitude) -> point pattern dataset in the two-dimensional plane

# without attaching the covid set
# the ppp command becomes: covids <-ppp(covid$lon, covid$lat,c(-180,180), c(-90,90))  

#######FUNCTION DENSITY : how dense are the points in space?
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

# we need to copy all the functions used to define the plot
cl <- colorRampPalette (c("yellow","orange","red"))(100)
plot(d, col=clr, main="Densities of covid-19")
plot(d,col=cl)
points (covids)
plot(coastlines, add=T)
dev.off () #dev=device 

########################################################################
########################################################################
########################################################################
########################################################################

# --------------------------------- 5. R code multivariate analysis 

install.packages("vegan") # community ecology package
library(vegan)

setwd("C:/lab/")

#import the table 
biomes <- read.table("biomes.csv", head=T, sep=",") #in the biomes there is an header (so T=true), the values are separated by comma
head(biomes) #or view(biomes) -> to view the dataset 

# how the species are related to each other?
multivar <- decorana(biomes) # DEtrended CORrrespondence ANAlysis = DECORANA
plot(multivar)

# analysis of the graph: 
# red colubus, giant orb, tree fern and raflesa are related each otehr --> they are in the same part of the graph
# the same occurs for another part of the graph, for ex. bufo, fox, squirrel, alnus, mosses

# import the addiotional table: biomes type
biomes_types <- read.table("biomes_types.csv", head=T, sep=",")
head(biomes_types)

attach(biomes_types) 

# we are going to draw an ellipse that connect all the points
# 4 different biomes, so 4 different colors or we can write col=c("green","blue","red","black")
# kind= type of graph --> hull is a convex shape and "e" is for ellipse

ordiellipse(multivar, type, col=1:4, kind = "ehull", lwd=3)
ordispider(multivar, type, col=1:4, label=T)


########################################################################
########################################################################
########################################################################
########################################################################

# --------------------------------- 6. R code rs (remote sensing)
#R code for remote sensing data analysis - per analisi di immagini satellitari

setwd("C:/lab/") 

#raster --> rastrum= aratro
install.packages("raster") # raster is the format with the pixels ( matrices of the row, columns and values)
install.packages("RStoolbox") # package for remote sensing image, processing and analysis such as calculating spectral indeces, principal component transformation
library(raster) 

p224r63_2011 <- brick("p224r63_2011_masked.grd") #importe the image 
plot(p224r63_2011)

#to change the color ramp palette : colours are based on number which are actually the reflectance in the electromagnetic spectrum
cl <- colorRampPalette(c('black','grey','light grey'))(100) 
plot(p224r63_2011, col=cl)

#EXERCISE: plot the image with the new color ramp palette
cl <- colorRampPalette(c('red','blue'))(100) 
plot(p224r63_2011, col=cl)

# Bands of landsat
# B1: blue band
# B2: green band
# B3: red band
# B4: NIR (infrared) band (just after the red in the electromagnetic spectrum)
# these bands can be plotted in different ramp palette

dev.off()
 
#multiframe of different plots
par(mfrow=c(2,2)) #number of column and row

# B1: blue band
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) 
plot(p224r63_2011$B1_sre, col=clb)     # $ is used to link every single band to an image

# B2: green band
clb <- colorRampPalette(c('dark green','bgreen','light green'))(100) 
plot(p224r63_2011$B2_sre, col=clb)  

# B3: red band
#R code for remote sensing data analysis - per analisi di immagini satellitari

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

#E XERCISE: plot the image with the new color ramp palette
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

# EXERCISE: NIR on top of the G component of the RGB 
# invert 4 with 3
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin") 

plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

##########

setwd("C:/lab/")
load("rs.RData")
ls()

library(raster)
p224r63_1988_masked <- brick("p224r63_1988_masked.grd")

plot(p224r63_1988_masked)

#if there are some problems with the 2011 image: p224r63_2011_masked<- brick("p224r63_2011_masked.grd") 

# EXERCISE: plot in visible RGB 321 both images
par(mfrow=c(2,1))
plotRGB(p224r63_1988_masked, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011_masked, r=4, g=3, b=2, stretch="Lin")

# EXERCISE: plot in visible RGB 432 both images
par(mfrow=c(2,1))
plotRGB(p224r63_1988_masked, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011_masked, r=4, g=3, b=2, stretch="Lin")

#enhance the noise!
par(mfrow=c(2,1))
plotRGB(p224r63_1988_masked, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011_masked, r=4, g=3, b=2, stretch="hist")

#DVI= NIR - RED --> stressed plants have very low value of difference vegetation index

#plotRGB
# Bands of Landsat
# B1: blue band
# B2: green band
# B3: red band B3_sre
# B4: NIR band  B4_sre

dvi2011 <- p224r63_2011_masked$B4_sre - p224r63_2011_masked$B3_sre
cl <- colorRampPalette(c('darkorchid3','light blue','lightpink4'))(100) 
plot(dvi2011)

#EXERCISE:  dvi for 1988
dvi1988 <- p224r63_1988_masked$B4_sre - p224r63_1988_masked$B3_sre
cl <- colorRampPalette(c('darkorchid3','light blue','lightpink4'))(100) 
plot(dvi1988)

# to see difference from one year to other
diff <- dvi2011 - dvi1988

# Effect of changing scale 
# changing the grain (=resolution= dimension of the pixels)
# RESEMPLING= changing size of pixel 

p224r63_2011res <- aggregate( p224r63_2011_masked, fact=10) # fact= increase the pixel * 10
p224r63_2011res100 <- aggregate( p224r63_2011_masked, fact=100)

par(mfrow=c(3,1))
plotRGB(p224r63_2011_masked, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011res100, r=4, g=3, b=2, stretch="Lin")

########################################################################
########################################################################
########################################################################
########################################################################

# --------------------------------- 7. R code ecosystem function

# R code to view biomass over the world and calculate changes in ecosystem functions
# energy
# chemical cycling
# proxies

install.packages("rasterdiv") #diversity
install.packages("rasterVis") #visualization

library(rasterdiv) # diversity based Raster Data
library(rasterVis) # methods for enhanced visualization and interaction with raster data

data(copNDVI) #Copernicus Long-term database
plot(copNDVI)

copNDVI <- reclassify(copNDVI, cbind(253:255, NA)) # removing water-based colours -> reclassify: function that reclassify groups of values to other values
levelplot(copNDVI)               

copNDVI10 <- aggregate (copNDVI, fact=10)# aggregating 10 pixel in 1 
levelplot(copNDVI10) 

#try to exagerate the aggregation
copNDVI100 <- aggregate (copNDVI, fact=100)
levelplot(copNDVI100) 

######

#library(ggplot2)
# myPalette <- colorRampPalette(c('white','green','dark green'))
# sc <- scale_colour_gradientn(colours = myPalette(100), limits=c(1, 8))

# ggR(copNDVI, geom_raster = TRUE) +
# scale_fill_gradientn(name = "NDVI", colours = myPalette(100))+
# labs(x="Longitude",y="Latitude", fill="")+
#   theme(legend.position = "bottom") + NULL
# ggtitle("NDVI")

setwd("C:/lab/")

library(raster)

defor1 <- brick("defor1_.jpg")
defor2 <- brick("defor2_.jpg")

# band1: NI
# band2: red
# band3: green 

par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

dvi1 <- defor1$defor1_.1 - defor1$defor1_.2

#defor2
#band1: NIR, defor2_.1
#band2: red, defor2_.2

dvi2 <- defor2$defor2_.1 - defor2$defor2_.2

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme

par(mfrow=c(1,2))
plot(dvi1, col=cl)
plot(dvi2, col=cl)

difdvi <- dvi1 - dvi2

dev.off()
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difdvi, col=cld)

hist(difdvi)

########################################################################
########################################################################
########################################################################
########################################################################

# --------------------------------- 8. R code pca remote sensing 

setwd("/Users/utente/lab")
library(raster)
library(RStoolbox)
library(ggplot2)


p224r63_2011 <- brick("p224r63_2011_masked.grd") # import the images composed by different layers

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
plot(diffpca$PC1, color=cldif)

########################################################################
########################################################################
########################################################################
########################################################################

# --------------------------------- 9. R code radiance

library(raster)

toy <- rasater (ncl=2, nrow=2, xmn=1, xmx=2, ymn=1, ymx=2)
values(toy) <- c(1.13, 1.44,1.55,3.4)
plot(toy)
text(toy,digits=2)

# 2 bits --> 2^2 = 4 values 
toy2bit<- stretch(toy,minv=0, maxv=3) #stretch changes the range of values  
                                      #minimum of 0 to a maximum of 3
storage.mode(toy2bits[]) = "integer"  #to ensure that we are going to use integer value 
plot(toy2bits)
text(toy2bits, digits=2)    

# 4 bits --> 2^4 =16 values 
toy4bit<- stretch(toy,minv=0, maxv=15)
storage.mode(toy4bits[]) = "integer"
plot(toy4bits)
text(toy4bits, digits=2) 

# 8 bits --> 2^8 =256 values 
toy8bit<- stretch(toy,minv=0, maxv=255)
storage.mode(toy8bits[]) = "integer"
plot(toy8bits)
text(toy8bits, digits=2)

#plot all together
par(mfrow=c(1,4))
  plot(toy)
text(toy,digits=2)
  plot(toy2bits)
text(toy2bits, digits=2)
  plot(toy4bits)
text(toy4bits, digits=2) 
  plot(toy8bits)
text(toy8bits, digits=2)


########################################################################
########################################################################
########################################################################
########################################################################

# --------------------------------- 10. R code faPAR

setwd("C:/lab/")

library(raster)
library(rasterVis)
library(rasterdiv)

plot(copNDVI) # Copernicus NDVI, present in the rasterdiv library
copNDVI <- reclassify(copNDVI, cbind(253:255, NA)) # remove data from 253 to 255 and put no data as value -> remove water from the analysis

levelplot(copNDVI)
# faPAR: we can see the real power of the forest in keeping carbon
faPAR10 <- raster("farPAR10.tif") # import the image; faPAR10 because it is aggregate by a fact=10

levelplot(farPAR10)

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

#the original faPAR from Copernicus is 2GB
# let's see how much space is needed for an 8-bit set

writeRaster( copNDVI, "copNDVI.tif")
# 5.3 MB

# to make the level plot of the faPAR
levelplot(faPAR10) #faPAR = fraction of the solar radiation absorbed by living leaves 

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

########################################################################
########################################################################
########################################################################
########################################################################

# --------------------------------- 11.R code EBV
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
plotRGB(snt, 3,2,1, stretch="lin") # visible colors 
plotRGB(snt, 4,3,2, stretch="lin") # NIR in top of red: vegetation being coloured in red

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
### Focus on Cladonia stellaris species

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

########################################################################
########################################################################
########################################################################
########################################################################

# --------------------------------- 12. R code NO2

setwd("C:/lab/NO2/")
library(ncdf4) # # ncdf4 package to read all the netCDF files. All Copernicus data use this extension

#EXERCISE: import all of the NO2 data in R  by the lapply function

#we should do the list of the files we want to import 
rlist <- list.files(pattern="EN")  #they all contain in the tille "EN" 

import<- lapply(rlist, raster) #import all the file selected with rlist 

EN <- stack(import) #stack function: to create a multitemporal image 
cl <-colorRampPalette(c('red','orange','yellow'))(100) 
plot(EN,col=cl) #plot the images altogether 

#to see the comparison between the first and the last day:
par(mfrow=c(1,2))
plot(EN$EN_0001, col=cl)
plot(EN$EN_0013, col=cl)

###RGB space: to show spatial data in using colors 
plotRGB(EN, r=1, g=7, b=13,stretch="lin") #1st image of the stack is 0001, 7th is 0007, the last(13rd) is 0013

#different map between the two situations 
dif <- EN$EN_0013 - EN$EN_0001
cld <-colorRampPalette(c('blue','white','red'))(100) #red means high differences, blue means lower difference between the 2 periods
plot(dif,col=cld) 

#quantitative measure of the decreasing of NO2
boxplot(EN)
boxplot(EN,outline=F) #vertical boxplot with the outlines removed 
boxplot(EN,outline=F, horizontal=T) #horizontal boxplot
boxplot(EN,outline=F, horizontal=T, axes=T)

# plot 
plot(EN$EN_0001, EN$EN_0013)
 
# we can compare each pixels of 2 stituations plotting the 2 images in order to see if NO2 decreases o increases in each pixel
plot(EN$EN_0001, EN$EN_0013) 
abline(0,1,col="red") #most of the point are under the line, that means that the NO2 decreases


############ do the same with snow images (see the snow file!)
setwd("C:/lab/snow/")
rlist <- list.files(pattern="snow")
import <- lapply(rlist, raster)
snow.multitemp <- stack(import)

plot(snow.multitemp$snow2010r,snow.multitemp$snow2020r) #strange plot! 
abline(0,1,col="red")

########################################################################
########################################################################
########################################################################
########################################################################

# --------------------------------- 13. R code snow

#set the working directory
setwd("C:/lab/") 

install.packages("ncdf4") #to read the netCDF files 
library(ncdf4)
library(raster)

#image downloaded by Copernicus dataset
snowmay <- raster("c_gls_SCE_202005260000_NHEMI_VIIRS_V1.0.1.nc") #a warning message may appear: cannot process these parts of the CRS. No problem, we are using only a part of the extent 

cl <- colorRampPalette(c('darkblue','blue','light blue'))(100) 

#EXERCISE: plot snow cover with the cl palette
plot(snowmay,col=cl) #we can see the parts covered by snow

#import snow data 
#set the new working directory 
setwd("C:/lab/snow")

#upload the files
snow2000r <- raster("snow2000r.tif")
snow2005r <- raster("snow2005r.tif")
snow2010r <- raster("snow2010r.tif")
snow2015r <- raster("snow2015r.tif")
snow2020r <- raster("snow2020r.tif")

#to plot all the data together we use the par function
par(mfrow=c(2,3)) #multiframe row 
plot(snow2000r, col=cl)
plot(snow2005r, col=cl)
plot(snow2010r, col=cl)
plot(snow2015r, col=cl)
plot(snow2020r, col=cl)

################## FAST VERSION OF IMPORT AND PLOT ALL THE DATA 
lapply() #function to apply a function over a list or vector 

#we should do the list of the files we want to import 
rlist <- list.files(pattern="snow")  #they all contain the word "snow"--> same pattern 

import<- lapply(rlist, raster) #import all the file selected with rlist 

snow.multitemp <- stack(import) #stack function: to create a multitemporal image 
plot(snow.multitemp,col=cl) # we have all the plot together without using the par function 

################ to make a PREDICTION 

source("prediction.r") #we use the script in R 

# since the code needs time we can download predicted.snow.2025.norm.tif from iol in the Data
predicted.snow.2025.norm <- raster("predicted.snow.2025.norm.tif")
plot(predicted.snow.2025.norm, col=cl)

############ day 2
#set again the working directory
setwd("C:/lab/snow")

#EXERCISE: import the snow cover images altogether
rlist <- list.files(pattern="snow")
import <- lapply(rlist, raster)
snow.multitemp <- stack(import)
cl <- colorRampPalette(c('darkblue','blue','light blue'))(100) 
plot(snow.multitemp, col=cl)

#load prediction file 
prediction <- raster("predicted.2025.norm.tif")
plot(prediction, col=cl) #snow cover will be present only in the northern part of the world 

#export output
#we made the calculation and we want to send the output
writeRaster(prediction, "final.tif") #in the folder "snow" we have the file named "final.tif"
final.stack <- stack(snow.multitemp, prediction)
plot(final.stack, col=cl) #plot all the images together 

#export the R graph as a pdf
pdf("my_final_graph.pdf")
plot(final.stack, col=cl)
dev.off()

#export the R graph as a png
png(("my_final_graph.pdf")
plot(final.stack, col=cl)
dev.off()

rlist_prediction <- list.files(pattern="20") 
import_prediction<- lapply(rlist_prediction, raster)
snow.multitemporal <- stack(import_prediction) #stack function: to create a multitemporal image 
plot(snow.multitemporal,col=cl) 

########################################################################
########################################################################
########################################################################
########################################################################

# --------------------------------- 14. R code crop

setwd("C:/lab/") 

library(raster)
library(ncdf4)
 
snow <- raster("c_gls_SCE_202005260000_NHEMI_VIIRS_V1.0.1.nc")

cl <- colorRampPalette(c('darkblue','blue','light blue'))(100)
plot(snow, col=cl)

# to see italy 
ext <- c(0, 20, 35, 50)

#zoom function
zoom(snow, ext=ext)

#crop the image cutting the previous image 
crop(snow, ext)
snowitaly <- crop(snow, ext)

#rectangular image
zoom(snow, ext=drawExtent())

########################################################################
########################################################################
########################################################################
########################################################################

# --------------------------------- 15. R code interpolation

setwd("C:/lab/")

# install.packages("spatstat")
library(spatstat) #to estimate the density of the plot 

inp <- read.table("dati_plot55_LAST3.csv", sep=";", head=T)
head(inp) #see the titles of the table 

attach(inp) #attach our dataframe (inp)
#plot(inp$X, inp$Y)
plot(X,Y)

summary(inp)
#ppp= planar point pattern : c is the range(minimum and maximum of X and Y)
inppp <- ppp(x=X, y=Y, c(716000,718000),c(4859000,4861000))

names(inp) #see the names of the variables 
marks(inppp)<- Canopy.cov #inp$Canopy.cov is not needed because we attached the function 

canopy <- Smooth(inppp) #we are going to interpolate the data 
plot(canopy) #plot smooth
points(inppp,col="green")

#lichens covered 
marks(inppp)<- cop.lich.mean  #lichens on the trees -> no lichens means high pollution 
lichs<- Smooth(inppp)
plot(lichs)
points(inppp) #higher amount of lichens is in the north 

#to see the images together
par(mfrow=c(1,2))
plot(canopy)
points(inppp)
plot(lichs)
points(inppp)
plot(Canopy.cov, cop.lich.mean, col="red", pch=19, cex=2)

###########
### Psammophilous vegetation
inp.psam <- read.table("dati_psammofile.csv", sep=";", head=T)
attach(inp.psam) 
head(inp.psam)

plot(E,N) 
inp.psam.ppp <- ppp(x=E,y=N,c(356450,372240),c(5059800,5064150))

marks(inp.psam.ppp)<- C_org #measure carbon in the soil 
C <- Smooth(inp.psam.ppp) #C=carbon
plot(C) 
points(inp.psam.ppp)

########################################################################
########################################################################
########################################################################
########################################################################

# --------------------------------- 16. R code sdm
# Species distribution modelling 

# install.packages("sdm") 
# install.packages("rgdal")
library(sdm)
library(raster) #used for geological variables: predictors 
library(rgdal) #used for species

#import species data
file<-system.file("external/species.shp", package="sdm") 
species<-shapefile(file)
species #too see all the information about the species 
species$Occurrence #occurrence is 0 or 1: absent or present
plot(species[species$Occurrence == 1,],col="blue",pch=16)
points(species[species$Occurrence == 0,],col="red",pch=16)

#environmental variables
path<-system.file("external", package="sdm") 
lst<-list.files(path=path,pattern="asc$",full.names = T) 
lst

#plot all the variables inside the stack
preds<-stack(lst)
cl<-colorRampPalette(c("blue","orange","red","yellow")) (100)
plot(preds, col=cl)

plot(preds$elevation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

plot(preds$temperature, col=cl)
points(species[species$Occurrence == 1,], pch=16)

plot(preds$precipitation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

plot(preds$vegetation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

#make the model
d<-sdmData(train=species, predictors=preds) #training set=insitu data(species set make previously), predictors=where the sp are predicted to be (stack of all of the variables) 
d #to see what there is inside 
m1<-sdm(Occurrence~elevation+precipitation+temperature+vegetation, data=d, methods="glm") 
p1<-predict(m1, newdata=preds)
plot(p1, col=cl)
points(species[species$Occurrence == 1,], pch=16)
s1 <- stack(preds,p1)
plot(s1, col=cl)

########################################################################
########################################################################
########################################################################
########################################################################

# --------------------------------- 16. R code exam project
    
setwd("C:/lab/California") #set the working directory

# install all packages needed 
install.packages ("raster") #analysis and geographyc data manipulation 
install.packages("rasterdiv") # diversity based Raster Data
install.packages ("rasterVis") #visualize raster data 
install.packages ("rgdal") #geospatial analysis 
install.packages("RStoolbox") #for remote sensing image, processing and analysis such as calculating spectral indices, principal component transformation
install.packages("ggplot2") #to better plot images 
install.packages("gridExtra") # to plot together different images


# load the packages in the library 
library(raster)
library(rasterdiv)
library(rasterVis) 
library(rgdal)
library(RStoolbox)
library(ggplot2)
library(gridExtra)


###### ANALYSIS 

#create a list of raster layers to use (for 2018- June and September, and for 2020- June and September)
#import 2018_June images
setwd("C:/lab/California/2018_14_June")
rlist_2018_June<- list.files(pattern="2018")
rlist_2018_June 
import_images_2018_June <- lapply(rlist_2018_June, raster)
images_2018_June <- stack(import_images_2018_June)
#crop the images 
ext <- c(0, 2500, 0, 1300)
#zoom function
zoom(images_2018_June, ext=ext)
images_2018_June_crop <- crop(images_2018_June, ext)

#import 2018_September images
setwd("C:/lab/California/2018_28_September")
rlist_2018_September<- list.files(pattern="2018")
rlist_2018_September 
import_images_2018_September <- lapply(rlist_2018_September, raster)
images_2018_September <- stack(import_images_2018_September)
images_2018_September_crop <- crop(images_2018_September, ext)

#import 2020_June images
setwd("C:/lab/California/2020_03_June")
rlist_2020_June<- list.files(pattern="2020")
rlist_2020_June 
import_images_2020_June <- lapply(rlist_2020_June, raster)
images_2020_June <- stack(import_images_2020_June)
images_2020_June_crop <- crop(images_2020_June, ext)

#import 2020_September images
setwd("C:/lab/California/2020_06_September")
rlist_2020_September<- list.files(pattern="2020")
rlist_2020_September 
import_images_2020_September <- lapply(rlist_2020_September, raster)
images_2020_September <- stack(import_images_2020_September)
images_2020_September_crop <- crop(images_2020_September, ext)

# plot in RGB visible 2018 images
visible_June_2018<- ggRGB(images_2018_June_crop, r=4, g=3, b=2,stretch = "Lin") 
visible_June_2018_print<- print(visible_June_2018 + ggtitle("Visible June 2018")+ theme (axis.title.x = element_blank(),axis.title.y = element_blank()))
visible_September_2018<- ggRGB(images_2018_September_crop, r=4, g=3, b=2,stretch = "Lin")
visible_September_2018_print<- print(visible_September_2018 + ggtitle("Visible September 2018")+ theme (axis.title.x = element_blank(),axis.title.y = element_blank()))

#plot June and September 2018 together
grid.arrange(visible_June_2018_print, visible_September_2018_print,  ncol = 1)

# plot in RGB visible 2020 images
visible_June_2020<- ggRGB(images_2020_June_crop, r=4, g=3, b=2,stretch = "Lin") 
visible_June_2020_print<- print(visible_June_2020 + ggtitle("Visible June 2020")+ theme (axis.title.x = element_blank(),axis.title.y = element_blank()))
visible_September_2020<- ggRGB(images_2020_September_crop, r=4, g=3, b=2,stretch = "Lin")
visible_September_2020_print<- print(visible_September_2020 + ggtitle("Visible September 2020")+ theme (axis.title.x = element_blank(),axis.title.y = element_blank()))

#plot June and September 2020 together
grid.arrange(visible_June_2020_print, visible_September_2020_print,  ncol = 1)

#plot all the images - 2018 and 2020 - together
grid.arrange(visible_June_2018_print, visible_September_2018_print, visible_June_2020_print, visible_September_2020_print,  ncol= 2, nrow = 2)

#RGB (8,4,3) - FALSE COLORS

# plot in false color 2018 images
false_June_2018<- ggRGB(images_2018_June_crop, r=8, g=4, b=3,stretch = "Lin") 
false_June_2018_print<- print(false_June_2018 + ggtitle("False color June 2018")+ theme (axis.title.x = element_blank(),axis.title.y = element_blank()))
false_September_2018<- ggRGB(images_2018_September_crop, r=8, g=4, b=3,stretch = "Lin")
false_September_2018_print<- print(false_September_2018 + ggtitle("False color September 2018")+ theme (axis.title.x = element_blank(),axis.title.y = element_blank()))

grid.arrange(false_June_2018_print, false_September_2018_print,  ncol = 1)

# plot in false color 2020 images
false_June_2020<- ggRGB(images_2020_June_crop, r=8, g=4, b=3,stretch = "Lin") 
false_June_2020_print<- print(false_June_2020 + ggtitle("False color June 2020")+ theme (axis.title.x = element_blank(),axis.title.y = element_blank()))
false_September_2020<- ggRGB(images_2020_September_crop, r=8, g=4, b=3,stretch = "Lin")
false_September_2020_print<- print(false_September_2020 + ggtitle("False color September 2020")+ theme (axis.title.x = element_blank(),axis.title.y = element_blank()))

grid.arrange(false_June_2020_print, false_September_2020_print,  ncol = 1)

# NDVI anlysis
# calculate NDVI using the red and nir bands

NDVI_2018_June <- (images_2018_June_crop[[8]] - images_2018_June_crop[[4]]) / (images_2018_June_crop[[8]] + images_2018_June_crop[[4]])
NDVI_2018_September <- (images_2018_September_crop[[8]] - images_2018_September_crop[[4]]) / (images_2018_September_crop[[8]] + images_2018_September_crop[[4]])
NDVI_2020_June <- (images_2020_June_crop[[8]] - images_2020_June_crop[[4]]) / (images_2020_June_crop[[8]] + images_2020_June_crop[[4]])
NDVI_2020_September <- (images_2020_September_crop[[8]] - images_2020_September_crop[[4]]) / (images_2020_September_crop[[8]] + images_2020_September_crop[[4]])

# plot the NDVI data
par(mfrow=c(2,2), 
    mar = c(1, 1, 1, 1)) #mar: plot with small margins
plot(NDVI_2018_June, main = "NDVI  - June 2018", axes = FALSE, box = FALSE )
plot(NDVI_2018_September, main = "NDVI  - September 2018",axes = FALSE, box = FALSE)
plot(NDVI_2020_June, main = "NDVI  - June 2020",axes = FALSE, box = FALSE)
plot(NDVI_2020_September, main = "NDVI  - September 2020",axes = FALSE, box = FALSE)

# I tried to visualize the difference between NDVI, but they have no so much significance
#see the difference between June and September - 2018
#diff_NDVI_2018 <- NDVI_2018_September - NDVI_2018_June
# color-palette for immages of comparison difference
#cldiff<- colorRampPalette(c("black", "yellow"))(100)
#plot(diff_NDVI_2018, col=cldiff,
#     main = "Difference in normalized vegetation index 2018 \n September and June" ,
#     box = FALSE)
#see the difference between June and September - 2020
#diff_NDVI_2020 <- NDVI_2020_September - NDVI_2020_June
#plot(diff_NDVI_2020, col=cldiff,
#     main = "Difference in normalized vegetation index 2020 \n September and June" ,
#     box = FALSE)
#see the difference between 2018 (June) and 2020 (September)
#diff_NDVI_2018_2020 <- NDVI_2020_September - NDVI_2018_June
#plot(diff_NDVI_2018_2020, col=cldiff,  
#     main = "Difference in normalized vegetation index \n 2020 - 2018" ,
#     box = FALSE)

# so I tried to visualize the differences using histograms thanks to the NDVI classification 
# histogram NDVI Juned 2018
hist_NDVI_2018_June <-hist(NDVI_2018_June, main = "Distribution of NDVI values \n June 2018",	xlab = "NDVI", ylab= "Frequency", breaks=30)  
axis(side=1, at = seq(-0.5,1, 0.05), labels = seq(-0.5,1, 0.05))

# histogram NDVI September 2018
hist_NDVI_2018_September <- hist(NDVI_2018_September, main = "Distribution of NDVI values \n September  2018",xlab = "NDVI", ylab= "Frequency", breaks=30)
axis(side=1, at = seq(-0.5,1, 0.05), labels = seq(-0.5,1, 0.05))

# histogram NDVI Juned 2020
hist_NDVI_2020_June <-	hist(NDVI_2020_June, main = "Distribution of NDVI values \n June 2020",	xlab = "NDVI", ylab= "Frequency", breaks=30, )
axis(side=1, at = seq(-0.5,1, 0.05), labels = seq(-0.5,1, 0.05))

# histogram NDVI September 2020
hist_NDVI_2020_September <- hist(NDVI_2020_September, main = "Distribution of NDVI values \n September  2020",xlab = "NDVI", ylab= "Frequency", breaks=30, )
axis(side=1, at = seq(-0.5,1, 0.05), labels = seq(-0.5,1, 0.05))

# create transparent colors 
col2rgb("lightblue")
col2rgb(c("lightblue", "lightgreen", "pink"))
mycol <- rgb(0, 0, 255, max = 255, alpha = 125, names = "blue50")
c1 <- rgb(173,216,230,max = 255, alpha = 80, names = "lt.blue")
c2 <- rgb(255,192,203, max = 255, alpha = 80, names = "lt.pink") 

# plot the 2018 histograms
par(mai=rep(0.5, 4))
layout(matrix(c(1,1,2,2,0,3,3,0), ncol = 4, byrow = TRUE))
plot(hist_NDVI_2018_June, col=c2, main="NDVI June 2018", xlab = "NDVI")
plot(hist_NDVI_2018_September, col=c1, main="NDVI September 2018", xlab = "NDVI")
plot(hist_NDVI_2018_June, col = c2, xlim = c(-0.5, 1), main="Comparison between 2018 NDVI",xlab = "NDVI" )
plot(hist_NDVI_2018_September , add = TRUE, col = c1)

# plot the 2020 histograms
par(mai=rep(0.5, 4))
layout(matrix(c(1,1,2,2,0,3,3,0), ncol = 4, byrow = TRUE))
plot(hist_NDVI_2020_June, col=c2, main="NDVI June 2020", xlab = "NDVI")
plot(hist_NDVI_2020_September, col=c1, main="NDVI September 2020", xlab = "NDVI")
plot(hist_NDVI_2020_June, col = c1, xlim = c(-0.5, 1), main="Comparison between 2020 NDVI",xlab = "NDVI" )
plot(hist_NDVI_2020_September, add = TRUE, col = c1)

#  remove cells where NDVI < 0,4
NDVI_2018_June_mod <- reclassify(NDVI_2018_June, cbind(-Inf, 0.4, NA))
NDVI_2018_September_mod <- reclassify(NDVI_2018_September, cbind(-Inf, 0.4, NA))
NDVI_2020_June_mod <- reclassify(NDVI_2020_June, cbind(-Inf, 0.4, NA))
NDVI_2020_September_mod <- reclassify(NDVI_2020_September, cbind(-Inf, 0.4, NA))

# plot the NDVI data modified - 2018 and 2020 
par(mfrow=c(2,2))
plot(NDVI_2018_June_mod, main='Vegetation \n June 2018', axes=FALSE, box=FALSE)
plot(NDVI_2018_September_mod, main='Vegetation \n September 2018', axes=FALSE, box=FALSE)
plot(NDVI_2020_June_mod, main='Vegetation \n June 2020', axes=FALSE, box=FALSE)
plot(NDVI_2020_September_mod, main='Vegetation \n September 2020', axes=FALSE, box=FALSE)

# NBR= normalized burned ratio 
# NBR 2018
NBR_June_2018 <-  (images_2018_June_crop[[8]] - images_2018_June_crop[[12]])/ (images_2018_June_crop[[8]] + images_2018_June_crop[[12]])
NBR_September_2018 <-  (images_2018_September_crop[[8]] - images_2018_September_crop[[12]])/ (images_2018_September_crop[[8]] + images_2018_September_crop[[12]])
# NBR 2020
NBR_June_2020 <-  (images_2020_June_crop[[8]] - images_2020_June_crop[[12]])/ (images_2020_June_crop[[8]] + images_2020_June_crop[[12]])
NBR_September_2020 <-  (images_2020_September_crop[[8]] - images_2020_September_crop[[12]])/ (images_2020_September_crop[[8]] + images_2020_September_crop[[12]])

# dNBR 2018
dNBR_2018 <-  NBR_June_2018 - NBR_September_2018
plot(dNBR_2018, 
     main = "Difference in NBR\n  June - September 2018" ,
     box = FALSE)
# dNBR 2020
dNBR_2020 <-  NBR_June_2020-NBR_September_2020 
plot(dNBR_2020,
     main = "Difference in NBR\n  June - September 2020" ,
     box = FALSE)

# BURN SEVERITY MAP: colour obtain the burn severity map, it is necessary to classify difference_NBR.
# The classification should be conducted in accordance with the USGS burn severity standards.

#   2018 
# scales the dNBR map by 10^3
dNBR_2018_scaled <- 1000*dNBR_2018
# sets the ranges that will be used to classify dNBR information about the ranges used, please see the NBR section on the recommended practice
NBR_ranges <- c(-Inf, -500, -1, -500, -251, 1, -251, -101, 2, -101, 99, 3, 99, 269, 4, 269, 439, 5, 439, 659, 6, 659, 1300, 7, 1300, +Inf, -1) 
# sets a classification matrix
class.matrix <- matrix(NBR_ranges, ncol = 3, byrow = TRUE)
# classification matrix is used to classify dNBR_2018_scaled
dNBR_2018_reclass <- reclassify(dNBR_2018_scaled, class.matrix, right=NA)
# Building the legend
# Now that the burn severity map has been generated, the legend for the burn severity classes also needs to be created. 
# builds the attribute table for the legend 
dNBR_2018_reclass <- ratify(dNBR_2018_reclass) 
rat2018 <- levels(dNBR_2018_reclass)[[1]]
# creates the text that will be on the legend
rat2018$legend  <- c("NA", "Enhanced Regrowth, High", "Enhanced Regrowth, Low", "Unburned", "Low Severity", "Moderate-low Severity", "Moderate-high Severity", "High Severity") 
levels(dNBR_2018_reclass) <- rat2018 
# change the default colors : setting the colors for the severity map
my_col=c("white", "darkolivegreen","darkolivegreen4","limegreen", "yellow2", "orange2", "red", "purple")
# plots the burn severity map 
plot(dNBR_2018_reclass,col=my_col,legend=F,box=F,axes=F, main="Burn Severity 2018") 
# plots the legend on the right side of the burn severity map
legend(x="top" ,legend =rat2018$legend, fill = my_col, y='right', inset=c(-0.2,0), ncol=3, cex = 0.75) 

#   2020

dNBR_2020_scaled <- 1000*dNBR_2020
# classification matrix is used to classify dNBR_2020_scaled
dNBR_2020_reclass <- reclassify(dNBR_2020_scaled, class.matrix, right=NA)
# Building the legend
# Now that the burn severity map has been generated, the legend for the burn severity classes also needs to be created. 
# builds the attribute table for the legend 
dNBR_2020_reclass <- ratify(dNBR_2020_reclass) 
rat2020 <- levels(dNBR_2020_reclass)[[1]]
# creates the text that will be on the legend
rat2020$legend  <- c("NA", "Enhanced Regrowth, High", "Enhanced Regrowth, Low", "Unburned", "Low Severity", "Moderate-low Severity", "Moderate-high Severity", "High Severity") 
levels(dNBR_2020_reclass) <- rat2020 
# plots the burn severity map 
plot(dNBR_2020_reclass,col=my_col,legend=F,box=F,axes=F, main="Burn Severity 2020") 
# plots the legend on the right side of the burn severity map
legend(x="top" ,legend =rat2020$legend, fill = my_col, y='right', inset=c(-0.2,0), ncol=3, cex = 0.75)

# It's possible to make a distribution of the classified NBR values from the previous raster
barplot(dNBR_2018_reclass,
        main = "Distribution of Classified NBR Values \n 2018",
        col = my_col,
        names.arg = c("NA", "RegrHigh", "RegrLow", "Unburned", "LowSev", "ModLowSev", "ModHighSev", "HighSev"), 
        horiz=TRUE,
        las=2,
        maxpixels= 2807500)
barplot(dNBR_2020_reclass,
        main = "Distribution of Classified NBR Values \n 2020",
        col = my_col,
        names.arg = c("NA", "RegrHigh", "RegrLow", "Unburned", "LowSev", "ModLowSev", "ModHighSev", "HighSev"), 
        horiz=TRUE,
        las=2,
        maxpixels= 2807500)


