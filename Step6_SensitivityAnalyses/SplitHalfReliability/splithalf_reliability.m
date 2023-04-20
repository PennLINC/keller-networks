
% This script will load in the PFN loadings for each of 10 participants from ABCD who had a sufficient duration of low-motion 
% high-quality resting-state data exceeding 20 minutes. We first computed PFNs in each 10-minute half of the data using the 
% approach described in the current manuscript. This script will load in those PFN loadings for each half of the data and save them 
% out in a format that can then be used to compute split half reliability.

% Set directory and subject list
cd('/Users/askeller/Documents/Kellernet_PrelimAnalysis/RevisionAnalyses_PFNsCog/SplitHalfReliability/SingleParcel_1by1_SH/')
subjList = {'sub-NDARINV3MTP07E9','sub-NDARINVG2PGTD44','sub-NDARINVE2GEK6A2','sub-NDARINVU9C9ZMKM','sub-NDARINV581KGKG6','sub-NDARINVK7B15B7Z','sub-NDARINVEBMR55XD','sub-NDARINVZ174YN3F','sub-NDARINV8720DP0M','sub-NDARINVRDJX9GRE'}; 
%saved_rs = [];

% Loop through each subject and extract UV matrices for part A and part B (each 10min half of the data)
for eachSubj = 1:10
eval(['finalUV_a = load(''/Users/askeller/Documents/Kellernet_PrelimAnalysis/RevisionAnalyses_PFNsCog/SplitHalfReliability/SingleParcel_1by1_SH/' char(subjList(eachSubj)) 'a/IndividualParcel_Final_sbj1_comp17_alphaS21_1_alphaL300_vxInfo1_ard0_eta0/final_UV.mat'');'])
eval(['finalUV_b = load(''/Users/askeller/Documents/Kellernet_PrelimAnalysis/RevisionAnalyses_PFNsCog/SplitHalfReliability/SingleParcel_1by1_SH/' char(subjList(eachSubj)) 'b/IndividualParcel_Final_sbj1_comp17_alphaS21_1_alphaL300_vxInfo1_ard0_eta0/final_UV.mat'');'])
V_a = double(cell2mat(finalUV_a.V));
V_b = double(cell2mat(finalUV_b.V));

% Save csvs of the loading matrices for each participant and each half of the data 
eval(['csvwrite(''/Users/askeller/Documents/Kellernet_PrelimAnalysis/RevisionAnalyses_PFNsCog/SplitHalfReliability/SingleParcel_1by1_SH/finalV_csvs/sub' num2str(eachSubj) '_Va.csv'',V_a)'])
eval(['csvwrite(''/Users/askeller/Documents/Kellernet_PrelimAnalysis/RevisionAnalyses_PFNsCog/SplitHalfReliability/SingleParcel_1by1_SH/finalV_csvs/sub' num2str(eachSubj) '_Vb.csv'',V_b)'])

end
