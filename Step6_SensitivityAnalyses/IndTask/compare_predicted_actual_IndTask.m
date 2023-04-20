
% NOTE: this script is meant to be run with the matlab GUI to make figures

clear all

% Add package to read NPY files into matlab
addpath('/Users/askeller/Documents/npy-matlab/')

% List the cognitive variables:
cog_vars = {'PicVocab','Flanker','Pattern','Reading','Picture','List','CardSort','LMT','RAVLT'};

% Specify results folder and data_for_ridge file location
folder_name='/Users/askeller/Documents/Kellernet_PrelimAnalysis/RevisionAnalyses_PFNsCog/IndTask/results/all_network/';
data_for_ridge=xlsread('/Users/askeller/Documents/Kellernet_PrelimAnalysis/Keller_PFNsCognition_Codebase_Revision/Step6_SensitivityAnalyses/IndTask/data_for_ridge_IndTask.xls');
% note: column order is this "PicVocab","Flanker","Pattern","Reading","Picture","List","CardSort","LMT","RAVLT","matched_group","interview_age","sex","meanFD","abcd_site","rel_family_id"

% Loop through each outcome variable
for cog = 1:length(cog_vars)

% Load in prediction results
eval(['file_name_samp1=''' char(cog_vars(cog)) '_prediction_testA.npy'';'])
eval(['file_name_samp2=''' char(cog_vars(cog)) '_prediction_testB.npy'';'])
eval(['pred_' char(cog_vars(cog)) '_samp1 = readNPY([folder_name ''/'' file_name_samp1]);'])
eval(['pred_' char(cog_vars(cog)) '_samp2 = readNPY([folder_name ''/'' file_name_samp2]);'])

end


% Load in actual cognitive scores and split by matched group
actual_PicVocab_samp1 = data_for_ridge(data_for_ridge(:,10)==1,1);
actual_Flanker_samp1 = data_for_ridge(data_for_ridge(:,10)==1,2);
actual_Pattern_samp1 = data_for_ridge(data_for_ridge(:,10)==1,3);
actual_Reading_samp1 = data_for_ridge(data_for_ridge(:,10)==1,4);
actual_Picture_samp1 = data_for_ridge(data_for_ridge(:,10)==1,5);
actual_List_samp1 = data_for_ridge(data_for_ridge(:,10)==1,6);
actual_CardSort_samp1 = data_for_ridge(data_for_ridge(:,10)==1,7);
actual_LMT_samp1 = data_for_ridge(data_for_ridge(:,10)==1,8);
actual_RAVLT_samp1 = data_for_ridge(data_for_ridge(:,10)==1,9);

actual_PicVocab_samp2 = data_for_ridge(data_for_ridge(:,10)==2,1);
actual_Flanker_samp2 = data_for_ridge(data_for_ridge(:,10)==2,2);
actual_Pattern_samp2 = data_for_ridge(data_for_ridge(:,10)==2,3);
actual_Reading_samp2 = data_for_ridge(data_for_ridge(:,10)==2,4);
actual_Picture_samp2 = data_for_ridge(data_for_ridge(:,10)==2,5);
actual_List_samp2 = data_for_ridge(data_for_ridge(:,10)==2,6);
actual_CardSort_samp2 = data_for_ridge(data_for_ridge(:,10)==2,7);
actual_LMT_samp2 = data_for_ridge(data_for_ridge(:,10)==2,8);
actual_RAVLT_samp2 = data_for_ridge(data_for_ridge(:,10)==2,9);


 

%% Plotting

% load colors
color_fill = gray(10);
color_fill_1 = color_fill(1,:);
color_fill_2 = color_fill(7,:);

figure()
subplot(5,2,1)
scatter(actual_PicVocab_samp2,pred_PicVocab_samp2,8,color_fill_2,'Marker','^','MarkerFaceColor',color_fill_2)
[r,p,ci,stats]=corrcoef(actual_PicVocab_samp2,pred_PicVocab_samp2)
hold on
scatter(actual_PicVocab_samp1,pred_PicVocab_samp1,45,color_fill_1,'Marker','.')
[r,p,ci,stats]=corrcoef(actual_PicVocab_samp1,pred_PicVocab_samp1)
hold on
linearFit = polyfit(actual_PicVocab_samp1,pred_PicVocab_samp1,1);
hline = refline(linearFit);
hline.Color=color_fill_1;
hline.LineWidth=2;
hold on
linearFit = polyfit(actual_PicVocab_samp2,pred_PicVocab_samp2,1);
hline = refline(linearFit);
hline.Color=color_fill_2;
hline.LineWidth=2;
xlabel("Actual",'FontSize',14)
ylabel("Predicted",'FontSize',14)
%axis([-5 5 -5 5])
title('PicVocab')

