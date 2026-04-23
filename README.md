## INLA_SPDE_fire_BA
Spatially explicit analysis of socio-ecological drivers of fires regimes in the Brazilian Amazon from 2009-2024


## Content of the repository 
The repository contains several inter-dependant files, make sure they are all in the same working directory when you launch the analysis. You'll also need an RData file with all the data, that is available upon request. 

* **amazon_border:** folder with the required shapefile for delimiting the area of interest 
* **model_agri_period:** analysis of agricultural fires for the 5 periods 
* **model_defo_period:** analysis of deforestation fires for the 5 periods  
* **model_forest_period:** analysis of forest fires for the 5 periods   


## Run the model 
For running the model on the HPC, you'll need to use the HPC (eg specification: ~1 node, 32 CPU, 100Gb, a couple of hours). Otherwise, the mySPDE effect could be removed from the formula and should be able to run on most laptop, without the spatio-temporal effect. 

## Results 

### Deforestation fires 
<img width="3751" height="4288" alt="figure_defo" src="https://github.com/user-attachments/assets/4b670d65-1629-4764-ad08-7d1655af2a54" />

Posterior means and 95% credible intervals of explanatory variables for deforestation fires in the Brazilian Amazon

### Agricultural fires 
<img width="3751" height="4288" alt="figure_agri" src="https://github.com/user-attachments/assets/8a144316-53cf-4bc6-ab5d-9580b38199b8" />

Posterior means and 95% credible intervals of explanatory variables for agricultural fires in the Brazilian Amazon

### Forest fires 
<img width="3708" height="4288" alt="figure_forest" src="https://github.com/user-attachments/assets/f14c22dc-2493-45c6-8e0a-df522907f4e2" />

Posterior means and 95% credible intervals of explanatory variables for forest fires in the Brazilian Amazon


