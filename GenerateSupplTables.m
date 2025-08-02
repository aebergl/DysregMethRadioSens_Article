function GenerateSupplTables
% Function generating individual tab-separated text files for the supplementary tables

%% Load defaults
MRA_Options;


%% Supplementary Table 1
DataDirectory = (fullfile(Opt.BaseDir,Opt.SubDirs.DataDir));
ResultDirectory = (fullfile(Opt.BaseDir,Opt.SubDirs.ResultDir));

TableDir = fullfile(Opt.BaseDir,Opt.SubDirs.SupplMaterialDir,Opt.SupplMat(3));


%% Table 1a HNSC
load(fullfile(DataDirectory,"HNSC_M450_RT_HPVneg.mat"),'HNSC_M450_RT_HPVneg')
load(fullfile(DataDirectory,"HNSC_M450_NoRT_HPVneg.mat"),'HNSC_M450_NoRT_HPVneg')
Fields={'age_at_initial_pathologic_diagnosis','gender','pathologic_T','pathologic_M','clinical_T','clinical_M','neoplasm_histologic_grade'};
Types = {'cont','cat','cat','cat','cat','cat','cat'};
FileName = fullfile(TableDir,'SuppTable_01a_HPVnegHNSCC_ClinTable.txt');
CalculateClincalComparison(HNSC_M450_RT_HPVneg,HNSC_M450_NoRT_HPVneg,Fields,Types,FileName)



%% Table 1b PRAD
load(fullfile(DataDirectory,"PRAD_M450_RT.mat"),'PRAD_M450_RT')
load(fullfile(DataDirectory,"PRAD_M450_NoRT.mat"),'PRAD_M450_NoRT')

Fields={'age_at_initial_pathologic_diagnosis','psa_value','gleason_score','pathologic_T','pathologic_N','clinical_T','consensus ancestry simple'};
Types = {'cont',[10 20],'cat','cat','cat','cat','cat'};
FileName = fullfile(TableDir,'SuppTable_01b_PRAD_ClinTable.txt');
CalculateClincalComparison(PRAD_M450_RT,PRAD_M450_NoRT,Fields,Types,FileName)


%% Table 1c SKCM
load(fullfile(DataDirectory,"SKCM_M450_RT.mat"),'SKCM_M450_RT')
load(fullfile(DataDirectory,"SKCM_M450_NoRT.mat"),'SKCM_M450_NoRT')

Fields = {'age_at_initial_pathologic_diagnosis','gender','Sample_Type','tumor_tissue_site','pathologic_T','pathologic_M','pathologic_N'};
Types = {'cont','cat','cat','cat','cat','cat','cat'};
FileName = fullfile(TableDir,'SuppTable_01c_SKCM_ClinTable.txt');
CalculateClincalComparison(SKCM_M450_RT,SKCM_M450_NoRT,Fields,Types,FileName)



%% Table 1d BRCA
load(fullfile(DataDirectory,"BRCA_M450_RT.mat"),'BRCA_M450_RT')
load(fullfile(DataDirectory,"BRCA_M450_NoRT.mat"),'BRCA_M450_NoRT')


Fields = {'age_at_initial_pathologic_diagnosis','gender','histological_type','pathologic_T','pathologic_M','pathologic_N','PAM50','breast_carcinoma_progesterone_receptor_status','breast_carcinoma_estrogen_receptor_status','lab_proc_her2_neu_immunohistochemistry_receptor_status'};
Types = {'cont','cat','cat','cat','cat','cat','cat','cat','cat','cat','cat','cat'};
FileName = fullfile(TableDir,'SuppTable_01d_BRCA_ClinTable.txt');
CalculateClincalComparison(BRCA_M450_RT,BRCA_M450_NoRT,Fields,Types,FileName)


%% Table 1e SARC
load(fullfile(DataDirectory,"SARC_M450_RT.mat"),'SARC_M450_RT')
load(fullfile(DataDirectory,"SARC_M450_NoRT.mat"),'SARC_M450_NoRT')

Fields = {'age_at_initial_pathologic_diagnosis','gender','tumor_tissue_site','histological_type'};
Types = {'cont','cat','cat','cat'};
FileName = fullfile(TableDir,'SuppTable_01e_SARC_ClinTable.txt');
CalculateClincalComparison(SARC_M450_RT,SARC_M450_NoRT,Fields,Types,FileName)


%% Table 1f STAD
load(fullfile(DataDirectory,"STAD_M450_RT.mat"),'STAD_M450_RT')
load(fullfile(DataDirectory,"STAD_M450_NoRT.mat"),'STAD_M450_NoRT')

