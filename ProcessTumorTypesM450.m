function ProcessTumorTypesM450
% Function for generating different tumor type methylation datasets and adding tumor type-specific 
% annotation. The files are saved in the DataDir directory.
% Anders Berglund 2025
%% Directory paths
try
    MRA_Options;
catch
    error('Could not load MRA_Options.m file\n Make sure the GitHub library is added to the path')
end

%% Load methylation file

load(fullfile(Opt.BaseDir,Opt.SubDirs.DataDir,"M450K.mat"),'M450K')


%% Data directory

DataDirectory = (fullfile(Opt.BaseDir,Opt.SubDirs.DataDir));
SampleAnnotationDirectory = (fullfile(Opt.BaseDir,Opt.SubDirs.SampleAnnotationDir));

%% Generate melanoma datasets, SKCM

% Select Melanoma samples
SKCM_M450 = EditSamplesDATA(M450K,'SKCM','Keep','SampleIdentifier','TCGA_Code');

% Add specific melanoma annotation
List      = {'bcr_patient_barcode','distant_metastasis_anatomic_site','tumor_tissue_site.1'};
SKCM_M450 = AddRowAnnotationFromFile(SKCM_M450,fullfile(SampleAnnotationDirectory,'clinical_PANCAN_patient_with_followup.tsv'),'File_Id','bcr_patient_barcode','ColumnsToAdd',List,'Truncate',12);

% Select Normal samples
SKCM_M450_Normal = EditSamplesDATA(SKCM_M450,{'Solid Tissue Normal'},'Keep','SampleIdentifier','Sample_Type');

SKCM_M450 = EditSamplesDATA(SKCM_M450,{'Primary solid Tumor','Metastatic'},'Keep','SampleIdentifier','Sample_Type');
indx_DSS  = strcmp('DSS',SKCM_M450.SURVIVAL.SurvivalTypes);
indx      = (~strcmpi('NA',SKCM_M450.SURVIVAL.SurvEvent(:,indx_DSS)) & isfinite(SKCM_M450.SURVIVAL.SurvTime(:,indx_DSS)));
SKCM_M450 = EditSamplesDATA(SKCM_M450,SKCM_M450.RowId(indx),'Keep');
SKCM_M450 = AddRowAnnotationFromFile(SKCM_M450,'RadiationInfo.xlsx','Truncate',12,'File_Id','bcr_patient_barcode','SheetName','SKCM');

% Select only samples with radiation treatment
SKCM_M450_RT = EditSamplesDATA(SKCM_M450,{'KEEP'},'Keep','SampleIdentifier','REMOVE');

% Select only samples without any radiation treatment
SKCM_M450_NoRT = EditSamplesDATA(SKCM_M450,{'---'},'Keep','SampleIdentifier','radiation_therapy_type');
SKCM_M450_NoRT = EditSamplesDATA(SKCM_M450_NoRT,{'YES'},'Remove','SampleIdentifier','radiation_therapy');

% Save individual file to DATA directory
save(fullfile(DataDirectory,"SKCM_M450_Normal.mat"),"SKCM_M450_Normal")
save(fullfile(DataDirectory,"SKCM_M450_RT.mat"),"SKCM_M450_RT")
save(fullfile(DataDirectory,"SKCM_M450_NoRT.mat"),"SKCM_M450_NoRT")

%% Generate prostate datasets, PRAD, PFI will be used instead of DSS

% Select Prostate samples
PRAD_M450 = EditSamplesDATA(M450K,'PRAD','Keep','SampleIdentifier','TCGA_Code');

% Add specific Prostate annotation
List      = {'bcr_patient_barcode','psa_value','days_to_first_biochemical_recurrence','secondary_pattern','primary_pattern','biochemical_recurrence','gleason_score'};
PRAD_M450 = AddRowAnnotationFromFile(PRAD_M450,fullfile(SampleAnnotationDirectory,'clinical_PANCAN_patient_with_followup.tsv'),'File_Id','bcr_patient_barcode','ColumnsToAdd',List,'Truncate',12);

