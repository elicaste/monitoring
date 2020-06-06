### R_code_NO2.r

setwd("C:/lab/NO2/")
library(ncdf4)

#EXERCISE: import all of the NO2 data in R  by the lapply function

#we should do the list of the files we want to import 
rlist <- list.files(pattern="EN")  #they all contain in the tille "EN" 

import<- lapply(rlist, raster) #import all the file selected with rlist 

EN <- stack(import) #stack function: to create a multitemporal imaage 
cl <-colorRampPalette(c('red','orange','yellow'))(100) 
plot(EN,col=cl) #plot the images all together 

#to see the comparison between the first and the last day:
par(mfrow=c(1,2))
plot(EN$EN_0001, col=cl)
plot(EN$EN_0013, col=cl)

###RGB space: to show spatial data in using colors 
plotRGB(EN, r=1, g=7, b=13,stretch="lin") #1st image of the stack is 0001, 7th is 0007, the last(13rd) is 0013

#different map between the two situations 
dif <- EN$EN_0013 - EN$EN_0001
cld <-colorRampPalette(c('blue','white','red'))(100) #red means high differences,blue means lower difference between the 2 periods
plot(dif,col=cld) 

#quantitative measure of the decreasing of NO2
boxplot(EN)
boxplot(EN,outline=F) #vertical boxplot with the outlines removed 
boxplot(EN,outline=F, horizontal=T) #horizontal boxplot
boxplot(EN,outline=F, horizontal=T, axes=T)

# plot 
plot(EN$EN_0001, EN$EN_0013)
 
# we can compare each pixels of 2 stituations plotting the 2 images in order to see if NO2 decreases o increases in each pixel
plot(EN$EN_0001, EN$EN_0013) 
abline(0,1,col="red") #most of the point are under the line, that means that the NO2 decreases


############ do the same with snow images (see the snow file!)
setwd("C:/lab/snow/")
rlist <- list.files(pattern="snow")
import <- lapply(rlist, raster)
snow.multitemp <- stack(import)

plot(snow.multitemp$snow2010r,snow.multitemp$snow2020r) #strange plot! 
abline(0,1,col="red")
