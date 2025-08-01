function DownloadProcessTCGAPanCanM450
% Function for downloading and processing Illumina M450K Pancancer data for "A dysregulated
% methylome modulates the radiosensitivity of cancer" article. 
% the function will also download additional annotation files used in the article.
% Anders Berglund 2025
%% Directory paths

try
    MRA_Options;
catch
    error('Could not load MRA_Options.m file\n Make sure the GitHub library is added to the path')
end

%% Download LARGE methylation file


% Move to the correct directory
cd(fullfile(Opt.BaseDir,Opt.SubDirs.RawDataDir))

% Stronlgy suggest to pre-download this file and put it in the correct folder, will take long to
% download

if (~isempty(Opt.TCGA_M450_path) || Opt.TCGA_M450_path == "") && ~isfile('jhu-usc.edu_PANCAN_HumanMethylation450.betaValue_whitelisted.tsv') 
    [~,name,ext] = fileparts(Opt.TCGA_M450_path);
    [status,msg] = copyfile(Opt.TCGA_M450_path,strcat(name,ext));
    if ~status
        error('Could not copy methylation file: %s\nError message:',Opt.TCGA_M450_path,msg)
    end
    
end


if ~isfile('jhu-usc.edu_PANCAN_HumanMethylation450.betaValue_whitelisted.tsv') 
    if isfile('jhu-usc.edu_PANCAN_HumanMethylation450.betaValue_whitelisted.tsv.gz')
        gunzip('jhu-usc.edu_PANCAN_HumanMethylation450.betaValue_whitelisted.tsv.gz')
    else
        try
            warning('Could not find jhu-usc.edu_PANCAN_HumanMethylation450.betaValue_whitelisted.tsv in this directory')
            warning('Starting to download it now, will probably take a couple of minutes')
            websave('jhu-usc.edu_PANCAN_HumanMethylation450.betaValue_whitelisted.tsv','https://api.gdc.cancer.gov/data/99b0c493-9e94-4d99-af9f-151e46bab989');

        catch
            error('Could not download jhu-usc.edu_PANCAN_HumanMethylation450.betaValue_whitelisted.tsv from https://api.gdc.cancer.gov/data/99b0c493-9e94-4d99-af9f-151e46bab989')
        end
    end
end



%% Dowload necessary Sample Annotation files

% Move to the correct directory
cd(fullfile(Opt.BaseDir,Opt.SubDirs.SampleAnnotationDir))

% Download TCGA PanCan sample annotation file
% https://gdc.cancer.gov/about-data/publications/pancanatlas
if ~isfile('clinical_PANCAN_patient_with_followup.tsv')
    try
        warning('Could not find clinical_PANCAN_patient_with_followup.tsv in this directory')
        warning('Starting to download it now, will probably take a couple of minutes')
        websave('clinical_PANCAN_patient_with_followup.tsv','https://api.gdc.cancer.gov/data/0fc78496-818b-4896-bd83-52db1f533c5c');
    catch
        error('Could not load clinical_PANCAN_patient_with_followup.tsv from https://api.gdc.cancer.gov/data/0fc78496-818b-4896-bd83-52db1f533c5c')
    end
end

% Download file with Survival information, will try two different locations, GDC and journal
% An Integrated TCGA Pan-Cancer Clinical Data Resource to Drive High-Quality Survival Outcome Analytics
% PMID: 29625055 PMCID: PMC6066282 DOI: 10.1016/j.cell.2018.02.052
% https://pmc.ncbi.nlm.nih.gov/articles/PMC6002769/
if ~isfile('TCGA-CDR-SupplementalTableS1.xlsx')
    try
        warning('Could not find TCGA-CDR-SupplementalTableS1.xls in this directory')
        warning('Starting to download it now, will probably take a couple of minutes')
        websave('TCGA-CDR-SupplementalTableS1.xlsx','https://api.gdc.cancer.gov/data/1b5f413e-a8d1-4d10-92eb-7c4ae739ed81');
    catch
        try
            websave('TCGA-CDR-SupplementalTableS1.xlsx','https://pmc.ncbi.nlm.nih.gov/articles/instance/6066282/bin/NIHMS978596-supplement-1.xlsx');
        catch

            error('Could not load TCGA-CDR-SupplementalTableS1.xlsx from https://api.gdc.cancer.gov/data/1b5f413e-a8d1-4d10-92eb-7c4ae739ed81 OR https://pmc.ncbi.nlm.nih.gov/articles/instance/6066282/bin/NIHMS978596-supplement-1.xlsx')
        end
    end
end

