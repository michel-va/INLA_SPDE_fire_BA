################################################################################

library(INLA)
library(sf)
library(sp)
library(inlabru)
library(rgdal)
library(raster)
library(terra)

#inla.setOption( num.threads = 40 ) 

bru_options_set(inla.mode = "experimental")
inla.setOption(inla.mode="experimental") 
load("data_all.RData")
source("function_cat.R")



nyear<-5

modis<-subset(modis,year>10)
modis<-subset(modis,distance<0.51)
loc<-coordinates(modis)



border<-st_read('amazon_border/biome.shp')
border<-border[5,]
border<-st_transform(border,proj)
border2<-as_Spatial(border,cast=T)
border2<-rebuild_CRS(border2)

########################
### Create the mesh 
b1<-inla.nonconvex.hull(loc,convex=0.25,concave=-0.05)


mesh.loc <- SpatialPoints(as.matrix(loc))


mesh <- inla.mesh.2d(loc=mesh.loc,
                     boundary=b1,
                     max.edge=c(15, 75),
                     min.angle=c(30, 21),
                     max.n=c(48000, 16000), ## Safeguard against large meshes.
                     max.n.strict=c(128000, 128000), ## Don't build a huge mesh!
                     cutoff=1, ## Filter away adjacent points.
                     offset=c(250, 250),
                     crs=CRS(proj4string(border2))) ## Offset for extra boundaries, if needed.



plot(mesh)

### Create integration points and matrix 
ips <- ipoints(border2,mesh)
ips_sf<-st_as_sf(ips)

for (i in 11:15){
  if(i==11){
    output<-ips_sf
    output$year<-i
  }else{
    output_temp<-ips_sf
    output_temp$year<-i
    output<-rbind(output_temp,output)
  }
}

ips<-as_Spatial(output)



matern= inla.spde2.pcmatern(mesh,prior.range = c(10, 0.5),
                            prior.sigma = c(15, 0.05))






tn.prior3<-list(theta=list(prior="pc.prec",param=c(10,0.1)),
                theta1=list(prior="pc.cor1",param=c(0.9,0.8)))





formula.1 <- coordinates+year ~
  gov(f.gov(x,y,year),model="factor_contrast")+
  pasture(f.pasture(x,y,year),model="factor_contrast")+
  annual(f.annual(x,y,year),model="factor_contrast")+
  agri_perm(f.agri_perm(x,y,year),model="factor_contrast")+
  fragmentation(f.ed(x,y,year),model="linear",prec.linear=0.01)+
  forest(f.forest(x,y,year),model="factor_contrast")+
  pasture.change(f.pasture.change(x,y,year),model='factor_contrast')+
  annual.change(f.annual_change(x,y,year),model="factor_contrast")+
  road(f.road(x,y,year),model="linear",prec.linear=0.01)+
  per.change(f.per_change(x,y,year),model="factor_contrast")+
  mcwd(f.mcwd(x,y,year),model="factor_contrast")+
  blacklist(f.blacklist(x,y,year),model="factor_contrast")+
  Intercept(1,prec.linear=0.1)+
  mySPDE(main=coordinates,model = matern, group = year, ngroup = nyear,diagonal=1e-8,control.group=list(model="ar1"))  # Add constr=T on the year effect? 




fit1 <- lgcp(formula.1, modis,sampler=ips,domain=list(coordinates=mesh,year=11:15),options = list( safe=TRUE,inla.mode="experimental",verbose=T,
                                                                                                  control.inla = list(strategy = "gaussian",int.strategy="eb"),
                                                                                                  control.compute=list(return.marginals=TRUE, dic=TRUE, cpo=TRUE,po=TRUE,waic=TRUE)))

summary(fit1)
fit1$summary.fixed
fit1$summary.random$gov

save.image("model_defo_3.Rdata")



