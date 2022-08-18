%file_pattern='/gpfs/fs001/cbica/projects/abcdfnets/results/SingleParcel_1by1/sub-NDARINV*/IndividualParcel_Final_sbj1_comp17_alphaS21_1_alphaL300_vxInfo1_ard0_eta0/final_UV.mat'
file_pattern='/Users/ariellekeller/Documents/CubicMounts/sub-NDARINV*/IndividualParcel_Final_sbj1_comp17_alphaS21_1_alphaL300_vxInfo1_ard0_eta0/final_UV.mat'
data_dir=dir(file_pattern);
data_locations=fullfile({data_dir.folder}, {data_dir.name});

% initialize table
df=cell(length(data_locations),2);

for i = 1:length(data_locations)
	UV=load(char(data_locations(i)));
	V=UV.V;
	V2=V{:};
% 	FP1=sum(V2(:,3));
% 	FP2=sum(V2(:,15));
% 	FP3=sum(V2(:,17));
% 	FP_tot=FP1+FP2+FP3;
	stringsplit=split(char(data_locations(i)),'/');
	subjname=stringsplit(6);
	df(i,1)=subjname;
    for eachNetwork = 1:17
	df(i,eachNetwork+1)=num2cell(sum(V2(:,eachNetwork)));
    end
	i
end
writetable(cell2table(df),'~/All_PFN_sizes_Rest_030722.csv')
	




%% doing this again for resting state only PFNs, but on cubic

%file_pattern='/gpfs/fs001/cbica/projects/abcdfnets/results/SingleParcel_1by1/sub-NDARINV*/IndividualParcel_Final_sbj1_comp17_alphaS21_1_alphaL300_vxInfo1_ard0_eta0/final_UV.mat'
file_pattern='/cbica/projects/abcdfnets/results/SingleParcel_1by1_Rest/sub-NDARINV*/IndividualParcel_Final_sbj1_comp17_alphaS21_1_alphaL300_vxInfo1_ard0_eta0/final_UV.mat'
data_dir=dir(file_pattern);
data_locations=fullfile({data_dir.folder}, {data_dir.name});

% initialize table
df=cell(length(data_locations),2);

for i = 1:length(data_locations)
	UV=load(char(data_locations(i)));
	V=UV.V;
	V2=V{:};
% 	FP1=sum(V2(:,3));
% 	FP2=sum(V2(:,15));
% 	FP3=sum(V2(:,17));
% 	FP_tot=FP1+FP2+FP3;
	stringsplit=split(char(data_locations(i)),'/');
	subjname=stringsplit(9);
	df(i,1)=subjname;
    for eachNetwork = 1:17
	df(i,eachNetwork+1)=num2cell(sum(V2(:,eachNetwork)));
    end
	i
end
writetable(cell2table(df),'/cbica/projects/abcdfnets/scripts/keller_ridge/pennlinc-regression/example_keller/All_PFN_sizes_Rest_081122.csv')
	
