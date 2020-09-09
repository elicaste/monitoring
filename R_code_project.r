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
install.packages("RasterLayer")
install.packages("ggplot2")# to plot better images 
install.packages("gridExtra") # to plot together different images

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
library(ggplot2)
library(gridExtra)

######################################### RGB and NDVI analysis 
#create a list of raster layers to use (for 2018- June and September, and for 2020- June and September)

#import 2018_June images
setwd("C:/lab/California/2018_June_14")
rlist_2018_June<- list.files(pattern="2018")
rlist_2018_June 
import_images_2018_June <- lapply(rlist_2018_June, raster)
images_2018_June <- stack(import_images_2018_June)
    #crop the images 
    ext <- c(800, 1700, 0, 1000)
    #zoom function
    zoom(images_2018_June, ext=ext)
images_2018_June_crop <- crop(images_2018_June, ext)

#import 2018_September images
setwd("C:/lab/California/2018_September_17")
rlist_2018_September<- list.files(pattern="2018")
rlist_2018_September 
import_images_2018_September <- lapply(rlist_2018_September, raster)
images_2018_September <- stack(import_images_2018_September)
images_2018_September_crop <- crop(images_2018_September, ext)

#import 2020_June images
setwd("C:/lab/California/2020_June_08")
rlist_2020_June<- list.files(pattern="2020")
rlist_2020_June 
import_images_2020_June <- lapply(rlist_2020_June, raster)
images_2020_June <- stack(import_images_2020_June)
images_2020_June_crop <- crop(images_2020_June, ext)

#import 2020_September images
setwd("C:/lab/California/2020_September_1")
rlist_2020_September<- list.files(pattern="2020")
rlist_2020_September 
import_images_2020_September <- lapply(rlist_2020_September, raster)
images_2020_September <- stack(import_images_2020_September)
images_2020_September_crop <- crop(images_2020_September, ext)

# plot in RGB visible 2018 images
visible_June_2018<- ggRGB(images_2018_June_crop, r=4, g=3, b=2,stretch = "Lin") 
visible_June_2018_print<- print(visible_June_2018 + ggtitle("Visible June 2018")+ theme (axis.title.x = element_blank(),axis.title.y = element_blank()))
visible_September_2018<- ggRGB(images_2018_September_crop, r=4, g=3, b=2,stretch = "Lin")
visible_September_2018_print<- print(visible_September_2018 + ggtitle("Visible September 2018")+ theme (axis.title.x = element_blank(),axis.title.y = element_blank()))

  #plot June and September 2018 together
grid.arrange(visible_June_2018_print, visible_September_2018_print,  nrow = 1)

# plot in RGB visible 2020 images
visible_June_2020<- ggRGB(images_2020_June_crop, r=4, g=3, b=2,stretch = "Lin") 
visible_June_2020_print<- print(visible_June_2020 + ggtitle("Visible June 2020")+ theme (axis.title.x = element_blank(),axis.title.y = element_blank()))
visible_September_2020<- ggRGB(images_2020_September_crop, r=4, g=3, b=2,stretch = "Lin")
visible_September_2020_print<- print(visible_September_2020 + ggtitle("Visible September 2020")+ theme (axis.title.x = element_blank(),axis.title.y = element_blank()))

  #plot June and September 2020 together
grid.arrange(visible_June_2020_print, visible_September_2020_print,  nrow = 1)

  #plot all the images - 2018 and 2020 - together
grid.arrange(visible_June_2018_print, visible_September_2018_print, visible_June_2020_print, visible_September_2020_print,  ncol= 2, nrow = 2)

#RGB (8,4,3)
#False color imagery is displayed in a combination of standard near infra-red, red and green band.
#It is most commonly used to assess plant density and healht, as plants reflect near infrared and green light, while absorbing red. 
#Since they reflect more near infrared than green, plant-covered land appears deep red. 
#Denser plant growth is darker red. Cities and exposed ground are gray or tan, and water appears blue or black.

