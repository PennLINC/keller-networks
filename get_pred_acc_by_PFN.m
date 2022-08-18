%% generate the brainmaps for prediction accuracy within each network.

clear all

% Add package to read NPY files into matlab
addpath('/Users/askeller/Documents/npy-matlab/')

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

% decision was to combine across the samples, so we will concatenate:
actual_PC1 = [actual_PC1_samp1; actual_PC1_samp2];
actual_PC2 = [actual_PC2_samp1; actual_PC2_samp2];
actual_PC3 = [actual_PC3_samp1; actual_PC3_samp2];


% matrix to collect R values by PFN
Rvals_byPFN = zeros(17,3);


% loop through each PFN and calculate the R value
for eachPFN = 0:16

eval(['folder_name=''/Users/askeller/Documents/Kellernet_PrelimAnalysis/RidgeResults/results_matchedsamples_081822/' num2str(eachPFN) '_network'';'])

% Load the predicted cognitive scores from the ridge regression
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

% decision was to combine across the samples, so we will concatenate:
pred_PC1 = [pred_PC1_samp1; pred_PC1_samp2];
pred_PC2 = [pred_PC2_samp1; pred_PC2_samp2];
pred_PC3 = [pred_PC3_samp1; pred_PC3_samp2];


% calculate the correlation between actual and predicted
[r_PC1,p_PC1,ci_PC1,stats_PC1]=corrcoef(actual_PC1,pred_PC1);
[r_PC2,p_PC2,ci_PC2,stats_PC2]=corrcoef(actual_PC2,pred_PC2);
[r_PC3,p_PC3,ci_PC3,stats_PC3]=corrcoef(actual_PC3,pred_PC3);

% extract and save R values
Rvals_byPFN(eachPFN+1,1) = r_PC1(1,2);
Rvals_byPFN(eachPFN+1,2) = r_PC2(1,2);
Rvals_byPFN(eachPFN+1,3) = r_PC3(1,2);

end


save('/Users/askeller/Documents/Kellernet_PrelimAnalysis/pred_acc_by_PFN.mat','Rvals_byPFN')

%% generate supp. figs with correlation between predicted and actual scores
%  for each individual network model

