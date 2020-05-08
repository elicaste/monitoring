# R_code_faPAR.r

setwd("C:/lab/")

library(raster)
library(rasterVis)
library(rasterdiv)

plot(copNDVI)
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))

levelplot(copNDVI)
faPAR10 <- raster("farPAR10.tif") #import the file

levelpot(farPAR10)

#save the plot as pdf
pfd("copNDVI.pdf")
levelplot(coNDVI)
dev.off()

pdf("faPAR.pdf")
levelplot(faPAR10)
dev.off()


