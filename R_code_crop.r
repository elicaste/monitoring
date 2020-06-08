### R_code_crop.r

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
