# INLA_SPDE_fire_BA
Spatially explicit analysis of socio-ecological drivers of fires regimes in the Brazilian Amazon from 2011-2020


## Content of the repository 
The repository contains several inter-dependant files, make sure they are all in the same working directory when you launch the analysis. You'll also need an RData file with all the data, that is available upon request. 

* **function_cat.R:** contain the function inlabru need to get the value of the different covariates on the observed points and the integration point of the mesh 
* **amazon_border:** folder with the required shapefile for delimiting the area of interest 
* **model_agri_period:** analysis of agricultural fires for the 2 periods 
* **model_defo_period:** analysis of deforestation fires for the 2 periods  
* **model_forest_period:** analysis of forest fires for the 2 periods   


## Run the model 
For running the model on the HPC, you'll need to use the HPC (eg specification: ~1 node, 32 CPU, 100Gb, a couple of hours). Otherwise, the mySPDE effect could be removed from the formula and should be able to run on most laptop, without the spatio-temporal effect. 

## Results 

### Deforestation fires 
<img width="1700" height="985" alt="figure_defo" src="https://github.com/user-attachments/assets/6fcaa8a6-2058-483b-bfbe-641235c691b6" />
Posterior means and 95% credible intervals of explanatory variables for deforestation fires in the Brazilian Amazon

### Forest fires 
<img width="1700" height="1026" alt="figure_forest" src="https://github.com/user-attachments/assets/d89412d2-ff3f-4cc3-ad32-4c6008398e65" />
Posterior means and 95% credible intervals of explanatory variables for forest fires in the Brazilian Amazon

### Agricultural fires 
<img width="1800" height="1043" alt="figure_agri" src="https://github.com/user-attachments/assets/fbda1b8a-21f0-4d0c-ab5c-c940748dcf0e" />
Posterior means and 95% credible intervals of explanatory variables for agricultural fires in the Brazilian Amazon
