function ProcessTumorTypesRNAseq
%% Directory paths
try
    MRA_Options;
catch
    error('Could not load MRA_Options.m file\n Make sure the GitHub library is added to the path')
end



%% Data directory

DataDirectory = (fullfile(Opt.BaseDir,Opt.SubDirs.RNAseqDataDir));
SampleAnnotationDirectory = (fullfile(Opt.BaseDir,Opt.SubDirs.SampleAnnotationDir));


%% Load file
load(fullfile(DataDirectory,"RNAseq.mat"),'RNAseq')


%% Generate melanoma datasets, SKCM

% Select Melanoma samples
SKCM_RNAseq = EditSamplesDATA(RNAseq,'SKCM','Keep','SampleIdentifier','TCGA_Code');

% Add specific melanoma annotation
List      = {'bcr_patient_barcode','distant_metastasis_anatomic_site','tumor_tissue_site.1'};
SKCM_RNAseq = AddRowAnnotationFromFile(SKCM_RNAseq,fullfile(SampleAnnotationDirectory,'clinical_PANCAN_patient_with_followup.tsv'),'File_Id','bcr_patient_barcode','ColumnsToAdd',List,'Truncate',12);

SKCM_RNAseq = EditSamplesDATA(SKCM_RNAseq,{'Primary solid Tumor','Metastatic'},'Keep','SampleIdentifier','Sample_Type');
indx_DSS  = strcmp('DSS',SKCM_RNAseq.SURVIVAL.SurvivalTypes);
indx      = (~strcmpi('NA',SKCM_RNAseq.SURVIVAL.SurvEvent(:,indx_DSS)) & isfinite(SKCM_RNAseq.SURVIVAL.SurvTime(:,indx_DSS)));
SKCM_RNAseq = EditSamplesDATA(SKCM_RNAseq,SKCM_RNAseq.RowId(indx),'Keep');
SKCM_RNAseq = AddRowAnnotationFromFile(SKCM_RNAseq,'/Users/berglund.anders/Documents/DATA/TCGA_PANCANCER/Results/RadiationMethylation/Annotation/RadiationInfo.xlsx','Truncate',12,'File_Id','bcr_patient_barcode','SheetName','SKCM');

% Select only samples with radiation treatment
SKCM_RNAseq_RT = EditSamplesDATA(SKCM_RNAseq,{'KEEP'},'Keep','SampleIdentifier','REMOVE');

% Select only samples without any radiation treatment
SKCM_RNAseq_NoRT = EditSamplesDATA(SKCM_RNAseq,{'---'},'Keep','SampleIdentifier','radiation_therapy_type');
SKCM_RNAseq_NoRT = EditSamplesDATA(SKCM_RNAseq_NoRT,{'YES'},'Remove','SampleIdentifier','radiation_therapy');

% Save individual file to DATA directory
save(fullfile(DataDirectory,"SKCM_RNAseq_RT.mat"),"SKCM_RNAseq_RT")
save(fullfile(DataDirectory,"SKCM_RNAseq_NoRT.mat"),"SKCM_RNAseq_NoRT")

%% Generate prostate datasets, PRAD, PFI will be used instead of DSS

% Select Prostate samples
PRAD_RNAseq = EditSamplesDATA(RNAseq,'PRAD','Keep','SampleIdentifier','TCGA_Code');

% Add specific Prostate annotation
List      = {'bcr_patient_barcode','psa_value','days_to_first_biochemical_recurrence','secondary_pattern','primary_pattern','biochemical_recurrence','gleason_score'};
PRAD_RNAseq = AddRowAnnotationFromFile(RNAseq,fullfile(SampleAnnotationDirectory,'clinical_PANCAN_patient_with_followup.tsv'),'File_Id','bcr_patient_barcode','ColumnsToAdd',List,'Truncate',12);

PRAD_RNAseq = EditSamplesDATA(PRAD_RNAseq,{'Primary solid Tumor'},'Keep','SampleIdentifier','Sample_Type');
indx_PFI  = strcmp('PFI',PRAD_RNAseq.SURVIVAL.SurvivalTypes);
indx      = (~strcmpi('NA',PRAD_RNAseq.SURVIVAL.SurvEvent(:,indx_PFI)) & isfinite(PRAD_RNAseq.SURVIVAL.SurvTime(:,indx_PFI)));
PRAD_RNAseq = EditSamplesDATA(PRAD_RNAseq,PRAD_RNAseq.RowId(indx),'Keep');
PRAD_RNAseq = AddRowAnnotationFromFile(PRAD_RNAseq,'/Users/berglund.anders/Documents/DATA/TCGA_PANCANCER/Results/RadiationMethylation/Annotation/RadiationInfo.xlsx','Truncate',12,'File_Id','bcr_patient_barcode','SheetName','PRAD');

