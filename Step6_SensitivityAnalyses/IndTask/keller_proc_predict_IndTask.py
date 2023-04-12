import sys
import os

homedir = sys.argv[1]
tmpdir = sys.argv[2]
network = sys.argv[3]
phenotype_name = sys.argv[4]

"""
this makes the features and targets in tmpdir
"""
os.system('python /{0}/preprocess_IndTask.py {1} {2}'.format(homedir,network,tmpdir))

working_dir = homedir + '/results_IndTask/{0}_network/'.format(network)
feature_path = '/{0}/features_{1}.npy'.format(tmpdir,network)
phenotype_path = '/{0}/phenotypes_target.csv'.format(tmpdir)
control_path = '/{0}/phenotypes_control.csv'.format(tmpdir)

"""
this does the actual ridge regression
"""
os.system('python /{0}/predict_matchedsamples.py {1} {2} {3} {4} {5} rel_family_id'.format(homedir,working_dir,feature_path,phenotype_path,phenotype_name,control_path))
