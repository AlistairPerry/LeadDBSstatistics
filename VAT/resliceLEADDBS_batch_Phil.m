function resliceLEADDBS_batch
%Adaption of this script to run on Phil's local machine
%   This script reslices the manually-calculated VAT volumes to the same dimensions as the normalised space
%run in spm12

%setup working and subjects directories
workingdirectory = pwd;
files = dir(workingdirectory);
dirFlags=[files.isdir];
subFolders=files(dirFlags);
subFolders(1:2)=[];

%load all subject information for creating spm batches
for s = 1:length(subFolders)
    currentSubj= subFolders(s,1).name;
    currentSubjDir = char([workingdirectory '/' currentSubj]);
    
    spm('defaults', 'fMRI');
    spm_jobman('initcfg');
    
    matlabbatchleft{1}.spm.spatial.coreg.write.ref = {['/Users/philipm/Desktop/Anatomical_Data/Lead_DBS_Analysis_PD/' currentSubj '/glanat.nii,1']};
    matlabbatchleft{1}.spm.spatial.coreg.write.source = {[currentSubjDir '/stimulations/FU2/' 'LEAD_DBS_VAT_LEFT.nii,1']};
    matlabbatchleft{1}.spm.spatial.coreg.write.roptions.interp = 0;
    matlabbatchleft{1}.spm.spatial.coreg.write.roptions.wrap = [0 0 0];
    matlabbatchleft{1}.spm.spatial.coreg.write.roptions.mask = 0;
    matlabbatchleft{1}.spm.spatial.coreg.write.roptions.prefix = 'r';
    
    spm_jobman('run',matlabbatchleft);
    
    spm('defaults', 'fMRI');
    spm_jobman('initcfg');
    
    matlabbatchright{1}.spm.spatial.coreg.write.ref = {['/Users/philipm/Desktop/Anatomical_Data/Lead_DBS_Analysis_PD/' currentSubj '/glanat.nii,1']};
    matlabbatchright{1}.spm.spatial.coreg.write.source = {[currentSubjDir '/stimulations/FU2/' 'LEAD_DBS_VAT_RIGHT.nii,1']};
    matlabbatchright{1}.spm.spatial.coreg.write.roptions.interp = 0;
    matlabbatchright{1}.spm.spatial.coreg.write.roptions.wrap = [0 0 0];
    matlabbatchright{1}.spm.spatial.coreg.write.roptions.mask = 0;
    matlabbatchright{1}.spm.spatial.coreg.write.roptions.prefix = 'r';
    
    spm_jobman('run',matlabbatchright);
    
end
end
