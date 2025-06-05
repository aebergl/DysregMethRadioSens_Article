function CalculateM450Results

% Function for processing Illumina M450K Pancancer data for "A dysregulated methylome modulates the radiosensitivity of cancer" article
% Anders Berglund 2025
%% Directory paths
try
    MRA_Options;
catch
    error('Could not load MRA_Options.m file\n Make sure the GitHub library is added to the path')
end

%% Data directory

DataDirectory = (fullfile(Opt.BaseDir,Opt.SubDirs.DataDir));
ResultDirectory = (fullfile(Opt.BaseDir,Opt.SubDirs.ResultDir));

%% Calculate melanoma datasets, SKCM

load(fullfile(DataDirectory,"SKCM_M450_RT.mat"),'SKCM_M450_RT')
load(fullfile(DataDirectory,"SKCM_M450_NoRT.mat"),'SKCM_M450_NoRT')

% Calculate Survival Result file based on DSS
RESULTS_SKCM_M450_RT_DSS   = CalculateSurvivalResults(SKCM_M450_RT,[],[],'DSS','M-value');
RESULTS_SKCM_M450_NoRT_DSS = CalculateSurvivalResults(SKCM_M450_NoRT,[],[],'DSS','M-value');

% Save Result files
save(fullfile(ResultDirectory,"RESULTS_SKCM_M450_RT_DSS.mat"),"RESULTS_SKCM_M450_RT_DSS")
save(fullfile(ResultDirectory,"RESULTS_SKCM_M450_NoRT_DSS.mat"),"RESULTS_SKCM_M450_NoRT_DSS")

%% Calculate prostate datasets, PRAD
load(fullfile(DataDirectory,"PRAD_M450_RT.mat"),'PRAD_M450_RT')
load(fullfile(DataDirectory,"PRAD_M450_NoRT.mat"),'PRAD_M450_NoRT')
load(fullfile(DataDirectory,"PRAD_M450_Normal.mat"),'PRAD_M450_Normal')

% Calculate Survival Result file based on PFI
RESULTS_PRAD_M450_RT_PFI = CalculateSurvivalResults(PRAD_M450_RT,[],[],'PFI','M-value');
RESULTS_PRAD_M450_NoRT_PFI = CalculateSurvivalResults(PRAD_M450_NoRT,[],[],'PFI','M-value');

% Save Result files
save(fullfile(ResultDirectory,"RESULTS_PRAD_M450_RT_PFI.mat"),"RESULTS_PRAD_M450_RT_PFI")
save(fullfile(ResultDirectory,"RESULTS_PRAD_M450_NoRT_PFI.mat"),"RESULTS_PRAD_M450_NoRT_PFI")

% Calculate Hyper Hypo and average methylation
HyperHypo_PRAD_M450_RT = CalculateDiffMethylation(PRAD_M450_RT,PRAD_M450_Normal);
save(fullfile(ResultDirectory,"HyperHypo_PRAD_M450_RT.mat"),"HyperHypo_PRAD_M450_RT")

% Calculate Survival Result file based on DSS
RESULTS_HyperHypo_PRAD_RT_PFI = CalculateSurvivalResults(HyperHypo_PRAD_M450_RT,[],[],'PFI',[]);
save(fullfile(ResultDirectory,"RESULTS_HyperHypo_PRAD_RT_PFI.mat"),"RESULTS_HyperHypo_PRAD_RT_PFI")

%% Calculate head and neck datasets, HNSC

load(fullfile(DataDirectory,"HNSC_M450_RT_HPVneg.mat"),'HNSC_M450_RT_HPVneg')
load(fullfile(DataDirectory,"HNSC_M450_RT_HPVpos.mat"),'HNSC_M450_RT_HPVpos')
load(fullfile(DataDirectory,"HNSC_M450_NoRT_HPVneg.mat"),'HNSC_M450_NoRT_HPVneg')
load(fullfile(DataDirectory,"HNSC_M450_Normal.mat"),'HNSC_M450_Normal')

% Calculate Survival Result file based on DSS
RESULTS_HNSC_M450_RT_HPVneg_DSS     = CalculateSurvivalResults(HNSC_M450_RT_HPVneg,[],[],'DSS','M-value');
RESULTS_HNSC_M450_RT_HPVpos_DSS     = CalculateSurvivalResults(HNSC_M450_RT_HPVpos,[],[],'DSS','M-value');
RESULTS_HNSC_M450_NoRT_HPVneq_DSS   = CalculateSurvivalResults(HNSC_M450_NoRT_HPVneg,[],[],'DSS','M-value');