% Select Normal samples
PRAD_M450_Normal  = EditSamplesDATA(PRAD_M450,{'Solid Tissue Normal'},'Keep','SampleIdentifier','Sample_Type');

PRAD_M450 = EditSamplesDATA(PRAD_M450,{'Primary solid Tumor'},'Keep','SampleIdentifier','Sample_Type');
indx_PFI  = strcmp('PFI',PRAD_M450.SURVIVAL.SurvivalTypes);
indx      = (~strcmpi('NA',PRAD_M450.SURVIVAL.SurvEvent(:,indx_PFI)) & isfinite(PRAD_M450.SURVIVAL.SurvTime(:,indx_PFI)));
PRAD_M450 = EditSamplesDATA(PRAD_M450,PRAD_M450.RowId(indx),'Keep');
PRAD_M450 = AddRowAnnotationFromFile(PRAD_M450,'RadiationInfo.xlsx','Truncate',12,'File_Id','bcr_patient_barcode','SheetName','PRAD');

% Select only samples with radiation treatment
PRAD_M450_RT = EditSamplesDATA(PRAD_M450,{'KEEP'},'Keep','SampleIdentifier','REMOVE');

% Select only samples without any radiation treatment
PRAD_M450_NoRT = EditSamplesDATA(PRAD_M450,{'---'},'Keep','SampleIdentifier','radiation_therapy_type');
PRAD_M450_NoRT = EditSamplesDATA(PRAD_M450_NoRT,{'YES'},'Remove','SampleIdentifier','radiation_therapy');

% Save individual file to DATA directory
save(fullfile(DataDirectory,"PRAD_M450_Normal.mat"),"PRAD_M450_Normal")
save(fullfile(DataDirectory,"PRAD_M450_RT.mat"),"PRAD_M450_RT")
save(fullfile(DataDirectory,"PRAD_M450_NoRT.mat"),"PRAD_M450_NoRT")

% Clear all prostate realted variables

clear PRAD_M450*  indx* List

%% Generate head and neck datasets, HNSC

% Select head and Neck samples
HNSC_M450 = EditSamplesDATA(M450K,'HNSC','Keep','SampleIdentifier','TCGA_Code');

% Add specific Head and Neck annotation
List      = {'bcr_patient_barcode','anatomic_neoplasm_subdivision','neoplasm_histologic_grade','tobacco_smoking_history','margin_status','hpv_status_by_ish_testing','hpv_status_by_p16_testing'};
HNSC_M450 = AddRowAnnotationFromFile(HNSC_M450,fullfile(SampleAnnotationDirectory,'clinical_PANCAN_patient_with_followup.tsv'),'File_Id','bcr_patient_barcode','ColumnsToAdd',List,'Truncate',12);

% Select Normal samples
HNSC_M450_Normal  = EditSamplesDATA(HNSC_M450,{'Solid Tissue Normal'},'Keep','SampleIdentifier','Sample_Type');

HNSC_M450 = EditSamplesDATA(HNSC_M450,{'Primary solid Tumor'},'Keep','SampleIdentifier','Sample_Type');
indx_DSS  = strcmp('DSS',HNSC_M450.SURVIVAL.SurvivalTypes);
indx      = (~strcmpi('NA',HNSC_M450.SURVIVAL.SurvEvent(:,indx_DSS)) & isfinite(HNSC_M450.SURVIVAL.SurvTime(:,indx_DSS)));
HNSC_M450 = EditSamplesDATA(HNSC_M450,HNSC_M450.RowId(indx),'Keep');
HNSC_M450 = AddRowAnnotationFromFile(HNSC_M450,'RadiationInfo.xlsx','Truncate',12,'File_Id','bcr_patient_barcode','SheetName','HNSC');

