# This is ASK's replication of Zaixu's script "Step_5th_SumWeights_EF.R" that 
# will try to recapitulate Figure 7C in his 2020 Neuron paper showing the sum of 
# the importance of topographic features by network. 


library(R.matlab)
library(ggplot2)


#ResultsFolder = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication/Revision';
#PredictionFolder = paste0(ResultsFolder, '/PredictionAnalysis/AtlasLoading');
WeightFolder = '/Users/askeller/Documents/Kellernet_PrelimAnalysis/CuiRep_7C_SumLoadings/';
Weight_EFAccuracy_Mat = readMat(paste0(WeightFolder, '/w_Brain_EFAccuracy_Matrix.mat'));
Weight_EFAccuracy_Matrix = Weight_EFAccuracy_Mat$w.Brain.EFAccuracy.Matrix;

#EFAccuracyEffect_Folder = paste0(ResultsFolder, '/GamAnalysis/AtlasLoading/CognitionEffects');
# plot contributing weight for age prediction
data <- data.frame(group = matrix(0, 34, 1));
data$x <- matrix(0, 34, 1);
data$y <- matrix(0, 34, 1);
Pos_Weight <- matrix(0, 1, 17);
for (i in c(1:17)){
  EFAccuracyWeight_tmp = Weight_EFAccuracy_Matrix[i,];
  data$group[i] = 'Below';
  data$x[i] = i;
  data$y[i] = sum(EFAccuracyWeight_tmp[which(EFAccuracyWeight_tmp > 0)]);
  data$group[i + 17] = 'Above';
  data$x[i + 17] = i;
  data$y[i + 17] = sum(EFAccuracyWeight_tmp[which(EFAccuracyWeight_tmp < 0)]);
  Pos_Weight[i] = data$y[i];
}
WeightSort <- sort(Pos_Weight, index.return = TRUE);
Rank <- WeightSort$ix;
data$x[1:17] <- data$x[1:17][Rank];
data$y[1:17] <- data$y[1:17][Rank];
data$x[18:34] <- data$x[18:34][Rank];
data$y[18:34] <- data$y[18:34][Rank];
data$x_New <- rbind(as.matrix(c(1:17)),as.matrix(c(1:17)));
data$x_ <- as.character(data$x_New);
ColorScheme_XAxis <- c("#7499C2", "#7499C2", "#7499C2","#7499C2","#AF33AD","#AF33AD",
                       "#F5BA2E","#4E31A8","#E443FF","#E76178","#00A131","#00A131",
                       "#E76178","#F5BA2E","#E76178","#E443FF","#F5BA2E");
ColorScheme_Fill_Manual <- c("#7499C2", "#7499C2", "#7499C2","#7499C2","#AF33AD","#AF33AD",
                             "#F5BA2E","#4E31A8","#E443FF","#E76178","#00A131","#00A131",
                             "#E76178","#F5BA2E","#E76178","#E443FF","#F5BA2E",
                             "#7499C2", "#7499C2", "#7499C2","#7499C2","#AF33AD","#AF33AD",
                             "#F5BA2E","#4E31A8","#E443FF","#E76178","#00A131","#00A131",
                             "#E76178","#F5BA2E","#E76178","#E443FF","#F5BA2E");
Fig <- ggplot(data, aes(x=x_New, y=y, fill = x_, alpha = group)) +
  geom_bar(stat = "identity", colour = "#000000", width = 0.8) +
  scale_fill_manual(limits = data$x_, values = ColorScheme_Fill_Manual) +
  scale_alpha_manual(limits = c('Above', 'Below'), values = c(0.3, 1)) +
  labs(x = "Networks", y = expression("Sum of Weights")) + theme_classic() +
  theme(axis.text.x = element_text(size= 27, color = ColorScheme_XAxis),
        axis.text.y = element_text(size= 31, color = "black"),
        axis.title=element_text(size = 31)) +
  theme(legend.position = "none") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_x_discrete(limits = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12,
                              13, 14, 15, 16, 17),
                   labels = c("4", "13", "2", "11", "10", "6", "15", "16", "7", "8", "14",
                              "5", "12", "17", "1", "9", "3"))
