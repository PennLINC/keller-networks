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
hi. this is going to run ridge regression, you basically just need:

working_dir: where you want your results saved, does not have to exist, we will make it
feature_path: path to the actual features, should be a subject x features npy array
phenotype_path: path to a csv with the to-be-predicted values
phenotype_name: str of name of column in phenotype_path you want
control_path: path to csv, regress these features from the features within each fold
fold_group: in this instance, this is the ABCD train and test split, A for one group, B for the other
"""
folds = 100 #in this instance, this is how many times we want to run the model 
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
features = np.load(feature_path).astype(np.float16)
"""
this is adapted from pennlinckit.utils.predict
"""
targets = pd.read_csv(phenotype_path)[phenotype_name].values.astype(np.float16)
fold_group = pd.read_csv(phenotype_path)[fold_group].values.astype(np.float16)
np.save('/{0}/{1}_targets.npy'.format(working_dir,phenotype_name),targets)
assert targets.shape[0] == features.shape[0]

#groups predefined
A = np.argwhere(fold_group==1)#[0] <-ASK removed this so we save an index of everywhere the fold group is 1
B = np.argwhere(fold_group==2)#[0]
assert np.intersect1d(A,B).size==0

accuracy = []
accuracy_null = []

for fold in np.arange(folds):
	#prediction = np.zeros((targets.shape))
	#sample with replacement
	#what is the range of prediction accuracies across samples with replacement (similar to Merek paper) - like a 95% CI
	random_vector_A = np.random.choice(range(A.shape[0]),A.shape[0],replace=True) # make sure that we are not putting the same subj in multiple folds
	random_vector_B = np.random.choice(range(B.shape[0]),B.shape[0],replace=True)
	#split up in to train/test (ie A/B) and then sample with replacement from above
	x_A = features[A][random_vector_A] # always the features of group A 
	y_A= targets[A][random_vector_A]     
	x_B = features[B][random_vector_B]
	y_B = targets[B][random_vector_B]
	# ASK added this line to make sure the groups have no overlap
	#assert np.intersect1d(A[random_vector_A],B[random_vector_B]).size==0
	nuisance_A = phenotypes_control.values[A][random_vector_A]
	nuisance_B = phenotypes_control.values[B][random_vector_B]
	# ASK added to remove the null dimension
	x_A = np.squeeze(x_A)
	y_A = np.squeeze(y_A)
	x_B = np.squeeze(x_B)
	y_B = np.squeeze(y_B)
	nuisance_A=np.squeeze(nuisance_A)
	nuisance_B=np.squeeze(nuisance_B)
	#do A>B first
	nuisance_model = LinearRegression() #make the nuisance model object
	nuisance_model.fit(nuisance_A,x_A) #fit the nuisance_model to training data
	x_A = x_A - nuisance_model.predict(nuisance_A) #remove nuisance from training data
	x_B = x_B - nuisance_model.predict(nuisance_B) #remove nuisance from test data
	m_a = RidgeCV(alphas=(1,10,100,500,1000,5000,10000,15000,20000)) #make the actual ridge model object, adding some super high reg strengths because we have so many features
	m_a.fit(x_A,y_A) # fit the ridge model
	predicted_y_B = m_a.predict(x_B) #apply the trained model to the test data, save the result # prediction[B][[random_vector_B]]
	# ASK changed how the prediction is saved out, since some subjects might be duplicated in the random resampling with replacement
	#do B>A 
	#nuisance_model = LinearRegression() #make the nuisance model object
	#nuisance_model.fit(nuisance_B,x_B) #fit the nuisance_model to training data
	#x_B = x_B - nuisance_model.predict(nuisance_B) #remove nuisance from training data
	#x_A = x_A - nuisance_model.predict(nuisance_A) #remove nuisance from test data
	m_b = RidgeCV(alphas=(1,10,100,500,1000,5000,10000,15000,20000)) #make the actual ridge model object, adding some super high reg strengths because we have so many features
	m_b.fit(x_B,y_B) # fit the ridge model
	predicted_y_A = m_b.predict(x_A) #apply the trained model to the test data, save the result
	# calculate prediction accuracy and save it out
	acc = pearsonr(np.concatenate((y_A,y_B)), np.concatenate((predicted_y_A,predicted_y_B)))[0] #ASK changed this line so that now we concatenate the subjects from group A and group B and do a correlation to get the prediction accuracy
	#acc = pearsonr(prediction,targets)[0]
	accuracy.append(acc)
	# ASK adding one step here so that this script generates a null distribution for predict_boot. This will shuffle the outcome variable (actual y-values) before computing the correlation between actual and predicted to get the accuracy.
	y_A_null = random.sample(y_A,len(y_A))
	y_B_null = random.sample(y_B,len(y_B))
	acc_null = pearsonr(np.concatenate((y_A_null,y_B_null)), np.concatenate((predicted_y_A,predicted_y_B)))[0] 
	accuracy_null.append(acc_null)
np.save('/{0}/{1}_acc_boot.npy'.format(working_dir,phenotype_name),accuracy)
np.save('/{0}/{1}_acc_null.npy'.format(working_dir,phenotype_name),accuracy_null)
