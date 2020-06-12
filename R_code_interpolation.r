### R_code_interpolation.r


setwd("C:/lab/")

# install.packages("spatstat")
library(spatstat) #to estimate the density of the plot 

inp <- read.table("dati_plot55_LAST3.csv", sep=";", head=T)
head(inp) #see the titles of the table 

attach(inp) #attach our dataframe (inp)
#plot(inp$X, inp$Y)
plot(X,Y)

summary(inp)
#ppp= planar point pattern : c is the range(minimum and maximum of X and Y)
inppp <- ppp(x=X, y=Y, c(716000,718000),c(4859000,4861000))

names(inp) #see the names of the variables 
marks(inppp)<- Canopy.cov #inp$Canopy.cov is not needed because we attached the function 

canopy <- Smooth(inppp) #we are going to interpolate the data 
plot(canopy) #plot smooth
points(inppp,col="green")

#lichens covered 
marks(inppp)<- cop.lich.mean  #lichens on the trees -> no lichens means high pollution 
lichs<- Smooth(inppp)
plot(lichs)
points(inppp) #higher amount of lichens is in the north 

#to see the images together
par(mfrow=c(1,2))
plot(canopy)
points(inppp)
plot(lichs)
points(inppp)
plot(Canopy.cov, cop.lich.mean, col="red", pch=19, cex=2)


###########
### Psammophilous vegetation
inp.psam <- read.table("dati_psammofile.csv", sep=";", head=T)
attach(inp.psam) 
head(inp.psam)

plot(E,N) 
inp.psam.ppp <- ppp(x=E,y=N,c(356450,372240),c(5059800,5064150))

marks(inp.psam.ppp)<- C_org #measure carbon in the soil 
C <- Smooth(inp.psam.ppp) #C=carbon
plot(C) 
points(inp.psam.ppp)



