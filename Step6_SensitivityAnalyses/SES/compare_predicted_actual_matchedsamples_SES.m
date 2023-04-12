
% NOTE: this script is meant to be run with the matlab GUI to make figures

clear all

% Add package to read NPY files into matlab
addpath('/Users/askeller/Documents/npy-matlab/')


%% Get predicted scores -- NULL model (ADI only)

% Load in prediction results
folder_name='/Users/askeller/Documents/Kellernet_PrelimAnalysis/RevisionAnalyses_PFNsCog/SES/Results/ADI_Null';
file_name_pred1_samp1_null='thompson_PC1_prediction_testA.npy';
file_name_pred2_samp1_null='thompson_PC2_prediction_testA.npy';
file_name_pred3_samp1_null='thompson_PC3_prediction_testA.npy';
file_name_pred1_samp2_null='thompson_PC1_prediction_testB.npy';
file_name_pred2_samp2_null='thompson_PC2_prediction_testB.npy';
file_name_pred3_samp2_null='thompson_PC3_prediction_testB.npy';
pred_PC1_samp1_null = readNPY([folder_name '/' file_name_pred1_samp1_null]);
pred_PC2_samp1_null = readNPY([folder_name '/' file_name_pred2_samp1_null]);
pred_PC3_samp1_null = readNPY([folder_name '/' file_name_pred3_samp1_null]);
pred_PC1_samp2_null = readNPY([folder_name '/' file_name_pred1_samp2_null]);
pred_PC2_samp2_null = readNPY([folder_name '/' file_name_pred2_samp2_null]);
pred_PC3_samp2_null = readNPY([folder_name '/' file_name_pred3_samp2_null]);

% put predictions on same scale as actual
pred_PC1_samp1_null = zscore(pred_PC1_samp1_null);
pred_PC2_samp1_null = zscore(pred_PC2_samp1_null);
pred_PC3_samp1_null = zscore(pred_PC3_samp1_null);
pred_PC1_samp2_null = zscore(pred_PC1_samp2_null);
pred_PC2_samp2_null = zscore(pred_PC2_samp2_null);
pred_PC3_samp2_null = zscore(pred_PC3_samp2_null);


%% Get predicted scores -- FULL model (ADI plus PFNs)

% Load in prediction results
folder_name='/Users/askeller/Documents/Kellernet_PrelimAnalysis/RevisionAnalyses_PFNsCog/SES/Results/ADI_PFNs';
file_name_pred1_samp1_full='thompson_PC1_prediction_testA.npy';
file_name_pred2_samp1_full='thompson_PC2_prediction_testA.npy';
file_name_pred3_samp1_full='thompson_PC3_prediction_testA.npy';
file_name_pred1_samp2_full='thompson_PC1_prediction_testB.npy';
file_name_pred2_samp2_full='thompson_PC2_prediction_testB.npy';
file_name_pred3_samp2_full='thompson_PC3_prediction_testB.npy';
pred_PC1_samp1_full = readNPY([folder_name '/' file_name_pred1_samp1_full]);
pred_PC2_samp1_full = readNPY([folder_name '/' file_name_pred2_samp1_full]);
pred_PC3_samp1_full = readNPY([folder_name '/' file_name_pred3_samp1_full]);
pred_PC1_samp2_full = readNPY([folder_name '/' file_name_pred1_samp2_full]);
pred_PC2_samp2_full = readNPY([folder_name '/' file_name_pred2_samp2_full]);
pred_PC3_samp2_full = readNPY([folder_name '/' file_name_pred3_samp2_full]);

% put predictions on same scale as actual
pred_PC1_samp1_full = zscore(pred_PC1_samp1_full);
pred_PC2_samp1_full = zscore(pred_PC2_samp1_full);
pred_PC3_samp1_full = zscore(pred_PC3_samp1_full);
pred_PC1_samp2_full = zscore(pred_PC1_samp2_full);
pred_PC2_samp2_full = zscore(pred_PC2_samp2_full);
pred_PC3_samp2_full = zscore(pred_PC3_samp2_full);

%% Get actual scores

% fourth column has the matched_group
data_for_ridge=xlsread('/Users/askeller/Documents/Kellernet_PrelimAnalysis/RevisionAnalyses_PFNsCog/SES/data_for_ridge_SES.xls');

% Load in actual cognitive scores
actual_PC1 = data_for_ridge(:,1);
actual_PC2 = data_for_ridge(:,2);
actual_PC3 = data_for_ridge(:,3);

% split data out by matched group
actual_PC1_samp1 = actual_PC1(data_for_ridge(:,4)==1);
actual_PC1_samp2 = actual_PC1(data_for_ridge(:,4)==2);
actual_PC2_samp1 = actual_PC2(data_for_ridge(:,4)==1);
actual_PC2_samp2 = actual_PC2(data_for_ridge(:,4)==2);
actual_PC3_samp1 = actual_PC3(data_for_ridge(:,4)==1);
actual_PC3_samp2 = actual_PC3(data_for_ridge(:,4)==2);



