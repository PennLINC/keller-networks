% This script will be used to replicate Cui et al. 2020 Neuron Figure 3B
% (or at least prep the matrices we need to do so).


clear all

%file_pattern='/gpfs/fs001/cbica/projects/abcdfnets/results/SingleParcel_1by1/sub-NDARINV*/IndividualParcel_Final_sbj1_comp17_alphaS21_1_alphaL300_vxInfo1_ard0_eta0/final_UV.mat'
file_pattern='/cbica/projects/abcdfnets/results/SingleParcel_1by1/sub-NDARINV*/IndividualParcel_Final_sbj1_comp17_alphaS21_1_alphaL300_vxInfo1_ard0_eta0/final_UV.mat'
data_dir=dir(file_pattern);
data_locations=fullfile({data_dir.folder}, {data_dir.name});

% initialize matrices
for eachNetwork1 = 1:17
    eval(['sbj_by_vtx_network' num2str(eachNetwork1) ' = [];'])
end


% Get a separate subject x vertex matrix for each network
for i = 1:length(data_locations)
    i
    UV=load(char(data_locations(i)));
    V=UV.V; % The V matrix contains the loadings at each vertex by network
    V=cell2mat(V);

    % ASK is adding this for variability_by_pfn3 to see whether trimming
    % these small loadings helps:

    % apply ZC code from step 6th - subject AtlasLabel will have parcels for viz
    V_Max = max(V);
    trimInd = V ./ max(repmat(V_Max, size(V, 1), 1), eps) < 5e-2;
    V(trimInd) = 0;
    %sbj_AtlasLoading_NoMedialWall = V;
    %[~, sbj_AtlasLabel_NoMedialWall] = max(sbj_AtlasLoading_NoMedialWall, [], 2);


    % Loop through each network, get vtx x subj matrix, then transpose
    for eachNetwork2 = 1:17
        eval(['sbj_by_vtx_network' num2str(eachNetwork2) '=[sbj_by_vtx_network' num2str(eachNetwork2) ' V(:,eachNetwork2)];'])
    end
end


% Loop through each network's subject x vertex matrix and calculate
% the across-subject variability
Variability_All = zeros(17, size(V,1)); % networks by vertices
for m = 1:17
    m
    eval(['sbj_by_vtx_network' num2str(m) ' = sbj_by_vtx_network' num2str(m) ''';'])
    for n = 1:size(sbj_by_vtx_network1,2)
        cmd = ['tmp_data = sbj_by_vtx_network' num2str(m) '(:, n);'];
        eval(cmd);
        Variability_All(m,n) = median(abs(tmp_data(tmp_data>0) - median(tmp_data(tmp_data>0)))); % ASK added this tmp_data>0 because a lot of our indices have loadings that are exactly 0
        %Variability_All(m,n) = median(abs(tmp_data - median(tmp_data)));
    end
end

save('VariabilityByPFN_Trimmed.mat','Variability_All')