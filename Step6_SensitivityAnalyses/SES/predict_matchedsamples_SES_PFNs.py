import glob
import h5py
import numpy as np
import os
import pandas as pd
from sklearn.linear_model import RidgeCV
from sklearn.model_selection import GroupKFold
from sklearn.linear_model import LinearRegression
from sklearn import preprocessing
import sys
from scipy.stats import pearsonr

"""
This script will run ridge regression. To run it, you need:

working_dir: where you want your results saved, does not have to exist, we will make it
feature_path: path to the actual features, should be a subject x features npy array
phenotype_path: path to a csv with the to-be-predicted values
phenotype_name: str of name of column in phenotype_path you want
control_path: path to csv, regress these features from the features within each fold
fold_group: in this instance, this is the ABCD train and test split, A for one group, B for the other

"""

working_dir = sys.argv[1] #'/cbica/projects/abcdfnets/scripts/keller_ridge/pennlinc-regression/example_keller/'
os.makedirs(working_dir,exist_ok=True)
feature_path = sys.argv[2]  #'/cbica/projects/abcdfnets/scripts/keller_ridge/pennlinc-regression/example_keller/tempfiles/features_0.npy'
phenotype_path = sys.argv[3] #'/cbica/projects/abcdfnets/scripts/keller_ridge/pennlinc-regression/example_keller/tempfiles/phenotypes_target.csv'
phenotype_name = sys.argv[4] #'thompson_PC1'
control_path = sys.argv[5] #'/cbica/projects/abcdfnets/scripts/keller_ridge/pennlinc-regression/example_keller/tempfiles/phenotypes_control.csv'
fold_group = 'matched_group' #sys.argv[6] # in this instance, this is the ABCD train and test split, A for one group, B for the other

"""
load the subject measures you want to control for
"""
phenotypes_control = pd.read_csv(control_path)
"""
load in all the feature weights
"""
features = np.load(feature_path)
"""
this is adapted from pennlinckit.utils.predict
"""
targets = pd.read_csv(phenotype_path)[phenotype_name].values.astype(np.float16)
fold_group = pd.read_csv(phenotype_path)[fold_group].values.astype(np.float16)
np.save('/{0}/{1}_targets.npy'.format(working_dir,phenotype_name),targets)
assert targets.shape[0] == features.shape[0]

accuracy = []
prediction = np.zeros((targets.shape))

# Split up the data into train/test based on the fold group
A = np.argwhere(fold_group==1) # <- save an index of everywhere the fold group is 1
B = np.argwhere(fold_group==2) # <- save an index of everywhere the fold group is 2
x_A = features[A]
y_A= targets[A]
x_B = features[B]
y_B = targets[B]
nuisance_A = phenotypes_control.values[A]
nuisance_B = phenotypes_control.values[B]

# Double check that the groups have no overlap
assert np.intersect1d(A,B).size==0
# Remove the unnecessary null dimension
x_A = np.squeeze(x_A)
y_A = np.squeeze(y_A)
x_B = np.squeeze(x_B)
y_B = np.squeeze(y_B)
nuisance_A=np.squeeze(nuisance_A)
nuisance_B=np.squeeze(nuisance_B)

# First train on group A and test on group B:
nuisance_model = LinearRegression() #make the nuisance model object
nuisance_model.fit(nuisance_A,x_A) #fit the nuisance_model to training data
x_A = x_A - nuisance_model.predict(nuisance_A) #remove nuisance from training data
x_B = x_B - nuisance_model.predict(nuisance_B) #remove nuisance from test data
m = RidgeCV(alphas=(1,10,100,500,1000,5000,10000,15000,20000)) #make the actual ridge model object, adding some super high reg strengths because we have so many features
m.fit(x_A,y_A) # fit the ridge model
predicted_y_B = m.predict(x_B) #apply the trained model to the test data
coefs = m.coef_.astype(np.float16)
alphas = m.alpha_

#save the results
np.save('/{0}/{1}_prediction_testB.npy'.format(working_dir,phenotype_name),predicted_y_B)
np.save('/{0}/{1}_coefs_testB.npy'.format(working_dir,phenotype_name),coefs)
np.save('/{0}/{1}_alphas_testB.npy'.format(working_dir,phenotype_name),alphas)

# Then train on group B and test on group A:
nuisance_model = LinearRegression() #make the nuisance model object
nuisance_model.fit(nuisance_B,x_B) #fit the nuisance_model to training data
x_B = x_B - nuisance_model.predict(nuisance_B) #remove nuisance from training data
x_A = x_A - nuisance_model.predict(nuisance_A) #remove nuisance from test data
m = RidgeCV(alphas=(1,10,100,500,1000,5000,10000,15000,20000)) #make the actual ridge model object, adding some super high reg strengths because we have so many features
m.fit(x_B,y_B) # fit the ridge model
predicted_y_A = m.predict(x_A) #apply the trained model to the test data
coefs = m.coef_.astype(np.float16)
alphas = m.alpha_

#save the results
np.save('/{0}/{1}_prediction_testA.npy'.format(working_dir,phenotype_name),predicted_y_A)
np.save('/{0}/{1}_coefs_testA.npy'.format(working_dir,phenotype_name),coefs)
np.save('/{0}/{1}_alphas_testA.npy'.format(working_dir,phenotype_name),alphas)

# calculate prediction accuracy and save it out
acc_testA = pearsonr(y_A, predicted_y_A)[0]
acc_testB = pearsonr(y_B, predicted_y_B)[0]
np.save('/{0}/acc_testA.npy'.format(working_dir),acc_testA)
np.save('/{0}/acc_testB.npy'.format(working_dir),acc_testB)