% Select only samples with radiation treatment and HPV-
HNSC_M450_RT_HPVneg = EditSamplesDATA(HNSC_M450,{'KEEP'},'Keep','SampleIdentifier','REMOVE');
HNSC_M450_RT_HPVneg = EditSamplesDATA(HNSC_M450_RT_HPVneg,{'negative'},'Keep','SampleIdentifier','HPV_status');

% Select only samples with radiation treatment and HPV+
HNSC_M450_RT_HPVpos = EditSamplesDATA(HNSC_M450,{'KEEP'},'Keep','SampleIdentifier','REMOVE');
HNSC_M450_RT_HPVpos = EditSamplesDATA(HNSC_M450_RT_HPVpos,{'positive'},'Keep','SampleIdentifier','HPV_status');


% Select only samples without any radiation treatment
HNSC_M450_NoRT_HPVneg = EditSamplesDATA(HNSC_M450,{'---'},'Keep','SampleIdentifier','radiation_therapy_type');
HNSC_M450_NoRT_HPVneg = EditSamplesDATA(HNSC_M450_NoRT_HPVneg,{'YES'},'Remove','SampleIdentifier','radiation_therapy');
HNSC_M450_NoRT_HPVneg = EditSamplesDATA(HNSC_M450_NoRT_HPVneg,{'negative'},'Keep','SampleIdentifier','HPV_status');

% Save individual file to DATA directory
save(fullfile(DataDirectory,"HNSC_M450_Normal.mat"),"HNSC_M450_Normal")
save(fullfile(DataDirectory,"HNSC_M450_RT_HPVneg.mat"),"HNSC_M450_RT_HPVneg")
save(fullfile(DataDirectory,"HNSC_M450_RT_HPVpos.mat"),"HNSC_M450_RT_HPVpos")
save(fullfile(DataDirectory,"HNSC_M450_NoRT_HPVneg.mat"),"HNSC_M450_NoRT_HPVneg")


%% Generate breast datasets, BRCA

% Select breast samples
BRCA_M450 = EditSamplesDATA(M450K,'BRCA','Keep','SampleIdentifier','TCGA_Code');

% Add specific breast annotation
List      = {'bcr_patient_barcode','menopause_status','breast_carcinoma_progesterone_receptor_status','breast_carcinoma_estrogen_receptor_status','lab_proc_her2_neu_immunohistochemistry_receptor_status','lab_procedure_her2_neu_in_situ_hybrid_outcome_type'};
BRCA_M450 = AddRowAnnotationFromFile(BRCA_M450,fullfile(SampleAnnotationDirectory,'clinical_PANCAN_patient_with_followup.tsv'),'File_Id','bcr_patient_barcode','ColumnsToAdd',List,'Truncate',12);

% Add even more specific breast annotation
List      = {'Case.ID','Final Pathology','PAM50','ER IHC','PR IHC','HER2 IHC'};
BRCA_M450 = AddRowAnnotationFromFile(BRCA_M450,fullfile(SampleAnnotationDirectory,'NIHMS724218-supplement-2.xlsx'),'ColumnsToAdd',List,'Truncate',12,'File_Id','Case.ID','NumHeaderLines',2);

% Select Normal samples
BRCA_M450_Normal  = EditSamplesDATA(BRCA_M450,{'Solid Tissue Normal'},'Keep','SampleIdentifier','Sample_Type');

BRCA_M450 = EditSamplesDATA(BRCA_M450,{'Primary solid Tumor'},'Keep','SampleIdentifier','Sample_Type');
indx_DSS  = strcmp('DSS',BRCA_M450.SURVIVAL.SurvivalTypes);
indx      = (~strcmpi('NA',BRCA_M450.SURVIVAL.SurvEvent(:,indx_DSS)) & isfinite(BRCA_M450.SURVIVAL.SurvTime(:,indx_DSS)));
BRCA_M450 = EditSamplesDATA(BRCA_M450,BRCA_M450.RowId(indx),'Keep');
BRCA_M450 = AddRowAnnotationFromFile(BRCA_M450,'RadiationInfo.xlsx','Truncate',12,'File_Id','bcr_patient_barcode','SheetName','BRCA');

