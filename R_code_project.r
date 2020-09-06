#R_code_project.r
setwd("C:/lab/California") #set the working director

# install all packages needed 
install.packages ("raster") #package for the analysis and geographyc data manipulation 
install.packages("rasterdiv")
install.packages ("rasterVis") #package for visualize raster data 
install.packages ("rgdal") #package for geospatial analysis 
install.packages("ncdf4") #package for netcdf manipulation
install.packages("rgdal")
install.packages("RStoolbox")
install.packages("gdalUtils")
install.packages("plot.matrix")

# load the packages in the library 
library(raster)
library(rasterdiv)
library(rasterVis)
library(ncdf4) 
library(rgdal)
library(RStoolbox)
library(gdalUtils) #to convert hdf file 
library(plot.matrix)

######################################### RGB and NDVI analysis 
#create a list of raster layers to use (for 2018- June and August, and for 2020- June and August)

#import 2018_June images
setwd("C:/lab/California/2018_June")
rlist_2018_June<- list.files(pattern="2018")
rlist_2018_June 
import_images_2018_June <- lapply(rlist_2018_June, raster)
images_2018_June <- stack(import_images_2018_June)
images_2018_June_br <- brick(images_2018_June)

#import 2018_August images
setwd("C:/lab/California/2018_August")
rlist_2018_August<- list.files(pattern="2018")
rlist_2018_August 
import_images_2018_August <- lapply(rlist_2018_August, raster)
images_2018_August <- stack(import_images_2018_August)
images_2018_August_br <- brick(images_2018_August)

#import 2020_June images
setwd("C:/lab/California/2020_June")
rlist_2020_June<- list.files(pattern="2020")
rlist_2020_June 
import_images_2020_June <- lapply(rlist_2020_June, raster)
images_2020_June <- stack(import_images_2020_June)
images_2020_June_br <- brick(images_2020_June) # convert data into rasterbrick for faster processing

# do the same for other moths and year
#import 2020_August images
setwd("C:/lab/California/2020_August")
rlist_2020_August<- list.files(pattern="2020")
rlist_2020_August 
import_images_2020_August <- lapply(rlist_2020_August, raster)
images_2020_August <- stack(import_images_2020_August)
images_2020_August_br <- brick(images_2020_August)

# plot in RGB visible 2018 images
par(mfrow=c(2,1))
plotRGB(images_2018_June, r=4, g=3, b=2, stretch="Lin", main = "June 2018", axes=TRUE )
plotRGB(images_2018_August, r=4, g=3, b=2, stretch="Lin", main = "August 2018", axes=TRUE) 

# plot in RGB visible 2020 images
par(mfrow=c(2,1))
plotRGB(images_2020_June, r=4, g=3, b=2, stretch="Lin", main = "June 2020", axes=TRUE )
plotRGB(images_2020_August, r=4, g=3, b=2, stretch="Lin", main = "August 2020", axes=TRUE) 

#RGB (8,4,3)
#False color imagery is displayed in a combination of standard near infra-red, red and green band.
#It is most commonly used to assess plant density and healht, as plants reflect near infrared and green light, while absorbing red. 
#Since they reflect more near infrared than green, plant-covered land appears deep red. 
#Denser plant growth is darker red. Cities and exposed ground are gray or tan, and water appears blue or black.

# plot in false color 2018 images
par(mfrow=c(3,1))
falsecolor_2018_June<- plotRGB(images_2018_June, r=8, g=4, b=3, stretch="Lin", main = "June 2018", axes=TRUE )
falsecolor_2018_August<- plotRGB(images_2018_August, r=8, g=4, b=3, stretch="Lin", main = "August 2018", axes=TRUE) 
diff_falsecolor_2018<- falsecolor_2018_August-falsecolor_2018_June
plot(diff_falsecolor_2018,) 

# plot in false color 2020 images
par(mfrow=c(3,1))
falsecolor_2020_June<- plotRGB(images_2020_June, r=8, g=4, b=3, stretch="Lin", main = "June 2020", axes=TRUE )
falsecolor_2020_August<- plotRGB(images_2020_August, r=8, g=4, b=3, stretch="Lin", main = "August 2020", axes=TRUE) 
#diff_falsecolor_2020<- falsecolor_2020_August-falsecolor_2020_June
#plot(diff_falsecolor_2020)

