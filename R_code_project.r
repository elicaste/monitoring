#R_code_project.r
setwd("C:/lab/")

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
#                    scaricare ogni mese per 7 anni   
#                    media annuale -> plot per vedere l'andamento dal 2014 al 2020
# 3. plot RGB 

# data of LAND TEMPERATURE : https://search.earthdata.nasa.gov/downloads/2296543603/collections/225898/links 
# BISOGNA ANCORA SCEGLIERE QUALI DATI 
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
watertemp_maine1<-crop(watertemp.multitemp$Sea.Surface.Temperature.1, ext)
watertemp_maine2<-crop(watertemp.multitemp$Sea.Surface.Temperature.2, ext)
watertemp_maine3<-crop(watertemp.multitemp$Sea.Surface.Temperature.3, ext)
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