subplot(5,2,2)
scatter(actual_Flanker_samp2,pred_Flanker_samp2,8,color_fill_2,'Marker','^','MarkerFaceColor',color_fill_2)
[r,p,ci,stats]=corrcoef(actual_Flanker_samp2,pred_Flanker_samp2)
hold on
scatter(actual_Flanker_samp1,pred_Flanker_samp1,45,color_fill_1,'Marker','.')
[r,p,ci,stats]=corrcoef(actual_Flanker_samp1,pred_Flanker_samp1)
hold on
linearFit = polyfit(actual_Flanker_samp1,pred_Flanker_samp1,1);
hline = refline(linearFit);
hline.Color=color_fill_1;
hline.LineWidth=2;
hold on
linearFit = polyfit(actual_Flanker_samp2,pred_Flanker_samp2,1);
hline = refline(linearFit);
hline.Color=color_fill_2;
hline.LineWidth=2;
xlabel("Actual",'FontSize',14)
ylabel("Predicted",'FontSize',14)
%axis([-5 5 -5 5])
title('Flanker')

subplot(5,2,3)
scatter(actual_Pattern_samp2,pred_Pattern_samp2,8,color_fill_2,'Marker','^','MarkerFaceColor',color_fill_2)
[r,p,ci,stats]=corrcoef(actual_Pattern_samp2,pred_Pattern_samp2)
hold on
scatter(actual_Pattern_samp1,pred_Pattern_samp1,45,color_fill_1,'Marker','.')
[r,p,ci,stats]=corrcoef(actual_Pattern_samp1,pred_Pattern_samp1)
hold on
linearFit = polyfit(actual_Pattern_samp1,pred_Pattern_samp1,1);
hline = refline(linearFit);
hline.Color=color_fill_1;
hline.LineWidth=2;
hold on
linearFit = polyfit(actual_Pattern_samp2,pred_Pattern_samp2,1);
hline = refline(linearFit);
hline.Color=color_fill_2;
hline.LineWidth=2;
xlabel("Actual",'FontSize',14)
ylabel("Predicted",'FontSize',14)
%axis([-5 5 -5 5])
title('Pattern')

subplot(5,2,4)
scatter(actual_Reading_samp2,pred_Reading_samp2,8,color_fill_2,'Marker','^','MarkerFaceColor',color_fill_2)
[r,p,ci,stats]=corrcoef(actual_Reading_samp2,pred_Reading_samp2)
hold on
scatter(actual_Reading_samp1,pred_Reading_samp1,45,color_fill_1,'Marker','.')
[r,p,ci,stats]=corrcoef(actual_Reading_samp1,pred_Reading_samp1)
hold on
linearFit = polyfit(actual_Reading_samp1,pred_Reading_samp1,1);
hline = refline(linearFit);
hline.Color=color_fill_1;
hline.LineWidth=2;
hold on
linearFit = polyfit(actual_Reading_samp2,pred_Reading_samp2,1);
hline = refline(linearFit);
hline.Color=color_fill_2;
hline.LineWidth=2;
xlabel("Actual",'FontSize',14)
ylabel("Predicted",'FontSize',14)
%axis([-5 5 -5 5])
title('Reading')

subplot(5,2,5)
scatter(actual_Picture_samp2,pred_Picture_samp2,8,color_fill_2,'Marker','^','MarkerFaceColor',color_fill_2)
[r,p,ci,stats]=corrcoef(actual_Picture_samp2,pred_Picture_samp2)
hold on
scatter(actual_Picture_samp1,pred_Picture_samp1,45,color_fill_1,'Marker','.')
[r,p,ci,stats]=corrcoef(actual_Picture_samp1,pred_Picture_samp1)
hold on
linearFit = polyfit(actual_Picture_samp1,pred_Picture_samp1,1);
hline = refline(linearFit);
hline.Color=color_fill_1;
hline.LineWidth=2;
hold on
linearFit = polyfit(actual_Picture_samp2,pred_Picture_samp2,1);
hline = refline(linearFit);
hline.Color=color_fill_2;
hline.LineWidth=2;
xlabel("Actual",'FontSize',14)
ylabel("Predicted",'FontSize',14)
%axis([-5 5 -5 5])
title('Picture')

