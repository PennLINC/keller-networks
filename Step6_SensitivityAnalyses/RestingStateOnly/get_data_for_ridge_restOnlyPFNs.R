
library(tidyr)
library(dplyr)
library(readr)

# First load in the spatial extent of each PFN (they're in order, 1-17)
# Then merge with the same datasets as above (NIH toolbox, trauma, etc.)
pfn_sizes <- read.csv("/Users/askeller/Documents/Kellernet_PrelimAnalysis/All_PFN_sizes_Rest_082122.csv")
# Change PFN column names so they're sensible
colnames(pfn_sizes)<-c("subjectkey","PFN1","PFN2","PFN3","PFN4","PFN5","PFN6","PFN7","PFN8","PFN9","PFN10","PFN11","PFN12","PFN13","PFN14","PFN15","PFN16","PFN17")


# Load data
newdata<-readRDS("/Users/askeller/Documents/Kellernet_PrelimAnalysis/DEAP-data-download_ThompsonScores_ResFamIncome.rds")
newdata.baseline<-newdata[newdata$event_name=="baseline_year_1_arm_1",]
colnames(newdata.baseline)[1]<-"subjectkey"
all.data <- merge(pfn_sizes,newdata.baseline[,c("subjectkey", setdiff(colnames(newdata.baseline),colnames(pfn_sizes)))],by="subjectkey")



# Remove subjects based on the following criteria:
## 1) 8min of retained TRs (600 TRs)
## 2) ABCD Booleans for rest and T1
num_TRs <- read.csv("/Users/askeller/Documents/Kellernet_PrelimAnalysis/num_TRs_by_subj_redo.csv")
data<-merge(all.data,num_TRs,by="subjectkey")
data.clean<-data[data$numTRs>=600,] # we go from 7,493 to 7,245 at this step

# Remove participants based on booleans from ABCD
abcd_imgincl01 <- read.csv("/Users/askeller/Documents/Kellernet_PrelimAnalysis/abcd_imgincl01.csv")
abcd_imgincl01 <- abcd_imgincl01[abcd_imgincl01$eventnam=="baseline_year_1_arm_1",]
abcd_imgincl01 <- abcd_imgincl01[!abcd_imgincl01$visit=="",] # start here with 11,663
abcd_imgincl01 <- abcd_imgincl01[abcd_imgincl01$imgincl_t1w_include==1,] # down to 11,124
abcd_imgincl01 <- abcd_imgincl01[abcd_imgincl01$imgincl_rsfmri_include==1,] # down to 9,388

combined.data <- merge(data.clean,abcd_imgincl01[, c("subjectkey",'imgincl_t1w_include')],by="subjectkey") # n=5,969


# for simplicity, rename thompson variables
colnames(combined.data)<-gsub("neurocog_pc1.bl","thompson_PC1",colnames(combined.data))
colnames(combined.data)<-gsub("neurocog_pc2.bl","thompson_PC2",colnames(combined.data))
colnames(combined.data)<-gsub("neurocog_pc3.bl","thompson_PC3",colnames(combined.data))

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


# Load train/test split from UMinn
traintest<-read_tsv("/Users/askeller/Documents/Kellernet_PrelimAnalysis/participants.tsv")
traintest.baseline<-traintest[traintest$session_id=="ses-baselineYear1Arm1",c("participant_id","matched_group")]
colnames(traintest.baseline)[1]<-c("subjectkey")
traintest.baseline$subjectkey <- gsub(pattern="sub-NDAR",replacement="NDAR_", traintest.baseline$subjectkey)
traintest.baseline<-traintest.baseline %>% distinct()
abcd.data.traintest <- merge(abcd.data,traintest.baseline,by="subjectkey")
abcd.data.train <- abcd.data.traintest[abcd.data.traintest$matched_group==1,]
abcd.data.test <- abcd.data.traintest[abcd.data.traintest$matched_group==2,]


abcd.data.for.ridge<-abcd.data.traintest[,c("subjectkey","thompson_PC1","thompson_PC2","thompson_PC3","matched_group","interview_age","sex","meanFD","abcd_site","rel_family_id")]
abcd.data.for.ridge.complete<-abcd.data.for.ridge[complete.cases(abcd.data.for.ridge),]

write.csv(abcd.data.for.ridge.complete,"/Users/askeller/Documents/Kellernet_PrelimAnalysis/data_for_ridge_Rest_082122.csv")

# 
# dim(abcd.data.traintest)
# dim(abcd.data.traintest[complete.cases(abcd.data.traintest$PFN1),])
# 
# 
# test<-merge(abcd.data.for.ridge.complete,pfn_sizes[,c("subjectkey","PFN1")],by="subjectkey")
# 
# 
# 
# 
