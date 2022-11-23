
################################################################################
########################## Climate #############################################


### mcwd 
f.mcwd<-function(x,y,year){
  output<-vector()
  spp <- SpatialPoints(data.frame(x = x, y = y), proj4string = fm_sp_get_crs(mcwd))
  spp$year<-year ### Change in the function 
  proj4string(spp) <- fm_sp_get_crs(mcwd)
  
  ### raster::extract the value 
  v<-raster::extract(stack(mcwd),spp)  
  for (i in 1:nrow(v)){
    output[i]<-v[i,year[i]]
  }
  return(output)}





f.distance<-function(x,y,year){
  output<-vector()
  spp <- SpatialPoints(data.frame(x = x, y = y), proj4string = fm_sp_get_crs(mcwd))
  spp$year<-year ### Change in the function 
  proj4string(spp) <- fm_sp_get_crs(mcwd)
  
  ### raster::extract the value 
  v<-raster::extract(stack(distance_edge),spp)  
  for (i in 1:nrow(v)){
    output[i]<-as.character(v[i, year[i]])
  }
  output<-as.character(output)
  return(output)}







################################################################################
########################## Agri ################################################

# Pasture
f.pasture<-function(x,y,year){
  output<-vector()
  spp <- SpatialPoints(data.frame(x = x, y = y), proj4string = fm_sp_get_crs(mcwd))
  spp$year<-year ### Change in the function 
  proj4string(spp) <- fm_sp_get_crs(mcwd)
  
  ### raster::extract the value 
  v<-raster::extract(stack(pasture),spp)  
    for (i in 1:nrow(v)){
      output[i]<-as.character(v[i, year[i]])
    }
    output<-as.character(output)
    return(output)}


f.pasture.change<-function(x,y,year){
  output<-vector()
  spp <- SpatialPoints(data.frame(x = x, y = y), proj4string = fm_sp_get_crs(mcwd))
  spp$year<-year ### Change in the function 
  proj4string(spp) <- fm_sp_get_crs(mcwd)
  
  ### raster::extract the value 
  v<-raster::extract(stack(pasture_change),spp)  
  for (i in 1:nrow(v)){
    output[i]<-as.character(v[i, year[i]])
  }
  output<-as.character(output)
  return(output)}


# Other annuals 
f.annual<-function(x,y,year){
  output<-vector()
  spp <- SpatialPoints(data.frame(x = x, y = y), proj4string = fm_sp_get_crs(mcwd))
  spp$year<-year ### Change in the function 
  proj4string(spp) <- fm_sp_get_crs(mcwd)
  
  ### raster::extract the value 
  v<-raster::extract(stack(annual_crop),spp)  
  for (i in 1:nrow(v)){
    output[i]<-as.character(v[i, year[i]])
  }
  output<-as.character(output)
  return(output)}


f.annual_change<-function(x,y,year){
  output<-vector()
  spp <- SpatialPoints(data.frame(x = x, y = y), proj4string = fm_sp_get_crs(mcwd))
  spp$year<-year ### Change in the function 
  proj4string(spp) <- fm_sp_get_crs(mcwd)
  
  ### raster::extract the value 
  v<-raster::extract(stack(annual_crop_change),spp)  
  for (i in 1:nrow(v)){
    output[i]<-as.character(v[i, year[i]])
  }
  output<-as.character(output)
  return(output)}


# Perennials 
f.agri_perm<-function(x,y,year){
  output<-vector()
  spp <- SpatialPoints(data.frame(x = x, y = y), proj4string = fm_sp_get_crs(mcwd))
  spp$year<-year ### Change in the function 
  proj4string(spp) <- fm_sp_get_crs(mcwd)
  
  ### raster::extract the value 
  v<-raster::extract(stack(perennial_crop),spp)  
  for (i in 1:nrow(v)){
    output[i]<-as.character(v[i, year[i]])
  }
  output<-as.character(output)
  return(output)}


