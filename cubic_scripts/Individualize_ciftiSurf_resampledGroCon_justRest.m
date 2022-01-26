function Individualize_ciftiSurf_resampledGroCon_justRest(subj)
% Based on the group atlas, creating each subject's individual specific atlas
ProjectFolder = '/cbica/projects/abcdfnets/results'

ResultantFolder = [ProjectFolder '/SingleParcel_1by1_Rest'];
mkdir(ResultantFolder);

PrepDataFile = [ProjectFolder '/SingleParcellation/CreatePrepData.mat'];

resId = 'IndividualParcel_Final';
% 7/2/21 - subbed in filled initResamp instead of "initResamp.mat"
initName = [ProjectFolder '/SingleParcellation/RobustInitialization_Cifti_Surf/initResamp.mat'];

K = 17;

% Use parameter in Hongming's NeuroImage paper, except for alphaL which we have expanded to account for the reduced smoothin in DCAN's pipeline
alphaS21 = 1;
alphaL = 300;
vxI = 1;
spaR = 1;
ard = 0;
iterNum = 30;
eta = 0;
calcGrp = 0;
parforOn = 0;


RawDataFolder = '/scratch/abcdfnets/nda-abcd-s3-downloader/August_2021_DL/derivatives/abcd-hcp-pipeline';
subj_dtseries=['/scratch/abcdfnets/nda-abcd-s3-downloader/August_2021_DL/derivatives/abcd-hcp-pipeline/*/*/*/' subj '_ses-baselineYear1Arm1_task-rest_p2mm_masked.dtseries.nii*'];
CiftiCell = g_ls(subj_dtseries)


% Parcellate the subject - load filepath, subject name, and 
[Fold, ~, ~] = fileparts(CiftiCell{1});
FoldStr = strsplit(Fold, '/');
ID_Str = FoldStr{8};
ResultantFolder_I = [ResultantFolder '/' ID_Str];
ResultFile_check = dir([ResultantFolder_I, '/**/final*.mat']);

% check for existing directory
if ~exist(ResultantFolder_I, 'dir')
   mkdir(ResultantFolder_I);
end
IDMatFile = [ResultantFolder_I '/ID.mat'];
save(IDMatFile, 'ID_Str');

sbjListFile = [ResultantFolder_I '/sbjListAllFile.txt'];
system(['rm -rf ' sbjListFile]);

cmd = ['echo ' CiftiCell{1} ' >> ' sbjListFile];
system(cmd);

deployFuncMvnmfL21p1_func_cifti(sbjListFile,PrepDataFile,ResultantFolder_I,resId,initName,K,alphaS21,alphaL,vxI,spaR,ard,eta,iterNum,calcGrp,parforOn)

