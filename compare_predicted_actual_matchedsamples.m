
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



%% Plotting

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
xlabel("Actual Cognitive Performance",'FontSize',20)
ylabel("Predicted Cognitive Performance",'FontSize',20)
axis([-4 4 -4 4])

figure()
subplot(2,1,1)
hist(acc_boot_PC1_samp1)
h=findobj(gca,'Type','patch')
h.FaceColor = color_fill_1;
h.EdgeColor = color_fill_1;
set(gca,'ytick',[])
hold on
line([0.45 0.45],[0 300],'Color','red','LineStyle','--')
axis([-0.1 0.5 0 300])
box off
subplot(2,1,2)
hist(acc_boot_PC1_samp2)
h=findobj(gca,'Type','patch')
h.FaceColor = color_fill_2;
h.EdgeColor = color_fill_2;
set(gca,'ytick',[])
axis([-0.1 0.1 0 300])
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
xlabel("Actual Cognitive Performance",'FontSize',20)
ylabel("Predicted Cognitive Performance",'FontSize',20)
axis([-4 4 -4 4])

figure()
subplot(2,1,1)
hist(acc_boot_PC2_samp1)
h=findobj(gca,'Type','patch')
h.FaceColor = color_fill_1;
h.EdgeColor = color_fill_1;
set(gca,'ytick',[])
axis([-0.1 0.1 0 300])
subplot(2,1,2)
hist(acc_boot_PC2_samp2)
h=findobj(gca,'Type','patch')
h.FaceColor = color_fill_2;
h.EdgeColor = color_fill_2;
set(gca,'ytick',[])
axis([-0.1 0.1 0 300])
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
xlabel("Actual Cognitive Performance",'FontSize',20)
ylabel("Predicted Cognitive Performance",'FontSize',20)
axis([-4 4 -4 4])

figure()
subplot(2,1,1)
hist(acc_boot_PC3_samp1)
h=findobj(gca,'Type','patch')
h.FaceColor = color_fill_1;
h.EdgeColor = color_fill_1;
axis([-0.1 0.1 0 300])
set(gca,'ytick',[])
box off
subplot(2,1,2)
hist(acc_boot_PC3_samp2)
h=findobj(gca,'Type','patch')
h.FaceColor = color_fill_2;
h.EdgeColor = color_fill_2;
set(gca,'ytick',[])
axis([-0.1 0.1 0 300])
box off



%% Make histograms for the bootstrapped distributions:


clear all

% Add package to read NPY files into matlab
addpath('/Users/askeller/Documents/npy-matlab/')

folder_name='/Users/askeller/Documents/Kellernet_PrelimAnalysis/RidgeResults/results_Boot_May1822/all_network/';
file_name_boot1='thompson_PC1_acc_boot.npy';
file_name_boot2='thompson_PC2_acc_boot.npy';
file_name_boot3='thompson_PC3_acc_boot.npy';
file_name_null1='thompson_PC1_acc_null.npy';
file_name_null2='thompson_PC2_acc_null.npy';
file_name_null3='thompson_PC3_acc_null.npy';

boot_PC1 = readNPY([folder_name '/' file_name_boot1]);
boot_PC2 = readNPY([folder_name '/' file_name_boot2]);
boot_PC3 = readNPY([folder_name '/' file_name_boot3]);

null_PC1 = readNPY([folder_name '/' file_name_null1]);
null_PC2 = readNPY([folder_name '/' file_name_null2]);
null_PC3 = readNPY([folder_name '/' file_name_null3]);


color_fill = gray(10);
color_fill_1 = color_fill(1,:);
color_fill_2 = color_fill(7,:);


figure()
subplot(3,1,1)
hist(boot_PC1)
h=findobj(gca,'Type','patch')
h.FaceColor = color_fill_1;
h.EdgeColor = color_fill_1;
set(gca,'ytick',[])
set(gca,'FontSize',12)
xlabel('Prediction Accuracy (r)')
box off
%axis([0.3 0.6 0 40])
subplot(3,1,2)
hist(boot_PC2)
h=findobj(gca,'Type','patch')
h.FaceColor = color_fill_1;
h.EdgeColor = color_fill_1;
set(gca,'ytick',[])
set(gca,'FontSize',12)
xlabel('Prediction Accuracy (r)')
box off
%axis([0 0.3 0 40])
subplot(3,1,3)
hist(boot_PC3)
h=findobj(gca,'Type','patch')
h.FaceColor = color_fill_1;
h.EdgeColor = color_fill_1;
set(gca,'ytick',[])
set(gca,'FontSize',12)
xlabel('Prediction Accuracy (r)')
%axis([0 0.4 0 40])
box off



figure()
subplot(3,1,1)
hist(null_PC1)
h=findobj(gca,'Type','patch')
h.FaceColor = color_fill_2;
h.EdgeColor = color_fill_2;
set(gca,'ytick',[])
set(gca,'FontSize',18)
box off
%axis([0.3 0.6 0 40])
subplot(3,1,2)
hist(null_PC2)
h=findobj(gca,'Type','patch')
h.FaceColor = color_fill_2;
h.EdgeColor = color_fill_2;
set(gca,'ytick',[])
set(gca,'FontSize',18)
box off
%axis([0 0.3 0 40])
subplot(3,1,3)
hist(null_PC3)
h=findobj(gca,'Type','patch')
h.FaceColor = color_fill_2;
h.EdgeColor = color_fill_2;
set(gca,'ytick',[])
set(gca,'FontSize',18)
box off
%axis([0 0.4 0 40])

mean(boot_PC1)
[h,p,ci,stats]=ttest(boot_PC1,null_PC1)


mean(boot_PC2)
[h,p,ci,stats]=ttest(boot_PC2,null_PC2)

mean(boot_PC3)
[h,p,ci,stats]=ttest(boot_PC3,null_PC3)





