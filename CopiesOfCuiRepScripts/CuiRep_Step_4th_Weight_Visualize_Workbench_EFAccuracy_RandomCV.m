

clear all

% Add package to read NPY files into matlab
addpath('/Users/askeller/Documents/npy-matlab/')

% note: the coefs matrix is 10 rows (folds) x 1010004 (weights at each of 59,412 vertices for each of 17 networks)
coefs = readNPY('/Users/askeller/Documents/Kellernet_PrelimAnalysis/RidgeResults/results_Mar2922/all_network/thompson_PC1_coefs.npy');

% Average over 10 folds
coefs_avg = mean(coefs,1);



% ReplicationFolder = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication';
% PredictionFolder = [ReplicationFolder '/Revision/PredictionAnalysis/AtlasLoading/'];
% Results_Cell = g_ls([PredictionFolder '/2Fold_RandomCV_EFAccuracy/Time_*/Fold_*_Score.mat']);
% for i = 1:length(Results_Cell)
% tmp = load(Results_Cell{i});
% w_Brain_EFAccuracy_AllModels(i, :) = tmp.w_Brain;
% end
%w_Brain_EFAccuracy = mean(w_Brain_EFAccuracy_AllModels);
%VisualizeFolder = [PredictionFolder '/WeightVisualize_EFAccuracy_RandomCV'];
%mkdir(VisualizeFolder);

% SubjectsFolder = '/share/apps/freesurfer/6.0.0/subjects/fsaverage5';
% % for surface data
% surfML = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication/data/SNR_Mask/subjects/fsaverage5/lh.Mask_SNR.label';
% mwIndVec_l = read_medial_wall_label(surfML);
% Index_l = setdiff([1:10242], mwIndVec_l);
% surfMR = '/data/jux/BBL/projects/pncSingleFuncParcel/Replication/data/SNR_Mask/subjects/fsaverage5/rh.Mask_SNR.label';
% mwIndVec_r = read_medial_wall_label(surfMR);
% Index_r = setdiff([1:10242], mwIndVec_r);

% load([PredictionFolder '/AtlasLoading_All_RemoveZero.mat']); % NonZeroIndex was here


%%

%%%%%%%%%%%%%%%%%%%%%%%%%
% EFAccuracy Prediction %
%%%%%%%%%%%%%%%%%%%%%%%%%

VertexQuantity = 59412; % 17734;

% Display the weight of the first 25% regions with the highest absolute weight
        % mkdir([VisualizeFolder '/First25Percent']);
w_Brain_EFAccuracy_Abs = abs(coefs_avg); %abs(w_Brain_EFAccuracy);
[~, Sorted_IDs] = sort(w_Brain_EFAccuracy_Abs);
w_Brain_EFAccuracy_FirstPercent = w_Brain_EFAccuracy_Abs;
w_Brain_EFAccuracy_FirstPercent(Sorted_IDs(1:round(length(Sorted_IDs) * 0.75))) = 0;

%w_Brain_EFAccuracy_FirstPercent_All = zeros(1, VertexQuantity*17); %zeros(1, 17734*17);
%w_Brain_EFAccuracy_FirstPercent_All(NonZeroIndex) = w_Brain_EFAccuracy_FirstPercent;

%EFAccuracyEffect_Folder = [ReplicationFolder '/Revision/GamAnalysis/AtlasLoading/EFAccuracyEffects'];

% for i = 1:17
%     i
%     w_Brain_EFAccuracy_FirstPercent_I = w_Brain_EFAccuracy_FirstPercent_All([(i - 1) * VertexQuantity + 1 : i * VertexQuantity]);
%     % left hemi
%     w_Brain_EFAccuracy_FirstPercent_lh = zeros(1, 10242);
%     w_Brain_EFAccuracy_FirstPercent_lh(Index_l) = w_Brain_EFAccuracy_FirstPercent_I(1:length(Index_l));
%     V_lh = gifti;
%     V_lh.cdata = w_Brain_EFAccuracy_FirstPercent_lh';
%     V_lh_File = [VisualizeFolder '/First25Percent/w_Brain_EFAccuracy_First25Percent_lh_Network_' num2str(i) '.func.gii'];
%     save(V_lh, V_lh_File);
% 
%     % right hemi
%     w_Brain_EFAccuracy_FirstPercent_rh = zeros(1, 10242);
%     w_Brain_EFAccuracy_FirstPercent_rh(Index_r) = w_Brain_EFAccuracy_FirstPercent_I(length(Index_l) + 1:end);
%     V_rh = gifti;
%     V_rh.cdata = w_Brain_EFAccuracy_FirstPercent_rh';
%     V_rh_File = [VisualizeFolder '/First25Percent/w_Brain_EFAccuracy_First25Percent_rh_Network_' num2str(i) '.func.gii'];
%     save(V_rh, V_rh_File);
%     % convert into cifti file
%     cmd = ['wb_command -cifti-create-dense-scalar ' VisualizeFolder '/First25Percent/w_Brain_EFAccuracy_First25Percent_Network_' ...
%         num2str(i) '.dscalar.nii -left-metric ' V_lh_File ' -right-metric ' V_rh_File];
%     system(cmd);
% end