# plot in false color 2018 images
false_June_2018<- ggRGB(images_2018_June_crop, r=8, g=4, b=3,stretch = "Lin") 
false_June_2018_print<- print(false_June_2018 + ggtitle("False color June 2018")+ theme (axis.title.x = element_blank(),axis.title.y = element_blank()))
false_September_2018<- ggRGB(images_2018_September_crop, r=8, g=4, b=3,stretch = "Lin")
false_September_2018_print<- print(false_September_2018 + ggtitle("False color September 2018")+ theme (axis.title.x = element_blank(),axis.title.y = element_blank()))

grid.arrange(false_June_2018_print, false_September_2018_print,  nrow = 1)

# plot in false color 2020 images
false_June_2020<- ggRGB(images_2020_June_crop, r=8, g=4, b=3,stretch = "Lin") 
false_June_2020_print<- print(false_June_2020 + ggtitle("False color June 2020")+ theme (axis.title.x = element_blank(),axis.title.y = element_blank()))
false_September_2020<- ggRGB(images_2020_September_crop, r=8, g=4, b=3,stretch = "Lin")
false_September_2020_print<- print(false_September_2020 + ggtitle("False color September 2020")+ theme (axis.title.x = element_blank(),axis.title.y = element_blank()))

grid.arrange(false_June_2020_print, false_September_2020_print,  nrow = 1)

# NDVI anlysis
#The normalized difference vegetation index (NDVI) uses a ratio between near infrared and red light within the electromagnetic spectrum. 
#To calculate NDVI, you use the following formula where NIR is near infrared light and red represents red light. 
#NDVI= (NIR - Red) / (NIR + Red)
#For your raster data, you will take the reflectance value in the red and near infrared bands to calculate the index.

# calculate NDVI using the red and nir bands

NDVI_2018_June <- (images_2018_June_crop[[8]] - images_2018_June_crop[[4]]) / (images_2018_June_crop[[8]] + images_2018_June_crop[[4]])
NDVI_2018_September <- (images_2018_September_crop[[8]] - images_2018_September_crop[[4]]) / (images_2018_September_crop[[8]] + images_2018_September_crop[[4]])
NDVI_2020_June <- (images_2020_June_crop[[8]] - images_2020_June_crop[[4]]) / (images_2020_June_crop[[8]] + images_2020_June_crop[[4]])
NDVI_2020_September <- (images_2020_September_crop[[8]] - images_2020_September_crop[[4]]) / (images_2020_September_crop[[8]] + images_2020_September_crop[[4]])

# plot the NDVI data
par(mfrow=c(2,2), 
    mar = c(1, 1, 1, 1)) #mar: plot with small margins
  plot(NDVI_2018_June, main = "NDVI  - June 2018", axes = FALSE, box = FALSE )
  plot(NDVI_2018_September, main = "NDVI  - September 2018",axes = FALSE, box = FALSE)
  plot(NDVI_2020_June, main = "NDVI  - June 2020",axes = FALSE, box = FALSE)
  plot(NDVI_2020_September, main = "NDVI  - September 2020",axes = FALSE, box = FALSE)


#see the difference between June and September - 2018
diff_NDVI_2018 <- NDVI_2018_September - NDVI_2018_June
  # color-palette for immages of comparison difference
  cldiff<- colorRampPalette(c("black", "yellow"))(100)
plot(diff_NDVI_2018, col=cldiff,
     main = "Difference in normalized vegetation index 2018 \n September and June" ,
     box = FALSE)

#see the difference between June and September - 2020
diff_NDVI_2020 <- NDVI_2020_September - NDVI_2020_June
plot(diff_NDVI_2020, col=cldiff,
     main = "Difference in normalized vegetation index 2020 \n September and June" ,
     box = FALSE)

#see the difference between 2018 (June) and 2020 (September)
diff_NDVI_2018_2020 <- NDVI_2020_September - NDVI_2018_June
plot(diff_NDVI_2018_2020, col=cldiff,  
     main = "Difference in normalized vegetation index \n 2020 - 2018" ,
     box = FALSE)

#DVI = NIR- red : Difference Vegetation Index ->Stressed plants have very low value of difference vegetation index 
DVI_2018_June <- (images_2018_June_crop[[8]] - images_2018_June_crop[[4]])
DVI_2018_September <- (images_2018_September_crop[[8]] - images_2018_September_crop[[4]])
DVI_2020_June <- (images_2020_June_crop[[8]] - images_2020_June_crop[[4]])
DVI_2020_September <- (images_2020_September_crop[[8]] - images_2020_September_crop[[4]])

