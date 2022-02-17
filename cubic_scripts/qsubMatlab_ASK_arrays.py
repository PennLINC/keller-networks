import numpy as np
from scipy.stats import pearsonr
from sklearn.linear_model import RidgeCV
from sklearn.model_selection import KFold
from sklearn.neural_network import MLPRegressor
from sklearn.linear_model import LinearRegression, LogisticRegression
import subprocess
import os
import pickle
import copy
def get_sge_task_id():
  sge_task_id = subprocess.check_output(['echo $SGE_TASK_ID'],shell=True).decode()
  return int(sge_task_id)
my_file = open("/cbica/projects/abcdfnets/scripts/combined_PFNs_PGs/subjects_from_manifest_01_28_22.txt", "r")
content = my_file.read()
content_list = content. split("\n")
content_list.pop()
subjects = content_list
subject = subjects[get_sge_task_id()]
#os.environ["subject"]=str(subject)
#cmd = "set subject = " subject ""
#os.system(cmd)
print(subject)
cmd = '''matlab -nodisplay -r "preProc_PFNs_PGs_Delete('{}')"'''.format(subject)
print(cmd)
os.system(cmd)
