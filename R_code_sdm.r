### R_code_sdm.r
# Species distribution modelling 

# install.packages("sdm") 
# install.packages("rgdal")
library(sdm)
library(raster) #used for geological variables: predictors 
library(rgdal) #used for species

#import species data
file<-system.file("external/species.shp", package="sdm") 
species<-shapefile(file)
species #too see all the information about the species 
species$Occurrence #occurrence is 0 or 1: absent or present
plot(species[species$Occurrence == 1,],col="blue",pch=16)
points(species[species$Occurrence == 0,],col="red",pch=16)

#environmental variables
path<-system.file("external", package="sdm") 
lst<-list.files(path=path,pattern="asc$",full.names = T) 
lst

#plot all the variables inside the stack
preds<-stack(lst)
cl<-colorRampPalette(c("blue","orange","red","yellow")) (100)
plot(preds, col=cl)

plot(preds$elevation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

plot(preds$temperature, col=cl)
points(species[species$Occurrence == 1,], pch=16)

plot(preds$precipitation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

plot(preds$vegetation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

#make the model
d<-sdmData(train=species, predictors=preds) #training set=insitu data(species set make previously), predictors=where the sp are predicted to be (stack of all of the variables) 
d #to see what there is inside 
m1<-sdm(Occurrence~elevation+precipitation+temperature+vegetation, data=d, methods="glm") 
p1<-predict(m1, newdata=preds)
plot(p1, col=cl)
points(species[species$Occurrence == 1,], pch=16)
s1 <- stack(preds,p1)
plot(s1, col=cl)
