### R CODE FOR MULTIVARIATE ANALYSIS

install.packages("vegan") # commnity ecology package
library(vegan)

setwd("C:/lab/")

#import the table 
biomes <- read.table("biomes.csv", head=T, sep=",") #in the biomes there is an header (so T=true, the values are separated by coma
head(biomes) #or view(biomes) -> to view the dataset 

# how the species are related eachother?
# DEtrended CORrrespondence ANAlysis = DECORANA
multivar <- decorana(biomes)
plot(multivar)

# analysis of the graph: 
# red colubus, giant orb, tree fern and raflesa are related each otehr --> they are in the same part of the graph
# the same occurs for another part of the graph, for ex. bufo, fox, squirrel, alnus, mosses

# import the addiotional table: biomes type
biomes_types <- read.table("biomes_types.csv", head=T, sep=",")
head(biomes_types)

attach(biomes_types) 

# we are going to draw an ellipse that connect all the points
# 4 different biomes, so 4 different colors or we can write col=c("green","blue","red","black")
# kind= type of graph --> hull is a convex shape and "e" is for ellipse

ordiellipse(multivar, type, col=1:4, kind = "ehull", lwd=3)

ordispider(multivar, type, col=1:4, label=T)



 
 


