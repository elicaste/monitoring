#R_code_project.r
setwd("C:/lab/California") #set the working director

# install all packages needed 
install.packages ("raster") #package for the analysis and geographyc data manipulation 
install.packages("rasterdiv")
install.packages ("rasterVis") #package for visualize raster data 
install.packages ("rgdal") #package for geospatial analysis 
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
library(plot.matrix)
library(RasterLayer)
library(ggplot2)
library(gridExtra)

######################################### RGB and NDVI analysis 
#create a list of raster layers to use (for 2018- June and September, and for 2020- June and September)

#import 2018_June images
setwd("C:/lab/California/2018_14_June")
rlist_2018_June<- list.files(pattern="2018")
rlist_2018_June 
import_images_2018_June <- lapply(rlist_2018_June, raster)
images_2018_June <- stack(import_images_2018_June)
#crop the images 
ext <- c(0, 2500, 0, 1300)
#zoom function
zoom(images_2018_June, ext=ext)
images_2018_June_crop <- crop(images_2018_June, ext)

#import 2018_September images
setwd("C:/lab/California/2018_28_September")
rlist_2018_September<- list.files(pattern="2018")
rlist_2018_September 
import_images_2018_September <- lapply(rlist_2018_September, raster)
images_2018_September <- stack(import_images_2018_September)
images_2018_September_crop <- crop(images_2018_September, ext)

#import 2020_June images
setwd("C:/lab/California/2020_03_June")
rlist_2020_June<- list.files(pattern="2020")
rlist_2020_June 
import_images_2020_June <- lapply(rlist_2020_June, raster)
images_2020_June <- stack(import_images_2020_June)
images_2020_June_crop <- crop(images_2020_June, ext)

#import 2020_September images
setwd("C:/lab/California/2020_06_September")
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
grid.arrange(visible_June_2018_print, visible_September_2018_print,  ncol = 1)

# plot in RGB visible 2020 images
visible_June_2020<- ggRGB(images_2020_June_crop, r=4, g=3, b=2,stretch = "Lin") 
visible_June_2020_print<- print(visible_June_2020 + ggtitle("Visible June 2020")+ theme (axis.title.x = element_blank(),axis.title.y = element_blank()))
visible_September_2020<- ggRGB(images_2020_September_crop, r=4, g=3, b=2,stretch = "Lin")
visible_September_2020_print<- print(visible_September_2020 + ggtitle("Visible September 2020")+ theme (axis.title.x = element_blank(),axis.title.y = element_blank()))

#plot June and September 2020 together
grid.arrange(visible_June_2020_print, visible_September_2020_print,  ncol = 1)

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

grid.arrange(false_June_2018_print, false_September_2018_print,  ncol = 1)

# plot in false color 2020 images
false_June_2020<- ggRGB(images_2020_June_crop, r=8, g=4, b=3,stretch = "Lin") 
false_June_2020_print<- print(false_June_2020 + ggtitle("False color June 2020")+ theme (axis.title.x = element_blank(),axis.title.y = element_blank()))
false_September_2020<- ggRGB(images_2020_September_crop, r=8, g=4, b=3,stretch = "Lin")
false_September_2020_print<- print(false_September_2020 + ggtitle("False color September 2020")+ theme (axis.title.x = element_blank(),axis.title.y = element_blank()))

grid.arrange(false_June_2020_print, false_September_2020_print,  ncol = 1)

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


# histogram NDVI Juned 2018
hist_NDVI_2018_June <-hist(NDVI_2018_June, main = "Distribution of NDVI values \n June 2018",	xlab = "NDVI", ylab= "Frequency", breaks=30)  
axis(side=1, at = seq(-0.5,1, 0.05), labels = seq(-0.5,1, 0.05))

# histogram NDVI September 2018
hist_NDVI_2018_September <- hist(NDVI_2018_September, main = "Distribution of NDVI values \n September  2018",xlab = "NDVI", ylab= "Frequency", breaks=30, ylim=25000 )
axis(side=1, at = seq(-0.5,1, 0.05), labels = seq(-0.5,1, 0.05))

# histogram NDVI Juned 2020
hist_NDVI_2020_June <-	hist(NDVI_2020_June, main = "Distribution of NDVI values \n June 2020",		 xlab = "NDVI", ylab= "Frequency", breaks=30, )
axis(side=1, at = seq(-0.5,1, 0.05), labels = seq(-0.5,1, 0.05))

# histogram NDVI September 2020
hist_NDVI_2020_September <- hist(NDVI_2020_September, main = "Distribution of NDVI values \n September  2020",xlab = "NDVI", ylab= "Frequency", breaks=30, )
axis(side=1, at = seq(-0.5,1, 0.05), labels = seq(-0.5,1, 0.05))

