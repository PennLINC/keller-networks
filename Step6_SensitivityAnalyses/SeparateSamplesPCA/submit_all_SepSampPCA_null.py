import os
import sys
import numpy as np
"""
this is the only script you actually should call, it will submit a job
this job makes the features, and then does the regression. 
only change the home_dir variable, everything else should run! 
"""

homedir = '/cbica/projects/abcdfnets/scripts/keller_ridge/pennlinc-regression/example_keller' #sys.argv[1] #'/cbica/projects/abcdfnets/scripts/keller_ridge/pennlinc-regression/example_keller/'

tmpdir = '/cbica/projects/abcdfnets/scripts/keller_ridge/pennlinc-regression/example_keller/tempfiles_SepSampPCA_null/' #os.environ['TMPDIR']
networks = np.array(['all']) 
network = 'all'

GB = '200G'    

for cog_score in ['SepSampPC1','SepSampPC2','SepSampPC3']:
        os.system('qsub -l h_vmem={0},s_vmem={0} -N {1} -R y -V -j y -b y -o ~/sge/ -e ~/sge/ python {2}/keller_proc_predict_SepSampPCA_null.py {2} {3} {4} {5}'.format(GB,cog_score,homedir,tmpdir,network,cog_score))