subplot(5,2,6)
scatter(actual_LMT_samp2,pred_LMT_samp2,15,color_fill_2,'Marker','^','MarkerFaceColor',color_fill_2)
[r,p,ci,stats]=corrcoef(actual_LMT_samp2,pred_LMT_samp2)
hold on
scatter(actual_LMT_samp1,pred_LMT_samp1,75,color_fill_1,'Marker','.')
[r,p,ci,stats]=corrcoef(actual_LMT_samp1,pred_LMT_samp1)
hold on
linearFit = polyfit(actual_LMT_samp1,pred_LMT_samp1,1);
hline = refline(linearFit);
hline.Color=color_fill_1;
hline.LineWidth=2;
hold on
linearFit = polyfit(actual_LMT_samp2,pred_LMT_samp2,1);
hline = refline(linearFit);
hline.Color=color_fill_2;
hline.LineWidth=2;
xlabel("Actual",'FontSize',16)
ylabel("Predicted",'FontSize',16)
%axis([-5 5 -5 5])
title('LMT')

subplot(5,2,7)
scatter(actual_RAVLT_samp2,pred_RAVLT_samp2,15,color_fill_2,'Marker','^','MarkerFaceColor',color_fill_2)
[r,p,ci,stats]=corrcoef(actual_RAVLT_samp2,pred_RAVLT_samp2)
hold on
scatter(actual_RAVLT_samp1,pred_RAVLT_samp1,75,color_fill_1,'Marker','.')
[r,p,ci,stats]=corrcoef(actual_RAVLT_samp1,pred_RAVLT_samp1)
hold on
linearFit = polyfit(actual_RAVLT_samp1,pred_RAVLT_samp1,1);
hline = refline(linearFit);
hline.Color=color_fill_1;
hline.LineWidth=2;
hold on
linearFit = polyfit(actual_RAVLT_samp2,pred_RAVLT_samp2,1);
hline = refline(linearFit);
hline.Color=color_fill_2;
hline.LineWidth=2;
xlabel("Actual",'FontSize',16)
ylabel("Predicted",'FontSize',16)
%axis([-5 5 -5 5])
title('RAVLT')


subplot(5,2,8)
scatter(actual_List_samp2,pred_List_samp2,15,color_fill_2,'Marker','^','MarkerFaceColor',color_fill_2)
[r,p,ci,stats]=corrcoef(actual_List_samp2,pred_List_samp2)
hold on
scatter(actual_List_samp1,pred_List_samp1,75,color_fill_1,'Marker','.')
[r,p,ci,stats]=corrcoef(actual_List_samp1,pred_List_samp1)
hold on
linearFit = polyfit(actual_List_samp1,pred_List_samp1,1);
hline = refline(linearFit);
hline.Color=color_fill_1;
hline.LineWidth=2;
hold on
linearFit = polyfit(actual_List_samp2,pred_List_samp2,1);
hline = refline(linearFit);
hline.Color=color_fill_2;
hline.LineWidth=2;
xlabel("Actual",'FontSize',16)
ylabel("Predicted",'FontSize',16)
%axis([-5 5 -5 5])
title('List')



subplot(5,2,9)
scatter(actual_CardSort_samp2,pred_CardSort_samp2,15,color_fill_2,'Marker','^','MarkerFaceColor',color_fill_2)
[r,p,ci,stats]=corrcoef(actual_CardSort_samp2,pred_CardSort_samp2)
hold on
scatter(actual_CardSort_samp1,pred_CardSort_samp1,75,color_fill_1,'Marker','.')
[r,p,ci,stats]=corrcoef(actual_CardSort_samp1,pred_CardSort_samp1)
hold on
linearFit = polyfit(actual_CardSort_samp1,pred_CardSort_samp1,1);
hline = refline(linearFit);
hline.Color=color_fill_1;
hline.LineWidth=2;
hold on
linearFit = polyfit(actual_CardSort_samp2,pred_CardSort_samp2,1);
hline = refline(linearFit);
hline.Color=color_fill_2;
hline.LineWidth=2;
xlabel("Actual",'FontSize',16)
ylabel("Predicted",'FontSize',16)
%axis([-5 5 -5 5])
title('CardSort')



%% Print r and p vals:

% List the cognitive variables:
cog_vars = {'PicVocab','Flanker','Pattern','Reading','Picture','List','CardSort','LMT','RAVLT'};

% Loop through each outcome variable
for cog = 1:length(cog_vars)

eval(['[r,p]=corrcoef(actual_' char(cog_vars(cog))  '_samp1,pred_' char(cog_vars(cog))  '_samp1);'])
eval(['r_' char(cog_vars(cog))  '_Disc = r(1,2)'])
eval(['p_' char(cog_vars(cog))  '_Disc = p(1,2)'])
eval(['[r,p]=corrcoef(actual_' char(cog_vars(cog))  '_samp2,pred_' char(cog_vars(cog))  '_samp2);'])
eval(['r_' char(cog_vars(cog))  '_Rep = r(1,2)'])
eval(['p_' char(cog_vars(cog))  '_Rep = p(1,2)'])

end

