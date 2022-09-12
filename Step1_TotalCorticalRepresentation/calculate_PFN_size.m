% This script will loop through the PFNs output and calculate the total
% cortical representation (PFN "size") as the sum of loadings for each PFN

file_pattern='/cbica/projects/abcdfnets/results/SingleParcel_1by1/sub-NDARINV*/IndividualParcel_Final_sbj1_comp17_alphaS21_1_alphaL300_vxInfo1_ard0_eta0/final_UV.mat'
data_dir=dir(file_pattern);
data_locations=fullfile({data_dir.folder}, {data_dir.name});

% initialize table
df=cell(length(data_locations),2);

% loop through each data location to extract PFN size
for i = 1:length(data_locations)
	UV=load(char(data_locations(i))); % UV matrix is result of NMF
	V=UV.V; % just take the V matrix with network loadings by vertex
	V2=V{:};
	stringsplit=split(char(data_locations(i)),'/');
	subjname=stringsplit(9); % note this will depend on subject ID style
	df(i,1)=subjname; % save out the sub ID
    for eachNetwork = 1:17
	df(i,eachNetwork+1)=num2cell(sum(V2(:,eachNetwork))); % sum loadings
    end
	i
end

writetable(cell2table(df),'/cbica/projects/abcdfnets/scripts/keller_ridge/pennlinc-regression/example_keller/All_PFN_sizes.csv')
	