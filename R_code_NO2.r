### R_code_NO2.r

setwd("C:/lab/NO2/")

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