% Absolute sum weights
w_Brain_EFAccuracy_All = zeros(1, VertexQuantity*17);
w_Brain_EFAccuracy_All(w_Brain_EFAccuracy_FirstPercent>0) = coefs_avg(w_Brain_EFAccuracy_FirstPercent>0);

%% Display weight of all regions
for i = 1:17
    w_Brain_EFAccuracy_Matrix(i, :) = w_Brain_EFAccuracy_All([(i - 1) * VertexQuantity + 1 : i * VertexQuantity]);
end
save(['/Users/askeller/Documents/Kellernet_PrelimAnalysis/CuiRep_7C_SumLoadings/w_Brain_EFAccuracy_Matrix.mat'], 'w_Brain_EFAccuracy_Matrix');



%% PC 2

clear all

% Add package to read NPY files into matlab
addpath('/Users/askeller/Documents/npy-matlab/')

% note: the coefs matrix is 10 rows (folds) x 1010004 (weights at each of 59,412 vertices for each of 17 networks)
coefs = readNPY('/Users/askeller/Documents/Kellernet_PrelimAnalysis/RidgeResults/results_Mar2922/all_network/thompson_PC2_coefs.npy');

% Average over 10 folds
coefs_avg = mean(coefs,1);

VertexQuantity = 59412; % 17734;

% Display the weight of the first 25% regions with the highest absolute weight
w_Brain_EFAccuracy_Abs = abs(coefs_avg); %abs(w_Brain_EFAccuracy);
[~, Sorted_IDs] = sort(w_Brain_EFAccuracy_Abs);
w_Brain_EFAccuracy_FirstPercent = w_Brain_EFAccuracy_Abs;
w_Brain_EFAccuracy_FirstPercent(Sorted_IDs(1:round(length(Sorted_IDs) * 0.75))) = 0;

% Absolute sum weights
w_Brain_EFAccuracy_All = zeros(1, VertexQuantity*17);
w_Brain_EFAccuracy_All(w_Brain_EFAccuracy_FirstPercent>0) = coefs_avg(w_Brain_EFAccuracy_FirstPercent>0);

% Display weight of all regions
for i = 1:17
    w_Brain_EFAccuracy_Matrix(i, :) = w_Brain_EFAccuracy_All([(i - 1) * VertexQuantity + 1 : i * VertexQuantity]);
end
save(['/Users/askeller/Documents/Kellernet_PrelimAnalysis/CuiRep_7C_SumLoadings/w_Brain_EFAccuracy_Matrix_PC2.mat'], 'w_Brain_EFAccuracy_Matrix');


%% PC 3

clear all

% Add package to read NPY files into matlab
addpath('/Users/askeller/Documents/npy-matlab/')

% note: the coefs matrix is 10 rows (folds) x 1010004 (weights at each of 59,412 vertices for each of 17 networks)
coefs = readNPY('/Users/askeller/Documents/Kellernet_PrelimAnalysis/RidgeResults/results_Mar2922/all_network/thompson_PC3_coefs.npy');

% Average over 10 folds
coefs_avg = mean(coefs,1);

VertexQuantity = 59412; % 17734;

% Display the weight of the first 25% regions with the highest absolute weight
w_Brain_EFAccuracy_Abs = abs(coefs_avg); %abs(w_Brain_EFAccuracy);
[~, Sorted_IDs] = sort(w_Brain_EFAccuracy_Abs);
w_Brain_EFAccuracy_FirstPercent = w_Brain_EFAccuracy_Abs;
w_Brain_EFAccuracy_FirstPercent(Sorted_IDs(1:round(length(Sorted_IDs) * 0.75))) = 0;

% Absolute sum weights
w_Brain_EFAccuracy_All = zeros(1, VertexQuantity*17);
w_Brain_EFAccuracy_All(w_Brain_EFAccuracy_FirstPercent>0) = coefs_avg(w_Brain_EFAccuracy_FirstPercent>0);

% Display weight of all regions
for i = 1:17
    w_Brain_EFAccuracy_Matrix(i, :) = w_Brain_EFAccuracy_All([(i - 1) * VertexQuantity + 1 : i * VertexQuantity]);
end
save(['/Users/askeller/Documents/Kellernet_PrelimAnalysis/CuiRep_7C_SumLoadings/w_Brain_EFAccuracy_Matrix_PC3.mat'], 'w_Brain_EFAccuracy_Matrix');



