% Script defining base directory and folder structure
% Also allows for using already downloaded molecular data files

%% Directory paths
% Please set you folder where 

Opt.BaseDir                 = "/Users/berglund.anders/Documents/PublicationFolders/RadiationMethylationArticle";

% These directories will be created in the BaseDir if they already are not there
Opt.SubDirs.SampleAnnotationDir     = "SampleAnnotation";
Opt.SubDirs.ProbeAnnotationDir      = "ProbeAnnotation";
Opt.SubDirs.RawDataDir              = "RawDataDir";
Opt.SubDirs.DataDir                 = "DataFiles";
Opt.SubDirs.ResultDir               = "ResultFiles";
Opt.SubDirs.PanelFigureDir          = "PanelFigures";
Opt.SubDirs.RNAseqDir               = "TCGA_RNAseq";
Opt.SubDirs.RNAseqDataDir           = "RNAseqDataFiles";
Opt.SubDirs.RNAseqResultDir         = "RNAseqResultFiles";
Opt.SubDirs.CCLEDir                 = "CCLE";
Opt.SubDirs.SupplMaterialDir        = "SupplementaryMaterial";  

Opt.FigureFolders = ["Figure_01" "Figure_02" "Figure_03" "Figure_04"];

Opt.SupplMat = ["SupplementaryFigure_01" "SupplementaryFigure_02" "SupplementaryFigure_03" "SupplementaryTable_01" "SupplementaryTable_02" "SupplementaryTable_03"];

%% Molecular files
% Optional path to jhu-usc.edu_PANCAN_HumanMethylation450.betaValue_whitelisted.tsv file with
% methylation data, will be copied to "RawDataDir"
Opt.TCGA_M450_path = '/Users/berglund.anders/Documents/DATA/jhu-usc.edu_PANCAN_HumanMethylation450.betaValue_whitelisted.tsv';   
% Link to processed and normalized CCLE data file
Opt.CCLE_M450_GSE68379_path = '/Users/berglund.anders/Documents/DATA/CCLE/MOLECULAR/M450_n1028/ENmix/beta_V4_n1028_MV.txt';   

%% Figure Settings

Opt.png_res = 600;