#see the difference between June and September - 2018
diff_DVI_2018 <- DVI_2018_September - DVI_2018_June
cldiff<- colorRampPalette(c("lightblue", "lightyellow", "red"))(100)
plot(diff_DVI_2018, col=cldiff,
     main = "Difference in vegetation index 2018 \n September - June" ,
     box = FALSE)

#see the difference between June and September - 2020
diff_DVI_2020 <- DVI_2020_September - DVI_2020_June
plot(diff_DVI_2020, col=cldiff,
     main = "Difference in vegetation index 2020 \n September - June" ,
     box = FALSE)

#see the difference between 2018 (June) and 2020 (September)
diff_DVI_2018_2020 <- DVI_2020_September - DVI_2018_June
plot(diff_DVI_2018_2020, col=cldiff,  
     main = "Difference in vegetation index \n  2020 - 2018" ,
     box = FALSE)


# NBR= normalized burned ratio 
# 2018
NBR_June_2018 <-  (images_2018_June_crop[[8]] - images_2018_June_crop[[12]])/ (images_2018_June_crop[[8]] + images_2018_June_crop[[12]])
NBR_September_2018 <-  (images_2018_September_crop[[8]] - images_2018_September_crop[[12]])/ (images_2018_September_crop[[8]] + images_2018_September_crop[[12]])
diff_NBR_2018 <- NBR_September_2018 - NBR_June_2018
plot(diff_NBR_2018, col=cldiff, 
     main = "Difference in NBR\n  June - September 2018" ,
     box = FALSE)

#2020
NBR_June_2020 <-  (images_2020_June_crop[[8]] - images_2020_June_crop[[12]])/ (images_2020_June_crop[[8]] + images_2020_June_crop[[12]])
NBR_September_2020 <-  (images_2020_September_crop[[8]] - images_2020_September_crop[[12]])/ (images_2020_September_crop[[8]] + images_2020_September_crop[[12]])
diff_NBR_2020 <- NBR_September_2020 - NBR_June_2020
plot(diff_NBR_2020, col=cldiff,
     main = "Difference in NBR\n  June - September 2020" ,
     box = FALSE)

#2018-2020
diff_NBR_2018_2020 <- NBR_September_2020 - NBR_June_2018
plot(diff_NBR_2018_2020, col=cldiff,
     main = "Difference in NBR\n  2018 - 2020" ,
     box = FALSE)

# Classify the Burn Severity map
# colour obtain the burn severity map, it is necessary to classify difference_NBR. §
# The classification should be conducted in accordance with the USGS burn severity standards.

# scales the dNBR map by 10^3
diff_NBR_2018_scaled <- 1000*diff_NBR_2018
# sets the ranges that will be used to classify dNBR information about the ranges used, please see the NBR section on the recommended practice
NBR_ranges <- c(-Inf, -500, -1, -500, -251, 1, -251, -101, 2, -101, 99, 3, 99, 269, 4, 269, 439, 5, 439, 659, 6, 659, 1300, 7, 1300, +Inf, -1) 
# sets a classification matrix
class.matrix <- matrix(NBR_ranges, ncol = 3, byrow = TRUE)
# classification matrix is used to classify diff_NBR_2018_scaled
diff_NBR_2018_reclass <- reclassify(diff_NBR_2018_scaled, class.matrix, right=NA)
# Building the legend
# Now that the burn severity map has been generated, the legend for the burn severity classes also needs to be created. 
# builds the attribute table for the legend 
diff_NBR_2018_reclass <- ratify(diff_NBR_2018_reclass) 
rat <- levels(diff_NBR_2018_reclass)[[1]]
# creates the text that will be on the legend
rat$legend  <- c("NA", "Enhanced Regrowth, High", "Enhanced Regrowth, Low", "Unburned", "Low Severity", "Moderate-low Severity", "Moderate-high Severity", "High Severity") 
levels(diff_NBR_2018_reclass) <- rat 
# change the default colors : setting the colors for the severity map
my_col=c("white", "darkolivegreen","darkolivegreen4","limegreen", "yellow2", "orange2", "red", "purple")
# plots the burn severity map 
plot(diff_NBR_2018_reclass,col=my_col,legend=F,box=F,axes=F, main="Burn Severity 2018") 
# plots the legend on the right side of the burn severity map
legend(x='right', legend =rat$legend, fill = my_col, y='right') 




