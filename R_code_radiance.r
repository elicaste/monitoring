# R code radiance

library(raster)

toy <- rasater (ncl=2, nrow=2, xmn=1, xmx=2, ymn=1, ymx=2)
values(toy) <- c(1.13, 1.44,1.55,3.4)
plot(toy)
text(toy,digits=2)

# 2 bits --> 2^2 = 4 values 
toy2bit<- stretch(toy,minv=0, maxv=3) #stretch changes the range of values  
                                      #minimum of 0 to a maximum of 3
storage.mode(toy2bits[]) = "integer"  #to ensure that we are going to use integer value 
plot(toy2bits)
text(toy2bits, digits=2)    

# 4 bits --> 2^4 =16 values 
toy4bit<- stretch(toy,minv=0, maxv=15)
storage.mode(toy4bits[]) = "integer"
plot(toy4bits)
text(toy4bits, digits=2) 

# 8 bits --> 2^8 =256 values 
toy8bit<- stretch(toy,minv=0, maxv=255)
storage.mode(toy8bits[]) = "integer"
plot(toy8bits)
text(toy8bits, digits=2)

#plot all together
par(mfrow=c(1,4))
  plot(toy)
text(toy,digits=2)
  plot(toy2bits)
text(toy2bits, digits=2)
  plot(toy4bits)
text(toy4bits, digits=2) 
  plot(toy8bits)
text(toy8bits, digits=2)