% Download file with HPV status, will try two different locations
% Genomic, Pathway Network, and Immunologic Features Distinguishing Squamous Carcinomas
% PMID: 29617660 PMCID: PMC6002769 DOI: 10.1016/j.celrep.2018.03.063
% https://pmc.ncbi.nlm.nih.gov/articles/PMC6002769/
if ~isfile('NIHMS958981-supplement-2.xlsx')
    try
        warning('Could not find NIHMS958981-supplement-2.xlsx in this directory')
        warning('Starting to download it now, will probably take a couple of seconds')
        websave('NIHMS958981-supplement-2.xlsx','https://pmc.ncbi.nlm.nih.gov/articles/instance/6002769/bin/NIHMS958981-supplement-2.xlsx');
    catch
        try
            websave('NIHMS958981-supplement-2.xlsx','https://ars.els-cdn.com/content/image/1-s2.0-S2211124718304248-mmc2.xlsx');
        catch

            error('Could not load NIHMS958981-supplement-2.xlsx from https://pmc.ncbi.nlm.nih.gov/articles/instance/6002769/bin/NIHMS958981-supplement-2.xlsx')
        end
    end
end

% Download file with BRCA annotation, will try two different locations
% Comprehensive molecular portraits of invasive lobular breast cancer
% PMID: 26451490 PMCID: PMC4603750 DOI: 10.1016/j.cell.2015.09.033
% https://pmc.ncbi.nlm.nih.gov/articles/PMC4603750/
if ~isfile('NIHMS724218-supplement-2.xlsx')
    try
        warning('Could not find NIHMS958065-supplement-4.xlsx in this directory')
        warning('Starting to download it now, will probably take a couple of seconds')
        websave('NIHMS724218-supplement-2.xlsx','https://pmc.ncbi.nlm.nih.gov/articles/instance/4603750/bin/NIHMS724218-supplement-2.xlsx');
    catch
        try
            websave('NIHMS724218-supplement-2.xlsx','https://ars.els-cdn.com/content/image/1-s2.0-S0092867415011952-mmc2.xlsx');
        catch

            error('Could not load NIHMS724218-supplement-2.xlsx from https://pmc.ncbi.nlm.nih.gov/articles/instance/5959730/bin/NIHMS958065-supplement-4.xlsx')
        end
    end
end
% Download file with GBM and LGG annotation, will try two different locations
% Molecular Profiling Reveals Biologically Discrete Subsets and Pathways of Progression in Diffuse Glioma
% PMID: 26824661 PMCID: PMC4754110 DOI: 10.1016/j.cell.2015.12.028
% https://pmc.ncbi.nlm.nih.gov/articles/PMC4754110/
% Will start to try and download file "AWG Clinical Supplementary Info" https://gdc.cancer.gov/about-data/publications/lgggbm_2016
if ~isfile('TableS1.PatientData.20151020.v3.xlsx')
    try
        warning('Could not find TableS1.PatientData.20151020.v3.xlsx in this directory')
        warning('Starting to download it now, will probably take a couple of seconds')
        websave('TableS1.PatientData.20151020.v3.xlsx','https://api.gdc.cancer.gov/data/a0886693-4c6e-40de-9cb1-8bfcb4bb30a7');
    catch
        try
            websave('TableS1.PatientData.20151020.v3.xlsx','https://pmc.ncbi.nlm.nih.gov/articles/instance/4754110/bin/NIHMS746836-supplement-8.xlsx');
        catch

            error('Could not load TableS1.PatientData.20151020.v3.xlsx from https://api.gdc.cancer.gov/data/a0886693-4c6e-40de-9cb1-8bfcb4bb30a7')
        end
    end
end
%% Download Illumina M450K CpG-probe annotation

% Move to the correct directory
cd(fullfile(Opt.BaseDir,Opt.SubDirs.ProbeAnnotationDir))

% Get Illumina M450K annotation file
% Make sure that humanmethylation450_15017482_v1-2.csv is in this directory or it will get
% downloaded
if ~isfile('humanmethylation450_15017482_v1-2.csv')
    try
        warning('Could not find humanmethylation450_15017482_v1-2.csv in this directory')
        warning('Starting to download it now, will probably take a couple of minutes')
        websave('humanmethylation450_15017482_v1-2.csv','https://webdata.illumina.com/downloads/productfiles/humanmethylation450/humanmethylation450_15017482_v1-2.csv');
    catch
        error('Could not download humanmethylation450_15017482_v1-2.csv from https://webdata.illumina.com/downloads/productfiles/humanmethylation450/')
    end
end

