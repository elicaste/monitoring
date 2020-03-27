### Multipanel in R: the second lecture of monitoring Ecosystem

install.packages("sp")
install.packages("GGally")      #this is used for the function ggpairs()
                                # it's a packages that we use after

library(sp)                     #require(sp) doeas the same 
library(GGally)                 #used for the other package installed

data(meuse) #there is a dataset available named meuse
attach (meuse)

#EXERCISE: see the names of the variabes and plot cadmium versus zinc
#there are two ways to see the names of the variables:
#the fist is

names (meuse)

#the second is 

#head (meuse)
plot(cadmium,zinc,pch=15,col="red",cex=2)

#Exercise:make all the possible paiwis plots of the dataset
#plot(x,cadmium)
#plot(x,zinc)
#plot...
#plot isn't a god idea, so we use PAIRS(meuse)

pairs(meuse)

#the result is a multipanel, that are all the graphs in one figure 
#in case you receive the error "the size is too large", you have to reshape with the mouse the graph window

pairs(~ cadmium+copper+lead+zinc, data=meuse)  

#grouping variabiles 
# ~ called tilde --> blocnum alt+126
#comma separates different arguments

pairs(meuse[,3:6])
#name of dataset + make the subset of the dataset  "," comma means "strart from" ":" means "untile"
#it is another way to to pairs(~ cadmium+copper+lead+zinc, data=meuse) 

#Exercise: prettify this graph = modify the characteristics of the graph

pairs(meuse[,3:6], col="blue", pch=4, cex=1)

#go up at the beginning of the code and istall another package
#GGally package will prettify the graph
#install the package and use the library(GGally)

ggpairs(meuse[,3:6])

#reading of the graph: cadium and copper have very high correlation (0<correlation<1)