% % get colors
% color_fill = gray(10);
% color_fill_1 = color_fill(1,:);
% color_fill_2 = color_fill(7,:);
% network_colors =       [215/255 105/255 122/255; 124/255 152/255 190/255; 236/255 188/255 78/255; 124/255 152/255 190/255; 71/255 159/255 66/255; 161/255 61/255 168/255; 211/255 80/255 247/255; 215/255 105/255 122/255; 211/255 80/255 247/255; 161/255 61/255 168/255; 124/255 152/255 190/255; 215/255 105/255 122/255; 124/255 152/255 190/255; 71/255 159/255 66/255; 236/255 188/255 78/255; 74/255 50/255 162/255; 236/255 188/255 78/255];
% network_colors_light = [234/255 183/255 191/255; 192/255 205/255 223/255; 245/255 222/255 169/255; 192/255 205/255 223/255; 165/255 208/255 167/255; 208/255 162/255 212/255; 230/255 165/255 250/255; 234/255 183/255 191/255; 230/255 165/255 250/255; 208/255 162/255 212/255; 192/255 205/255 223/255; 234/255 183/255 191/255; 192/255 205/255 223/255; 165/255 208/255 167/255; 245/255 222/255 169/255; 171/255 161/255 209/255; 245/255 222/255 169/255];
%
% %red: [215/255 105/255 122/255] light: [234/255 183/255 191/255]
% %pink: [211/255 80/255 247/255] light: [230/255 165/255 250/255]
% %yellow: [236/255 188/255 78/255] light: [245/255 222/255 169/255]
% %green: [71/255 159/255 66/255] light: [165/255 208/255 167/255]
% %purple: [74/255 50/255 162/255] light: [171/255 161/255 209/255]
% %blue: [124/255 152/255 190/255] light: [192/255 205/255 223/255]
% %pink/purple: [161/255 61/255 168/255] light: [208/255 162/255 212/255]
%
% % fourth column has the matched_group
% data_for_ridge=xlsread('/Users/askeller/Documents/Kellernet_PrelimAnalysis/RidgeResults/data_for_ridge_032822.xls');
%
% % split data out by matched group
% actual_PC1_samp1 = actual_PC1(data_for_ridge(:,4)==1);
% actual_PC1_samp2 = actual_PC1(data_for_ridge(:,4)==2);
% actual_PC2_samp1 = actual_PC2(data_for_ridge(:,4)==1);
% actual_PC2_samp2 = actual_PC2(data_for_ridge(:,4)==2);
% actual_PC3_samp1 = actual_PC3(data_for_ridge(:,4)==1);
% actual_PC3_samp2 = actual_PC3(data_for_ridge(:,4)==2);
%
%
%
% % loop through each PFN and calculate the R value
% for eachPFN = 0:16
%
% eval(['folder_name=''/Users/askeller/Documents/Kellernet_PrelimAnalysis/RidgeResults/results_Mar2922/' num2str(eachPFN) '_network'';'])
%
% % Load the predicted cognitive scores from the ridge regression
% file_name_pred1='thompson_PC1_prediction.npy';
% file_name_pred2='thompson_PC2_prediction.npy';
% file_name_pred3='thompson_PC3_prediction.npy';
% pred_PC1 = readNPY([folder_name '/' file_name_pred1]);
% pred_PC2 = readNPY([folder_name '/' file_name_pred2]);
% pred_PC3 = readNPY([folder_name '/' file_name_pred3]);
%
% % put predictions on same scale as actual
% pred_PC1 = zscore(pred_PC1);
% pred_PC2 = zscore(pred_PC2);
% pred_PC3 = zscore(pred_PC3);
%
% % split data out by matched group
% pred_PC1_samp1 = pred_PC1(data_for_ridge(:,4)==1);
% pred_PC1_samp2 = pred_PC1(data_for_ridge(:,4)==2);
% pred_PC2_samp1 = pred_PC2(data_for_ridge(:,4)==1);
% pred_PC2_samp2 = pred_PC2(data_for_ridge(:,4)==2);
% pred_PC3_samp1 = pred_PC3(data_for_ridge(:,4)==1);
% pred_PC3_samp2 = pred_PC3(data_for_ridge(:,4)==2);
%
%
% % scatterplot between actual and predicted
%
% figure(1)
% subplot(5,4,eachPFN+1)
% scatter(actual_PC1_samp2,pred_PC1_samp2,15,network_colors_light(eachPFN+1,:),'Marker','^','MarkerFaceColor',network_colors_light(eachPFN+1,:))
% [r,p,ci,stats]=corrcoef(actual_PC1_samp2,pred_PC1_samp2)
% hold on
% scatter(actual_PC1_samp1,pred_PC1_samp1,75,network_colors(eachPFN+1,:),'Marker','.')
% [r,p,ci,stats]=corrcoef(actual_PC1_samp1,pred_PC1_samp1)
% hold on
% linearFit = polyfit(actual_PC1_samp1,pred_PC1_samp1,1);
% hline = refline(linearFit);
% hline.Color=color_fill_1;
% hline.LineWidth=2;
% hold on
% linearFit = polyfit(actual_PC1_samp2,pred_PC1_samp2,1);
% hline = refline(linearFit);
% hline.Color=color_fill_2;
% hline.LineWidth=2;
% xlabel("Actual General Cognition",'FontSize',6)
% ylabel("Predicted General Cognition",'FontSize',6)
% axis([-4 4 -4 4])
%
%
% figure(2)
% subplot(5,4,eachPFN+1)
% scatter(actual_PC2_samp2,pred_PC2_samp2,15,network_colors_light(eachPFN+1,:),'Marker','^','MarkerFaceColor',network_colors_light(eachPFN+1,:))
% [r,p,ci,stats]=corrcoef(actual_PC2_samp2,pred_PC2_samp2)
% hold on
% scatter(actual_PC2_samp1,pred_PC2_samp1,75,network_colors(eachPFN+1,:),'Marker','.')
% [r,p,ci,stats]=corrcoef(actual_PC2_samp1,pred_PC2_samp1)
% hold on
% linearFit = polyfit(actual_PC2_samp1,pred_PC2_samp1,1);
% hline = refline(linearFit);
% hline.Color=color_fill_1;
% hline.LineWidth=2;
% hold on
% linearFit = polyfit(actual_PC2_samp2,pred_PC2_samp2,1);
% hline = refline(linearFit);
% hline.Color=color_fill_2;
% hline.LineWidth=2;
% xlabel("Actual Executive Function",'FontSize',6)
% ylabel("Predicted Executive Function",'FontSize',6)
% axis([-4 4 -4 4])
%
%
%
% figure(3)
% subplot(5,4,eachPFN+1)
% scatter(actual_PC3_samp2,pred_PC3_samp2,15,network_colors_light(eachPFN+1,:),'Marker','^','MarkerFaceColor',network_colors_light(eachPFN+1,:))
% [r,p,ci,stats]=corrcoef(actual_PC3_samp2,pred_PC3_samp2)
% hold on
% scatter(actual_PC3_samp1,pred_PC3_samp1,75,network_colors(eachPFN+1,:),'Marker','.')
% [r,p,ci,stats]=corrcoef(actual_PC3_samp1,pred_PC3_samp1)
% hold on
% linearFit = polyfit(actual_PC3_samp1,pred_PC3_samp1,1);
% hline = refline(linearFit);
% hline.Color=color_fill_1;
% hline.LineWidth=2;
% hold on
% linearFit = polyfit(actual_PC3_samp2,pred_PC3_samp2,1);
% hline = refline(linearFit);
% hline.Color=color_fill_2;
% hline.LineWidth=2;
% xlabel("Actual Learning/Memory",'FontSize',6)
% ylabel("Predicted Learning/Memory",'FontSize',6)
% axis([-4 4 -4 4])
%
%
% end


