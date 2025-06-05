function ProcessCCLEM450

%% Load Defaults

MRA_Options

%%
CCLEDir = (fullfile(Opt.BaseDir,Opt.SubDirs.CCLEDir));


%% Move to the correct directory
cd(fullfile(CCLEDir))


% Load data downloaded from GSE68379 and proccessed using ENmix, see XXX.R for R-scriptCope the
% file

try
    if isfile(Opt.CCLE_M450_GSE68379_path) 
        CCLE = ReadData(Opt.CCLE_M450_GSE68379_path,'R');
    end
catch
   CCLE_file = uigetfile(fullfile(Opt.BaseDir,'*.*'),'Select CCLE methylation file');
   if CCLE_file
        CCLE = ReadData(CCLE_file,'R');
   else
       error('Could not import CCLE methylation file. Please select the file of give the correct path in MRA-Options.m file')
   end
end
% Add Info
CCLE.Title = 'CCLE M450 GSE68379';
CCLE.Info.Type = 'Methylation';
CCLE.Info.Platform = 'M450K';

% Add CpG-probe Annotation
CCLE = AddIlluminaManifestAnnotation(CCLE,fullfile(Opt.BaseDir,Opt.SubDirs.ProbeAnnotationDir,'humanmethylation450_15017482_v1-2.csv'),'Replace');
CCLE = AddColAnnotationFromFile(CCLE,fullfile(Opt.BaseDir,Opt.SubDirs.ProbeAnnotationDir,'HM450.hg38.manifest.tsv'),'File_Id','probeID','ColumnsToAdd',{'CpG_chrm','CpG_beg','gene_HGNC'});

% remove non-cg probes, X, Y and Masked probes
CCLE = RemoveSelectedCpGs(CCLE,'KeepCgOnly','X','Y','Masked',fullfile(Opt.BaseDir,Opt.SubDirs.ProbeAnnotationDir,'HM450.hg38.mask.tsv'));

% Read Series matrix
geodata = getgeodata('GSE68379','ToFile','GSE68379_SeriesMatrix.txt');
[~, ~] = Geo2SampleInfo(geodata,'GSE68379_SampleInfo.txt');


% Add series matrix
CCLE = AddRowAnnotationFromFile(CCLE,'GSE68379_SampleInfo.txt','File_Id','geo_accession','Truncate',10,'ColumnsToAdd',{'geo_accession','cell line','primary site','primary histology','cosmic_id'});
CellID_M450 = CCLE.RowAnnotation(:,1);

% get Cellosaurious data

CELLOSAURUS = ProcessCellosaurusFile('cellosaurus.txt');

ManualCorrectionCCLE = {'ECC4', 'ECC4 [Human cholangiocarcinoma]';...
                    'HARA', 'HARA [Human squamous cell lung carcinoma]';...
                    'HEP3B2-1-7', 'Hep 3B2.1-7';...
                    'HH', 'HH [Human lymphoma]';...
                    'KS-1', 'KS-1 [Human glioblastoma]';...
                    'ML-1', 'ML-1 [Human thyroid carcinoma]';...
                    'NTERA-S-CL-D1', 'NT2-D1';...
                    'OMC-1', 'OMC-1 [Human cervical carcinoma]';...
                    'PC-3_JPC-3', 'PC-3 [Human lung carcinoma]';...
                    'RCM-1', 'RCM-1 [Human rectal adenocarcinoma]';...
                    'TK', 'TK [Human B-cell lymphoma]'};

[~, ~] = GetCellosariousID(CellID_M450,CELLOSAURUS,'ManualCorrection',ManualCorrectionCCLE,'PrintResults','GSE68379_Cellosaurus.txt');

CCLE = AddRowAnnotationFromFile(CCLE,'GSE68379_Cellosaurus.txt','DATA_Id','cell line','File_Id','Orig Id','ColumnsToAdd',{'Orig Id','ID','AC','SY','DI','SX','AG','CA'});



% Download file with radiation info, will try two different locations
% A genetic basis for the variation in the vulnerability of cancer to DNA damage
% PMID: 27109210 PMCID: PMC4848553 DOI: 10.1038/ncomms11428
% https://pmc.ncbi.nlm.nih.gov/articles/PMC4848553/
if ~isfile('ncomms11428-s2.xlsx')
    try
        warning('Could not find ncomms11428-s2.xlsx in this directory')
        warning('Starting to download it now, will probably take a couple of seconds')
        websave('ncomms11428-s2.xlsx','https://pmc.ncbi.nlm.nih.gov/articles/instance/4848553/bin/ncomms11428-s2.xlsx');
    catch
        try
            websave('ncomms11428-s2.xlsx','https://static-content.springer.com/esm/art%3A10.1038%2Fncomms11428/MediaObjects/41467_2016_BFncomms11428_MOESM708_ESM.xlsx');
        catch

            error('Could not load NIHMS958981-supplement-2.xlsx from https://pmc.ncbi.nlm.nih.gov/articles/instance/4848553/bin/ncomms11428-s2.xlsx')
        end
    end
end

opts = spreadsheetImportOptions("NumVariables", 8);

% Specify sheet and range
opts.Sheet = "Supplementary Data 1";
opts.DataRange = "A3:H535";

% Specify column names and types
opts.VariableNames = ["Master_ccl_id", "CellLine", "Site", "Histology", "Subhistology", "Culture_media", "Snp_fp_status", "AUC"];
opts.VariableTypes = ["char", "char", "char", "char", "char", "char", "char", "char"];

% Specify variable properties
opts = setvaropts(opts, ["Master_ccl_id", "CellLine", "Site", "Histology", "Subhistology", "Culture_media", "Snp_fp_status", "AUC"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Master_ccl_id", "CellLine", "Site", "Histology", "Subhistology", "Culture_media", "Snp_fp_status", "AUC"], "EmptyFieldRule", "auto");

% Import the data
T = readtable("ncomms11428-s2.xlsx", opts, "UseExcel", false);




ManualCorrectionRadiation = {'CJM', 'CJM [Human melanoma]';...
                    'ML1', 'ML-1 [Human thyroid carcinoma]';...
                    'RCM1', 'RCM-1 [Human rectal adenocarcinoma]'};

[RESULTS, ColumnFields] = GetCellosariousID(T.CellLine,CELLOSAURUS,'ManualCorrection',ManualCorrectionRadiation);

indx=ismember(ColumnFields,{'Orig Id','ID'});
TableRes = array2table(RESULTS(:,indx),'VariableNames',ColumnFields(indx));

TT=join(T,TableRes,'LeftKeys','CellLine','RightKeys','Orig Id');
writetable(TT,'AUC_Radiation.txt','Delimiter','\t');

CCLE_Radiation = AddRowAnnotationFromFile(CCLE,'/Users/berglund.anders/Documents/DATA/CCLE/ANNOTATIONS/RADIATION/AUC_Radiation.txt','DATA_Id','ID','File_Id','ID');
CCLE_Radiation  = EditSamplesDATA(CCLE_Radiation,CCLE_Radiation.RowId(strcmp('---',CCLE_Radiation.RowAnnotation(:,end))),'Remove');


save(fullfile(CCLEDir,"CCLE_Radiation.mat"),"CCLE_Radiation")




