# INLA_SPDE_fire_BA
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
![figure_defo](https://github.com/user-attachments/assets/e17015ff-c255-41dd-b968-5c7af4df291a)
Posterior means and 95% credible intervals of explanatory variables for deforestation fires in the Brazilian Amazon

### Agricultural fires 
![figure_agri](https://github.com/user-attachments/assets/975a6755-73b9-45fe-aa2c-281d96b3246d)
Posterior means and 95% credible intervals of explanatory variables for agricultural fires in the Brazilian Amazon

### Forest fires 
![figure_forest](https://github.com/user-attachments/assets/f33a8550-c415-4b8b-abe0-004ad1fba76b)
Posterior means and 95% credible intervals of explanatory variables for forest fires in the Brazilian Amazon