%% Make a bar plot of prediction accuracy by PFN

clear all

% Add package to read NPY files into matlab
addpath('/Users/askeller/Documents/npy-matlab/')

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

% set empty matrices
pred_acc_PC1_samp1 = [];
pred_acc_PC2_samp1 = [];
pred_acc_PC3_samp1 = [];
pred_acc_PC1_samp2 = [];
pred_acc_PC2_samp2 = [];
pred_acc_PC3_samp2 = [];

for eachPFN = 0:16

    eval(['folder_name=''/Users/askeller/Documents/Kellernet_PrelimAnalysis/RidgeResults/results_matchedsamples_081822/' num2str(eachPFN) '_network'';'])

    % Load the predicted cognitive scores from the ridge regression
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


    % calculate the correlation between actual and predicted (sample 1)
    [r_PC1,p_PC1,ci_PC1,stats_PC1]=corrcoef(actual_PC1_samp1,pred_PC1_samp1);
    [r_PC2,p_PC2,ci_PC2,stats_PC2]=corrcoef(actual_PC2_samp1,pred_PC2_samp1);
    [r_PC3,p_PC3,ci_PC3,stats_PC3]=corrcoef(actual_PC3_samp1,pred_PC3_samp1);
    pred_acc_PC1_samp1 = [pred_acc_PC1_samp1 r_PC1(1,2)];
    pred_acc_PC2_samp1 = [pred_acc_PC2_samp1 r_PC2(1,2)];
    pred_acc_PC3_samp1 = [pred_acc_PC3_samp1 r_PC3(1,2)];

    % calculate the correlation between actual and predicted (sample 2)
    [r_PC1,p_PC1,ci_PC1,stats_PC1]=corrcoef(actual_PC1_samp2,pred_PC1_samp2);
    [r_PC2,p_PC2,ci_PC2,stats_PC2]=corrcoef(actual_PC2_samp2,pred_PC2_samp2);
    [r_PC3,p_PC3,ci_PC3,stats_PC3]=corrcoef(actual_PC3_samp2,pred_PC3_samp2);
    pred_acc_PC1_samp2 = [pred_acc_PC1_samp2 r_PC1(1,2)];
    pred_acc_PC2_samp2 = [pred_acc_PC2_samp2 r_PC2(1,2)];
    pred_acc_PC3_samp2 = [pred_acc_PC3_samp2 r_PC3(1,2)];