# NDVI anlysis
#The normalized difference vegetation index (NDVI) uses a ratio between near infrared and red light within the electromagnetic spectrum. 
#To calculate NDVI, you use the following formula where NIR is near infrared light and red represents red light. 
#NDVI= (NIR - Red) / (NIR + Red)
#For your raster data, you will take the reflectance value in the red and near infrared bands to calculate the index.

#DVI = NIR- red : Difference Vegetation Index ->Stressed plants have very low value of difference vegetation index 
dvi2018_June <- images_2018_June$X2018.06.02.00_00_2018.06.02.23_59_Sentinel.2_L2A_B04_.Raw.
  -images_2018_June
dvi2020 <- 
  
#see the difference before and after the summer period - 2018
diff_dvi <- dvi2020 - dvi2018
cldiff<- colorRampPalette(c("peachpuff", "mistyrose1", "darkorchid4"))(100)
plot(diff_dvi, col=cldiff)

#see the difference before and after the summer period - 2020

#DVI = NIR- red : Difference Vegetation Index ->Stressed plants have very low value of difference vegetation index 
dvi2018 <- images_2018$X2018.06.14_00_00_._2018.06.14_23_59._Sentinel.2_S2L2A._NDVI - images_2018$X2018.06.14_00_00_._2018.06.14_23_59._Sentinel.2_S2L2A._B02_.Raw.
dvi2020 <- images_2020$X2020.06.08_00_00_._2020.06.08_23_59._Sentinel.2_S2L2A._NDVI - images_2020$X2020.06.08_00_00_._2020.06.08_23_59._Sentinel.2_S2L2A._B02_.Raw.

#NDVI = DVI/NIR+red : Normalised Difference Vegetation Index
ndvi2018 <- dvi2018 / (images_2018$X2018.06.14_00_00_._2018.06.14_23_59._Sentinel.2_S2L2A._NDVI + images_2018$X2018.06.14_00_00_._2018.06.14_23_59._Sentinel.2_S2L2A._B02_.Raw.)
ndvi2020 <- dvi2020 / (images_2020$X2020.06.08_00_00_._2020.06.08_23_59._Sentinel.2_S2L2A._NDVI + images_2020$X2020.06.08_00_00_._2020.06.08_23_59._Sentinel.2_S2L2A._B02_.Raw.)

cl <- colorRampPalette(c('darkorchid3','light blue','lightpink4'))(100) 
par(mfrow=c(2,1))
plot(ndvi2018, col=cl)
plot(ndvi2020, col=cl)

# to see difference from one year to other
diff_dvi <- dvi2020 - dvi2018
cldiff<- colorRampPalette(c("peachpuff", "mistyrose1", "darkorchid4"))(100)
plot(diff_dvi, col=cldiff)



################fino a qui

######################################### RGB and NDVI analysis 

#import 2018 images
setwd("C:/lab/California/2018_June")
rlist_2018_June<- list.files(pattern="2018")
rlist_2018_June 
import_images_2018_June <- lapply(rlist_2018, raster)
images_2018_June <- stack(import_images_2018_June)
cl <- colorRampPalette(c('red','orange','yellow'))(100) 
plot(images_2018:June, col=cl) # to see all the bands 

#import 2020 images
setwd("C:/lab/EO_images2020")
rlist_2020 <- list.files(pattern="2020")
rlist_2020
import_images_202 <- lapply(rlist_2020, raster)
images_2020 <- stack(import_images_2020)
plot(images_2020, col=cl) #to see all the bands


# pot in RGB visible 321 both images: how the human eyes really see
par(mfrow=c(2,1))
plotRGB(images_2018, r=3, g=2, b=1, stretch="Lin", main = "2018", axes=TRUE )
plotRGB(images_2020, r=3, g=2, b=1, stretch="Lin", main = "2020", axes=TRUE) 

# plot in false colour RGB 432 both images -> NIR in top: vegetation being coloured in red
par(mfrow=c(2,1))
plotRGB(images_2018, r=4, g=3, b=2, stretch="Lin", main = "2018", axes=TRUE)
plotRGB(images_2020, r=4, g=3, b=2, stretch="Lin", main = "2020", axes=TRUE) 

# Mode2: multivariate analysis
par(mfrow=c(2,1))
plotRGB(images_2018, r=4, g=3, b=2, stretch="hist", main = "2018", axes=TRUE)
plotRGB(images_2020, r=4, g=3, b=2, stretch="hist", main = "2020", axes=TRUE) 

