#R_code_project.r
setwd("C:/lab/incendi") #set the working director

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
install.packages("RasterLayer")
install.packages ("devtools") # Strumenti di pacchetto per rendere più facile lo sviluppo di pacchetti R

# load the packages in the library 
library(raster)
library(rasterdiv)
library(rasterVis)
library(ncdf4) 
library(rgdal)
library(RStoolbox)
library(gdalUtils) #to convert hdf file 
library(plot.matrix)
library(RasterLayer)
library(devtools)

install.packages ("maptools") # Pacchetto di strumenti per leggere e gestire oggetti spaziali
install.packages ("rgeos") # Interfaccia per Geometry Engine - Open Source (GEOS)
install.packages ("RCurl") # Fornisce funzioni per consentire di comporre richieste HTTP generali e di recuperare gli URI


prefire2020<- "LC80010852017008LGN00" 	
postfire2020<- "LC80010852017056LGN00" 
prefire2013<- "LC80010852017008LGN00" 	
postfire2013<- "LC80010852017056LGN00"

lspre2013<- ReadLandsat8(prefire2013) #read images 2013 pre-fire
lspost2013<- ReadLandsat8(postfire2013) #read  images 2013 post-fire
lspre2020<- ReadLandsat8(prefire2020) #read  images 2020 pre-fire
lspost2020<- ReadLandsat8(postfire2020) #read  images 2020 post-fire


______________________________________________________________________________________________________________

