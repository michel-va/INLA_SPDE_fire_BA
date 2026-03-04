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
![figure_defo](https://github.com/user-attachments/assets/0bf86a66-2286-4348-939f-1bae14a278e6)

Posterior means and 95% credible intervals of explanatory variables for deforestation fires in the Brazilian Amazon

### Forest fires 
![figure_forest](https://github.com/user-attachments/assets/a80230b4-9a50-45da-8bc2-ccfac65e795e)

Posterior means and 95% credible intervals of explanatory variables for forest fires in the Brazilian Amazon

### Agricultural fires 
![figure_agri](https://github.com/user-attachments/assets/e045725e-31c6-4dd6-86c7-7309aaa3dcd7)

Posterior means and 95% credible intervals of explanatory variables for agricultural fires in the Brazilian Amazon