% Get Additional annotation file for M450K
if ~isfile('HM450.hg38.manifest.tsv')
    if isfile('HM450.hg38.manifest.tsv.gz')
        gunzip('HM450.hg38.manifest.tsv.gz')
    else
        try
            warning('Could not find HM450.hg38.manifest.tsv in this directory')
            warning('Starting to download it now, will probably take a couple of minutes')
            websave('HM450.hg38.manifest.tsv.gz','https://github.com/zhou-lab/InfiniumAnnotationV1/raw/main/Anno/HM450/archive/202209/HM450.hg38.manifest.tsv.gz');
            gunzip('HM450.hg38.manifest.tsv.gz')
        catch
            error('Could not download HM450.hg38.manifest.tsv.gz from https://github.com/zhou-lab/InfiniumAnnotationV1/raw/main/Anno/HM450/archive/202209/HM450.hg38.manifest.tsv.gz')
        end
    end
end

% Get Masking file for M450K
if ~isfile('HM450.hg38.mask.tsv')
    if isfile('HM450.hg38.mask.tsv.gz')
        gunzip('HM450.hg38.mask.tsv.gz')
    else
        try
            warning('Could not find HM450.hg38.mask.tsv in this directory')
            warning('Starting to download it now, will probably take a couple of seconds')
            websave('HM450.hg38.mask.tsv.gz','https://github.com/zhou-lab/InfiniumAnnotationV1/raw/main/Anno/HM450/archive/202209/HM450.hg38.mask.tsv.gz');
            gunzip('HM450.hg38.mask.tsv.gz')
        catch
            error('Could not download HM450.hg38.mask.tsv.gz from https://github.com/zhou-lab/InfiniumAnnotationV1/raw/main/Anno/HM450/archive/202209/')
        end
    end
end

%% Start loading and processing methylation file


% read large text files, takes several minutes
M450K = ReadData(fullfile(Opt.BaseDir,Opt.SubDirs.RawDataDir,"jhu-usc.edu_PANCAN_HumanMethylation450.betaValue_whitelisted.tsv"));
% Add Info
M450K.Title = 'TCGA M450 PanCan';
M450K.Info.Type = 'Methylation';
M450K.Info.Platform = 'M450K';

% Add basic Sample info based on TCGA sample Id
[SampleInfo,SampleFields] = ConvertTCGAId(cellstr(M450K.RowId));
M450K.RowAnnotation = string(SampleInfo);
M450K.RowAnnotationFields = SampleFields;

% Define what parameters to add
List = {'bcr_patient_barcode','gender','age_at_initial_pathologic_diagnosis',...
    'tumor_tissue_site','new_tumor_event_after_initial_treatment','radiation_therapy',...
    'race','histological_type','pathologic_T','pathologic_M','clinical_M','pathologic_N',...
    'clinical_stage','clinical_T','clinical_N'};
M450K = AddRowAnnotationFromFile(M450K,fullfile(Opt.BaseDir,Opt.SubDirs.SampleAnnotationDir,'clinical_PANCAN_patient_with_followup.tsv'),'File_Id','bcr_patient_barcode','ColumnsToAdd',List,'Truncate',12);


% add HPV status
M450K = AddRowAnnotationFromFile(M450K,fullfile(Opt.BaseDir,Opt.SubDirs.SampleAnnotationDir,'NIHMS958981-supplement-2.xlsx'),'ColumnsToAdd',{'Methylation450 Samples','HPV_status','Major HPV type'},'SheetName','Table S1M','File_Id','Methylation450 Samples','Truncate',12);

% Add Survival data from TCGA-Clinical Data Resource (CDR) Outcome
% TCGA-CDR-SupplementalTableS1.xlsx
% Will add Survival data for the normal samples
SURVIVAL = ReadTCGA_Survival_File(fullfile(Opt.BaseDir,Opt.SubDirs.SampleAnnotationDir,'TCGA-CDR-SupplementalTableS1.xlsx'));
M450K = AddSurvivalDATA(M450K,[],SURVIVAL);


% Add CpG-probe Annotation
M450K = AddIlluminaManifestAnnotation(M450K,fullfile(Opt.BaseDir,Opt.SubDirs.ProbeAnnotationDir,'humanmethylation450_15017482_v1-2.csv'),'Replace');
M450K = AddColAnnotationFromFile(M450K,fullfile(Opt.BaseDir,Opt.SubDirs.ProbeAnnotationDir,'HM450.hg38.manifest.tsv'),'File_Id','probeID','ColumnsToAdd',{'CpG_chrm','CpG_beg','gene_HGNC'});

% remove non-cg probes, X, Y and Masked probes
M450K = RemoveSelectedCpGs(M450K,'KeepCgOnly','X','Y','Masked',fullfile(Opt.BaseDir,Opt.SubDirs.ProbeAnnotationDir,'HM450.hg38.mask.tsv'),'RemoveMV',5);

% Save Large file with all TCGA samples
save(fullfile(Opt.BaseDir,Opt.SubDirs.DataDir,"M450K.mat"),"M450K","-v7.3")