######### 2020
# scales the dNBR map by 10^3
diff_NBR_2020_scaled <- 1000*diff_NBR_2020
# sets the ranges that will be used to classify dNBR information about the ranges used, please see the NBR section on the recommended practice
NBR_ranges <- c(-Inf, -500, -1, -500, -251, 1, -251, -101, 2, -101, 99, 3, 99, 269, 4, 269, 439, 5, 439, 659, 6, 659, 1300, 7, 1300, +Inf, -1) 
# sets a classification matrix
class.matrix <- matrix(NBR_ranges, ncol = 3, byrow = TRUE)
# classification matrix is used to classify diff_NBR_2020_scaled
diff_NBR_2020_reclass <- reclassify(diff_NBR_2020_scaled, class.matrix, right=NA)
# Building the legend
# Now that the burn severity map has been generated, the legend for the burn severity classes also needs to be created. 
# builds the attribute table for the legend 
diff_NBR_2020_reclass <- ratify(diff_NBR_2020_reclass) 
rat <- levels(diff_NBR_2020_reclass)[[1]]
# creates the text that will be on the legend
rat$legend  <- c("NA", "Enhanced Regrowth, High", "Enhanced Regrowth, Low", "Unburned", "Low Severity", "Moderate-low Severity", "Moderate-high Severity", "High Severity") 
levels(diff_NBR_2020_reclass) <- rat 
# change the default colors : setting the colors for the severity map
my_col=c("white", "darkolivegreen","darkolivegreen4","limegreen", "yellow2", "orange2", "red", "purple")
# plots the burn severity map 
plot(diff_NBR_2020_reclass,col=my_col,legend=F,box=F,axes=F, main="Burn Severity 2020") 
# plots the legend on the right side of the burn severity map
legend(x='right', legend =rat$legend, fill = my_col, y='right') 

######### 2018-2020
# scales the dNBR map by 10^3
diff_NBR_2018_2020_scaled <- 1000*diff_NBR_2018_2020
# sets the ranges that will be used to classify dNBR information about the ranges used, please see the NBR section on the recommended practice
NBR_ranges <- c(-Inf, -500, -1, -500, -251, 1, -251, -101, 2, -101, 99, 3, 99, 269, 4, 269, 439, 5, 439, 659, 6, 659, 1300, 7, 1300, +Inf, -1) 
# sets a classification matrix
class.matrix <- matrix(NBR_ranges, ncol = 3, byrow = TRUE)
# classification matrix is used to classify diff_NBR_2020_scaled
diff_NBR_2018_2020_reclass <- reclassify(diff_NBR_2018_2020_scaled, class.matrix, right=NA)
# Building the legend
# Now that the burn severity map has been generated, the legend for the burn severity classes also needs to be created. 
# builds the attribute table for the legend 
diff_NBR_2018_2020_reclass <- ratify(diff_NBR_2018_2020_reclass) 
rat <- levels(diff_NBR_2018_2020_reclass)[[1]]
# creates the text that will be on the legend
rat$legend  <- c("NA", "Enhanced Regrowth, High", "Enhanced Regrowth, Low", "Unburned", "Low Severity", "Moderate-low Severity", "Moderate-high Severity", "High Severity") 
levels(diff_NBR_2020_reclass) <- rat 
# change the default colors : setting the colors for the severity map
my_col=c("white", "darkolivegreen","darkolivegreen4","limegreen", "yellow2", "orange2", "red", "purple")
# plots the burn severity map 
plot(diff_NBR_2018_2020_reclass,col=my_col,legend=F,box=F,axes=F, main="Burn Severity 2018-2020") 
# plots the legend on the right side of the burn severity map
legend(x='right', legend =rat$legend, fill = my_col, y='right')





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