#DVI = NIR- red : Difference Vegetation Index ->Stressed plants have very low value of difference vegetation index 
dvi2018 <- images_2018$X2018.06.14_00_00_._2018.06.14_23_59._Sentinel.2_S2L2A._NDVI - images_2018$X2018.06.14_00_00_._2018.06.14_23_59._Sentinel.2_S2L2A._B02_.Raw.
dvi2020 <- images_2020$X2020.06.08_00_00_._2020.06.08_23_59._Sentinel.2_S2L2A._NDVI - images_2020$X2020.06.08_00_00_._2020.06.08_23_59._Sentinel.2_S2L2A._B02_.Raw.

#NDVI = DVI/NIR+red : Normalised Difference Vegetation Index
ndvi2018 <- dvi2018 / (images_2018$X2018.06.14_00_00_._2018.06.14_23_59._Sentinel.2_S2L2A._NDVI + images_2018$X2018.06.14_00_00_._2018.06.14_23_59._Sentinel.2_S2L2A._B02_.Raw.)
ndvi2020 <- dvi2020 / (images_2020$X2020.06.08_00_00_._2020.06.08_23_59._Sentinel.2_S2L2A._NDVI + images_2020$X2020.06.08_00_00_._2020.06.08_23_59._Sentinel.2_S2L2A._B02_.Raw.)

cl <- colorRampPalette(c('darkorchid3','light blue','lightpink4'))(100) 
par(mfrow=c(2,1))
plot(ndvi2018, col=cl)
plot(ndvi2020, col=cl)

# to see difference from one year to other
diff_dvi <- dvi2020 - dvi2018
cldiff<- colorRampPalette(c("peachpuff", "mistyrose1", "darkorchid4"))(100)
plot(diff_dvi, col=cldiff)


#import 2017-07-09 images
setwd("C:/lab/EO_images20170709")
rlist_2017<- list.files(pattern="2017")
rlist_2017
import_images_2017 <- lapply(rlist_2017, raster)
images_2017 <- stack(import_images_2017)


#import 2020-06-13 images
setwd("C:/lab/EO_images20200613")
rlist_2020<- list.files(pattern="2020")
rlist_2020
import_images_2020 <- lapply(rlist_2020, raster)
images_2020 <- stack(import_images_2020)

# Sentinel-2 bands
# b1 = Coastal Aerosol
# B2 = blue
# B3 = green
# B4 = red
# B5 = Vegetation Red Edge
# B6 = Vegetation Red Edge
# B7 = Vegetation Red Edge
# B8 = NIR
# B9 = Water Vapour
# B10 = SWIR-Cirrus
# B11 = SWIR
# B12 = SWIR

# pot in RGB visible 321 both images: how the human eyes really see  
#True color composite uses visible light bands red (B04), green (B03) and blue (B02) in the corresponding red, green and blue color channels, 
#resulting in a natural colored result, that is a good representation of the Earth as humans would see it naturally.
par(mfrow=c(2,1))
plotRGB(images_2017, r=4, g=3, b=2, stretch="Lin", main = "2017")
plotRGB(images_2020, r=4, g=3, b=2, stretch="Lin", main = "2020")

# plot in FALSE COLOR RGB 843 both images -> NIR in top: vegetation being coloured in red 
# False color imagery is displayed in a combination of standard near infra-red, red and green band. 
#False color composite using near infrared, red and green bands is very popular. It is most commonly used to assess plant density and healht, 
#as plants reflect near infrared and green light, while absorbing red. Since they reflect more near infrared than green, plant-covered land appears deep red. 
#Denser plant growth is darker red. Cities and exposed ground are gray or tan, and water appears blue or black.
par(mfrow=c(2,1))
plotRGB(images_2017, r=8, g=4, b=3, stretch="Lin", main = "2017")
plotRGB(images_2020, r=8, g=4, b=3, stretch="Lin", main = "2020")

#DVI = NIR- red : Difference Vegetation Index ->Stressed plants have very low value of difference vegetation index 
dvi2017 <- images_2017$X2017.07.09_00_00_._2017.07.09_23_59._Sentinel.2_S2L2A._B08_.Raw. - images_2017$X2017.07.09_00_00_._2017.07.09_23_59._Sentinel.2_S2L2A._B04_.Raw.
dvi2020 <- images_2020$X2020.07.13_00_00_._2020.07.13_23_59._Sentinel.2_S2L2A._B08_.Raw. - images_2020$X2020.07.13_00_00_._2020.07.13_23_59._Sentinel.2_S2L2A._B04_.Raw.

