clear

% set up folders
HomeFolder = '/cbica/projects/abcdfnets/scripts';
SpinTest_Folder = [HomeFolder '/keller_spins'];
PermuteData_Folder = [SpinTest_Folder '/PermuteData'];
mkdir(PermuteData_Folder);
Configuration_Folder = [SpinTest_Folder '/Configuration'];
mkdir(Configuration_Folder);

% Spin permutation for group atlas
AtlasLabel_lh_CSV_Path = [SpinTest_Folder '/SA_AvgRank_LH.csv'];
AtlasLabel_rh_CSV_Path = [SpinTest_Folder '/SA_AvgRank_RH.csv'];
AtlasLabel_Perm_File = [PermuteData_Folder '/GroupAtlasLabel_Perm.mat'];
Configuration_File = [Configuration_Folder '/Configuration_Group.mat'];
save(Configuration_File, 'AtlasLabel_lh_CSV_Path', 'AtlasLabel_rh_CSV_Path', 'AtlasLabel_Perm_File');
ScriptPath = [Configuration_Folder '/Script_Group.sh'];
addpath(genpath('/cbica/projects/abcdfnets/scripts')
SpinPermuFS(AtlasLabel_lh_CSV_Path, AtlasLabel_rh_CSV_Path, 1000, AtlasLabel_Perm_File)

