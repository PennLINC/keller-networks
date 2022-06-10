# This code is copied and adapted for use with the ABCDFNETS data from Zaixu's script:
# Step_10th_ViolinPlot_AtlasVariability_Loading.R (on the github pncSingleFuncParcel)

library(R.matlab)
library(ggplot2);

ResultsFolder = '/Users/askeller/Documents/Kellernet_PrelimAnalysis/';
AtlasFolder = paste0(ResultsFolder, 'SArank_PFNs/');
Variability_Mat = readMat(paste0(ResultsFolder,'VariabilityByPFN_Trimmed.mat'));

AtlasLabel_Mat = readMat(paste0(AtlasFolder, '/sbj_AtlasLabel_NoMedialWall_Keller.mat'));

#Variability=as.matrix(Variability_Mat[1])

AllData = data.frame(Variability = matrix(0, 59412, 1));
AllData$Label = matrix(0, 59412, 1);
for (i in c(1:59412))
{
  AllData$Variability[i] = Variability_Mat$Variability.All[i];
  AllData$Label[i] = AtlasLabel_Mat$sbj.AtlasLabel.NoMedialWall[i];
}
AllData$Variability = as.numeric(AllData$Variability);
AllData$Label = as.factor(AllData$Label);



# NOTE: A.S.K ADDING A STEP HERE
# In Zaixu's original version, this step was not present. I noticed that a lot of the variability values are exactly 0, and this is because a lot of the loading values are dropped to zero. We also are using fslr here which has 59K vertices, whereas Zaixu's version had far fewer. For now, I will eliminate vertices where the variability is exactly 0 (out to like 7 decimal places) since this very likely indicates the loading was zero for all subjects. 
#AllData = AllData[AllData$Variability!=0.0000000,]
AllData=AllData[complete.cases(AllData),]

# Order the network by the median value 
MedianValue = matrix(0, 1, 17);
for (i in c(1:17)) {
  ind = which(AllData$Label == i);
  MedianValue[i] = median(AllData$Variability[ind],na.rm=TRUE);
}
tmp = sort(MedianValue, index.return = TRUE);


ColorScheme = c("#E76178", "#7499C2", "#F5BA2E", "#7499C2", "#00A131",
                "#AF33AD", "#E443FF", "#E76178", "#E443FF", "#AF33AD",
                "#7499C2", "#E76178", "#7499C2", "#00A131", "#F5BA2E",
                "#4E31A8", "#F5BA2E");
ColorScheme_XText = c("#AF33AD", "#AF33AD", "#7499C2", "#7499C2", "#4E31A8",
                      "#7499C2", "#7499C2", "#F5BA2E", "#00A131", "#E76178",
                      "#E443FF", "#E443FF", "#E76178", "#E76178", "#F5BA2E",
                      "#00A131", "#F5BA2E");

Order = tmp$ix #c(10, 6, 4, 2, 16, 11, 13, 15, 5, 12, 7, 9, 8, 1, 17, 14, 3);
ColorScheme_XText_New = ColorScheme#_XText;

for (i in c(1:17)) {
  ind = which(Order == i);
  ColorScheme_XText_New[ind] = ColorScheme#_XText[i];
}

ggplot(AllData, aes(x = Label, y = Variability, fill = Label, color = Label)) +
  geom_violin(trim = FALSE) +
  scale_color_manual(values = ColorScheme) +
  scale_fill_manual(values = ColorScheme) +
  labs(x = "Networks", y = "Across-subject Variability") + theme_classic() +
  theme(axis.text.x = element_text(size = 22, color = ColorScheme_XText_New),
        axis.text.y = element_text(size = 22, color = "black"),
        axis.title = element_text(size = 22)) +
  theme(axis.text.x = element_text(angle = 22, hjust = 1)) +
  theme(legend.position = "none") +  scale_x_discrete(limits = factor(c(4,5,9,16,1,13,8,17,12,3,6,15,2,10,7,14,11))) +
  geom_boxplot(width=0.1, fill = "white"); #,labels = c("4","5","9","16","1","13","8","17","12","3","6","15","2","10","7","14","11")

ggsave('/Users/askeller/Documents/Kellernet_PrelimAnalysis/CuiRep_MedianVariability/Variability_Loading_Mean_Violin.tiff', width = 20, height = 15, dpi = 600, units = "cm");