% Select only samples with radiation treatment
BRCA_M450_RT = EditSamplesDATA(BRCA_M450,{'KEEP'},'Keep','SampleIdentifier','REMOVE');

% Select only samples without any radiation treatment
BRCA_M450_NoRT = EditSamplesDATA(BRCA_M450,{'---'},'Keep','SampleIdentifier','radiation_therapy_type');
BRCA_M450_NoRT = EditSamplesDATA(BRCA_M450_NoRT,{'YES'},'Remove','SampleIdentifier','radiation_therapy');

% Save individual file to DATA directory
save(fullfile(DataDirectory,"BRCA_M450_Normal.mat"),"BRCA_M450_Normal")
save(fullfile(DataDirectory,"BRCA_M450_RT.mat"),"BRCA_M450_RT")
save(fullfile(DataDirectory,"BRCA_M450_NoRT.mat"),"BRCA_M450_NoRT")



%% Generate sarcoma datasets, SARC

% Select Melanoma samples
SARC_M450 = EditSamplesDATA(M450K,'SARC','Keep','SampleIdentifier','TCGA_Code');


% Select Normal samples
SARC_M450_Normal = EditSamplesDATA(SARC_M450,{'Solid Tissue Normal'},'Keep','SampleIdentifier','Sample_Type');

SARC_M450 = EditSamplesDATA(SARC_M450,{'Primary solid Tumor'},'Keep','SampleIdentifier','Sample_Type');
indx_DSS  = strcmp('DSS',SARC_M450.SURVIVAL.SurvivalTypes);
indx      = (~strcmpi('NA',SARC_M450.SURVIVAL.SurvEvent(:,indx_DSS)) & isfinite(SARC_M450.SURVIVAL.SurvTime(:,indx_DSS)));
SARC_M450 = EditSamplesDATA(SARC_M450,SARC_M450.RowId(indx),'Keep');
SARC_M450 = AddRowAnnotationFromFile(SARC_M450,'RadiationInfo.xlsx','Truncate',12,'File_Id','bcr_patient_barcode','SheetName','SARC');

% Select only samples with radiation treatment
SARC_M450_RT = EditSamplesDATA(SARC_M450,{'KEEP'},'Keep','SampleIdentifier','REMOVE');

% Select only samples without any radiation treatment
SARC_M450_NoRT = EditSamplesDATA(SARC_M450,{'---'},'Keep','SampleIdentifier','radiation_therapy_type');
SARC_M450_NoRT = EditSamplesDATA(SARC_M450_NoRT,{'YES'},'Remove','SampleIdentifier','radiation_therapy');

% Save individual file to DATA directory
save(fullfile(DataDirectory,"SARC_M450_Normal.mat"),"SARC_M450_Normal")
save(fullfile(DataDirectory,"SARC_M450_RT.mat"),"SARC_M450_RT")
save(fullfile(DataDirectory,"SARC_M450_NoRT.mat"),"SARC_M450_NoRT")

%% Generate stomach datasets, STAD

% Select Melanoma samples
STAD_M450 = EditSamplesDATA(M450K,'STAD','Keep','SampleIdentifier','TCGA_Code');


% Select Normal samples
STAD_M450_Normal = EditSamplesDATA(STAD_M450,{'Solid Tissue Normal'},'Keep','SampleIdentifier','Sample_Type');

STAD_M450 = EditSamplesDATA(STAD_M450,{'Primary solid Tumor'},'Keep','SampleIdentifier','Sample_Type');
indx_DSS  = strcmp('DSS',STAD_M450.SURVIVAL.SurvivalTypes);
indx      = (~strcmpi('NA',STAD_M450.SURVIVAL.SurvEvent(:,indx_DSS)) & isfinite(STAD_M450.SURVIVAL.SurvTime(:,indx_DSS)));
STAD_M450 = EditSamplesDATA(STAD_M450,STAD_M450.RowId(indx),'Keep');
STAD_M450 = AddRowAnnotationFromFile(STAD_M450,'RadiationInfo.xlsx','Truncate',12,'File_Id','bcr_patient_barcode','SheetName','STAD');

