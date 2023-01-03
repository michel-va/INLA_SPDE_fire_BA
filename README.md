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
![deforestation](https://user-images.githubusercontent.com/84012797/210445292-c85eeea2-4ab6-4832-bbec-6bd7cf96684c.png)

Posterior means and 95% credible intervals of explanatory variables for deforestation fires in the Brazilian Amazon

### Forest fires 
![forest](https://user-images.githubusercontent.com/84012797/210445308-289b64ac-0845-4399-ae26-c35a92dbf88b.png)

Posterior means and 95% credible intervals of explanatory variables for forest fires in the Brazilian Amazon

### Agricultural fires 
![agri](https://user-images.githubusercontent.com/84012797/210445337-55083612-c1b8-4b12-965e-35f8f313a318.png)

Posterior means and 95% credible intervals of explanatory variables for agricultural fires in the Brazilian Amazon
