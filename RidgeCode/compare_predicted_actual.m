
clear all

% Add package to read NPY files into matlab
addpath('/Users/askeller/Documents/npy-matlab/')

folder_name='/Users/askeller/Documents/Kellernet_PrelimAnalysis/RidgeResults/results_Mar2922/all_network/';
file_name_pred1='thompson_PC1_prediction.npy';
file_name_pred2='thompson_PC2_prediction.npy';
file_name_pred3='thompson_PC3_prediction.npy';

pred_PC1 = readNPY([folder_name '/' file_name_pred1]);
pred_PC2 = readNPY([folder_name '/' file_name_pred2]);
pred_PC3 = readNPY([folder_name '/' file_name_pred3]);

% put predictions on same scale as actual
pred_PC1 = zscore(pred_PC1);
pred_PC2 = zscore(pred_PC2);
pred_PC3 = zscore(pred_PC3);


actual_PC1=xlsread('/Users/askeller/Documents/Kellernet_PrelimAnalysis/RidgeResults/PC1_targets.xls');
actual_PC2=xlsread('/Users/askeller/Documents/Kellernet_PrelimAnalysis/RidgeResults/PC2_targets.xls');
actual_PC3=xlsread('/Users/askeller/Documents/Kellernet_PrelimAnalysis/RidgeResults/PC3_targets.xls');


% fourth column has the matched_group
data_for_ridge=xlsread('/Users/askeller/Documents/Kellernet_PrelimAnalysis/RidgeResults/data_for_ridge_032822.xls');

% split data out by matched group to match Fig 7 in Cui 2020
pred_PC1_samp1 = pred_PC1(data_for_ridge(:,4)==1);
pred_PC1_samp2 = pred_PC1(data_for_ridge(:,4)==2);
pred_PC2_samp1 = pred_PC2(data_for_ridge(:,4)==1);
pred_PC2_samp2 = pred_PC2(data_for_ridge(:,4)==2);
pred_PC3_samp1 = pred_PC3(data_for_ridge(:,4)==1);
pred_PC3_samp2 = pred_PC3(data_for_ridge(:,4)==2);
actual_PC1_samp1 = actual_PC1(data_for_ridge(:,4)==1);
actual_PC1_samp2 = actual_PC1(data_for_ridge(:,4)==2);
actual_PC2_samp1 = actual_PC2(data_for_ridge(:,4)==1);
actual_PC2_samp2 = actual_PC2(data_for_ridge(:,4)==2);
actual_PC3_samp1 = actual_PC3(data_for_ridge(:,4)==1);
actual_PC3_samp2 = actual_PC3(data_for_ridge(:,4)==2);


%% Calculate permutations for inset histograms of 7A

bootstraps = 1000;

acc_boot_PC1_samp1 = [];
acc_boot_PC2_samp1 = [];
acc_boot_PC3_samp1 = [];
acc_boot_PC1_samp2 = [];
acc_boot_PC2_samp2 = [];
acc_boot_PC3_samp2 = [];


for eachBootstrap = 1:bootstraps

[r,p,ci,stats]=corrcoef(pred_PC1_samp1,actual_PC1_samp1(randperm(length(actual_PC1_samp1))));
acc_boot_PC1_samp1 = [acc_boot_PC1_samp1 r(1,2)];

[r,p,ci,stats]=corrcoef(pred_PC2_samp1,actual_PC2_samp1(randperm(length(actual_PC2_samp1))));
acc_boot_PC2_samp1 = [acc_boot_PC2_samp1 r(1,2)];

[r,p,ci,stats]=corrcoef(pred_PC3_samp1,actual_PC3_samp1(randperm(length(actual_PC3_samp1))));
acc_boot_PC3_samp1 = [acc_boot_PC3_samp1 r(1,2)];

[r,p,ci,stats]=corrcoef(pred_PC1_samp2,actual_PC1_samp2(randperm(length(actual_PC1_samp2))));
acc_boot_PC1_samp2 = [acc_boot_PC1_samp2 r(1,2)];

[r,p,ci,stats]=corrcoef(pred_PC2_samp2,actual_PC2_samp2(randperm(length(actual_PC2_samp2))));
acc_boot_PC2_samp2 = [acc_boot_PC2_samp2 r(1,2)];

[r,p,ci,stats]=corrcoef(pred_PC3_samp2,actual_PC3_samp2(randperm(length(actual_PC3_samp2))));
acc_boot_PC3_samp2 = [acc_boot_PC3_samp2 r(1,2)];

end




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
axis([-0.1 0.1 0 300])
box off
subplot(2,1,2)
hist(acc_boot_PC1_samp2)
h=findobj(gca,'Type','patch')
h.FaceColor = color_fill_2;
h.EdgeColor = color_fill_2;
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
axis([-0.1 0.1 0 300])
subplot(2,1,2)
hist(acc_boot_PC2_samp2)
h=findobj(gca,'Type','patch')
h.FaceColor = color_fill_2;
h.EdgeColor = color_fill_2;
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
box off
subplot(2,1,2)
hist(acc_boot_PC3_samp2)
h=findobj(gca,'Type','patch')
h.FaceColor = color_fill_2;
h.EdgeColor = color_fill_2;
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

boot_PC1 = readNPY([folder_name '/' file_name_boot1]);
boot_PC2 = readNPY([folder_name '/' file_name_boot2]);
boot_PC3 = readNPY([folder_name '/' file_name_boot3]);


color_fill = gray(10);
color_fill_1 = color_fill(1,:);
color_fill_2 = color_fill(7,:);


figure()
subplot(3,1,1)
hist(boot_PC1)
h=findobj(gca,'Type','patch')
h.FaceColor = color_fill_1;
h.EdgeColor = color_fill_1;
%axis([0.3 0.6 0 40])
subplot(3,1,2)
hist(boot_PC2)
h=findobj(gca,'Type','patch')
h.FaceColor = color_fill_1;
h.EdgeColor = color_fill_1;
%axis([0 0.3 0 40])
subplot(3,1,3)
hist(boot_PC3)
h=findobj(gca,'Type','patch')
h.FaceColor = color_fill_1;
h.EdgeColor = color_fill_1;
%axis([0 0.4 0 40])
box off