Fig
ggsave('/Users/askeller/Documents/Kellernet_PrelimAnalysis/CuiRep_7C_SumLoadings/EFPredictionWeight_Sum_Bar_PC1.tiff', width = 19, height = 15, dpi = 600, units = "cm")


####### REPEAT FOR PC2 BE SURE TO CLEAR THE ENV VARIABLES BEFORE RUNNING:

WeightFolder = '/Users/askeller/Documents/Kellernet_PrelimAnalysis/CuiRep_7C_SumLoadings/';
Weight_EFAccuracy_Mat = readMat(paste0(WeightFolder, '/w_Brain_EFAccuracy_Matrix_PC2.mat'));
Weight_EFAccuracy_Matrix = Weight_EFAccuracy_Mat$w.Brain.EFAccuracy.Matrix;

data <- data.frame(group = matrix(0, 34, 1));
data$x <- matrix(0, 34, 1);
data$y <- matrix(0, 34, 1);
Pos_Weight <- matrix(0, 1, 17);
for (i in c(1:17)){
  EFAccuracyWeight_tmp = Weight_EFAccuracy_Matrix[i,];
  data$group[i] = 'Below';
  data$x[i] = i;
  data$y[i] = sum(EFAccuracyWeight_tmp[which(EFAccuracyWeight_tmp > 0)]);
  data$group[i + 17] = 'Above';
  data$x[i + 17] = i;
  data$y[i + 17] = sum(EFAccuracyWeight_tmp[which(EFAccuracyWeight_tmp < 0)]);
  Pos_Weight[i] = data$y[i];
}
WeightSort <- sort(Pos_Weight, index.return = TRUE);
Rank <- WeightSort$ix;
data$x[1:17] <- data$x[1:17][Rank];
data$y[1:17] <- data$y[1:17][Rank];
data$x[18:34] <- data$x[18:34][Rank];
data$y[18:34] <- data$y[18:34][Rank];
data$x_New <- rbind(as.matrix(c(1:17)),as.matrix(c(1:17)));
data$x_ <- as.character(data$x_New);
ColorScheme_XAxis <- c("#7499C2","#AF33AD","#F5BA2E","#7499C2","#7499C2","#7499C2",
                       "#AF33AD","#E443FF","#E76178", "#4E31A8","#00A131",
                       "#E76178","#00A131","#F5BA2E","#E76178","#E443FF","#F5BA2E");
ColorScheme_Fill_Manual <- c("#7499C2","#AF33AD","#F5BA2E","#7499C2","#7499C2","#7499C2",
                             "#AF33AD","#E443FF","#E76178", "#4E31A8","#00A131",
                             "#E76178","#00A131","#F5BA2E","#E76178","#E443FF","#F5BA2E",
                             "#7499C2","#AF33AD","#F5BA2E","#7499C2","#7499C2","#7499C2",
                             "#AF33AD","#E443FF","#E76178", "#4E31A8","#00A131",
                             "#E76178","#00A131","#F5BA2E","#E76178","#E443FF","#F5BA2E");
Fig <- ggplot(data, aes(x=x_New, y=y, fill = x_, alpha = group)) +
  geom_bar(stat = "identity", colour = "#000000", width = 0.8) +
  scale_fill_manual(limits = data$x_, values = ColorScheme_Fill_Manual) +
  scale_alpha_manual(limits = c('Above', 'Below'), values = c(0.3, 1)) +
  labs(x = "Networks", y = expression("Sum of Weights")) + theme_classic() +
  theme(axis.text.x = element_text(size= 27, color = ColorScheme_XAxis),
        axis.text.y = element_text(size= 31, color = "black"),
        axis.title=element_text(size = 31)) +
  theme(legend.position = "none") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_x_discrete(limits = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12,
                              13, 14, 15, 16, 17),
                   labels = c("4", "10", "15", "13", "2", "11", "6", "7", "8", "16", "5",
                              "1", "14", "17", "12", "9", "3"))
Fig
ggsave('/Users/askeller/Documents/Kellernet_PrelimAnalysis/CuiRep_7C_SumLoadings/EFPredictionWeight_Sum_Bar_PC2.tiff', width = 19, height = 15, dpi = 600, units = "cm");