par(mfrow=c(2,1))
plot(dvi2017, main = "DVI 2017")
plot(dvi2020, main = "DVI 2020")


#NDVI = DVI/NIR+red : Normalised Difference Vegetation Index
ndvi2017 <- dvi2017 / (images_2017$X2017.07.09_00_00_._2017.07.09_23_59._Sentinel.2_S2L2A._B08_.Raw. + images_2017$X2017.07.09_00_00_._2017.07.09_23_59._Sentinel.2_S2L2A._B04_.Raw.)
ndvi2020 <- dvi2020 / (images_2020$X2020.07.13_00_00_._2020.07.13_23_59._Sentinel.2_S2L2A._B08_.Raw. + images_2020$X2020.07.13_00_00_._2020.07.13_23_59._Sentinel.2_S2L2A._B04_.Raw.)

cl <- colorRampPalette(c('darkorchid3','light blue','lightpink4'))(100) 
par(mfrow=c(2,1))
plot(ndvi2017, col=cl)
plot(ndvi2020, col=cl)

# to see difference from one year to other
diff_dvi <- dvi2020 - dvi2017
cldiff<- colorRampPalette(c("peachpuff", "mistyrose1", "darkorchid4"))(100)
plot(diff_dvi, col=cldiff)




# 1. temperature --> see if change through the time 
#                    scaricare ogni mese per 7 anni 
#                    media annuale -> plot per vedere l'andamento dal 2014 al 2020


# 2. vegetation cover --> Fraction of green Vegetation Cover
#                         The Fraction of Vegetation Cover (FCover) corresponds to the fraction of ground covered by green vegetation. 
#                         Practically, it quantifies the spatial extent of the vegetation. 
#                         Because it is independent from the illumination direction and it is sensitive to the vegetation amount, 
#                         FCover is a very good candidate for the replacement of classical vegetation indices for the monitoring of ecosystems.
#                    scaricare ogni mese per 4 anni   
#                    media annuale -> plot per vedere l'andamento dal 2017 al 2020
# 3. plot RGB e NIR 
# 4. vedo effetti di questi cambiamenti


######################################### data of LAND TEMPERATURE : import file efrom earthdata.nasa.gov     

setwd("C:/lab/Land_temperature")
landtemp_list<- list.files(pattern = "LST") #select all the file whose name contains "FCOVER"
landtemp_list #see the files name 
import_landtemp<- lapply(landtemp_list, raster) 
landtemp.multitemp<- stack(import_landtemp)

#zoom on the zone near San Francisco
extCal <- c(-124,-121, 37,39)
cl_temp <- colorRampPalette(c("blue", "lightblue", "yellow", "orange", "red"))(100)
zoom(landtemp.multitemp$Fraction.of.Valid.Observations.1 , ext=extCal, col=cl_temp)

#cut the previous image 
land_temp_201706<-crop(landtemp.multitemp$Fraction.of.Valid.Observations.1, extCal)

#convert single raster layer to matrix
land_temp_201706_matrix <- raster::as.matrix(land_temp_201706) 

plot.matrix(land_temp_201706_matrix)

saveDataset(land_temp_201706_matrix)
plot(land_temp_201706_matrix)
image(as.matrix(land_temp_201706))
land_temp_201706_matrix <- raster2matrix(land_temp_201706)
# see the difference between 2020 and 2000
difftemp <- 

  
  

######################################### data of VEGETATION COVER: import file from Copernicus 
# to quikly import all the data together use the the lapply function 
setwd("C:/lab/Vegetation_cover_Copernicus/")
vegcover_list<- list.files(pattern = "FCOVER") #select all the file whose name contains "FCOVER"
vegcover_list #see the files name 
import<- lapply(vegcover_list, raster) 
vegcover.multitemp<- stack(import)

#zoom on California
extCal <- c(-125,-105, 30,50)
zoom(vegcover.multitemp$Fraction.of.green.Vegetation.Cover.1km.1 , ext=extCal)
#cut the previous image 
veg_cover_201706<-crop(vegcover.multitemp$Fraction.of.green.Vegetation.Cover.1km.1, extCal)

#see the difference between june 2017 and june 2020
diff_veg_cover_2017_2020<- veg_cover_202006 - veg_cover_201706
cldiff<- colorRampPalette(c("blue", "black", "yellow"))(100)
plot(diff_veg_cover_2017_2020, col=cldiff)



