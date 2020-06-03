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
#you made the calculation and you wat to send the output
writeRaster(prediction, "final.tif") #in the folder "snow" you have the file named "final.tif"
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
snow.multitemporal <- stack(import_prediction) #stack function: to create a multitemporal imaage 
plot(snow.multitemporal,col=cl) 