Fields = {'age_at_initial_pathologic_diagnosis','gender','histological_type','pathologic_T','pathologic_M','pathologic_N','pathologic_stage','neoplasm_histologic_grade'};
Types = {'cont','cat','cat','cat','cat','cat','cat','cat'};
FileName = fullfile(TableDir,'SuppTable_01f_STAD_ClinTable.txt');
CalculateClincalComparison(STAD_M450_RT,STAD_M450_NoRT,Fields,Types,FileName)


%% Table 1g CESC
load(fullfile(DataDirectory,"CESC_M450_RT.mat"),'CESC_M450_RT')
load(fullfile(DataDirectory,"CESC_M450_NoRT.mat"),'CESC_M450_NoRT')

Fields = {'age_at_initial_pathologic_diagnosis','histological_type','pathologic_T','pathologic_M','pathologic_N','clinical_stage','neoplasm_histologic_grade','HPV_status','Major HPV type'};
Types = {'cont','cat','cat','cat','cat','cat','cat','cat','cat'};
FileName = fullfile(TableDir,'SuppTable_01g_CESC_ClinTable.txt');
CalculateClincalComparison(CESC_M450_RT,CESC_M450_NoRT,Fields,Types,FileName)


%% Table 1h GBM
load(fullfile(DataDirectory,"GBM_M450_RT.mat"),'GBM_M450_RT')
load(fullfile(DataDirectory,"GBM_M450_NoRT.mat"),'GBM_M450_NoRT')

Fields = {'age_at_initial_pathologic_diagnosis','gender','histological_type','MGMT promoter status','Original Subtype','Transcriptome Subtype','Supervised DNA Methylation Cluster'};
Types = {'cont','cat','cat','cat','cat','cat','cat'};
FileName = fullfile(TableDir,'SuppTable_01h_GBM_ClinTable.txt');
CalculateClincalComparison(GBM_M450_RT,GBM_M450_NoRT,Fields,Types,FileName)

%% Table 1i LGG
load(fullfile(DataDirectory,"LGG_M450_RT.mat"),'LGG_M450_RT')
load(fullfile(DataDirectory,"LGG_M450_NoRT.mat"),'LGG_M450_NoRT')

Fields = {'age_at_initial_pathologic_diagnosis','gender','histological_type','Grade','IDH status','MGMT promoter status','Original Subtype','Transcriptome Subtype','Supervised DNA Methylation Cluster'};
Types = {'cont','cat','cat','cat','cat','cat','cat','cat','cat'};
FileName = fullfile(TableDir,'SuppTable_01i_LGG_ClinTable.txt');
CalculateClincalComparison(LGG_M450_RT,LGG_M450_NoRT,Fields,Types,FileName)


%%
%% Supplementary Table 2

TableDir = fullfile(Opt.BaseDir,Opt.SubDirs.SupplMaterialDir,Opt.SupplMat(4));
load(fullfile(ResultDirectory,"SelectedCpG_probes.mat"),'SelectedCpG_probes')

HNSC_M450_RT_HPVneg =  EditVariablesDATA(HNSC_M450_RT_HPVneg,SelectedCpG_probes,'Keep');

[fid,Msg] = fopen(fullfile(TableDir,'SuppTable_02_SelectedCpG_probes.txt'),'w');
if fid == -1
    error('Could not create %s, reason: %s',fullfile(TableDir,'SuppTable_02_174CpG_probes.txt'),Msg)
end
VarNames = ["IlmnID" "Regulatory_Feature_Group" "gene_HGNC"];
[~, indx] = ismember(VarNames,HNSC_M450_RT_HPVneg.ColAnnotationFields);
fprintf(fid,'IlmnID\tRegulatory_Feature_Group\tgene_HGNC\n');
for i = 1:HNSC_M450_RT_HPVneg.nCol
    fprintf(fid,'%s\t%s\t%s\n',HNSC_M450_RT_HPVneg.ColAnnotation(i,indx));

end
fclose(fid);


%% Supplementary Table 

CCLEDir = (fullfile(Opt.BaseDir,Opt.SubDirs.CCLEDir));
TableDir = fullfile(Opt.BaseDir,Opt.SubDirs.SupplMaterialDir,Opt.SupplMat(5));

% Melnoma

load(fullfile(CCLEDir,"CCLE_Melanoma.mat"),"CCLE_Melanoma")

WriteData(CCLE_Melanoma,fullfile(TableDir,'SuppTable_03_CCLE_M450_MelanomaSamples.txt')','SampleAnnotationOnly')


