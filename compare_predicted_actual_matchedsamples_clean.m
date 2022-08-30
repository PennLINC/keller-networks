
clear all

% Add package to read NPY files into matlab
addpath('/Users/askeller/Documents/npy-matlab/')

% Load in prediction results
folder_name='/Users/askeller/Documents/Kellernet_PrelimAnalysis/RidgeResults/results_matchedsamples_081822/all_network';
file_name_pred1_samp1='thompson_PC1_prediction_testA.npy';
file_name_pred2_samp1='thompson_PC2_prediction_testA.npy';
file_name_pred3_samp1='thompson_PC3_prediction_testA.npy';
file_name_pred1_samp2='thompson_PC1_prediction_testB.npy';
file_name_pred2_samp2='thompson_PC2_prediction_testB.npy';
file_name_pred3_samp2='thompson_PC3_prediction_testB.npy';
pred_PC1_samp1 = readNPY([folder_name '/' file_name_pred1_samp1]);
pred_PC2_samp1 = readNPY([folder_name '/' file_name_pred2_samp1]);
pred_PC3_samp1 = readNPY([folder_name '/' file_name_pred3_samp1]);
pred_PC1_samp2 = readNPY([folder_name '/' file_name_pred1_samp2]);
pred_PC2_samp2 = readNPY([folder_name '/' file_name_pred2_samp2]);
pred_PC3_samp2 = readNPY([folder_name '/' file_name_pred3_samp2]);

% put predictions on same scale as actual
pred_PC1_samp1 = zscore(pred_PC1_samp1);
pred_PC2_samp1 = zscore(pred_PC2_samp1);
pred_PC3_samp1 = zscore(pred_PC3_samp1);
pred_PC1_samp2 = zscore(pred_PC1_samp2);
pred_PC2_samp2 = zscore(pred_PC2_samp2);
pred_PC3_samp2 = zscore(pred_PC3_samp2);

% fourth column has the matched_group
data_for_ridge=xlsread('/Users/askeller/Documents/Kellernet_PrelimAnalysis/RidgeResults/data_for_ridge_081822.xls');

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


%% Load in the results for bootstrapping and null distributions

% ~~~~~ NULL ~~~~~~ %
folder_name='/Users/askeller/Documents/Kellernet_PrelimAnalysis/RidgeResults/results_matchedsamples_null_081822/';
file_name_acc_PC1_null_samp1='thompson_PC1_acc_null_testA.npy';
file_name_acc_PC1_null_samp2='thompson_PC1_acc_null_testB.npy';
file_name_acc_PC2_null_samp1='thompson_PC2_acc_null_testA.npy';
file_name_acc_PC2_null_samp2='thompson_PC2_acc_null_testB.npy';
file_name_acc_PC3_null_samp1='thompson_PC3_acc_null_testA.npy';
file_name_acc_PC3_null_samp2='thompson_PC3_acc_null_testB.npy';
acc_PC1_null_samp1 = readNPY([folder_name '/' file_name_acc_PC1_null_samp1]);
acc_PC1_null_samp2 = readNPY([folder_name '/' file_name_acc_PC1_null_samp2]);
acc_PC2_null_samp1 = readNPY([folder_name '/' file_name_acc_PC2_null_samp1]);
acc_PC2_null_samp2 = readNPY([folder_name '/' file_name_acc_PC2_null_samp2]);
acc_PC3_null_samp1 = readNPY([folder_name '/' file_name_acc_PC3_null_samp1]);
acc_PC3_null_samp2 = readNPY([folder_name '/' file_name_acc_PC3_null_samp2]);


% ~~~~~ BOOTSTRAP ~~~~~~ %
folder_name='/Users/askeller/Documents/Kellernet_PrelimAnalysis/RidgeResults/results_matchedsamples_boot_081822';
file_name_acc_PC1_boot='thompson_PC1_acc_boot.npy';
file_name_acc_PC2_boot='thompson_PC2_acc_boot.npy';
file_name_acc_PC3_boot='thompson_PC3_acc_boot.npy';
acc_PC1_boot = readNPY([folder_name '/' file_name_acc_PC1_boot]);
acc_PC2_boot = readNPY([folder_name '/' file_name_acc_PC2_boot]);
acc_PC3_boot = readNPY([folder_name '/' file_name_acc_PC3_boot]);