# create transparent colors 
col2rgb("lightblue")
col2rgb(c("lightblue", "lightgreen", "pink"))
mycol <- rgb(0, 0, 255, max = 255, alpha = 125, names = "blue50")
c1 <- rgb(173,216,230,max = 255, alpha = 80, names = "lt.blue")
c2 <- rgb(255,192,203, max = 255, alpha = 80, names = "lt.pink") 

# plot the 2018 histograms
par(mai=rep(0.5, 4))
layout(matrix(c(1,1,2,2,0,3,3,0), ncol = 4, byrow = TRUE))
plot(hist_NDVI_2018_June, col=c2, main="NDVI June 2018", xlab = "NDVI")
plot(hist_NDVI_2018_September, col=c1, main="NDVI September 2018", xlab = "NDVI")
plot(hist_NDVI_2018_June, col = c1, xlim = c(-0.5, 1), main="Comparison between 2018 NDVI",xlab = "NDVI" )
plot(hist_NDVI_2018_September , add = TRUE, col = c2)

# plot the 2020 histograms
par(mai=rep(0.5, 4))
layout(matrix(c(1,1,2,2,0,3,3,0), ncol = 4, byrow = TRUE))
plot(hist_NDVI_2020_June, col=c2, main="NDVI June 2020", xlab = "NDVI")
plot(hist_NDVI_2020_September, col=c1, main="NDVI September 2020", xlab = "NDVI")
plot(hist_NDVI_2020_September, col = c1, xlim = c(-0.5, 1), ylim = c(0,130000), main="Comparison between 2020 NDVI",xlab = "NDVI" )
plot(hist_NDVI_2020_June, add = TRUE, col = c2)

#  remove cells where NDVI < 0,4
NDVI_2018_June_mod <- reclassify(NDVI_2018_June, cbind(-Inf, 0.4, NA))
NDVI_2018_September_mod <- reclassify(NDVI_2018_September, cbind(-Inf, 0.4, NA))
NDVI_2020_June_mod <- reclassify(NDVI_2020_June, cbind(-Inf, 0.4, NA))
NDVI_2020_September_mod <- reclassify(NDVI_2020_September, cbind(-Inf, 0.4, NA))

# plot the NDVI data modified - 2018 and 2020 
par(mfrow=c(2,2))
plot(NDVI_2018_June_mod, main='Vegetation \n June 2018', axes=FALSE, box=FALSE)
plot(NDVI_2018_September_mod, main='Vegetation \n September 2018', axes=FALSE, box=FALSE)
plot(NDVI_2020_June_mod, main='Vegetation \n June 2020', axes=FALSE, box=FALSE)
plot(NDVI_2020_September_mod, main='Vegetation \n September 2020', axes=FALSE, box=FALSE)

# NBR= normalized burned ratio 
# 2018 NBR
NBR_June_2018 <-  (images_2018_June_crop[[8]] - images_2018_June_crop[[12]])/ (images_2018_June_crop[[8]] + images_2018_June_crop[[12]])
NBR_September_2018 <-  (images_2018_September_crop[[8]] - images_2018_September_crop[[12]])/ (images_2018_September_crop[[8]] + images_2018_September_crop[[12]])
#2020 NBR
NBR_June_2020 <-  (images_2020_June_crop[[8]] - images_2020_June_crop[[12]])/ (images_2020_June_crop[[8]] + images_2020_June_crop[[12]])
NBR_September_2020 <-  (images_2020_September_crop[[8]] - images_2020_September_crop[[12]])/ (images_2020_September_crop[[8]] + images_2020_September_crop[[12]])
# visualize NBR rasters before and after the fire.
# Define color palette
nbr_colors <- colorRampPalette(brewer.pal(11, "RdYlGn"))(100) 
# Define in how many rows and columns are the graphs plotted
par(mfrow=c(1,2))

# Plot
plot(nbr_pre,
     main = "Landsat derived NBR\n Pre-Fire",
     axes = FALSE,
     box = FALSE,
     col = nbr_colors,
     zlim = c(-1, 1))
plot(nbr_post,
     main = "Landsat derived NBR\n Post-Fire",
     axes = FALSE,
     box = FALSE,
     col = nbr_colors,
     zlim = c(-1, 1))
# dNBR 2018
dNBR_2018 <-  NBR_June_2018 - NBR_September_2018
plot(dNBR_2018, 
     main = "Difference in NBR\n  June - September 2018" ,
     box = FALSE)
# dNBR 2020
dNBR_2020 <-  NBR_June_2020-NBR_September_2020 
plot(dNBR_2020,
     main = "Difference in NBR\n  June - September 2020" ,
     box = FALSE)


# BURN SEVERITY MAP: colour obtain the burn severity map, it is necessary to classify difference_NBR.
# The classification should be conducted in accordance with the USGS burn severity standards.

