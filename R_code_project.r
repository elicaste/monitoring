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
# to open a NASA HDF file use get_subdatasets() 
sds <- get_subdatasets ("MOD11C3.A2017152.006.2017187193442.hdf")
#To retrieve data from dataset, use readGDAL().
d5 <- readGDAL(sds[6], options=c("RASTERXDIM=4","RASTERYDIM=3","RASTERBDIM=2","RASTER4DIM=1","RASTER5DIM=0"))


nc <- nc_open("MOD11C3.A2017152.006.2017187193442.hdf")
library(gdalUtils)
# Get a list of sds names
sds <- get_subdatasets("MOD11C3.hdf")

# Isolate the name of the first sds
name <- sds[1]
filename <- 'name/of/output/file.tif'
gdal_translate(sds[1], dst_dataset = filename)
# Load the Geotiff created into R
r <- raster(filename)


sds <- get_subdatasets("MOD11C3.A2017152.006.2017187193442.hdf")
# Isolate the name of the first sds
temp_jun20017 <- sds[1]
temp_jun20017 <- 'temp_jun20017.tif'
gdal_translate(sds[1], dst_dataset = temp_jun20017)
# Load the Geotiff created into R
temp_jun20017 <- raster(temp_jun20017)
plot(temp_jun20017)



#CONVERTIRE FILE HDF PER ESSERE LETTI 
# to quikly import all the data together use the the lapply function 
setwd("C:/lab/temp/")
watertemp_list<- list.files(pattern = "AQUA_MODIS.2009")
watertemp_list #see the files name 
import<- lapply(watertemp_list, raster) 
watertemp.multitemp<- stack(import)
cl <- colorRampPalette(c("blue","green","yellow", "orange","red"))(10000)
plot(watertemp.multitemp, col=cl)

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



# from the comparison between 2017 and 2020 it's possible to see that some zones are changed 
# download from Copernicus the burned area 


