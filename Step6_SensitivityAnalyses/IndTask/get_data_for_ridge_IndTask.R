
# First load in the spatial extent of each PFN (they're in order, 1-17)
# Then merge with the same datasets as above (NIH toolbox, trauma, etc.)
pfn_sizes <- read.csv("/Users/askeller/Documents/Kellernet_PrelimAnalysis/All_PFN_sizes.csv")
# Change PFN column names so they're sensible
colnames(pfn_sizes)<-c("subjectkey","PFN1","PFN2","PFN3","PFN4","PFN5","PFN6","PFN7","PFN8","PFN9","PFN10","PFN11","PFN12","PFN13","PFN14","PFN15","PFN16","PFN17")

# Load data
nihtb<-read.table("/Users/askeller/Documents/Kellernet_PrelimAnalysis/NihTB/abcd_tbss01.txt",header=TRUE)
lmt<-read.table("/Users/askeller/Documents/Kellernet_PrelimAnalysis/Thomp/lmtp201.txt",header=TRUE)
ravlt<-read.table("/Users/askeller/Documents/Kellernet_PrelimAnalysis/Thomp/abcd_ps01.txt",header=TRUE)

# Convert factors to numeric values
nihtb$nihtbx_flanker_uncorrected <- as.numeric(nihtb$nihtbx_flanker_uncorrected)
nihtb$nihtbx_picvocab_uncorrected <- as.numeric(nihtb$nihtbx_picvocab_uncorrected)
nihtb$nihtbx_pattern_uncorrected <- as.numeric(nihtb$nihtbx_pattern_uncorrected)
nihtb$nihtbx_picture_uncorrected <- as.numeric(nihtb$nihtbx_picture_uncorrected)
nihtb$nihtbx_reading_uncorrected <- as.numeric(nihtb$nihtbx_reading_uncorrected)
nihtb$nihtbx_list_uncorrected <- as.numeric(nihtb$nihtbx_list_uncorrected)
nihtb$nihtbx_cardsort_uncorrected <- as.numeric(nihtb$nihtbx_cardsort_uncorrected)
lmt$lmt_scr_perc_correct <- as.numeric(lmt$lmt_scr_perc_correct)
ravlt$pea_ravlt_sd_trial_i_tc <- as.numeric(ravlt$pea_ravlt_sd_trial_i_tc)
ravlt$pea_ravlt_sd_trial_ii_tc <- as.numeric(ravlt$pea_ravlt_sd_trial_ii_tc)
ravlt$pea_ravlt_sd_trial_iii_tc <- as.numeric(ravlt$pea_ravlt_sd_trial_iii_tc)
ravlt$pea_ravlt_sd_trial_iv_tc <- as.numeric(ravlt$pea_ravlt_sd_trial_iv_tc)
ravlt$pea_ravlt_sd_trial_v_tc <- as.numeric(ravlt$pea_ravlt_sd_trial_v_tc)

# for RAVLT we need to generate a summed score (code borrowed from Thompson et al. 2019):
ind_pea_ravlt = c(which(names(ravlt)=="pea_ravlt_sd_trial_i_tc"),which(names(ravlt)=="pea_ravlt_sd_trial_ii_tc"),
                  which(names(ravlt)=="pea_ravlt_sd_trial_iii_tc"),which(names(ravlt)=="pea_ravlt_sd_trial_iv_tc"),
                  which(names(ravlt)=="pea_ravlt_sd_trial_v_tc")); names(ravlt)[ind_pea_ravlt]; summary(ravlt[,ind_pea_ravlt])
ravlt$RAVLT <- apply(ravlt[,ind_pea_ravlt],1,sum)



# Select out the T1 cognition
nihtb_T1 <- nihtb[nihtb$eventname=="baseline_year_1_arm_1",c("subjectkey","nihtbx_picvocab_uncorrected","nihtbx_flanker_uncorrected","nihtbx_pattern_uncorrected","nihtbx_reading_uncorrected","nihtbx_picture_uncorrected","nihtbx_list_uncorrected","nihtbx_cardsort_uncorrected")]
colnames(nihtb_T1)<-c("subjectkey","PicVocab","Flanker","Pattern","Reading","Picture","List","CardSort")
lmt_T1 <- lmt[lmt$eventname=="baseline_year_1_arm_1",c("subjectkey","lmt_scr_perc_correct")]
colnames(lmt_T1)<-c("subjectkey","LMT")
ravlt_T1 <- ravlt[ravlt$eventname=="baseline_year_1_arm_1",c("subjectkey","RAVLT")]
cog.data.T1 <- merge(nihtb_T1,lmt_T1,by="subjectkey")
cog.data.all.T1 <- merge(cog.data.T1,ravlt_T1,by="subjectkey")
cog.data.all.T1.PFNs <- merge(cog.data.all.T1,pfn_sizes,by="subjectkey")


