

library(gifti)
library(R.matlab)
library(RNifti)
library(ciftiTools)
ciftiTools.setOption('wb_path', '/Users/askeller/Documents/workbench/')
library(ggplot2)

PFNs_hardparcel<-read_cifti('/Users/askeller/Documents/Kellernet_PrelimAnalysis/hardparcel_group.dscalar.nii')
map_predacc_PC1_lh <- PFNs_hardparcel$data$cortex_left
map_predacc_PC1_rh <- PFNs_hardparcel$data$cortex_right
map_predacc_PC2_lh <- PFNs_hardparcel$data$cortex_left
map_predacc_PC2_rh <- PFNs_hardparcel$data$cortex_right
map_predacc_PC3_lh <- PFNs_hardparcel$data$cortex_left
map_predacc_PC3_rh <- PFNs_hardparcel$data$cortex_right

pred_acc <- readMat('/Users/askeller/Documents/Kellernet_PrelimAnalysis/pred_acc_by_PFN.mat');
pred_acc <- pred_acc$Rvals.byPFN

for (PFN in 1:17) {
    map_predacc_PC1_lh[map_predacc_PC1_lh==PFN,1]=pred_acc[PFN,1]
    map_predacc_PC2_lh[map_predacc_PC2_lh==PFN,1]=pred_acc[PFN,2]
    map_predacc_PC3_lh[map_predacc_PC3_lh==PFN,1]=pred_acc[PFN,3]
    
    map_predacc_PC1_rh[map_predacc_PC1_rh==PFN,1]=pred_acc[PFN,1]
    map_predacc_PC2_rh[map_predacc_PC2_rh==PFN,1]=pred_acc[PFN,2]
    map_predacc_PC3_rh[map_predacc_PC3_rh==PFN,1]=pred_acc[PFN,3]
}

PFNs_hardparcel_PredAccPC1 <- PFNs_hardparcel
PFNs_hardparcel_PredAccPC2 <- PFNs_hardparcel
PFNs_hardparcel_PredAccPC3 <- PFNs_hardparcel

PFNs_hardparcel_PredAccPC1$data$cortex_left <- map_predacc_PC1_lh
PFNs_hardparcel_PredAccPC1$data$cortex_right <- map_predacc_PC1_rh
PFNs_hardparcel_PredAccPC2$data$cortex_left <- map_predacc_PC2_lh
PFNs_hardparcel_PredAccPC2$data$cortex_right <- map_predacc_PC2_rh
PFNs_hardparcel_PredAccPC3$data$cortex_left <- map_predacc_PC3_lh
PFNs_hardparcel_PredAccPC3$data$cortex_right <- map_predacc_PC3_rh

write_cifti(PFNs_hardparcel_PredAccPC1,'/Users/askeller/Documents/Kellernet_PrelimAnalysis/PFNs_PredAccPC1')
write_cifti(PFNs_hardparcel_PredAccPC2,'/Users/askeller/Documents/Kellernet_PrelimAnalysis/PFNs_PredAccPC2')
write_cifti(PFNs_hardparcel_PredAccPC3,'/Users/askeller/Documents/Kellernet_PrelimAnalysis/PFNs_PredAccPC3')