install.packages("rasterdiv")
install.packages("rasterVis")
install.packages("ncdf4")
install.packages("rgdal")
install.packages("RStoolbox")
install.packages("gdalUtils")
install.packages("RasterLayer")
install.packages("plot.matrix")
library(raster) ## package for raster manipulation: imports a single layer, yet satellite images are made of more than one layer
library(rasterVis)
library(ncdf4) # package for netcdf manipulation
library(rgdal) # package for geospatial analysis
library(RStoolbox)
library(gdalUtils) #to convert hdf file 
library(plot.matrix)

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
land_temp_201707<-crop(landtemp.multitemp$Fraction.of.Valid.Observations.2, extCal)
land_temp_201708<-crop(landtemp.multitemp$Fraction.of.Valid.Observations.3, extCal)
land_temp_201709<-crop(landtemp.multitemp$Fraction.of.Valid.Observations.4, extCal)
land_temp_201710<-crop(landtemp.multitemp$Fraction.of.Valid.Observations.5, extCal)
land_temp_201711<-crop(landtemp.multitemp$Fraction.of.Valid.Observations.6, extCal)
land_temp_201712<-crop(landtemp.multitemp$Fraction.of.Valid.Observations.7, extCal)
land_temp_201801<-crop(landtemp.multitemp$Fraction.of.Valid.Observations.8, extCal)
land_temp_201802<-crop(landtemp.multitemp$Fraction.of.Valid.Observations.9, extCal)
land_temp_201803<-crop(landtemp.multitemp$Fraction.of.Valid.Observations.10, extCal)
land_temp_201804<-crop(landtemp.multitemp$Fraction.of.Valid.Observations.11, extCal)
land_temp_201805<-crop(landtemp.multitemp$Fraction.of.Valid.Observations.12, extCal)
land_temp_201806<-crop(landtemp.multitemp$Fraction.of.Valid.Observations.13, extCal)
land_temp_201807<-crop(landtemp.multitemp$Fraction.of.Valid.Observations.14, extCal)
land_temp_201808<-crop(landtemp.multitemp$Fraction.of.Valid.Observations.14, extCal)
land_temp_201809<-crop(landtemp.multitemp$Fraction.of.Valid.Observations.16, extCal)
land_temp_201810<-crop(landtemp.multitemp$Fraction.of.Valid.Observations.17, extCal)
land_temp_201811<-crop(landtemp.multitemp$Fraction.of.Valid.Observations.18, extCal)
land_temp_201812<-crop(landtemp.multitemp$Fraction.of.Valid.Observations.19, extCal)
land_temp_201901<-crop(landtemp.multitemp$Fraction.of.Valid.Observations.20, extCal)
land_temp_201902<-crop(landtemp.multitemp$Fraction.of.Valid.Observations.21, extCal)
land_temp_201903<-crop(landtemp.multitemp$Fraction.of.Valid.Observations.22, extCal)
land_temp_201904<-crop(landtemp.multitemp$Fraction.of.Valid.Observations.23, extCal)
land_temp_201905<-crop(landtemp.multitemp$Fraction.of.Valid.Observations.24, extCal)
land_temp_201906<-crop(landtemp.multitemp$Fraction.of.Valid.Observations.25, extCal)
land_temp_201907<-crop(landtemp.multitemp$Fraction.of.Valid.Observations.26, extCal)
land_temp_201908<-crop(landtemp.multitemp$Fraction.of.Valid.Observations.27, extCal)
land_temp_201909<-crop(landtemp.multitemp$Fraction.of.Valid.Observations.28, extCal)
land_temp_201910<-crop(landtemp.multitemp$Fraction.of.Valid.Observations.29, extCal)
land_temp_201911<-crop(landtemp.multitemp$Fraction.of.Valid.Observations.30, extCal)
land_temp_201912<-crop(landtemp.multitemp$Fraction.of.Valid.Observations.31, extCal)
land_temp_202001<-crop(landtemp.multitemp$Fraction.of.Valid.Observations.32, extCal)
land_temp_202002<-crop(landtemp.multitemp$Fraction.of.Valid.Observations.33, extCal)
land_temp_202003<-crop(landtemp.multitemp$Fraction.of.Valid.Observations.34, extCal)
land_temp_202004<-crop(landtemp.multitemp$Fraction.of.Valid.Observations.35, extCal)
land_temp_202005<-crop(landtemp.multitemp$Fraction.of.Valid.Observations.36, extCal)
land_temp_202006<-crop(landtemp.multitemp$Fraction.of.Valid.Observations.37, extCal)

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
veg_cover_201707<-crop(vegcover.multitemp$Fraction.of.green.Vegetation.Cover.1km.2, extCal)
veg_cover_201708<-crop(vegcover.multitemp$Fraction.of.green.Vegetation.Cover.1km.3, extCal)
veg_cover_201709<-crop(vegcover.multitemp$Fraction.of.green.Vegetation.Cover.1km.4, extCal)
veg_cover_201710<-crop(vegcover.multitemp$Fraction.of.green.Vegetation.Cover.1km.5, extCal)
veg_cover_201711<-crop(vegcover.multitemp$Fraction.of.green.Vegetation.Cover.1km.6, extCal)
veg_cover_201712<-crop(vegcover.multitemp$Fraction.of.green.Vegetation.Cover.1km.7, extCal)
veg_cover_201801<-crop(vegcover.multitemp$Fraction.of.green.Vegetation.Cover.1km.8, extCal)
veg_cover_201802<-crop(vegcover.multitemp$Fraction.of.green.Vegetation.Cover.1km.9, extCal)
veg_cover_201803<-crop(vegcover.multitemp$Fraction.of.green.Vegetation.Cover.1km.10, extCal)
veg_cover_201804<-crop(vegcover.multitemp$Fraction.of.green.Vegetation.Cover.1km.11, extCal)
veg_cover_201805<-crop(vegcover.multitemp$Fraction.of.green.Vegetation.Cover.1km.12, extCal)
veg_cover_201806<-crop(vegcover.multitemp$Fraction.of.green.Vegetation.Cover.1km.13, extCal)
veg_cover_201807<-crop(vegcover.multitemp$Fraction.of.green.Vegetation.Cover.1km.14, extCal)
veg_cover_201808<-crop(vegcover.multitemp$Fraction.of.green.Vegetation.Cover.1km.14, extCal)
veg_cover_201809<-crop(vegcover.multitemp$Fraction.of.green.Vegetation.Cover.1km.16, extCal)
veg_cover_201810<-crop(vegcover.multitemp$Fraction.of.green.Vegetation.Cover.1km.17, extCal)
veg_cover_201811<-crop(vegcover.multitemp$Fraction.of.green.Vegetation.Cover.1km.18, extCal)
veg_cover_201812<-crop(vegcover.multitemp$Fraction.of.green.Vegetation.Cover.1km.19, extCal)
veg_cover_201901<-crop(vegcover.multitemp$Fraction.of.green.Vegetation.Cover.1km.20, extCal)
veg_cover_201902<-crop(vegcover.multitemp$Fraction.of.green.Vegetation.Cover.1km.21, extCal)
veg_cover_201903<-crop(vegcover.multitemp$Fraction.of.green.Vegetation.Cover.1km.22, extCal)
veg_cover_201904<-crop(vegcover.multitemp$Fraction.of.green.Vegetation.Cover.1km.23, extCal)
veg_cover_201905<-crop(vegcover.multitemp$Fraction.of.green.Vegetation.Cover.1km.24, extCal)
veg_cover_201906<-crop(vegcover.multitemp$Fraction.of.green.Vegetation.Cover.1km.25, extCal)
veg_cover_201907<-crop(vegcover.multitemp$Fraction.of.green.Vegetation.Cover.1km.26, extCal)
veg_cover_201908<-crop(vegcover.multitemp$Fraction.of.green.Vegetation.Cover.1km.27, extCal)
veg_cover_201909<-crop(vegcover.multitemp$Fraction.of.green.Vegetation.Cover.1km.28, extCal)
veg_cover_201910<-crop(vegcover.multitemp$Fraction.of.green.Vegetation.Cover.1km.29, extCal)
veg_cover_201911<-crop(vegcover.multitemp$Fraction.of.green.Vegetation.Cover.1km.30, extCal)
veg_cover_201912<-crop(vegcover.multitemp$Fraction.of.green.Vegetation.Cover.1km.31, extCal)
veg_cover_202001<-crop(vegcover.multitemp$Fraction.of.green.Vegetation.Cover.1km.32, extCal)
veg_cover_202002<-crop(vegcover.multitemp$Fraction.of.green.Vegetation.Cover.1km.33, extCal)
veg_cover_202003<-crop(vegcover.multitemp$Fraction.of.green.Vegetation.Cover.1km.34, extCal)
veg_cover_202004<-crop(vegcover.multitemp$Fraction.of.green.Vegetation.Cover.1km.35, extCal)
veg_cover_202005<-crop(vegcover.multitemp$Fraction.of.green.Vegetation.Cover.1km.36, extCal)
veg_cover_202006<-crop(vegcover.multitemp$Fraction.of.green.Vegetation.Cover.1km.37, extCal)

#see the difference between june 2017 and june 2020
diff_veg_cover_2017_2020<- veg_cover_202006 - veg_cover_201706
cldiff<- colorRampPalette(c("blue", "black", "yellow"))(100)
plot(diff_veg_cover_2017_2020, col=cldiff)

######################################### RGB and NDVI analysis 

#import 2018 images
setwd("C:/lab/EO_images2018")
rlist_2018<- list.files(pattern="2018")
rlist_2018
import_images_2018 <- lapply(rlist_2018, raster)
images_2018 <- stack(import_images_2018)
cl <- colorRampPalette(c('red','orange','yellow'))(100) 
plot(images_2018, col=cl) # to see all the bands 

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

