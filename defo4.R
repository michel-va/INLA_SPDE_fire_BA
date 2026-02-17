# 0) Packages -------------------------------------------------------------
library(terra)
library(sf)
library(INLA)
library(dplyr)
library(tibble)
library(Matrix)
library(fmesher)



raster_response <- rast("raster/response/stack_defo.tif")  # 2 layers
raster_response<-raster_response[[11:13]]
raster_response[is.na(raster_response)]<-0

border<-st_read("amazon_border/biome.shp")
border<-st_transform(border,crs(raster_response))
border<-border[5,]

raster_response<-crop(raster_response,border)
raster_response<-mask(raster_response,border)
raster_response[is.na(raster_response)] <- 0



cov_files <- list(
  mcwd = "raster/mcwd2.tif",
  road = "raster/road_cat_4.tif",
  pasture='raster/pasture.tif',
  annual_crop="raster/annual_crop.tif",
  perennial_crop="raster/perennial_crop.tif",
  fragmentation="raster/ed.tif",
  governance = "raster/governance_all.tif",
  pasture_change = "raster/pasture_change.tif",
  annual_crop_change = "raster/annual_crop_change.tif",
  perennial_crop_change = "raster/perennial_crop_change.tif",
  blacklist = "raster/blacklist.tif"
)

cov_stack <- lapply(cov_files, function(f) {
  rast(f)[[11:13]] |>
    project(raster_response) |>
    crop(border) |>
    mask(border) |>
    resample(raster_response, method = "near")
})


names(cov_stack) <- names(cov_files)


coords <- xyFromCell(raster_response, seq_len(ncell(raster_response)))
coords_df <- as.data.frame(coords)
names(coords_df) <- c("x", "y")

resp_vals <- values(raster_response)
cov_vals  <- lapply(cov_stack, values)

nl <- nlyr(raster_response)
ncell_tot <- ncell(raster_response)

df_list <- vector("list", nl)
for (yr in seq_len(nl)) {
  
  df_tmp <- tibble(
    cell = seq_len(ncell_tot),
    x = coords_df$x,
    y = coords_df$y,
    year_idx = yr,
    response = resp_vals[, yr],
    mcwd =  factor(cov_vals$mcwd[, yr],levels = c(1, 2, 3,4,5,6,7)),
    road =  factor(cov_vals$road[, yr],levels = c(1, 2, 3,4)),
    pasture=factor(cov_vals$pasture[,yr],levels=c(1,2,3)),
    annual_crop=factor(cov_vals$annual_crop[,yr],levels=c(1,2,3)),
    perennial_crop=factor(cov_vals$perennial_crop[,yr],levels=c(1,2,3)),
    fragmentation=factor(cov_vals$fragmentation[,yr],levels=c(1,2,3,4)),
    governance =  factor(cov_vals$governance[, yr],levels = c(1, 2, 3,4,5,6,7,8,9,10,11,12)),
    pasture_change =  factor(cov_vals$pasture_change[, yr],levels = c(1, 2)),
    annual_crop_change =  factor(cov_vals$annual_crop_change[, yr],levels = c(1, 2)),
    perennial_crop_change =  factor(cov_vals$perennial_crop_change[, yr],levels = c(1, 2)),
    blacklist =  factor(cov_vals$blacklist[, yr],levels = c(1, 2,3))
  )
  
  df_list[[yr]] <- df_tmp
}

df_long <- bind_rows(df_list)

df_long <- df_long %>%
  mutate(
    y_bin = as.integer(response > 0)
  ) %>%
  select(-response) %>%
  filter(if_all(everything(), ~ !is.na(.)))

df_long <- df_long %>%
  mutate(
    mcwd = relevel(factor(mcwd), ref = "1"),
    road = relevel(factor(road), ref = "1"),
    pasture= relevel(factor(pasture), ref = "1"),
    annual_crop= relevel(factor(annual_crop), ref = "1"),
    perennial_crop= relevel(factor(perennial_crop), ref = "1"),
    fragmentation= relevel(factor(fragmentation), ref = "1"),
    governance = relevel(factor(governance), ref = "1"),
    pasture_change = relevel(factor(pasture_change), ref = "1"),
    annual_crop_change = relevel(factor(annual_crop_change), ref = "1"),
    perennial_crop_change = relevel(factor(perennial_crop_change), ref = "1"),
    blacklist = relevel(factor(blacklist), ref = "1")
  )



#########################################################
############## OLD SECTIONS

# Build mesh (shared for all years)
# -------------------------
# Use unique coordinates to speed up mesh construction



coords_mesh <- df_long %>%
  filter(y_bin == 1) %>%
  distinct(x, y) %>%
  as.matrix()

mesh <- fm_mesh_2d_inla(
  loc = coords_mesh,
  boundary = border,
  max.edge = c(50, 150),
  cutoff = 1,
  offset = c(200, 200)
)




# -------------------------
# SPDE definition (PC priors)
# -------------------------
spde <- inla.spde2.pcmatern(mesh = mesh,
                            prior.range = c(10, 0.5),   # P(range < 30km) = 0.5 (tune)
                            prior.sigma = c(1, 0.01))      # P(sigma > 1) = 0.01 (tune)



#############################################################################
n_years <- length(unique(df_long$year_idx))
spde_index <- inla.spde.make.index(name = "s", n.spde = spde$n.spde, n.group = n_years)

A_st <- inla.spde.make.A(
  mesh = mesh,
  loc = as.matrix(df_long[, c("x", "y")]),
  group = df_long$year_idx,
  n.group = n_years
)


# Stack: include spatio-temporal index 's' as effect
stack_st <- inla.stack(
  data = list(y = df_long$y_bin),
  A = list(1, A_st),
  effects = list(
    data.frame(
      intercept = 1,
      mcwd =df_long$mcwd,
      road = df_long$road,
      pasture= df_long$pasture,
      annual_crop= df_long$annual_crop,
      perennial_crop= df_long$perennial_crop,
      fragmentation= df_long$fragmentation,
      governance = df_long$governance,
      pasture_change = df_long$pasture_change,
      annual_crop_change = df_long$annual_crop_change,
      perrenial_crop_change = df_long$perennial_crop_change,
      blacklist = df_long$blacklist,
      year_idx =df_long$year_idx   
      
    ),
    list(s = spde_index$s, s.group = spde_index$s.group)
  ),
  tag = "estimation_st"
)







formula_st <- y ~ mcwd+road+pasture+annual_crop+perennial_crop+fragmentation+governance+pasture_change+annual_crop_change+perrenial_crop_change+blacklist+
  f(year_idx, model = "rw1")+
  f(s, model = spde, group = s.group, control.group =
      list(model = "ar1",hyper = list(rho = list(prior = "pccor1", param = c(0.7, 0.8)))))



res_st_defo4 <- inla(
    formula_st,
    family = "zeroinflatedbinomial1",
    data = inla.stack.data(stack_st, spde = spde),
    control.predictor = list(A = inla.stack.A(stack_st), compute = TRUE,link=1),
    control.compute = list(dic = TRUE, waic = TRUE, cpo = TRUE, config = TRUE),
    control.inla=list(strategy="laplace"),
    control.fixed = list(prec.intercept=1, prec=1),
    verbose = TRUE
  )
  

summary(res_st_defo4)
rm(list=setdiff(ls(),c("res_st_defo4","mesh","stack_st","df_long")))
save.image("model_inla_defo42.Rdata")





