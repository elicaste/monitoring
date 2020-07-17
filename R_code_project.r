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

# data of LAND TEMPERATURE 
# to quikly import all the data together use the the lapply function 
setwd("C:/lab/temp/")
watertemp_list<- list.files(pattern = "AQUA_MODIS.2009")
watertemp_list #see the files name 
import<- lapply(watertemp_list, raster) 
watertemp.multitemp<- stack(import)
cl <- colorRampPalette(c("blue","green","yellow", "orange","red"))(10000)
plot(watertemp.multitemp, col=cl)