% Select only samples with radiation treatment
PRAD_RNAseq_RT = EditSamplesDATA(PRAD_RNAseq,{'KEEP'},'Keep','SampleIdentifier','REMOVE');

% Select only samples without any radiation treatment
PRAD_RNAseq_NoRT = EditSamplesDATA(PRAD_RNAseq,{'---'},'Keep','SampleIdentifier','radiation_therapy_type');
PRAD_RNAseq_NoRT = EditSamplesDATA(PRAD_RNAseq_NoRT,{'YES'},'Remove','SampleIdentifier','radiation_therapy');

% Save individual file to DATA directory
save(fullfile(DataDirectory,"PRAD_RNAseq_RT.mat"),"PRAD_RNAseq_RT")
save(fullfile(DataDirectory,"PRAD_RNAseq_NoRT.mat"),"PRAD_RNAseq_NoRT")

%% Generate head and neck datasets, HNSC

% Select head and Neck samples
HNSC_RNAseq = EditSamplesDATA(RNAseq,'HNSC','Keep','SampleIdentifier','TCGA_Code');

% Add specific Head and Neck annotation
List      = {'bcr_patient_barcode','anatomic_neoplasm_subdivision','neoplasm_histologic_grade','tobacco_smoking_history','margin_status','hpv_status_by_ish_testing','hpv_status_by_p16_testing'};
HNSC_RNAseq = AddRowAnnotationFromFile(HNSC_RNAseq,fullfile(SampleAnnotationDirectory,'clinical_PANCAN_patient_with_followup.tsv'),'File_Id','bcr_patient_barcode','ColumnsToAdd',List,'Truncate',12);


HNSC_RNAseq = EditSamplesDATA(HNSC_RNAseq,{'Primary solid Tumor'},'Keep','SampleIdentifier','Sample_Type');
indx_DSS  = strcmp('DSS',HNSC_RNAseq.SURVIVAL.SurvivalTypes);
indx      = (~strcmpi('NA',HNSC_RNAseq.SURVIVAL.SurvEvent(:,indx_DSS)) & isfinite(HNSC_RNAseq.SURVIVAL.SurvTime(:,indx_DSS)));
HNSC_RNAseq = EditSamplesDATA(HNSC_RNAseq,HNSC_RNAseq.RowId(indx),'Keep');
HNSC_RNAseq = AddRowAnnotationFromFile(HNSC_RNAseq,'/Users/berglund.anders/Documents/DATA/TCGA_PANCANCER/Results/RadiationMethylation/Annotation/RadiationInfo.xlsx','Truncate',12,'File_Id','bcr_patient_barcode','SheetName','HNSC');

% Select only samples with radiation treatment and HPV-
HNSC_RNAseq_RT_HPVneg = EditSamplesDATA(HNSC_RNAseq,{'KEEP'},'Keep','SampleIdentifier','REMOVE');
HNSC_RNAseq_RT_HPVneg = EditSamplesDATA(HNSC_RNAseq_RT_HPVneg,{'negative'},'Keep','SampleIdentifier','HPV_status');

% Select only samples without any radiation treatment
HNSC_RNAseq_NoRT_HPVneg = EditSamplesDATA(HNSC_RNAseq,{'---'},'Keep','SampleIdentifier','radiation_therapy_type');
HNSC_RNAseq_NoRT_HPVneg = EditSamplesDATA(HNSC_RNAseq_NoRT_HPVneg,{'YES'},'Remove','SampleIdentifier','radiation_therapy');
HNSC_RNAseq_NoRT_HPVneg = EditSamplesDATA(HNSC_RNAseq_NoRT_HPVneg,{'negative'},'Keep','SampleIdentifier','HPV_status');

% Save individual file to DATA directory
save(fullfile(DataDirectory,"HNSC_RNAseq_RT_HPVneg.mat"),"HNSC_RNAseq_RT_HPVneg")
save(fullfile(DataDirectory,"HNSC_RNAseq_NoRT_HPVneg.mat"),"HNSC_RNAseq_NoRT_HPVneg")

%% Generate breast datasets, BRCA

% Select breast samples
BRCA_RNAseq = EditSamplesDATA(RNAseq,'BRCA','Keep','SampleIdentifier','TCGA_Code');

