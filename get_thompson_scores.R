
# Load data
nihtb<-read.table("/Users/ariellekeller/Documents/Kellernet_PrelimAnalysis/NihTB/abcd_tbss01.txt",header=TRUE)
nihtb.baseline<-nihtb[nihtb$eventname=="baseline_year_1_arm_1",]
lmt<-read.table("/Users/ariellekeller/Documents/Kellernet_PrelimAnalysis/Thomp/lmtp201.txt",header=TRUE)
lmt.baseline<-lmt[lmt$eventname=="baseline_year_1_arm_1",]
merged.data2 <- merge(nihtb.baseline,lmt.baseline[, c("subjectkey", setdiff(colnames(lmt.baseline),colnames(nihtb.baseline)))],by="subjectkey")
ravlt<-read.table("/Users/ariellekeller/Documents/Kellernet_PrelimAnalysis/Thomp/abcd_ps01.txt",header=TRUE)
ravlt.baseline<-ravlt[ravlt$eventname=="baseline_year_1_arm_1",]
combined.data <- merge(merged.data2,ravlt.baseline[, c("subjectkey", setdiff(colnames(ravlt.baseline),colnames(merged.data2)))],by="subjectkey")

# Coerce data types
combined.data$nihtbx_flanker_uncorrected <- as.numeric(combined.data$nihtbx_flanker_uncorrected)
combined.data$nihtbx_picvocab_uncorrected <- as.numeric(combined.data$nihtbx_picvocab_uncorrected)
combined.data$nihtbx_list_uncorrected <- as.numeric(combined.data$nihtbx_list_uncorrected)
combined.data$nihtbx_pattern_uncorrected <- as.numeric(combined.data$nihtbx_pattern_uncorrected)
combined.data$nihtbx_cardsort_uncorrected <- as.numeric(combined.data$nihtbx_cardsort_uncorrected)
combined.data$nihtbx_picture_uncorrected <- as.numeric(combined.data$nihtbx_picture_uncorrected)
combined.data$nihtbx_reading_uncorrected <- as.numeric(combined.data$nihtbx_reading_uncorrected)
combined.data$lmt_scr_perc_correct <- as.numeric(combined.data$lmt_scr_perc_correct)
combined.data$pea_ravlt_sd_trial_i_tc <- as.numeric(combined.data$pea_ravlt_sd_trial_i_tc)
combined.data$pea_ravlt_sd_trial_ii_tc <- as.numeric(combined.data$pea_ravlt_sd_trial_ii_tc)
combined.data$pea_ravlt_sd_trial_iii_tc <- as.numeric(combined.data$pea_ravlt_sd_trial_iii_tc)
combined.data$pea_ravlt_sd_trial_iv_tc <- as.numeric(combined.data$pea_ravlt_sd_trial_iv_tc)
combined.data$pea_ravlt_sd_trial_v_tc <- as.numeric(combined.data$pea_ravlt_sd_trial_v_tc)
combined.data$interview_age <- as.numeric(combined.data$interview_age)

ind_pea_ravlt = c(which(names(combined.data)=="pea_ravlt_sd_trial_i_tc"),which(names(combined.data)=="pea_ravlt_sd_trial_ii_tc"),
                  which(names(combined.data)=="pea_ravlt_sd_trial_iii_tc"),which(names(combined.data)=="pea_ravlt_sd_trial_iv_tc"),
                  which(names(combined.data)=="pea_ravlt_sd_trial_v_tc")); names(combined.data)[ind_pea_ravlt]; summary(combined.data[,ind_pea_ravlt])
combined.data$pea_ravlt_ld = apply(combined.data[,ind_pea_ravlt],1,sum)

combined.data$pea_ravlt_ld <- as.numeric(combined.data$pea_ravlt_ld)

# Rename according to Thompson 2018 code
names(combined.data)[which(names(combined.data)=="nihtbx_picvocab_uncorrected")] = "PicVocab"
names(combined.data)[which(names(combined.data)=="nihtbx_flanker_uncorrected")] = "Flanker"
names(combined.data)[which(names(combined.data)=="nihtbx_list_uncorrected")] = "List"
names(combined.data)[which(names(combined.data)=="nihtbx_cardsort_uncorrected")] = "CardSort"
names(combined.data)[which(names(combined.data)=="nihtbx_pattern_uncorrected")] = "Pattern"
names(combined.data)[which(names(combined.data)=="nihtbx_picture_uncorrected")] = "Picture"
names(combined.data)[which(names(combined.data)=="nihtbx_reading_uncorrected")] = "Reading"
names(combined.data)[which(names(combined.data)=="pea_ravlt_ld")] = "RAVLT"
names(combined.data)[which(names(combined.data)=="lmt_scr_perc_correct")] = "LMT"

combined.data$thompson_PC1 <- (0.754*combined.data$PicVocab)+(0.213*combined.data$Flanker)+(0.471*combined.data$List)+(0.205*combined.data$CardSort)+(0.015*combined.data$Pattern)+(0.012*combined.data$Picture)+(0.82*combined.data$Reading)+(0.306*combined.data$RAVLT)+(0.5*combined.data$LMT)

combined.data$thompson_PC2 <- (0.065*combined.data$PicVocab)+(0.712*combined.data$Flanker)+(0.148*combined.data$List)+(0.71*combined.data$CardSort)+(0.813*combined.data$Pattern)+(0.135*combined.data$Picture)+(0.12*combined.data$Reading)+(0.125*combined.data$RAVLT)+(0.299*combined.data$LMT)

combined.data$thompson_PC3 <- (0.19*combined.data$PicVocab)+(0.067*combined.data$Flanker)+(0.493*combined.data$List)+(0.232*combined.data$CardSort)+(0.085*combined.data$Pattern)+(0.863*combined.data$Picture)+(0.122*combined.data$Reading)+(0.712*combined.data$RAVLT)+(0.068*combined.data$LMT)

thompson_scores <- combined.data[,c("subjectkey","thompson_PC1","thompson_PC2","thompson_PC3")]

write.csv(thompson_scores,"/Users/ariellekeller/Documents/Kellernet_PrelimAnalysis/thompson_scores.csv")