####### REPEAT FOR PC3, BE SURE TO CLEAR THE ENV VARIABLES BEFORE RUNNING:

WeightFolder = '/Users/askeller/Documents/Kellernet_PrelimAnalysis/CuiRep_7C_SumLoadings/';
Weight_EFAccuracy_Mat = readMat(paste0(WeightFolder, '/w_Brain_EFAccuracy_Matrix_PC3.mat'));
Weight_EFAccuracy_Matrix = Weight_EFAccuracy_Mat$w.Brain.EFAccuracy.Matrix;

data <- data.frame(group = matrix(0, 34, 1));
data$x <- matrix(0, 34, 1);
data$y <- matrix(0, 34, 1);
Pos_Weight <- matrix(0, 1, 17);
for (i in c(1:17)){
  EFAccuracyWeight_tmp = Weight_EFAccuracy_Matrix[i,];
  data$group[i] = 'Below';
  data$x[i] = i;
  data$y[i] = sum(EFAccuracyWeight_tmp[which(EFAccuracyWeight_tmp > 0)]);
  data$group[i + 17] = 'Above';
  data$x[i + 17] = i;
  data$y[i + 17] = sum(EFAccuracyWeight_tmp[which(EFAccuracyWeight_tmp < 0)]);
  Pos_Weight[i] = data$y[i];
}
WeightSort <- sort(Pos_Weight, index.return = TRUE);
Rank <- WeightSort$ix;
data$x[1:17] <- data$x[1:17][Rank];
data$y[1:17] <- data$y[1:17][Rank];
data$x[18:34] <- data$x[18:34][Rank];
data$y[18:34] <- data$y[18:34][Rank];
data$x_New <- rbind(as.matrix(c(1:17)),as.matrix(c(1:17)));
data$x_ <- as.character(data$x_New);
ColorScheme_XAxis <- c("#7499C2", "#7499C2", "#AF33AD", "#7499C2", "#7499C2","#AF33AD", 
                       "#F5BA2E", "#E76178","#E443FF", "#4E31A8", "#00A131", 
                       "#F5BA2E", "#00A131", "#E76178", "#E76178", "#E443FF","#F5BA2E");
ColorScheme_Fill_Manual <- c("#7499C2", "#7499C2", "#AF33AD", "#7499C2", "#7499C2","#AF33AD", 
                             "#F5BA2E", "#E76178","#E443FF", "#4E31A8", "#00A131", 
                             "#F5BA2E", "#00A131", "#E76178", "#E76178", "#E443FF","#F5BA2E",
                             "#7499C2", "#7499C2", "#AF33AD", "#7499C2", "#7499C2","#AF33AD", 
                             "#F5BA2E", "#E76178","#E443FF", "#4E31A8", "#00A131", 
                             "#F5BA2E", "#00A131", "#E76178", "#E76178", "#E443FF","#F5BA2E");
Fig <- ggplot(data, aes(x=x_New, y=y, fill = x_, alpha = group)) +
  geom_bar(stat = "identity", colour = "#000000", width = 0.8) +
  scale_fill_manual(limits = data$x_, values = ColorScheme_Fill_Manual) +
  scale_alpha_manual(limits = c('Above', 'Below'), values = c(0.3, 1)) +
  labs(x = "Networks", y = expression("Sum of Weights")) + theme_classic() +
  theme(axis.text.x = element_text(size= 27, color = ColorScheme_XAxis),
        axis.text.y = element_text(size= 31, color = "black"),
        axis.title=element_text(size = 31)) +
  theme(legend.position = "none") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_x_discrete(limits = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12,
                              13, 14, 15, 16, 17),
                   labels = c("4", "13", "10", "11", "2", "6", "15", "8", "7", "16", "5",
                              "17", "14", "1", "12", "9", "3"))
Fig
ggsave('/Users/askeller/Documents/Kellernet_PrelimAnalysis/CuiRep_7C_SumLoadings/EFPredictionWeight_Sum_Bar_PC3.tiff', width = 19, height = 16, dpi = 600, units = "cm");



