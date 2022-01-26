function get_FD_ABCD(subj)
%%% This function will take a single subject's NDAR name, download their fMRI data and motion masks, concatenate the fMRI data, mask according to Robert's instructions (.2mm FD, power outliers out), derive a single-subject parcellation based on Cui et al. 2020's group template, and delete the input fMRI data.

% print subject being run
subj

% Add path to  miniconda for the python bits
addpath(genpath('/cbica/projects/abcdfnets/miniconda3/bin/python/'))

% add matlab path for used functions
addpath(genpath('/cbica/projects/abcdfnets/scripts/code_nmf_cifti/tool_folder'));

% tell it where AWS tools are for downloads
system('export PATH=/cbica/projects/abcdfnets/aws/dist/:$PATH')

% echo subj name into a .txt
subjTxtCommand=['echo ' subj ' >> /cbica/projects/abcdfnets/nda-abcd-s3-downloader/' subj '.txt'];
system(subjTxtCommand)

% make output folder
direcString=['/cbica/projects/abcdfnets/results/PGs_PFNs_output_justRest/' subj];
mkdirCommand=['mkdir ' direcString];
system(mkdirCommand)

% download that one subject's data
subjDlCommand=['/cbica/projects/abcdfnets/miniconda3/bin/python3 /cbica/projects/abcdfnets/nda-abcd-s3-downloader/download.py -i /cbica/projects/abcdfnets/nda-abcd-s3-downloader/datastructure_manifest_10_2.txt -o /scratch/abcdfnets/nda-abcd-s3-downloader/August_2021_DL/ -s /cbica/projects/abcdfnets/nda-abcd-s3-downloader/' subj '.txt -l /cbica/projects/abcdfnets/nda-abcd-s3-downloader/dl_logs -d /cbica/projects/abcdfnets/nda-abcd-s3-downloader/rest_subsets_justMotion.txt &']

% note: downloader tool does not seem to communicate when it is done to matlab
% added '&' and 'pause' so that matlab waits 5 minutes to proceed rather than getting caught up indefinitely
system(subjDlCommand)
pause(320)

% Save motion mask from the downloaded data
save_motion_mask(subj)

end
