
# This script has been adapted by ASK to recreate Figure 6 from Cui et al. 2020 using ABCD data

library('R.matlab');
library('mgcv');
library('ggplot2');
library('visreg');
library('ggtext')

# ProjectFolder <- '/data/jux/BBL/projects/pncSingleFuncParcel/Replication';
# Behavior <- read.csv(paste0(ProjectFolder, '/data/n693_Behavior_20181219.csv'));
# Behavior_New <- data.frame(BBLID = Behavior$bblid);
# Behavior_New$AgeYears <- as.numeric(Behavior$ageAtScan1/12);
# Motion <- (Behavior$restRelMeanRMSMotion + Behavior$nbackRelMeanRMSMotion + Behavior$idemoRelMeanRMSMotion)/3;
# Behavior_New$Motion <- as.numeric(Motion);
# Behavior_New$Sex_factor <- as.factor(Behavior$sex);
# Behavior_New$F1_Exec_Comp_Res_Accuracy <- as.numeric(Behavior$F1_Exec_Comp_Res_Accuracy);
# AtlasLoading_Folder <- paste0(ProjectFolder, '/Revision/SingleParcellation/SingleAtlas_Analysis/FinalAtlasLoading');
# 
# SubjectsQuantity = 693;
# FeaturesQuantity = 17734;
# # Extract Loading
# Data_Size <- SubjectsQuantity * FeaturesQuantity * 17;
# Data_All <- matrix(0, 1, Data_Size);
# dim(Data_All) <- c(SubjectsQuantity, FeaturesQuantity, 17);
# BBLID <- Behavior_New$BBLID;
# for (i in c(1:length(BBLID)))
# {
#   print(i);
#   AtlasLoading_File <- paste0(AtlasLoading_Folder, '/', as.character(BBLID[i]), '.mat');
#   Data <- readMat(AtlasLoading_File);
#   Data_All[i,,] <- Data$sbj.AtlasLoading.NoMedialWall;
# }
# 
# Gam_Z_Vector_Age_WholeNetworkSum <- matrix(0, 1, 17);
# Gam_P_Vector_Age_WholeNetworkSum <- matrix(0, 1, 17);
# Gam_P_Vector_Cognition_WholeNetworkSum <- matrix(0, 1, 17);
# Gam_Z_Vector_Cognition_WholeNetworkSum <- matrix(0, 1, 17);
# for (i in 1:17)
# {
#   print(paste0('Network_', as.character(i)));
#   Data_I = Data_All[,,i];
#   WholeNetworkSum = as.numeric(rowSums(Data_I));
#   # Effects of network size 
#   Gam_Analysis_WholeNetworkSum <- gam(WholeNetworkSum ~ s(AgeYears, k=4) + Sex_factor + Motion, method = "REML", data = Behavior_New);
#   Gam_P_Vector_Age_WholeNetworkSum[i] = summary(Gam_Analysis_WholeNetworkSum)$s.table[4];
#   Gam_Z_Vector_Age_WholeNetworkSum[i] <- qnorm(Gam_P_Vector_Age_WholeNetworkSum[i] / 2, lower.tail = FALSE);
#   lm_Analysis_WholeNetworkSum <- lm(WholeNetworkSum ~ AgeYears + Sex_factor + Motion, data = Behavior_New);
#   Age_T <- summary(lm_Analysis_WholeNetworkSum)$coefficients[2, 3];
#   if (Age_T < 0) {
#     Gam_Z_Vector_Age_WholeNetworkSum[i] <- -Gam_Z_Vector_Age_WholeNetworkSum[i];
#   }
#   print(paste0('Age effect: P Value is: ', as.character(summary(Gam_Analysis_WholeNetworkSum)$s.table[4]))) 
#   # Calculate the partial correlation to represent effect size
#   WholeNetworkSum_Partial <- lm(WholeNetworkSum ~ Sex_factor + Motion, data = Behavior_New)$residuals;
#   Age_Partial <- lm(AgeYears ~ Sex_factor + Motion, data = Behavior_New)$residuals;
#   cor.test(WholeNetworkSum_Partial, Age_Partial);
#   
#   Gam_Analysis_Cognition_WholeNetworkSum <- gam(WholeNetworkSum ~ F1_Exec_Comp_Res_Accuracy + s(AgeYears, k=4) + Sex_factor + Motion, method = "REML", data = Behavior_New);
#   Gam_P_Vector_Cognition_WholeNetworkSum[i] = summary(Gam_Analysis_Cognition_WholeNetworkSum)$p.table[2,4];
#   Gam_Z_Vector_Cognition_WholeNetworkSum[i] = summary(Gam_Analysis_Cognition_WholeNetworkSum)$p.table[2,3];
#   print(paste0('Cognition effect: P Value is: ', as.character(summary(Gam_Analysis_Cognition_WholeNetworkSum)$p.table[2,4])));
#   # Calculate the partial correlation to represent effect size
#   WholeNetworkSum_Partial <- lm(WholeNetworkSum ~ AgeYears + Sex_factor + Motion, data = Behavior_New)$residuals;
#   EF_Partial <- lm(F1_Exec_Comp_Res_Accuracy ~ AgeYears + Sex_factor + Motion, data = Behavior_New)$residuals;
#   cor.test(WholeNetworkSum_Partial, EF_Partial);
# }
# Gam_P_Vector_Age_WholeNetworkSum_Bonf = p.adjust(Gam_P_Vector_Age_WholeNetworkSum, 'bonferroni');
# Gam_P_Vector_Cognition_WholeNetworkSum_Bonf = p.adjust(Gam_P_Vector_Cognition_WholeNetworkSum, 'bonferroni');