% ~~~~~ BOOTSTRAP NULL ~~~~~~ %
folder_name='/Users/askeller/Documents/Kellernet_PrelimAnalysis/RidgeResults/results_matchedsamples_boot_null_081822';
file_name_acc_PC1_boot_null='thompson_PC1_acc_boot_null.npy';
file_name_acc_PC2_boot_null='thompson_PC2_acc_boot_null.npy';
file_name_acc_PC3_boot_null='thompson_PC3_acc_boot_null.npy';
acc_PC1_boot_null = readNPY([folder_name '/' file_name_acc_PC1_boot_null]);
acc_PC2_boot_null = readNPY([folder_name '/' file_name_acc_PC2_boot_null]);
acc_PC3_boot_null = readNPY([folder_name '/' file_name_acc_PC3_boot_null]);



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
subplot(2,1,1)
hist(acc_PC1_null_samp1)
h=findobj(gca,'Type','patch')
h.FaceColor = color_fill_1;
h.EdgeColor = color_fill_1;
set(gca,'ytick',[])
hold on
axis([-0.1 0.1 0 30])
box off
subplot(2,1,2)
hist(acc_PC1_null_samp2)
h=findobj(gca,'Type','patch')
h.FaceColor = color_fill_2;
h.EdgeColor = color_fill_2;
set(gca,'ytick',[])
axis([-0.1 0.1 0 30])
box off

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
subplot(2,1,1)
hist(acc_PC2_null_samp1)
h=findobj(gca,'Type','patch')
h.FaceColor = color_fill_1;
h.EdgeColor = color_fill_1;
set(gca,'ytick',[])
axis([-0.1 0.1 0 30])
subplot(2,1,2)
hist(acc_PC2_null_samp2)
h=findobj(gca,'Type','patch')
h.FaceColor = color_fill_2;
h.EdgeColor = color_fill_2;
set(gca,'ytick',[])
axis([-0.1 0.1 0 30])
box off

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

figure()
subplot(2,1,1)
hist(acc_PC3_null_samp1)
h=findobj(gca,'Type','patch')
h.FaceColor = color_fill_1;
h.EdgeColor = color_fill_1;
axis([-0.1 0.1 0 30])
set(gca,'ytick',[])
box off
subplot(2,1,2)
hist(acc_PC3_null_samp2)
h=findobj(gca,'Type','patch')
h.FaceColor = color_fill_2;
h.EdgeColor = color_fill_2;
set(gca,'ytick',[])
axis([-0.1 0.1 0 30])
box off



%% Make histograms for the bootstrapped distributions:

figure()
subplot(3,1,1)
hist(acc_PC1_boot,6)
h=findobj(gca,'Type','patch')
h.FaceColor = color_fill_1;
h.EdgeColor = color_fill_1;
set(gca,'ytick',[])
set(gca,'FontSize',12)
xlabel('Prediction Accuracy (r)')
box off
axis([0.41 0.45 0 40])
subplot(3,1,2)
hist(acc_PC2_boot,6)
h=findobj(gca,'Type','patch')
h.FaceColor = color_fill_1;
h.EdgeColor = color_fill_1;
set(gca,'ytick',[])
set(gca,'FontSize',12)
xlabel('Prediction Accuracy (r)')
box off
axis([0.14 0.2 0 40])
subplot(3,1,3)
hist(acc_PC3_boot,7)
h=findobj(gca,'Type','patch')
h.FaceColor = color_fill_1;
h.EdgeColor = color_fill_1;
set(gca,'ytick',[])
set(gca,'FontSize',12)
xlabel('Prediction Accuracy (r)')
axis([0.25 0.3 0 40])
box off



figure()
subplot(3,1,1)
hist(acc_PC1_boot_null)
h=findobj(gca,'Type','patch')
h.FaceColor = color_fill_2;
h.EdgeColor = color_fill_2;
set(gca,'ytick',[])
set(gca,'FontSize',18)
box off
axis([-0.05 0.05 0 30])
subplot(3,1,2)
hist(acc_PC2_boot_null)
h=findobj(gca,'Type','patch')
h.FaceColor = color_fill_2;
h.EdgeColor = color_fill_2;
set(gca,'ytick',[])
set(gca,'FontSize',18)
box off
axis([-0.05 0.05 0 30])
subplot(3,1,3)
hist(acc_PC3_boot_null)
h=findobj(gca,'Type','patch')
h.FaceColor = color_fill_2;
h.EdgeColor = color_fill_2;
set(gca,'ytick',[])
set(gca,'FontSize',18)
box off
axis([-0.05 0.05 0 30])