end


% Sort the pred accs (sort by average across samples)
[ordered,index_PC1]=sort(mean([pred_acc_PC1_samp1; pred_acc_PC1_samp2]));
[ordered,index_PC2]=sort(mean([pred_acc_PC2_samp1; pred_acc_PC2_samp2]));
[ordered,index_PC3]=sort(mean([pred_acc_PC3_samp1; pred_acc_PC3_samp2]));
pred_acc_PC1_samp1_ordered = pred_acc_PC1_samp1(index_PC1);
pred_acc_PC1_samp2_ordered = pred_acc_PC1_samp2(index_PC1);
pred_acc_PC2_samp1_ordered = pred_acc_PC2_samp1(index_PC2);
pred_acc_PC2_samp2_ordered = pred_acc_PC2_samp2(index_PC2);
pred_acc_PC3_samp1_ordered = pred_acc_PC3_samp1(index_PC3);
pred_acc_PC3_samp2_ordered = pred_acc_PC3_samp2(index_PC3);



%% General Cognition


% load in colors for graph
network_colors =       [215/255 105/255 122/255; 124/255 152/255 190/255; 236/255 188/255 78/255; 124/255 152/255 190/255; 71/255 159/255 66/255; 161/255 61/255 168/255; 211/255 80/255 247/255; 215/255 105/255 122/255; 211/255 80/255 247/255; 161/255 61/255 168/255; 124/255 152/255 190/255; 215/255 105/255 122/255; 124/255 152/255 190/255; 71/255 159/255 66/255; 236/255 188/255 78/255; 74/255 50/255 162/255; 236/255 188/255 78/255];
network_colors_light = [234/255 183/255 191/255; 192/255 205/255 223/255; 245/255 222/255 169/255; 192/255 205/255 223/255; 165/255 208/255 167/255; 208/255 162/255 212/255; 230/255 165/255 250/255; 234/255 183/255 191/255; 230/255 165/255 250/255; 208/255 162/255 212/255; 192/255 205/255 223/255; 234/255 183/255 191/255; 192/255 205/255 223/255; 165/255 208/255 167/255; 245/255 222/255 169/255; 171/255 161/255 209/255; 245/255 222/255 169/255];
network_colors_sorted = network_colors(index_PC1,:);
network_colors_light_sorted = network_colors_light(index_PC1,:);

figure(1)
for eachPFN2 = 1:17
    bar(eachPFN2,pred_acc_PC1_samp1_ordered(eachPFN2),'BarWidth',0.3,'FaceColor',network_colors_sorted(eachPFN2,:),'EdgeColor','none')
    hold on
    bar(eachPFN2+0.3,pred_acc_PC1_samp2_ordered(eachPFN2),'BarWidth',0.3,'FaceColor',network_colors_light_sorted(eachPFN2,:),'EdgeColor','none')
end
xticks([1.15:1:17.15])
xticklabels(index_PC1)
xlabel('Personalized Functional Network','FontSize',14)
ylabel('Prediction Accuracy','FontSize',14)
box off


%% Executive Function


