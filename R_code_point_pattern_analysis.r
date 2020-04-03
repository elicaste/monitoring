### POINT PATTERN ANALYSIS: DENSITY MAP

install.packages("spatstat")
library(spatstat)

attach(covid)
head(covid)

# give a name to the object we are goingo to prepare
covids <-ppp(lon,lat,c(-180,180), c(-90,90))  
# ppp(x,y, range of longiture, range of latitude) -> point pattern dataset in the two-dimensional plane

# without attaching the covid set
# the ppp commang becomes: covids <-ppp(covid$lon, covid$lat,c(-180,180), c(-90,90))  

#######FUNCTION DENSITY
d<-density(covids)

plot(d) #to show the density graph
points(covids)



