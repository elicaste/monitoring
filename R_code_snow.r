### R_code_snow.r

#set the working directory
setwd("C:/lab/") 

install.packages("ncdf4") #to read the netCDF files 
library(ncdf4)
library(raster)

#image downloaded by Copernicus dataset
snowmay <- raster("c_gls_SCE_202005260000_NHEMI_VIIRS_V1.0.1.nc") #it can appear a warning message: cannot process these parts of the CRS. No problem, we are using only a part of the extent 

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

#to plot all the data together we usa the par function
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

snow.multitemp <- stack(import) #stack function: to create a multitemporal imaage 
plot(snow.multitemp,col=cl) # we have all the plot together without using the par function 

################ to make a PREDICTION 

source("prediction.r") #we use the script in R 

  

par(mfrow=c(1,2))
plot(snow.multitemp$snow2000r, col=cl)
plot(snow.multitemp$snow2020r, col=cl)

par(mfrow=c(1,2))
plot(snow.multitemp$snow2000r, col=cl, zlim=c(0,250))
plot(snow.multitemp$snow2020r, col=cl, zlim=c(0,250))

difsnow = snow.multitemp$snow2020r - snow.multitemp$snow2000r
cldiff <- colorRampPalette(c('blue','white','red'))(100) 
plot(difsnow, col=cldiff)

# prediction
# go to IOL and downloand prediction.r into the folder snow
# source("prediction.r")
# plot(predicted.snow.2025.norm, col=cl)
# since the code needs time, you can ddownload predicted.snow.2025.norm.tif from iol in the Data

predicted.snow.2025.norm <- raster("predicted.snow.2025.norm.tif")
plot(predicted.snow.2025.norm, col=cl)