% Add specific breast annotation
List      = {'bcr_patient_barcode','menopause_status','breast_carcinoma_progesterone_receptor_status','breast_carcinoma_estrogen_receptor_status','lab_proc_her2_neu_immunohistochemistry_receptor_status','lab_procedure_her2_neu_in_situ_hybrid_outcome_type'};
BRCA_RNAseq = AddRowAnnotationFromFile(BRCA_RNAseq,fullfile(SampleAnnotationDirectory,'clinical_PANCAN_patient_with_followup.tsv'),'File_Id','bcr_patient_barcode','ColumnsToAdd',List,'Truncate',12);

% Add even more specific breast annotation
List      = {'Case.ID','Final Pathology','PAM50','ER IHC','PR IHC','HER2 IHC'};
BRCA_RNAseq = AddRowAnnotationFromFile(BRCA_RNAseq,fullfile(SampleAnnotationDirectory,'NIHMS724218-supplement-2.xlsx'),'ColumnsToAdd',List,'Truncate',12,'File_Id','Case.ID','NumHeaderLines',2);

BRCA_RNAseq = EditSamplesDATA(BRCA_RNAseq,{'Primary solid Tumor'},'Keep','SampleIdentifier','Sample_Type');
indx_DSS  = strcmp('DSS',BRCA_RNAseq.SURVIVAL.SurvivalTypes);
indx      = (~strcmpi('NA',BRCA_RNAseq.SURVIVAL.SurvEvent(:,indx_DSS)) & isfinite(BRCA_RNAseq.SURVIVAL.SurvTime(:,indx_DSS)));
BRCA_RNAseq = EditSamplesDATA(BRCA_RNAseq,BRCA_RNAseq.RowId(indx),'Keep');
BRCA_RNAseq = AddRowAnnotationFromFile(BRCA_RNAseq,'/Users/berglund.anders/Documents/DATA/TCGA_PANCANCER/Results/RadiationMethylation/Annotation/RadiationInfo.xlsx','Truncate',12,'File_Id','bcr_patient_barcode','SheetName','BRCA');

% Select only samples with radiation treatment
BRCA_RNAseq_RT = EditSamplesDATA(BRCA_RNAseq,{'KEEP'},'Keep','SampleIdentifier','REMOVE');

% Select only samples without any radiation treatment
BRCA_RNAseq_NoRT = EditSamplesDATA(BRCA_RNAseq,{'---'},'Keep','SampleIdentifier','radiation_therapy_type');
BRCA_RNAseq_NoRT = EditSamplesDATA(BRCA_RNAseq_NoRT,{'YES'},'Remove','SampleIdentifier','radiation_therapy');

% Save individual file to DATA directory
save(fullfile(DataDirectory,"BRCA_RNAseq_RT.mat"),"BRCA_RNAseq_RT")
save(fullfile(DataDirectory,"BRCA_RNAseq_NoRT.mat"),"BRCA_RNAseq_NoRT")

%% Generate sarcoma datasets, SARC

% Select Melanoma samples
SARC_RNAseq = EditSamplesDATA(RNAseq,'SARC','Keep','SampleIdentifier','TCGA_Code');

SARC_RNAseq = EditSamplesDATA(SARC_RNAseq,{'Primary solid Tumor'},'Keep','SampleIdentifier','Sample_Type');
indx_DSS  = strcmp('DSS',SARC_RNAseq.SURVIVAL.SurvivalTypes);
indx      = (~strcmpi('NA',SARC_RNAseq.SURVIVAL.SurvEvent(:,indx_DSS)) & isfinite(SARC_RNAseq.SURVIVAL.SurvTime(:,indx_DSS)));
SARC_RNAseq = EditSamplesDATA(SARC_RNAseq,SARC_RNAseq.RowId(indx),'Keep');
SARC_RNAseq = AddRowAnnotationFromFile(SARC_RNAseq,'/Users/berglund.anders/Documents/DATA/TCGA_PANCANCER/Results/RadiationMethylation/Annotation/RadiationInfo.xlsx','Truncate',12,'File_Id','bcr_patient_barcode','SheetName','SARC');

% Select only samples with radiation treatment
SARC_RNAseq_RT = EditSamplesDATA(SARC_RNAseq,{'KEEP'},'Keep','SampleIdentifier','REMOVE');

% Select only samples without any radiation treatment
SARC_RNAseq_NoRT = EditSamplesDATA(SARC_RNAseq,{'---'},'Keep','SampleIdentifier','radiation_therapy_type');
SARC_RNAseq_NoRT = EditSamplesDATA(SARC_RNAseq_NoRT,{'YES'},'Remove','SampleIdentifier','radiation_therapy');

% Save individual file to DATA directory
save(fullfile(DataDirectory,"SARC_RNAseq_RT.mat"),"SARC_RNAseq_RT")
save(fullfile(DataDirectory,"SARC_RNAseq_NoRT.mat"),"SARC_RNAseq_NoRT")