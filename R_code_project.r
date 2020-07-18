#R_code_project.r
setwd("C:/lab/") #set the working director

install.packages("rasterdiv")
install.packages("rasterVis")
install.packages("ncdf4")
install.packages("rgdal")
install.packages("RStoolbox")
install.packages("gdalUtils")

library(raster) ## package for raster manipulation: imports a single layer, yet satellite images are made of more than one layer
library(rasterVis)
library(ncdf4) # package for netcdf manipulation
library(rgdal) # package for geospatial analysis
library(RStoolbox)
library(gdalUtils) #to convert hdf file 

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
#                                                                    https://search.earthdata.nasa.gov/downloads/2296543603/collections/225898/links  

setwd("C:/lab/Land_temperature")
# to open a hdf it needs the library(gdalUtils)
# cause there are lots of file, to import them I use a loop 
land_temp<- dir(pattern = ".hdf")
land_temp #visualise all the hdf files
land_temp_name <- substr(land_temp,1,37)
land_temp_name <- paste0("LandTemp", land_temp, ".tif")
land_temp_name # visualise the new files name 
i <- 1
for (i in 1:37){
  sds <- get_subdatasets(land_temp[i])
  gdal_translate(sds[1], dst_dataset = land_temp_name[i])
}


#zoom on California
ext <- c(-80,-50, 25,50)
zoom(watertemp.multitemp$Sea.Surface.Temperature.1 , ext=ext, col=cl)

#cut the previous image 
veg_cover1<-crop(watertemp.multitemp$Sea.Surface.Temperature.1, ext)
veg_cover2<-crop(watertemp.multitemp$Sea.Surface.Temperature.2, ext)
veg_cover3<-crop(watertemp.multitemp$Sea.Surface.Temperature.3, ext)
watertemp_maine4<-crop(watertemp.multitemp$Sea.Surface.Temperature.4, ext)
watertemp_maine5<-crop(watertemp.multitemp$Sea.Surface.Temperature.5, ext)
watertemp_maine6<-crop(watertemp.multitemp$Sea.Surface.Temperature.6, ext)
watertemp_maine7<-crop(watertemp.multitemp$Sea.Surface.Temperature.7, ext)
watertemp_maine8<-crop(watertemp.multitemp$Sea.Surface.Temperature.8, ext)
watertemp_maine9<-crop(watertemp.multitemp$Sea.Surface.Temperature.9, ext)
watertemp_maine10<-crop(watertemp.multitemp$Sea.Surface.Temperature.10, ext)
watertemp_maine11<-crop(watertemp.multitemp$Sea.Surface.Temperature.11, ext)
watertemp_maine12<-crop(watertemp.multitemp$Sea.Surface.Temperature.12, ext)

#plot all the 2002 water temperature in the Gulf of Maine
par(mfrow=c(3,4))
plot(watertemp_maine1, col=cl)
plot(watertemp_maine2, col=cl)
plot(watertemp_maine3, col=cl)
plot(watertemp_maine4, col=cl)
plot(watertemp_maine5, col=cl)
plot(watertemp_maine6, col=cl)
plot(watertemp_maine7, col=cl)
plot(watertemp_maine8, col=cl)
plot(watertemp_maine9, col=cl)
plot(watertemp_maine10, col=cl)
plot(watertemp_maine11, col=cl)
plot(watertemp_maine12, col=cl)

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
setwd("C:/lab/ES_images2018")
rlist_2018<- list.files(pattern="2018")
rlist_2018
import_images_2018 <- lapply(rlist_2018, raster)
images_2018 <- stack(import_images_2018)
cl <- colorRampPalette(c('red','orange','yellow'))(100) 
plot(images_2018, col=cl)

#import 2020 images
setwd("C:/lab/ES_images2020")
rlist_2020 <- list.files(pattern="2020")
rlist_2020
import_images_202 <- lapply(rlist_2020, raster)
images_2020 <- stack(import_images_2020)
plot(images_2020, col=cl)

# RGB : B2 = blue, B3 = green, B4 = red, B8 = NIR, B11 = SWIR
# pot in RGB visible 321 both images
par(mfrow=c(2,1))
plotRGB(images_2018, r=3, g=2, b=1, stretch="Lin")
plotRGB(images_2020, r=3, g=2, b=1, stretch="Lin") 

# plot in false colour RGB 432 both images
par(mfrow=c(2,1))
plotRGB(images_2018, r=4, g=3, b=2, stretch="Lin")
plotRGB(images_2020, r=4, g=3, b=2, stretch="Lin") 

# Mode2: multivariate analysis
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist") 



# Let's change the grain (dimension of pixel) of our images  # res: resempling
p224r63_2011res <- aggregate(p224r63_2011, fact=10)   
p224r63_2011res100 <- aggregate(p224r63_2011, fact=100)
# fact: amount of time we want to increase our images (10 time the image)
     
par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011res100, r=4, g=3, b=2, stretch="Lin")

# from the comparison between 2017 and 2020 it's possible to see that some zones are changed 
# download from Copernicus the burned area 


