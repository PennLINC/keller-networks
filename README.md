# keller-networks
This code is used to conduct analyses in ABCD data relating personalized functional network (PFN) functional topography to cognition, as a replication and extension of Cui et al. 2020.
This pipeline will expect that PFNs have already been generated for each participant using NMF. Details and code to accomplish this are documented at https://github.com/ZaixuCui/pncSingleFuncParcel

## Step 1: Associations between total cortical representation and general cognition (Figure 2)

### 1.1	Calculate total cortical representation

Use calculate_PFN_size.m to take the output of the PFNs derivation (NMF) and calculate the total cortical representation (PFN “size”) as the sum of loadings for each PFN.

### 1.2	Stats+Plotting

Use the Rmarkdown Associations_PFN_Cognition.Rmd to compute associations between total cortical representation and general cognition and generate figures that replicate Cui et al. (2020). This file will also produce a demographics table. Note that data must be downloaded from NDA/DEAP prior to running this Rmarkdown. 

## Step 2: Ridge Regression

### 2.1	Setup

Use the function get_data_for_ridge.R to prepare a csv file that will be used to conduct the ridge regression. The steps taken here for data cleaning will resemble those in the code for step 1.

### 2.2	Ridge Regression with Matched Samples

Here we will train and test ridge regression models using PFN topography to predict cognitive performance across three domains (General Cognition, Executive Function, and Learning/Memory). These three domains are also referred to as Thompson PC1, Thompson PC2, and Thompson PC3, respectively.

Use the function submit.py to submit CUBIC jobs that will run the ridge regressions using each PFN independently. This will run the wrapper called keller_proc_predict.py, which will call the preprocessing script (preprocess.py) followed by the ridge regression script (predict_matchedsamples.py). 

We also want to run ridge regressions using all the PFNs together (vertex-wise loadings for each PFN are concatenated). To do so, use submit_all.py. Note that these CUBIC jobs need a lot more power than for the independent PFN models so the GB request is higher.

This “matched samples” version of the ridge regressions will train on one sub-sample of the ABCD data (also referred to as the “Discovery” sub-sample) and test on the other (also referred to as the “Replication” sub-sample), and vice versa. Covariates for age, sex, motion, and ABCD site are regressed out of these models.

NOTE: If you want to change the output directories for all the results to land in, change the “homedir” variable and “tempdir” variables in the submit.py or submit_all.py scripts, and change the “workingdir” in the keller_proc_predict.py wrapper script. The homedir is meant to be the outermost folder containing the scripts, results folder, and temporary files folder. The tempdir folder will store intermediate files used during the process (I like to save everything out to check, but they’re considered “temp” because they can be deleted afterward if needed). The workingdir folder is the results directory, which will auto populate with folders for each PFN. Because python likes to 0-index, the folders will be labeled “0_network”… “16_network” and there will be a folder for “all_network” containing the results of submit_all.py. 

### 2.2	Ridge Regression with Matched Samples – Null Distribution

Next we will generate a null distribution by running the same ridge regression models as above with the outcome variable shuffled. This is currently set up to run 100 iterations and takes about 40hrs to run. The file structure is exactly the same as for the regular matched samples version (but is currently ONLY being run on the “all_network” version, not the individual PFN models), and uses the following files: submit_all_null.py, keller_proc_predict_null.py, predict_matchedsamples_null.py. The preprocess.py script does not change. 

### 2.3	Ridge Regression with Bootstrapping

Next we will test whether our matched samples split is a good one, by generating a distribution of prediction accuracies across 100 bootstraps, each time generating a random train/test split. This also takes about 40hrs to run. The file structure is exactly the same as for the regular matched samples version (but is currently ONLY being run on the “all_network” version, not the individual PFN models), and uses the following files: submit_all_boot.py, keller_proc_predict_boot.py, predict_matchedsamples_bootstrap.py. The preprocess.py script does not change. 


### 2.4	Ridge Regression with Bootstrapping – Null Distribution

Next we will generate a null distribution for the bootstrapped version of the ridge regressions. As before, this will save prediction accuracies across 100 bootstraps, each time generating a random train/test split AND shuffling the outcome variable. This also takes about 40hrs to run. The file structure is exactly the same as for the regular matched samples version (but is currently ONLY being run on the “all_network” version, not the individual PFN models), and uses the following files: submit_all_boot_null.py, keller_proc_predict_boot_null.py, predict_matchedsamples_bootstrap_null.py. The preprocess.py script does not change. 


## Step 3: Results of ridge regression models and plotting (Figures 3 and 4)

### 3.1	Scatterplots and histograms (In Figure 3 Panel A and B, and Figure 4 Panels A, B, E and F).
Use the results of the ridge regression models to plot scatterplots and histograms using compare_predicted_actual_matchedsamples.m. 

