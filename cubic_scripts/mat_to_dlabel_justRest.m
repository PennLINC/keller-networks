function mat_to_dlabel_justRest(subj)

%%%
ProjectFolder = '/cbica/projects/abcdfnets/results';
OutputFolder = ['/cbica/projects/abcdfnets/results/SingleParcel_1by1_Rest/' subj '/'];
%%%

% resampled V of interest (group or individ - CHANGE AS FIT TO MATCH NAME)
finalUVFile=['/cbica/projects/abcdfnets/results/SingleParcel_1by1_Rest/' subj '/IndividualParcel_Final_sbj1_comp17_alphaS21_1_alphaL300_vxInfo1_ard0_eta0/final_UV.mat'];
Loading_Mat=load(finalUVFile);
V=Loading_Mat.V;
% extract from struct
V=V{:};

% apply ZC code from step 6th - subject AtlasLabel will have parcels for viz
V_Max = max(V);
trimInd = V ./ max(repmat(V_Max, size(V, 1), 1), eps) < 5e-2;
V(trimInd) = 0;
sbj_AtlasLoading_NoMedialWall = V;
[~, sbj_AtlasLabel_NoMedialWall] = max(sbj_AtlasLoading_NoMedialWall, [], 2);

% cifti to replace cdata in
HP=cifti_read('/cbica/projects/abcdfnets/results/SingleParcellation/RobustInitialization_Cifti_Surf/robust_initVHP.dscalar.nii');
HP.cdata(1:59412)=sbj_AtlasLabel_NoMedialWall;
outputfile=['/cbica/projects/abcdfnets/results/SingleParcel_1by1_Rest/' subj '/' subj '_Parcel.dscalar.nii'];
cifti_write(HP,outputfile)