% Select only samples with radiation treatment
STAD_M450_RT = EditSamplesDATA(STAD_M450,{'KEEP'},'Keep','SampleIdentifier','REMOVE');

% Select only samples without any radiation treatment
STAD_M450_NoRT = EditSamplesDATA(STAD_M450,{'---'},'Keep','SampleIdentifier','radiation_therapy_type');
STAD_M450_NoRT = EditSamplesDATA(STAD_M450_NoRT,{'YES'},'Remove','SampleIdentifier','radiation_therapy');

% Save individual file to DATA directory
save(fullfile(DataDirectory,"STAD_M450_Normal.mat"),"STAD_M450_Normal")
save(fullfile(DataDirectory,"STAD_M450_RT.mat"),"STAD_M450_RT")
save(fullfile(DataDirectory,"STAD_M450_NoRT.mat"),"STAD_M450_NoRT")


%% Generate cervical datasets, CESC

% Select cervical samples
CESC_M450 = EditSamplesDATA(M450K,'CESC','Keep','SampleIdentifier','TCGA_Code');


% Select Normal samples
CESC_M450_Normal = EditSamplesDATA(CESC_M450,{'Solid Tissue Normal'},'Keep','SampleIdentifier','Sample_Type');

CESC_M450 = EditSamplesDATA(CESC_M450,{'Primary solid Tumor'},'Keep','SampleIdentifier','Sample_Type');
indx_DSS  = strcmp('DSS',CESC_M450.SURVIVAL.SurvivalTypes);
indx      = (~strcmpi('NA',CESC_M450.SURVIVAL.SurvEvent(:,indx_DSS)) & isfinite(CESC_M450.SURVIVAL.SurvTime(:,indx_DSS)));
CESC_M450 = EditSamplesDATA(CESC_M450,CESC_M450.RowId(indx),'Keep');
CESC_M450 = AddRowAnnotationFromFile(CESC_M450,'RadiationInfo.xlsx','Truncate',12,'File_Id','bcr_patient_barcode','SheetName','CESC');

% Select only samples with radiation treatment
CESC_M450_RT = EditSamplesDATA(CESC_M450,{'KEEP'},'Keep','SampleIdentifier','REMOVE');

% Select only samples without any radiation treatment
CESC_M450_NoRT = EditSamplesDATA(CESC_M450,{'---'},'Keep','SampleIdentifier','radiation_therapy_type');
CESC_M450_NoRT = EditSamplesDATA(CESC_M450_NoRT,{'YES'},'Remove','SampleIdentifier','radiation_therapy');

% Save individual file to DATA directory
save(fullfile(DataDirectory,"CESC_M450_Normal.mat"),"CESC_M450_Normal")
save(fullfile(DataDirectory,"CESC_M450_RT.mat"),"CESC_M450_RT")
save(fullfile(DataDirectory,"CESC_M450_NoRT.mat"),"CESC_M450_NoRT")



%% Generate glioma datasets, GBM

% Select glioma samples
GBM_M450 = EditSamplesDATA(M450K,'GBM','Keep','SampleIdentifier','TCGA_Code');

% Add specific GBM annotation
List     = {'Case','IDH status','MGMT promoter status','Original Subtype','Transcriptome Subtype','Supervised DNA Methylation Cluster','Random Forest Sturm Cluster'};
GBM_M450 = AddRowAnnotationFromFile(GBM_M450,fullfile(SampleAnnotationDirectory,'TableS1.PatientData.20151020.v3.xlsx'),'ColumnsToAdd',List,'Truncate',12,'File_Id','Case','SheetName','S1A. TCGA discovery dataset');


% Select Normal samples
GBM_M450_Normal  = EditSamplesDATA(GBM_M450,{'Solid Tissue Normal'},'Keep','SampleIdentifier','Sample_Type');