% load in colors for graph
network_colors =       [215/255 105/255 122/255; 124/255 152/255 190/255; 236/255 188/255 78/255; 124/255 152/255 190/255; 71/255 159/255 66/255; 161/255 61/255 168/255; 211/255 80/255 247/255; 215/255 105/255 122/255; 211/255 80/255 247/255; 161/255 61/255 168/255; 124/255 152/255 190/255; 215/255 105/255 122/255; 124/255 152/255 190/255; 71/255 159/255 66/255; 236/255 188/255 78/255; 74/255 50/255 162/255; 236/255 188/255 78/255];
network_colors_light = [234/255 183/255 191/255; 192/255 205/255 223/255; 245/255 222/255 169/255; 192/255 205/255 223/255; 165/255 208/255 167/255; 208/255 162/255 212/255; 230/255 165/255 250/255; 234/255 183/255 191/255; 230/255 165/255 250/255; 208/255 162/255 212/255; 192/255 205/255 223/255; 234/255 183/255 191/255; 192/255 205/255 223/255; 165/255 208/255 167/255; 245/255 222/255 169/255; 171/255 161/255 209/255; 245/255 222/255 169/255];
network_colors_sorted = network_colors(index_PC2,:);
network_colors_light_sorted = network_colors_light(index_PC2,:);

figure(2)
for eachPFN2 = 1:17
    bar(eachPFN2,pred_acc_PC2_samp1_ordered(eachPFN2),'BarWidth',0.3,'FaceColor',network_colors_sorted(eachPFN2,:),'EdgeColor','none')
    hold on
    bar(eachPFN2+0.3,pred_acc_PC2_samp2_ordered(eachPFN2),'BarWidth',0.3,'FaceColor',network_colors_light_sorted(eachPFN2,:),'EdgeColor','none')
end
xticks([1.15:1:17.15])
xticklabels(index_PC2)
xlabel('Personalized Functional Network','FontSize',14)
ylabel('Prediction Accuracy','FontSize',14)
box off


%% Learning/Memory


% load in colors for graph
network_colors =       [215/255 105/255 122/255; 124/255 152/255 190/255; 236/255 188/255 78/255; 124/255 152/255 190/255; 71/255 159/255 66/255; 161/255 61/255 168/255; 211/255 80/255 247/255; 215/255 105/255 122/255; 211/255 80/255 247/255; 161/255 61/255 168/255; 124/255 152/255 190/255; 215/255 105/255 122/255; 124/255 152/255 190/255; 71/255 159/255 66/255; 236/255 188/255 78/255; 74/255 50/255 162/255; 236/255 188/255 78/255];
network_colors_light = [234/255 183/255 191/255; 192/255 205/255 223/255; 245/255 222/255 169/255; 192/255 205/255 223/255; 165/255 208/255 167/255; 208/255 162/255 212/255; 230/255 165/255 250/255; 234/255 183/255 191/255; 230/255 165/255 250/255; 208/255 162/255 212/255; 192/255 205/255 223/255; 234/255 183/255 191/255; 192/255 205/255 223/255; 165/255 208/255 167/255; 245/255 222/255 169/255; 171/255 161/255 209/255; 245/255 222/255 169/255];
network_colors_sorted = network_colors(index_PC3,:);
network_colors_light_sorted = network_colors_light(index_PC3,:);

figure(3)
for eachPFN2 = 1:17
    bar(eachPFN2,pred_acc_PC3_samp1_ordered(eachPFN2),'BarWidth',0.3,'FaceColor',network_colors_sorted(eachPFN2,:),'EdgeColor','none')
    hold on
    bar(eachPFN2+0.3,pred_acc_PC3_samp2_ordered(eachPFN2),'BarWidth',0.3,'FaceColor',network_colors_light_sorted(eachPFN2,:),'EdgeColor','none')
end
xticks([1.15:1:17.15])
xticklabels(index_PC3)
xlabel('Personalized Functional Network','FontSize',14)
ylabel('Prediction Accuracy','FontSize',14)
box off