### 3.2	Bar plots of prediction accuracy by PFN (Figure 3 Panel C and Figure 4 Panels C,G)
Use the script pred_acc_by_PFN.m to save out R values by PFN and to generate bar plots of the prediction accuracy by PFN (from the individual network models). 

### 3.3	Brain maps of prediction accuracy  (Figure 3 Panel D and Figure 4 Panels D,H)
Use the script pred_acc_by_PFN_workbench.R to take the results from pred_acc_by_PFN.m and convert them to .dscalar.nii files that can be read in by Connectome Workbench for plotting the brainmaps. 


## Step 4: Association between prediction accuracy and S-A axis rank (Figure 5)


### 4.1	Spin tests

Run spin tests to spatially permute the S-A axis labels. First use convert_SAranks_gii_to_csv.R to get the S-A axis ranks by vertex into the proper format, and then run SpinTests_ABCD.m to do the spin tests (this calls on Aaron Alexander-Bloch’s code with SpinPermuFS). 

### 4.2	Stats+Plotting

Next, use the Rmarkdown SA_rank_by_PFN_spins.Rmd to do the statistics and make plots of the relationship between S-A axis rank and prediction accuracy by PFN.


## Step 5: Sum Of Weights (Supplementary Figure 2)

### 5.1	Transform the coefficients from the ridge regression with matched samples to a sum of weights (Python to Matlab)
To recreate Cui et al. (2020)’s Figure 7C showing the sum of model weights by network, you’ll need the output from the ridge regression with matched samples. First, convert the coefs file (e.g. thompson_PC1_coefs_testA.npy) to a .mat file so that Matlab can read it using convert_numpy_arrays_to_mats.py and then use transform_model_coefficients_to_sum_weights.m to transform these coefficients to the sum of weights that we will use for plotting. Note that these scripts are set up to transform 6 files (3 cognitive domains x 2 matched samples)

### 5.2	Plot the sum of weights by PFN as a bar plot for each matched sample and each cognitive domain (Matlab to R)
The Rmarkdown file Cui2020Rep_SumWeightsBarPlots.Rmd walks through the plotting for each of the 6 files above (3 cognitive domains x 2 matched samples). The resultant bar plots will show the sum of weights by PFN. 


## Step 6: Sensitivity Analyses
All code for sensitivity analyses can be found in "Step6_SensitivityAnalyses"

### Individual Task: 
The goal of this analysis is to see how well our ridge regression models trained on the multivariate pattern of PFN topography predict cognitive perofrmance in individual tasks (rather than broad cognitive domains derived from dimensionality reduction). This code will therefore train ridge regression models on PFN topography to predict performance on individual cognitive tasks. The workflow is exactly the same as section 2.1 (get_data_for_ridge_IndTask.R to prepare the data for the ridge regressions), section 2.2 (perform ridge regresison using submit_all_IndTask.py which will call keller_proc_predict_IndTask.py which will call preprocess_IndTask.py), and section 3.1 (compare_predicted_actual_IndTask.m to see the results). 

### Separate Samples PCA: 
The goal of this analysis is to confirm that our ridge regression models trianed on the multivariate pattern of PFN topography can still predict cognition across the three broad domains when the cognitive PCA scores are derived separately in the discovery and replicaiton samples. Again, the workflow is very similar to those used above:
1. Use SeparateSamplesCognitionPCA.Rmd to derive the cognitive PCA scores separately in the discovery and replication samples. This will create a data_for_ridge file that will be used for the ridge regression models.
2. Use submit_all_SepSampPCA.py to run the ridge regression on the matched samples in the same manner as above (this will call keller_proc_predict_SepSampPCA.py which will call preprocess_SepSampPCA.py)
3. To run these same ridge regressions on individual PFNs rather than all PFNs together, use submit_SepSampPCA.py
4. To get null distributions (like in section 2.2 above), run submit_all_SepSampPCA_null.py which will call keller_proc_predict_SepSampPCA_null.py
5. To visualize the results for the model trained on all PFNs, use /Step3_RidgeRegressionPlotting/compare_predicted_actual_matchedsamples.m
6. To visualize the results for each individual PFN, use SepSamp_pred_acc_by_PFN.m followed by SepSamp_pred_acc_by_PFN_workbench.R.

### SES: 
The goal of this analysis is to train two ridge regression models: the first is trained only on areal deprivation index and the second is trained on both areal deprivation index and PFN topography together. 

### Resting State Only: 
Performs ridge regression analyses and univariate association analyses using only the data from resting-state scans

### Size By Pred Acc: 
Compares the size of each PFN to prediction accuracy

### Split Half Reliability: 
Computes the split-half reliability of PFN topography in a subset of participants

### Psychotropic Medication Use: 
Sensitivity analyses controlling for psychotropic medication use can be found in "/Step1_TotalCorticalRepresentation/Associations_PFN_Cognition.Rmd"