GBM_M450 = EditSamplesDATA(GBM_M450,{'Primary solid Tumor'},'Keep','SampleIdentifier','Sample_Type');
indx_DSS = strcmp('DSS',GBM_M450.SURVIVAL.SurvivalTypes);
indx     = (~strcmpi('NA',GBM_M450.SURVIVAL.SurvEvent(:,indx_DSS)) & isfinite(GBM_M450.SURVIVAL.SurvTime(:,indx_DSS)));
GBM_M450 = EditSamplesDATA(GBM_M450,GBM_M450.RowId(indx),'Keep');
GBM_M450 = AddRowAnnotationFromFile(GBM_M450,'RadiationInfo.xlsx','Truncate',12,'File_Id','bcr_patient_barcode','SheetName','GBM');

% Select only samples with radiation treatment
GBM_M450_RT = EditSamplesDATA(GBM_M450,{'KEEP'},'Keep','SampleIdentifier','REMOVE');

% Select only samples without any radiation treatment
GBM_M450_NoRT = EditSamplesDATA(GBM_M450,{'---'},'Keep','SampleIdentifier','radiation_therapy_type');
GBM_M450_NoRT = EditSamplesDATA(GBM_M450_NoRT,{'YES'},'Remove','SampleIdentifier','radiation_therapy');

% Save individual file to DATA directory
save(fullfile(DataDirectory,"GBM_M450_Normal.mat"),"GBM_M450_Normal")
save(fullfile(DataDirectory,"GBM_M450_RT.mat"),"GBM_M450_RT")
save(fullfile(DataDirectory,"GBM_M450_NoRT.mat"),"GBM_M450_NoRT")




%% Generate lower grade glioma datasets, LGG

% Select glioma samples
LGG_M450 = EditSamplesDATA(M450K,'LGG','Keep','SampleIdentifier','TCGA_Code');

% Add specific LGG annotation
List     = {'Case','IDH status','MGMT promoter status','Original Subtype','Transcriptome Subtype','Supervised DNA Methylation Cluster','Random Forest Sturm Cluster'};
LGG_M450 = AddRowAnnotationFromFile(LGG_M450,fullfile(SampleAnnotationDirectory,'TableS1.PatientData.20151020.v3.xlsx'),'ColumnsToAdd',List,'Truncate',12,'File_Id','Case','SheetName','S1A. TCGA discovery dataset');


LGG_M450 = EditSamplesDATA(LGG_M450,{'Primary solid Tumor'},'Keep','SampleIdentifier','Sample_Type');
indx_DSS = strcmp('DSS',LGG_M450.SURVIVAL.SurvivalTypes);
indx     = (~strcmpi('NA',LGG_M450.SURVIVAL.SurvEvent(:,indx_DSS)) & isfinite(LGG_M450.SURVIVAL.SurvTime(:,indx_DSS)));
LGG_M450 = EditSamplesDATA(LGG_M450,LGG_M450.RowId(indx),'Keep');
LGG_M450 = AddRowAnnotationFromFile(LGG_M450,'RadiationInfo.xlsx','Truncate',12,'File_Id','bcr_patient_barcode','SheetName','LGG');

% Select only samples with radiation treatment
LGG_M450_RT = EditSamplesDATA(LGG_M450,{'KEEP'},'Keep','SampleIdentifier','REMOVE');

% Select only samples without any radiation treatment
LGG_M450_NoRT = EditSamplesDATA(LGG_M450,{'---'},'Keep','SampleIdentifier','radiation_therapy_type');
LGG_M450_NoRT = EditSamplesDATA(LGG_M450_NoRT,{'YES'},'Remove','SampleIdentifier','radiation_therapy');

% Save individual file to DATA directory
save(fullfile(DataDirectory,"LGG_M450_RT.mat"),"LGG_M450_RT")
save(fullfile(DataDirectory,"LGG_M450_NoRT.mat"),"LGG_M450_NoRT")