# Load in family data
newdata<-readRDS("/Users/askeller/Documents/Kellernet_PrelimAnalysis/DEAP-data-download_ThompsonScores_ResFamIncome.rds")
newdata.baseline<-newdata[newdata$event_name=="baseline_year_1_arm_1",]
colnames(newdata.baseline)[1]<-"subjectkey"
all.data <- merge(cog.data.all.T1.PFNs,newdata.baseline[,c("subjectkey", setdiff(colnames(newdata.baseline),colnames(pfn_sizes)))],by="subjectkey")


# Remove subjects based on the following criteria:
## 1) 8min of retained TRs (600 TRs)
## 2) ABCD Booleans for rest and T1
num_TRs <- read.csv("/Users/askeller/Documents/Kellernet_PrelimAnalysis/num_TRs_by_subj_redo.csv")
data<-merge(all.data,num_TRs,by="subjectkey")
data.clean<-data[data$numTRs>=600,]

# Remove participants based on booleans from ABCD
abcd_imgincl01 <- read.csv("/Users/askeller/Documents/Kellernet_PrelimAnalysis/abcd_imgincl01.csv")
abcd_imgincl01 <- abcd_imgincl01[abcd_imgincl01$eventnam=="baseline_year_1_arm_1",]
abcd_imgincl01 <- abcd_imgincl01[!abcd_imgincl01$visit=="",] 
abcd_imgincl01 <- abcd_imgincl01[abcd_imgincl01$imgincl_t1w_include==1,] 
abcd_imgincl01 <- abcd_imgincl01[abcd_imgincl01$imgincl_rsfmri_include==1,]
combined.data <- merge(data.clean,abcd_imgincl01[, c("subjectkey",'imgincl_t1w_include')],by="subjectkey") 


# Add in Family and Site covariates
# Remember to add in this variable about family structure so we can use it as a covariate
family <-read.table("/Users/askeller/Documents/Kellernet_PrelimAnalysis/ses/acspsw03.txt",header=TRUE)
family.baseline<-family[family$eventname=="baseline_year_1_arm_1",]
abcd.data.almost <- merge(combined.data,family.baseline[, c("subjectkey", setdiff(colnames(family.baseline),colnames(combined.data)))],by="subjectkey")

# also add in the variable for site ID to use as a covariate
site_info <- readRDS("/Users/askeller/Documents/Kellernet_PrelimAnalysis/DEAP-siteID.rds")
site.baseline<-site_info[site_info$event_name=="baseline_year_1_arm_1",]
colnames(site.baseline)[1]<-"subjectkey"
abcd.data.almost2 <- merge(abcd.data.almost,site.baseline[,c("subjectkey", setdiff(colnames(site.baseline),colnames(abcd.data.almost)))],by="subjectkey")

# Add mean FD
meanFD <- read.csv("/Users/askeller/Documents/Kellernet_PrelimAnalysis/PFN_Gradients_CombinedScript/getFD/meanFD_031822.csv")
colnames(meanFD)<-c("subjectkey","meanFD")
meanFD$subjectkey <- gsub(pattern="sub-NDAR",replacement="NDAR_", meanFD$subjectkey)
abcd.data <- merge(abcd.data.almost2,meanFD,by="subjectkey")

# Subset the participants to be the same as those in the main text:
subj_to_use <- read.csv("/Users/askeller/Documents/Kellernet_PrelimAnalysis/Keller_PFNsCognition_Codebase_Revision/Step6_SensitivityAnalyses/IndTask/subj_to_use.csv")
abcd.data.use <- merge(abcd.data,subj_to_use,by="subjectkey")

# Load train/test split from UMinn
traintest<-read_tsv("/Users/askeller/Documents/Kellernet_PrelimAnalysis/participants.tsv")
traintest.baseline<-traintest[traintest$session_id=="ses-baselineYear1Arm1",c("participant_id","matched_group")]
colnames(traintest.baseline)[1]<-c("subjectkey")
traintest.baseline$subjectkey <- gsub(pattern="sub-NDAR",replacement="NDAR_", traintest.baseline$subjectkey)
traintest.baseline<-traintest.baseline %>% distinct()
abcd.data.traintest <- merge(abcd.data.use,traintest.baseline,by="subjectkey")
abcd.data.train <- abcd.data.traintest[abcd.data.traintest$matched_group==1,]
abcd.data.test <- abcd.data.traintest[abcd.data.traintest$matched_group==2,]
abcd.data.for.ridge<-abcd.data.traintest[,c("subjectkey","PicVocab","Flanker","Pattern","Reading","Picture","List","CardSort","LMT","RAVLT","matched_group","interview_age","sex","meanFD","abcd_site","rel_family_id")]
abcd.data.for.ridge.complete<-abcd.data.for.ridge[complete.cases(abcd.data.for.ridge),]

write.csv(abcd.data.for.ridge.complete,"/Users/askeller/Documents/Kellernet_PrelimAnalysis/Keller_PFNsCognition_Codebase_Revision/Step6_SensitivityAnalyses/IndTask/data_for_ridge_IndTask.csv")