#   2018 
# scales the dNBR map by 10^3
dNBR_2018_scaled <- 1000*dNBR_2018
# sets the ranges that will be used to classify dNBR information about the ranges used, please see the NBR section on the recommended practice
NBR_ranges <- c(-Inf, -500, -1, -500, -251, 1, -251, -101, 2, -101, 99, 3, 99, 269, 4, 269, 439, 5, 439, 659, 6, 659, 1300, 7, 1300, +Inf, -1) 
# sets a classification matrix
class.matrix <- matrix(NBR_ranges, ncol = 3, byrow = TRUE)
# classification matrix is used to classify dNBR_2018_scaled
dNBR_2018_reclass <- reclassify(dNBR_2018_scaled, class.matrix, right=NA)
# Building the legend
# Now that the burn severity map has been generated, the legend for the burn severity classes also needs to be created. 
# builds the attribute table for the legend 
dNBR_2018_reclass <- ratify(dNBR_2018_reclass) 
rat2018 <- levels(dNBR_2018_reclass)[[1]]
# creates the text that will be on the legend
rat2018$legend  <- c("NA", "Enhanced Regrowth, High", "Enhanced Regrowth, Low", "Unburned", "Low Severity", "Moderate-low Severity", "Moderate-high Severity", "High Severity") 
levels(dNBR_2018_reclass) <- rat2018 
# change the default colors : setting the colors for the severity map
my_col=c("white", "darkolivegreen","darkolivegreen4","limegreen", "yellow2", "orange2", "red", "purple")
# plots the burn severity map 
plot(dNBR_2018_reclass,col=my_col,legend=F,box=F,axes=F, main="Burn Severity 2018") 
# plots the legend on the right side of the burn severity map
legend(x="top" ,legend =rat$legend, fill = my_col, y='right', inset=c(-0.2,0), ncol=3, cex = 0.75) 

#   2020

dNBR_2020_scaled <- 1000*dNBR_2020
# classification matrix is used to classify dNBR_2020_scaled
dNBR_2020_reclass <- reclassify(dNBR_2020_scaled, class.matrix, right=NA)
# Building the legend
# Now that the burn severity map has been generated, the legend for the burn severity classes also needs to be created. 
# builds the attribute table for the legend 
dNBR_2020_reclass <- ratify(dNBR_2020_reclass) 
rat2020 <- levels(dNBR_2020_reclass)[[1]]
# creates the text that will be on the legend
rat2020$legend  <- c("NA", "Enhanced Regrowth, High", "Enhanced Regrowth, Low", "Unburned", "Low Severity", "Moderate-low Severity", "Moderate-high Severity", "High Severity") 
levels(dNBR_2020_reclass) <- rat2020 
# plots the burn severity map 
plot(dNBR_2020_reclass,col=my_col,legend=F,box=F,axes=F, main="Burn Severity 2020") 
# plots the legend on the right side of the burn severity map
legend(x="top" ,legend =rat2020$legend, fill = my_col, y='right', inset=c(-0.2,0), ncol=3, cex = 0.75)

#   2018-2020
dNBR_2018_2020_scaled <- 1000*dNBR_2018_2020
# classification matrix is used to classify dNBR_2018_2020_scaled
dNBR_2018_2020_reclass <- reclassify(dNBR_2018_2020_scaled, class.matrix, right=NA)

# build the legend
dNBR_2018_2020_reclass <- ratify(dNBR_2018_2020_reclass) 
rat2018_2020 <- levels(dNBR_2018_2020_reclass)[[1]]
# creates the text that will be on the legend
rat2018_2020$legend  <- c("NA", "Enhanced Regrowth, High", "Enhanced Regrowth, Low", "Unburned", "Low Severity", "Moderate-low Severity", "Moderate-high Severity", "High Severity") 
levels(dNBR_2018_2020_reclass) <- rat2018_2020 
# plots the burn severity map 
plot(dNBR_2018_2020_reclass,col=my_col,legend=F,box=F,axes=F, main="Burn Severity 2018 - 2020") 
# plots the legend on the right side of the burn severity map
legend(x="top" ,legend =rat$legend, fill = my_col, y='right', inset=c(-0.2,0), ncol=3, cex = 0.75)

# distribution classified NBR values 
barplot(dNBR_2018_reclass,
        main = "Distribution of Classified NBR Values \n 2018",
        col = my_col,
        names.arg = c("NA", "RegrHigh", "RegrLow", "Unburned", "LowSev", "ModLowSev", "ModHighSev", "HighSev"), 
        horiz=TRUE,
        las=2,
        maxpixels= 2807500)
barplot(dNBR_2020_reclass,
        main = "Distribution of Classified NBR Values \n 2020",
        col = my_col,
        names.arg = c("NA", "RegrHigh", "RegrLow", "Unburned", "LowSev", "ModLowSev", "ModHighSev", "HighSev"), 
        horiz=TRUE,
        las=2,
        maxpixels= 2807500)