z_vec = c(-0.7272896,-3.0618619,3.2424142,-4.1576597,0.4844896,2.7263041,1.5161223,2.2195368,-0.2067699,-1.0122599,-1.1448722,1.2091494,2.3374685,1.1452890,3.4992115,1.0181162,4.2734299);

z_vec_sorted = rank(z_vec);
#keep_p = [0 1 1 1 0 0 0 0 0 0 0 0 0 0 1 0 1];
#z_vec=sort(z_vec)

# Using 7 colors scheme for bar plot
# bar plot for cognition effects
data <- data.frame(CognitionEffects_Z = as.numeric(z_vec)) #data.frame(CognitionEffects_Z = as.numeric(Gam_Z_Vector_Cognition_WholeNetworkSum));
data$EffectRank <- as.numeric(z_vec_sorted)#rank(data$CognitionEffects_Z);
BorderColor <- c("#E76178", "#7499C2", "#F5BA2E", "#7499C2", "#00A131",
                 "#AF33AD", "#E443FF", "#E76178", "#E443FF", "#AF33AD",
                 "#7499C2", "#E76178", "#7499C2", "#00A131", "#F5BA2E", 
                 "#4E31A8", "#F5BA2E");
LineType <- c("dashed", "solid", "solid", "solid", "dashed", "dashed",
              "dashed", "dashed", "dashed", "dashed", "dashed", "dashed",
              "dashed", "dashed", "solid", "dashed", "solid");
Fig <- ggplot(data, aes(EffectRank, CognitionEffects_Z)) +
  geom_bar(stat = "identity", fill=c("#FFFFFF", "#7499C2", "#F5BA2E",
                                     "#7499C2", "#FFFFFF", "#FFFFFF", "#FFFFFF", "#FFFFFF",
                                     "#FFFFFF", "#FFFFFF", "#FFFFFF", "#FFFFFF", "#FFFFFF",
                                     "#FFFFFF", "#F5BA2E", "#FFFFFF", "#F5BA2E"), 
           colour = BorderColor, linetype = LineType, width = 0.8) + 
  labs(x = "Networks", y = expression(paste("EF Association (", italic("Z"), ")"))) + theme_classic() +
  theme(axis.text.x = ggtext::element_markdown(size= 27, color = BorderColor[c(4,2,11,10,1,9,5,16,14,12,7,8,13,6,3,15,17)]), 
        axis.text.y = ggtext::element_markdown(size= 33, color = "black"), 
        axis.title=ggtext::element_markdown(size = 33)) +
  theme(axis.text.x = ggtext::element_markdown(angle = 45, hjust = 1)) +
  scale_x_discrete(labels = c('4','2','11','10','1','9','5','16','14','12','7','8','13','6','3','15','17'),limits = c('5','2','15','1','7','14','11','12','6','4','3','10','13','9','16','8','17')) # + scale_y_continuous(limits = c(-4, 6), breaks = c(-4, -2, 0, 2, 4, 6));
Fig
ggsave('/Users/askeller/Documents/Kellernet_PrelimAnalysis/NetworkSize_Loading_EFEffects.tiff', width = 19, height = 15, dpi = 600, units = "cm");


