function CalculateCCLEResults
% Calculate results from the CCLE data

%% Directory paths
try
    MRA_Options;
catch
    error('Could not load MRA_Options.m file\n Make sure the GitHub library is added to the path')
end

CCLEDir = (fullfile(Opt.BaseDir,Opt.SubDirs.CCLEDir));


% Melnoma

load(fullfile(CCLEDir,"CCLE_Radiation.mat"),"CCLE_Radiation")

MEL_indx = any(contains(CCLE_Radiation.RowAnnotation,'melanoma','IgnoreCase',true),2);
CCLE_Melanoma  = EditSamplesDATA(CCLE_Radiation,CCLE_Radiation.RowId(MEL_indx),'Keep');


% Get AUC
indx_AUC = strncmp('AUC',CCLE_Melanoma.RowAnnotationFields,9);
AUC_MEL=CCLE_Melanoma.RowAnnotation(:,indx_AUC);
AUC_MEL=cellfun(@(x) str2double(x), AUC_MEL, 'UniformOutput', 0);
AUC_MEL = cell2mat(AUC_MEL);

c=strings(length(AUC_MEL),1);
c(AUC_MEL < median(AUC_MEL)) = {"AUC Low"};
c(AUC_MEL >= median(AUC_MEL)) = {"AUC High"};
CCLE_Melanoma.RowAnnotation=[CCLE_Melanoma.RowAnnotation c];
CCLE_Melanoma.RowAnnotationFields(end+1)={'AUC Group'};

save(fullfile(CCLEDir,"CCLE_Melanoma.mat"),"CCLE_Melanoma")
save(fullfile(CCLEDir,"AUC_MEL.mat"),"AUC_MEL")
% High vs Low

RESULTS_CCLE_Melanoma_AUC_High_vs_Low = CalculateDiffResults(CCLE_Melanoma,'AUC Low','AUC High','AUC Group','M-value');
RESULTS_CCLE_Melanoma_AUC_Corr = CalculateCorrelationResults(CCLE_Melanoma,AUC_MEL,[],[],'M-value');

save(fullfile(CCLEDir,"RESULTS_CCLE_Melanoma_AUC_High_vs_Low.mat"),"RESULTS_CCLE_Melanoma_AUC_High_vs_Low")
save(fullfile(CCLEDir,"RESULTS_CCLE_Melanoma_AUC_Corr.mat"),"RESULTS_CCLE_Melanoma_AUC_Corr")