% Save Result files
save(fullfile(ResultDirectory,"RESULTS_HNSC_M450_RT_HPVneg_DSS.mat"),"RESULTS_HNSC_M450_RT_HPVneg_DSS")
save(fullfile(ResultDirectory,"RESULTS_HNSC_M450_RT_HPVpos_DSS.mat"),"RESULTS_HNSC_M450_RT_HPVpos_DSS")
save(fullfile(ResultDirectory,"RESULTS_HNSC_M450_NoRT_HPVneq_DSS.mat"),"RESULTS_HNSC_M450_NoRT_HPVneq_DSS")

% Calculate Hyper Hypo and average methylation
HyperHypo_HNSC_M450_RT_HPVneg = CalculateDiffMethylation(HNSC_M450_RT_HPVneg,HNSC_M450_Normal);
save(fullfile(ResultDirectory,"HyperHypo_HNSC_M450_RT_HPVneg.mat"),"HyperHypo_HNSC_M450_RT_HPVneg")

% Calculate Survival Result file based on DSS
RESULTS_HyperHypo_HNSC_RT_HPVneg_DSS = CalculateSurvivalResults(HyperHypo_HNSC_M450_RT_HPVneg,[],[],'DSS',[]);
save(fullfile(ResultDirectory,"RESULTS_HyperHypo_HNSC_RT_HPVneg_DSS.mat"),"RESULTS_HyperHypo_HNSC_RT_HPVneg_DSS")

%% Calculate breast datasets, BRCA
load(fullfile(DataDirectory,"BRCA_M450_RT.mat"),'BRCA_M450_RT')
load(fullfile(DataDirectory,"BRCA_M450_NoRT.mat"),'BRCA_M450_NoRT')

% Calculate Survival Result file based on DSS
RESULTS_BRCA_M450_RT_DSS = CalculateSurvivalResults(BRCA_M450_RT,[],[],'DSS','M-value');
RESULTS_BRCA_M450_NoRT_DSS = CalculateSurvivalResults(BRCA_M450_NoRT,[],[],'DSS','M-value');

% Save Result files
save(fullfile(ResultDirectory,"RESULTS_BRCA_M450_RT_DSS.mat"),"RESULTS_BRCA_M450_RT_DSS")
save(fullfile(ResultDirectory,"RESULTS_BRCA_M450_NoRT_DSS.mat"),"RESULTS_BRCA_M450_NoRT_DSS")

%% Calculate sarcoma datasets, SARC
load(fullfile(DataDirectory,"SARC_M450_RT.mat"),'SARC_M450_RT')
load(fullfile(DataDirectory,"SARC_M450_NoRT.mat"),'SARC_M450_NoRT')

% Calculate Survival Result file based on DSS
RESULTS_SARC_M450_RT_DSS = CalculateSurvivalResults(SARC_M450_RT,[],[],'DSS','M-value');
RESULTS_SARC_M450_NoRT_DSS = CalculateSurvivalResults(SARC_M450_NoRT,[],[],'DSS','M-value');

% Save Result files
save(fullfile(ResultDirectory,"RESULTS_SARC_M450_RT_DSS.mat"),"RESULTS_SARC_M450_RT_DSS")
save(fullfile(ResultDirectory,"RESULTS_SARC_M450_NoRT_DSS.mat"),"RESULTS_SARC_M450_NoRT_DSS")


%% Calculate stomach datasets, STAD
load(fullfile(DataDirectory,"STAD_M450_RT.mat"),'STAD_M450_RT')
load(fullfile(DataDirectory,"STAD_M450_NoRT.mat"),'STAD_M450_NoRT')

% Calculate Survival Result file based on DSS
RESULTS_STAD_M450_RT_DSS = CalculateSurvivalResults(STAD_M450_RT,[],[],'DSS','M-value');
RESULTS_STAD_M450_NoRT_DSS = CalculateSurvivalResults(STAD_M450_NoRT,[],[],'DSS','M-value');

% Save Result files
save(fullfile(ResultDirectory,"RESULTS_STAD_M450_RT_DSS.mat"),"RESULTS_STAD_M450_RT_DSS")
save(fullfile(ResultDirectory,"RESULTS_STAD_M450_NoRT_DSS.mat"),"RESULTS_STAD_M450_NoRT_DSS")

%% Calculate cervical datasets, CESC
load(fullfile(DataDirectory,"CESC_M450_RT.mat"),'CESC_M450_RT')
load(fullfile(DataDirectory,"CESC_M450_NoRT.mat"),'CESC_M450_NoRT')

% Calculate Survival Result file based on DSS
RESULTS_CESC_M450_RT_DSS = CalculateSurvivalResults(CESC_M450_RT,[],[],'DSS','M-value');
RESULTS_CESC_M450_NoRT_DSS = CalculateSurvivalResults(CESC_M450_NoRT,[],[],'DSS','M-value');

