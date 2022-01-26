function save_motion_mask(subj)
% load in subj
topleveldir='/scratch/abcdfnets/nda-abcd-s3-downloader/August_2021_DL/derivatives/abcd-hcp-pipeline/sub-*'
direc=dir(topleveldir);
% initialize empty vector for average length
TRvecNum=[];
% for each "task"
tasks=["rest"]%,"MID","SST","nback"];
for t=1:length(tasks)
    task=tasks(t);
    sname=subj;
    fpParent=['/scratch/abcdfnets/nda-abcd-s3-downloader/August_2021_DL/derivatives/abcd-hcp-pipeline/' sname '/ses-baselineYear1Arm1/func/'];
%    fp=strjoin([fpParent sname '_ses-baselineYear1Arm1_task-' task '_bold_desc-filtered_timeseries.dtseries.nii'],'');
    % not flagging missing tasks for now, added this conditional to reflect that
%    if exist(fp,'file')
%         ts_cif=read_cifti(fp);
%         ts=ts_cif.cdata;
        % load in mask
        masfp=strjoin([fpParent sname '_ses-baselineYear1Arm1_task-' task '_desc-filteredwithoutliers_motion_mask.mat'],'');
        %if exist(masfp,'file')
            
            [status,message,messageId]=copyfile(masfp,'/cbica/projects/abcdfnets/scripts/combined_PFNs_PGs/saved_motion_masks/','f')
            
%             mask=load(masfp);
%             % get to FD_thresh of .2 mm, corresponds to threshold 21
%             maskp2mm=mask.motion_data{1,21}.combined_removal;
%             TRwise_mask=logical(maskp2mm);
%             % length of mask corresponds to number of TRs
%             % 1 indicates flagged for FD over selected threshold, reverse 'em so 0 indicates removal
%             TRwise_mask=~TRwise_mask;
%             % remove TRs with corresp. flag
%             masked_trs=ts(:,TRwise_mask);
            % reconfig cifti metadata to reflect new number of TRs
%             newciftiSize=size(masked_trs);
%             newTRnum=newciftiSize(2);
            %s-2 because we start at 3
%             ts_cif.diminfo{2}.length=newTRnum;
%             % overwrite TRs for new file
%             ts_cif.cdata=masked_trs;
            % set output filepath
%            ofp=strjoin([fpParent sname '_ses-baselineYear1Arm1_task-' task '_p2mm_masked.dtseries.nii'],'');
%             % There is no reason this should be a requried step
%             ofp=convertStringsToChars(ofp);
%             % write out motion masked cifti
%             write_cifti(ts_cif,ofp);
%         else
%             missingDir=['/cbica/projects/abcdfnets/results/MissingDataReports/' sname];
%             mkdir(missingDir);
%             missingFile=[missingDir '/MissingData.txt'];
%             system(['echo motionMask_missing >> ' missingFile]);
        %end
   % else
   % end
end
