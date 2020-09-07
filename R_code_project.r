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
install.packages("RasterLayer")

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
library(rgeos)
library(RColorBrewer)

######################################### RGB and NDVI analysis 
#create a list of raster layers to use (for 2018- June and August, and for 2020- June and August)

#import 2018_June images
setwd("C:/lab/California/2018_June_14")
rlist_2018_June<- list.files(pattern="2018")
rlist_2018_June 
import_images_2018_June <- lapply(rlist_2018_June, raster)
images_2018_June <- stack(import_images_2018_June)
images_2018_June_br <- brick(images_2018_June)

#import 2018_August images
setwd("C:/lab/California/2018_August_28")
rlist_2018_August<- list.files(pattern="2018")
rlist_2018_August 
import_images_2018_August <- lapply(rlist_2018_August, raster)
images_2018_August <- stack(import_images_2018_August)
images_2018_August_br <- brick(images_2018_August)

#import 2020_June images
setwd("C:/lab/California/2020_June_08")
rlist_2020_June<- list.files(pattern="2020")
rlist_2020_June 
import_images_2020_June <- lapply(rlist_2020_June, raster)
images_2020_June <- stack(import_images_2020_June)
images_2020_June_br <- brick(images_2020_June) # convert data into rasterbrick for faster processing

#import 2020_August images
setwd("C:/lab/California/2020_August_26")
rlist_2020_August<- list.files(pattern="2020")
rlist_2020_August 
import_images_2020_August <- lapply(rlist_2020_August, raster)
images_2020_August <- stack(import_images_2020_August)
images_2020_August_br <- brick(images_2020_August)

# plot in RGB visible 2018 images
par(mfrow=c(2,1))
plotRGB(images_2018_June, r=4, g=3, b=2, stretch="Lin", 
        main = "June 2018", 
        axes = TRUE)
plotRGB(images_2018_August, r=4, g=3, b=2, stretch="Lin", 
        main = "August 2018", 
        axes = TRUE) 

# plot in RGB visible 2020 images
par(mfrow=c(2,1))
plotRGB(images_2020_June, r=4, g=3, b=2, stretch="Lin", 
        main = "June 2020", 
        axes = TRUE)
plotRGB(images_2020_August, r=4, g=3, b=2, stretch="Lin", 
        main = "August 2020", 
        axes = TRUE) 

#plot all the images together
par(mfrow=c(2,2))
plotRGB(images_2018_June, r=4, g=3, b=2, stretch="Lin", 
        main = "June 2018", 
        axes = TRUE)
plotRGB(images_2018_August, r=4, g=3, b=2, stretch="Lin", 
        main = "August 2018", 
        axes = TRUE) 
plotRGB(images_2020_June, r=4, g=3, b=2, stretch="Lin", 
        main = "June 2020", 
        axes = TRUE)
plotRGB(images_2020_August, r=4, g=3, b=2, stretch="Lin", 
        main = "August 2020", 
        axes = TRUE) 
#?????????????????
# Remove water based colours
bind_2018_August <- reclassify(images_2018_August, cbind(253:255, NA))


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

# calculate NDVI using the red (band 1) and nir (band 4) bands
NDVI_2018_June <- (images_2018_June_br[[8]] - images_2018_June_br[[4]]) / (images_2018_June_br[[8]] + images_2018_June_br[[4]])
NDVI_2018_August <- (images_2018_August_br[[8]] - images_2018_August_br[[4]]) / (images_2018_August_br[[8]] + images_2018_August_br[[4]])
NDVI_2020_June <- (images_2020_June_br[[8]] - images_2020_June_br[[4]]) / (images_2020_June_br[[8]] + images_2020_June_br[[4]])
NDVI_2020_August <- (images_2020_August_br[[8]] - images_2020_August_br[[4]]) / (images_2020_August_br[[8]] + images_2020_August_br[[4]])

# plot the data
par(mfrow=c(2,2), 
    mar = c(1, 1, 1, 1),
    main = "NDVI" ,) #mar: plot with small margins
plot(NDVI_2018_June, main = "NDVI  - June 2018", axes = FALSE, box = FALSE )
plot(NDVI_2018_August, main = "NDVI  - August 2018",axes = FALSE, box = FALSE)
plot(NDVI_2020_June, main = "NDVI  - June 2020",axes = FALSE, box = FALSE)
plot(NDVI_2020_August, main = "NDVI  - August 2020",axes = FALSE, box = FALSE)



#DVI = NIR- red : Difference Vegetation Index ->Stressed plants have very low value of difference vegetation index 
DVI_2018_June <- (images_2018_June_br[[8]] - images_2018_June_br[[4]])
DVI_2018_August <- (images_2018_August_br[[8]] - images_2018_August_br[[4]])
DVI_2020_June <- (images_2020_June_br[[8]] - images_2020_June_br[[4]])
DVI_2020_August <- (images_2020_August_br[[8]] - images_2020_August_br[[4]])

#see the difference between before and after the summer period - 2018
diff_DVI_2018 <- DVI_2018_August - DVI_2018_June
cldiff<- colorRampPalette(c("lightblue", "lightyellow", "red"))(100)
plot(diff_DVI_2018, col=cldiff,
     main = "Difference in vegetation index 2018 \n August and June" ,
     axes = FALSE, box = FALSE)
# xlim = c(400, 1000), ylim = c(0,600)

#see the difference between before and after the summer period - 2020
diff_DVI_2020 <- DVI_2020_August - DVI_2020_June
plot(diff_DVI_2020, col=cldiff,
     main = "Difference in vegetation index 2020 \n August and June" ,
    box = FALSE)
# axes = FALSE, xlim = c(400, 1000), ylim = c(0,600)

#see the difference between 2018 and 2020
diff_DVI_2018_2020 <- DVI_2020_August - DVI_2018_August
plot(diff_DVI_2018_2020, col=cldiff,  
     main = "Difference in vegetation index \n August 2020 and 2018" ,
     xlim = c(400, 1000), ylim = c(0,600),
     box = FALSE)


# Zoom 

# I don't need a resample because the bands have the same resolution
May2020 <- stack(import)
ext <- c(662000, 680000, 4710000, 4730000) # set the coordinates of the Park
Parcomay <- crop(May2020, ext) # create a new image of the zoomed area


# Quantitative estimation
# plot!
plot(ndvi_park_june, ndvi_park_july)
abline(0,1, col="red") # y=a+bx
################fino a qui









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



