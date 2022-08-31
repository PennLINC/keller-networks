import numpy as np
from scipy.io import savemat

PC1_testA=np.load('/Users/askeller/Documents/Kellernet_PrelimAnalysis/RidgeResults/results_matchedsamples_081822/all_network/thompson_PC1_coefs_testA.npy')
mdic={"PC1_testA": PC1_testA}
savemat('/Users/askeller/Documents/Kellernet_PrelimAnalysis/RidgeResults/results_matchedsamples_081822/all_network/thompson_PC1_coefs_testA.mat',mdic)

PC2_testA=np.load('/Users/askeller/Documents/Kellernet_PrelimAnalysis/RidgeResults/results_matchedsamples_081822/all_network/thompson_PC2_coefs_testA.npy')
mdic={"PC2_testA": PC2_testA}
savemat('/Users/askeller/Documents/Kellernet_PrelimAnalysis/RidgeResults/results_matchedsamples_081822/all_network/thompson_PC2_coefs_testA.mat',mdic)

PC3_testA=np.load('/Users/askeller/Documents/Kellernet_PrelimAnalysis/RidgeResults/results_matchedsamples_081822/all_network/thompson_PC3_coefs_testA.npy')
mdic={"PC3_testA": PC3_testA}
savemat('/Users/askeller/Documents/Kellernet_PrelimAnalysis/RidgeResults/results_matchedsamples_081822/all_network/thompson_PC3_coefs_testA.mat',mdic)


PC1_testB=np.load('/Users/askeller/Documents/Kellernet_PrelimAnalysis/RidgeResults/results_matchedsamples_081822/all_network/thompson_PC1_coefs_testB.npy')
mdic={"PC1_testB": PC1_testB}
savemat('/Users/askeller/Documents/Kellernet_PrelimAnalysis/RidgeResults/results_matchedsamples_081822/all_network/thompson_PC1_coefs_testB.mat',mdic)

PC2_testB=np.load('/Users/askeller/Documents/Kellernet_PrelimAnalysis/RidgeResults/results_matchedsamples_081822/all_network/thompson_PC2_coefs_testB.npy')
mdic={"PC2_testB": PC2_testB}
savemat('/Users/askeller/Documents/Kellernet_PrelimAnalysis/RidgeResults/results_matchedsamples_081822/all_network/thompson_PC2_coefs_testB.mat',mdic)

PC3_testB=np.load('/Users/askeller/Documents/Kellernet_PrelimAnalysis/RidgeResults/results_matchedsamples_081822/all_network/thompson_PC3_coefs_testB.npy')
mdic={"PC3_testB": PC3_testB}
savemat('/Users/askeller/Documents/Kellernet_PrelimAnalysis/RidgeResults/results_matchedsamples_081822/all_network/thompson_PC3_coefs_testB.mat',mdic)