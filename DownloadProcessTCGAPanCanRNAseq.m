function DownloadProcessTCGAPanCanRNAseq

%% Load Defaults

MRA_Options

%% Move to the correct directory
cd(fullfile(Opt.BaseDir,Opt.SubDirs.RNAseqDir))


%% Use ready make function for downloading and annotate TCGA PANCANCER RNAseq data



%Read already downloaded 'EBPlusPlusAdjustPANCAN_IlluminaHiSeq_RNASeqV2.geneExp.tsv'
if ~isfile('EBPlusPlusAdjustPANCAN_IlluminaHiSeq_RNASeqV2.geneExp.tsv')
    try
        warning('Could not find EBPlusPlusAdjustPANCAN_IlluminaHiSeq_RNASeqV2.geneExp.tsv in this directory')
        warning('Starting to download it now, will probably take a couple of minutes')
        websave('EBPlusPlusAdjustPANCAN_IlluminaHiSeq_RNASeqV2.geneExp.tsv','http://api.gdc.cancer.gov/data/3586c0da-64d0-4b74-a449-5ff4d9136611');
        
    catch
        error('Could not load EBPlusPlusAdjustPANCAN_IlluminaHiSeq_RNASeqV2.geneExp.tsv from https://gdc.cancer.gov/about-data/publications/pancanatlas')
    end
end
fprintf('Processing EBPlusPlusAdjustPANCAN_IlluminaHiSeq_RNASeqV2.geneExp.tsv\n')

RNAseq = ReadData('EBPlusPlusAdjustPANCAN_IlluminaHiSeq_RNASeqV2.geneExp.tsv');

% Add Info
RNAseq.Title = 'TCGA RNAseq PanCan';
RNAseq.Info.Source = 'EBPlusPlusAdjustPANCAN_IlluminaHiSeq_RNASeqV2.geneExp.tsv';
RNAseq.Info.Type = 'GeneExpression';
RNAseq.Info.Platform = 'RNAseqV2';


% Get Refseq Id
fprintf('Updating Gene Annotation\n')

GeneIdSymbol = cellfun(@(x) strsplit(x,'|'),RNAseq.ColId,'UniformOutput',false);
GeneIdSymbol = cat(1,GeneIdSymbol{:});
RNAseq.ColId = GeneIdSymbol(:,2);

%Get REFSeq in for NCBI 
RNAseq = AddREFseqGeneInfo(RNAseq,[],'Replace');
RNAseq.ColAnnotationFields(end+1:end+2) = {'TCGA GeneSymbol','TCGA GeneId'}';
RNAseq.ColAnnotation = [RNAseq.ColAnnotation  GeneIdSymbol];

% Add basic Sample info based on TCGA sample Id
fprintf('Converting TCGA Id to sample info\n')

[SampleInfo,SampleFields] = ConvertTCGAId(cellstr(RNAseq.RowId));
RNAseq.RowAnnotation = SampleInfo;
RNAseq.RowAnnotationFields = SampleFields;

% Convert to log2
RNAseq.X(RNAseq.X < 0) = 0;
RNAseq.X = log2(RNAseq.X+1);

% Add Survival data from TCGA-Clinical Data Resource (CDR) Outcome
% TCGA-CDR-SupplementalTableS1.xlsx 
% Will add Survival data for the normal samples
fprintf('Adding Survival data\n')
SURVIVAL = ReadTCGA_Survival_File(fullfile(Opt.BaseDir,Opt.SubDirs.SampleAnnotationDir,'TCGA-CDR-SupplementalTableS1.xlsx'));
RNAseq = AddSurvivalDATA(RNAseq,[],SURVIVAL);

% Add cinical data from TCGA-Clinical Data Resource (CDR)
if ~isfile(fullfile(Opt.BaseDir,Opt.SubDirs.SampleAnnotationDir,'clinical_PANCAN_patient_with_followup.tsv'))
    try
        warning('Could not find clinical_PANCAN_patient_with_followup.tsv in this directory')
        warning('Starting to download it now, will probably take a couple of minutes')
        websave(fullfile(Opt.BaseDir,Opt.SubDirs.SampleAnnotationDir,'clinical_PANCAN_patient_with_followup.tsv'),'http://api.gdc.cancer.gov/data/0fc78496-818b-4896-bd83-52db1f533c5c');
    catch
        error('Could not load clinical_PANCAN_patient_with_followup.tsv from http://api.gdc.cancer.gov/data/0fc78496-818b-4896-bd83-52db1f533c5c')
    end
end
List = {'bcr_patient_barcode','gender','age_at_initial_pathologic_diagnosis',...
    'tumor_tissue_site','new_tumor_event_after_initial_treatment','radiation_therapy',...
    'race','histological_type','pathologic_T','pathologic_M','clinical_M','pathologic_N',...
    'clinical_stage','clinical_T','clinical_N'};
RNAseq = AddRowAnnotationFromFile(RNAseq,fullfile(Opt.BaseDir,Opt.SubDirs.SampleAnnotationDir,'clinical_PANCAN_patient_with_followup.tsv'),'File_Id','bcr_patient_barcode','ColumnsToAdd',List,'Truncate',12);

% add HPV status
RNAseq = AddRowAnnotationFromFile(RNAseq,fullfile(Opt.BaseDir,Opt.SubDirs.SampleAnnotationDir,'NIHMS958981-supplement-2.xlsx'),'ColumnsToAdd',{'Methylation450 Samples','HPV_status','Major HPV type'},'SheetName','Table S1M','File_Id','Methylation450 Samples','Truncate',12);



save(fullfile(Opt.BaseDir,Opt.SubDirs.RNAseqDataDir,"RNAseq.mat"),"RNAseq")

end