%% Compare accuracy between NULL and FULL models
%% PC1
[r_null,p]=corrcoef(actual_PC1_samp1,pred_PC1_samp1_null)
p(1,2)
[r_null,p]=corrcoef(actual_PC1_samp2,pred_PC1_samp2_null)
p(1,2)
[r_full,p]=corrcoef(actual_PC1_samp1,pred_PC1_samp1_full)
p(1,2)
[r_full,p]=corrcoef(actual_PC1_samp2,pred_PC1_samp2_full)
p(1,2)

%% PC2
[r_null,p]=corrcoef(actual_PC2_samp1,pred_PC2_samp1_null)
p(1,2)
[r_null,p]=corrcoef(actual_PC2_samp2,pred_PC2_samp2_null)
p(1,2)
[r_full,p]=corrcoef(actual_PC2_samp1,pred_PC2_samp1_full)
p(1,2)
[r_full,p]=corrcoef(actual_PC2_samp2,pred_PC2_samp2_full)
p(1,2)

%% PC3
[r_null,p]=corrcoef(actual_PC3_samp1,pred_PC3_samp1_null)
p(1,2)
[r_null,p]=corrcoef(actual_PC3_samp2,pred_PC3_samp2_null)
p(1,2)
[r_full,p]=corrcoef(actual_PC3_samp1,pred_PC3_samp1_full)
p(1,2)
[r_full,p]=corrcoef(actual_PC3_samp2,pred_PC3_samp2_full)
p(1,2)


%% Plotting

% load colors
color_fill = gray(10);
color_fill_1 = color_fill(1,:);
color_fill_2 = color_fill(7,:);

figure()
scatter(actual_PC1_samp2,pred_PC1_samp2,15,color_fill_2,'Marker','^','MarkerFaceColor',color_fill_2)
[r,p,ci,stats]=corrcoef(actual_PC1_samp2,pred_PC1_samp2)
hold on
scatter(actual_PC1_samp1,pred_PC1_samp1,75,color_fill_1,'Marker','.')
[r,p,ci,stats]=corrcoef(actual_PC1_samp1,pred_PC1_samp1)
hold on
linearFit = polyfit(actual_PC1_samp1,pred_PC1_samp1,1);
hline = refline(linearFit);
hline.Color=color_fill_1;
hline.LineWidth=2;
hold on
linearFit = polyfit(actual_PC1_samp2,pred_PC1_samp2,1);
hline = refline(linearFit);
hline.Color=color_fill_2;
hline.LineWidth=2;
xlabel("Actual Cognitive Performance",'FontSize',16)
ylabel("Predicted Cognitive Performance",'FontSize',16)
axis([-4 4 -4 4])


figure()
scatter(actual_PC2_samp2,pred_PC2_samp2,15,color_fill_2,'Marker','^','MarkerFaceColor',color_fill_2)
[r,p,ci,stats]=corrcoef(actual_PC2_samp2,pred_PC2_samp2)
hold on
scatter(actual_PC2_samp1,pred_PC2_samp1,75,color_fill_1,'Marker','.')
[r,p,ci,stats]=corrcoef(actual_PC2_samp1,pred_PC2_samp1)
hold on
linearFit = polyfit(actual_PC2_samp1,pred_PC2_samp1,1);
hline = refline(linearFit);
hline.Color=color_fill_1;
hline.LineWidth=2;
hold on
linearFit = polyfit(actual_PC2_samp2,pred_PC2_samp2,1);
hline = refline(linearFit);
hline.Color=color_fill_2;
hline.LineWidth=2;
xlabel("Actual Cognitive Performance",'FontSize',16)
ylabel("Predicted Cognitive Performance",'FontSize',16)
axis([-4 4 -4 4])


figure()
scatter(actual_PC3_samp2,pred_PC3_samp2,15,color_fill_2,'Marker','^','MarkerFaceColor',color_fill_2)
[r,p,ci,stats]=corrcoef(actual_PC3_samp2,pred_PC3_samp2)
hold on
scatter(actual_PC3_samp1,pred_PC3_samp1,75,color_fill_1,'Marker','.')
[r,p,ci,stats]=corrcoef(actual_PC3_samp1,pred_PC3_samp1)
hold on
linearFit = polyfit(actual_PC3_samp1,pred_PC3_samp1,1);
hline = refline(linearFit);
hline.Color=color_fill_1;
hline.LineWidth=2;
hold on
linearFit = polyfit(actual_PC3_samp2,pred_PC3_samp2,1);
hline = refline(linearFit);
hline.Color=color_fill_2;
hline.LineWidth=2;
xlabel("Actual Cognitive Performance",'FontSize',16)
ylabel("Predicted Cognitive Performance",'FontSize',16)
axis([-4 4 -4 4])