% Save Result files
save(fullfile(ResultDirectory,"RESULTS_CESC_M450_RT_DSS.mat"),"RESULTS_CESC_M450_RT_DSS")
save(fullfile(ResultDirectory,"RESULTS_CESC_M450_NoRT_DSS.mat"),"RESULTS_CESC_M450_NoRT_DSS")

%% Calculate glioma datasets, GBM

load(fullfile(DataDirectory,"GBM_M450_RT.mat"),'GBM_M450_RT')
load(fullfile(DataDirectory,"GBM_M450_NoRT.mat"),'GBM_M450_NoRT')

% Calculate Survival Result file based on DSS
RESULTS_GBM_M450_RT_DSS = CalculateSurvivalResults(GBM_M450_RT,[],[],'DSS','M-value');
RESULTS_GBM_M450_NoRT_DSS = CalculateSurvivalResults(GBM_M450_NoRT,[],[],'DSS','M-value');

% Save Result files
save(fullfile(ResultDirectory,"RESULTS_GBM_M450_RT_DSS.mat"),"RESULTS_GBM_M450_RT_DSS")
save(fullfile(ResultDirectory,"RESULTS_GBM_M450_NoRT_DSS.mat"),"RESULTS_GBM_M450_NoRT_DSS")

%% Calculate lower grade glioma datasets, LGG
load(fullfile(DataDirectory,"LGG_M450_RT.mat"),'LGG_M450_RT')
load(fullfile(DataDirectory,"LGG_M450_NoRT.mat"),'LGG_M450_NoRT')

% Calculate Survival Result file based on DSS
RESULTS_LGG_M450_RT_DSS = CalculateSurvivalResults(LGG_M450_RT,[],[],'DSS','M-value');
RESULTS_LGG_M450_NoRT_DSS = CalculateSurvivalResults(LGG_M450_NoRT,[],[],'DSS','M-value');

% Save Result files
save(fullfile(ResultDirectory,"RESULTS_LGG_M450_RT_DSS.mat"),"RESULTS_LGG_M450_RT_DSS")
save(fullfile(ResultDirectory,"RESULTS_LGG_M450_NoRT_DSS.mat"),"RESULTS_LGG_M450_NoRT_DSS")

%%

X = [(log2(RESULTS_HNSC_M450_RT_HPVneg_DSS.X(:,8)))> 1 & -log10(RESULTS_HNSC_M450_RT_HPVneg_DSS.X(:,5))>2 ,...
    (log2(RESULTS_PRAD_M450_RT_PFI.X(:,8)))> 1 & -log10(RESULTS_PRAD_M450_RT_PFI.X(:,5))>2 ,...
    (log2(RESULTS_SKCM_M450_RT_DSS.X(:,8)))> 1 & -log10(RESULTS_SKCM_M450_RT_DSS.X(:,5))>2 ,...
    (log2(RESULTS_BRCA_M450_RT_DSS.X(:,8)))> 1 & -log10(RESULTS_BRCA_M450_RT_DSS.X(:,5))>2 ,...
   (log2(RESULTS_SARC_M450_RT_DSS.X(:,8)))> 1 & -log10(RESULTS_SARC_M450_RT_DSS.X(:,5))>2];

s = sum(X,2);
indx = find(s>=2);
SelectedCpG_probes = RESULTS_HNSC_M450_RT_HPVneg_DSS.RowId(indx);
save(fullfile(ResultDirectory,"SelectedCpG_probes.mat"),"SelectedCpG_probes")

% GetGeneSymbols for the selected CpG-probes
indx_GS = strcmp('gene_HGNC',RESULTS_HNSC_M450_RT_HPVneg_DSS.RowAnnotationFields);
GenesRaw = RESULTS_HNSC_M450_RT_HPVneg_DSS.RowAnnotation(indx,indx_GS);
GenesRaw(GenesRaw == "NA") = [];
GenesSplit = arrayfun(@(x) strsplit(x,';'), GenesRaw, 'UniformOutput', 0);
GenesSingle = [GenesSplit{:}]';
GenesSingle = unique(GenesSingle);
% Write the gene symbols to txt file
writelines(GenesSingle,fullfile(ResultDirectory,"GeneSymbols_SelectedCpGprobes.txt"))

% fprintf('%s\t',RESULTS_HNSC_M450_RT_HPVneg_DSS.RowAnnotationFields{:});fprintf('\n')
% 
% for i=1:length(indx)
%     fprintf('%s\t',RESULTS_HNSC_M450_RT_HPVneg_DSS.RowAnnotation{indx(i),:});fprintf('\n');
% end
