

library(gifti)
library(R.matlab)
library(RNifti)
library(ciftiTools)
ciftiTools.setOption('wb_path', '/Users/askeller/Documents/workbench/')
library(ggplot2)

PFNs_hardparcel<-read_cifti('/Users/askeller/Documents/Kellernet_PrelimAnalysis/hardparcel_group.dscalar.nii')
map_SArank_lh <- PFNs_hardparcel$data$cortex_left
map_SArank_rh <- PFNs_hardparcel$data$cortex_right

SArank_byPFN <- read.csv('/Users/askeller/Documents/Kellernet_PrelimAnalysis/SpinTests/SArank_by_PFN.csv');
SArank_byPFN <- SArank_byPFN$meanRank

for (PFN in 1:17) {
  map_SArank_lh[map_SArank_lh==PFN,1]=SArank_byPFN[PFN]
  map_SArank_rh[map_SArank_rh==PFN,1]=SArank_byPFN[PFN]
}

PFNs_hardparcel_SArank <- PFNs_hardparcel

PFNs_hardparcel_SArank$data$cortex_left <- map_SArank_lh
PFNs_hardparcel_SArank$data$cortex_right <- map_SArank_rh

write_cifti(PFNs_hardparcel_SArank,'/Users/askeller/Documents/Kellernet_PrelimAnalysis/PFNs_hardparcel_SArank')