f.per_change<-function(x,y,year){
  output<-vector()
  spp <- SpatialPoints(data.frame(x = x, y = y), proj4string = fm_sp_get_crs(mcwd))
  spp$year<-year ### Change in the function 
  proj4string(spp) <- fm_sp_get_crs(mcwd)
  
  ### raster::extract the value 
  v<-raster::extract(stack(perennial_crop_change),spp)  
  for (i in 1:nrow(v)){
    output[i]<-as.character(v[i, year[i]])
  }
  output<-as.character(output)
  return(output)}


# Cash crops 
f.cash_crop<-function(x,y,year){
  output<-vector()
  spp <- SpatialPoints(data.frame(x = x, y = y), proj4string = fm_sp_get_crs(mcwd))
  spp$year<-year ### Change in the function 
  proj4string(spp) <- fm_sp_get_crs(mcwd)
  
  ### raster::extract the value 
  v<-raster::extract(stack(cash_crop),spp)  
  for (i in 1:nrow(v)){
    output[i]<-as.character(v[i, year[i]])
  }
  output<-as.character(output)
  return(output)}



f.other_annual<-function(x,y,year){
  output<-vector()
  spp <- SpatialPoints(data.frame(x = x, y = y), proj4string = fm_sp_get_crs(mcwd))
  spp$year<-year ### Change in the function 
  proj4string(spp) <- fm_sp_get_crs(mcwd)
  
  ### raster::extract the value 
  v<-raster::extract(stack(other_annual_crop),spp)  
  for (i in 1:nrow(v)){
    output[i]<-as.character(v[i, year[i]])
  }
  output<-as.character(output)
  return(output)}







################################################################################
########################## Ecosystems ##########################################


# Edges density 

f.ed<-function(x,y,year){
  output<-vector()
  spp <- SpatialPoints(data.frame(x = x, y = y), proj4string = fm_sp_get_crs(mcwd))
  spp$year<-year ### Change in the function 
  proj4string(spp) <- fm_sp_get_crs(mcwd)
  
  ### raster::extract the value 
  v<-raster::extract(stack(ed),spp)  
  for (i in 1:nrow(v)){
    output[i]<-v[i,year[i]]
  }
  return(output)}




#forest
f.forest<-function(x,y,year){
  output<-vector()
  spp <- SpatialPoints(data.frame(x = x, y = y), proj4string = fm_sp_get_crs(mcwd))
  spp$year<-year ### Change in the function 
  proj4string(spp) <- fm_sp_get_crs(mcwd)
  
  ### raster::extract the value 
  v<-raster::extract(stack(forest),spp)  
  for (i in 1:nrow(v)){
    output[i]<-as.character(v[i, year[i]])
  }
  output<-as.character(output)
  return(output)}




################################################################################
########################## Infrastructures #####################################

### Transport cost 

f.road<-function(x,y,year){
  output<-vector()
  spp <- SpatialPoints(data.frame(x = x, y = y), proj4string = fm_sp_get_crs(mcwd))
  spp$year<-year ### Change in the function 
  proj4string(spp) <- fm_sp_get_crs(mcwd)
  
  ### raster::extract the value 
  v<-raster::extract(stack(road),spp)  
  for (i in 1:nrow(v)){
    output[i]<-v[i,year[i]]
  }
  output<-as.numeric(output)
  
  return(output)}





################################################################################
########################## env. policies #######################################

f.gov<-function(x,y,year){
  output<-vector()
  spp <- SpatialPoints(data.frame(x = x, y = y), proj4string = fm_sp_get_crs(mcwd))
  spp$year<-year ### Change in the function 
  proj4string(spp) <- fm_sp_get_crs(mcwd)
  
  ### raster::extract the value 
  v<-raster::extract(stack(governance),spp)  
  for (i in 1:nrow(v)) {
    output[i] <- as.character(v[i, year[i]])
  }
  output<-as.character(output)
  return(output)
}




# Blacklisting 
f.blacklist<-function(x,y,year){
  output<-vector()
  spp <- SpatialPoints(data.frame(x = x, y = y), proj4string = fm_sp_get_crs(mcwd))
  spp$year<-year ### Change in the function 
  proj4string(spp) <- fm_sp_get_crs(mcwd)
  
  ### raster::extract the value 
  v<-raster::extract(stack(blacklist),spp)  
  for (i in 1:nrow(v)) {
    output[i] <- as.character(v[i, year[i]])
  }
  return(output)
}