# # Scatter plots of cognition effects for two significant FP networks
# i = 15;
# Data_I = Data_All[,,i];
# WholeNetworkSum = as.numeric(rowSums(Data_I));
# Gam_Analysis_Cognition_WholeNetworkSum <- gam(WholeNetworkSum ~ F1_Exec_Comp_Res_Accuracy + s(AgeYears, k=4) + Sex_factor + Motion, method = "REML", data = Behavior_New);
# Fig <- visreg(Gam_Analysis_Cognition_WholeNetworkSum, "F1_Exec_Comp_Res_Accuracy", xlab = "EF Performance", ylab = "Total Representation", line.par = list(col = '#F5BA2E'), fill = list(fill = '#F3DDA8'), gg = TRUE)
# Fig <- Fig + theme_classic() +
#   theme(axis.text=element_text(size=30, color='black'), axis.title=element_text(size=30)) +
#   scale_y_continuous(limits = c(399, 710), breaks = c(400, 500, 600, 700), label = c("400", "500", "600", "700")) + 
#   scale_x_continuous(limits = c(-3.3, 2.3), breaks = c(-3.2, -1.6, 0, 1.6)) + 
#   geom_point(color = '#F5BA2E', size = 1.5)
# Fig
# ggsave('/data/jux/BBL/projects/pncSingleFuncParcel/Replication/Revision/Figures/EFEffect_Scatter_Network15.tiff', width = 17, height = 15, dpi = 300, units = "cm");
# 
# i = 17;
# Data_I = Data_All[,,i];
# WholeNetworkSum = as.numeric(rowSums(Data_I));
# Gam_Analysis_Cognition_WholeNetworkSum <- gam(WholeNetworkSum ~ F1_Exec_Comp_Res_Accuracy + s(AgeYears, k=4) + Sex_factor + Motion, method = "REML", data = Behavior_New);
# Fig <- visreg(Gam_Analysis_Cognition_WholeNetworkSum, "F1_Exec_Comp_Res_Accuracy", xlab = "EF Performance", ylab = "Total Representation", line.par = list(col = '#F5BA2E'), fill = list(fill = '#F3DDA8'), gg = TRUE)
# Fig <- Fig + theme_classic() +
#   theme(axis.text=element_text(size=30, color='black'), axis.title=element_text(size=30)) +
#   scale_y_continuous(limits = c(1000, 1900), breaks = c(1000, 1300, 1600, 1900), label = c("1000", "1300", "1600", "1900")) +
#   scale_x_continuous(limits = c(-3.3, 2.3), breaks = c(-3.2, -1.6, 0, 1.6)) +
#   geom_point(color = '#F5BA2E', size = 1.5)
# Fig
# ggsave('/data/jux/BBL/projects/pncSingleFuncParcel/Replication/Revision/Figures/EFEffect_Scatter_Network17.tiff', width = 17, height = 15, dpi = 300, units = "cm");
# 



z_vec = c(2.3579583,-1.3893710,3.0733065,-7.8620168,0.5033792,5.2102436,-0.7345963,0.9642072,-1.5014385,0.2726571,2.7748788,-0.4367185,-2.2333869,0.9093127,3.7563792,0.6383354,4.6654067);

z_vec_sorted = rank(z_vec);
#keep_p = [0 1 1 1 0 0 0 0 0 0 0 0 0 0 1 0 1];
#z_vec=sort(z_vec)

# Using 7 colors scheme for bar plot
# bar plot for cognition effects
data <- data.frame(CognitionEffects_Z = as.numeric(z_vec)) #data.frame(CognitionEffects_Z = as.numeric(Gam_Z_Vector_Cognition_WholeNetworkSum));
data$EffectRank <- as.numeric(z_vec_sorted)#rank(data$CognitionEffects_Z);
BorderColor <- c("#E76178", "#7499C2", "#F5BA2E", "#7499C2", "#00A131",
                 "#AF33AD", "#E443FF", "#E76178", "#E443FF", "#AF33AD",
                 "#7499C2", "#E76178", "#7499C2", "#00A131", "#F5BA2E", 
                 "#4E31A8", "#F5BA2E");
LineType <- c("dashed", "dashed", "solid", "solid", "dashed", "solid",
              "dashed", "dashed", "dashed", "dashed", "dashed", "dashed",
              "dashed", "dashed", "solid", "dashed", "solid");
Fig <- ggplot(data, aes(EffectRank, CognitionEffects_Z)) +
  geom_bar(stat = "identity", fill=c("#FFFFFF", "#FFFFFF", "#F5BA2E",
                                     "#7499C2", "#FFFFFF", "#AF33AD", "#FFFFFF", "#FFFFFF",
                                     "#FFFFFF", "#FFFFFF", "#FFFFFF", "#FFFFFF", "#FFFFFF",
                                     "#FFFFFF", "#F5BA2E", "#FFFFFF", "#F5BA2E"), 
           colour = BorderColor, linetype = LineType, width = 0.8) + 
  labs(x = "Networks", y = expression(paste("EF Association (", italic("Z"), ")"))) + theme_classic() +
  theme(axis.text.x = ggtext::element_markdown(size= 27, color = BorderColor[c(4,13,9,2,7,12,10,5,16,14,8,1,11,3,15,17,6)]), 
        axis.text.y = ggtext::element_markdown(size= 33, color = "black"), 
        axis.title=ggtext::element_markdown(size = 33)) +
  theme(axis.text.x = ggtext::element_markdown(angle = 45, hjust = 1)) +
  scale_x_discrete(labels = c('4','13','9','2','7','12','10','5','16','14','8','1','11','3','15','17','6'),limits = c('12','4','14','1','8','17','5','11','3','7','13','6','2','10','15','9','16')) # + scale_y_continuous(limits = c(-4, 6), breaks = c(-4, -2, 0, 2, 4, 6));
Fig
ggsave('/Users/askeller/Documents/Kellernet_PrelimAnalysis/NetworkSize_Loading_EFEffects_test.tiff', width = 19, height = 15, dpi = 600, units = "cm");


