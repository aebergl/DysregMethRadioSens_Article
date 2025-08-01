# MethylationRadiationArticle
Matlab functions and scripts for downloading, processing, calculating and generating figures for our "A dysregulated methylome modulates the radiosensitivity of cancer" article. 

 
## Table of contents
* [Requirements](#Requirements)
* [Initiation](#Initiation)
	* [MRA\_Options.m](#MRA_Optionsm)
	* [InitiateMRA.m](#InitiateMRAm)
* [Downloading and Processing Files](#Downloading-and-Processing-Files)
	* [DownloadProcessTCGAPanCanM450.m](#DownloadProcessTCGAPanCanM450m)
	* [ProcessTumorTypesM450.m](#ProcessTumorTypesM450m)
	* [DownloadProcessTCGAPanCanRNAseq.m](#DownloadProcessTCGAPanCanRNAseqm)
	* [ProcessTumorTypesRNAseq.m](#ProcessTumorTypesRNAseqm)
	* [CalculateCCLEResults.m](#CalculateCCLEResultsm)
* [Calculations](#Calculations)
	* [CalculateM450Results.m](#CalculateM450Resultsm)
	* [CalculatePCAModel.m](#CalculatePCAModelm)
	* [CalculateRNAseqResults.m](#CalculateRNAseqResultsm)
	* [ProcessCCLEM450.m](#ProcessCCLEM450m)
* [Generate Figures](#Generate-Figures)
	* [GeneratePanelFigure01.m](#GeneratePanelFigure01m)
	* [GeneratePanelFigure02.m](#GeneratePanelFigure02m)
	* [GeneratePanelFigure03.m](#GeneratePanelFigure03m)
	* [GeneratePanelFigure04.m](#GeneratePanelFigure04m)
* [Generate Supplementary Figures](#Generate-Supplementary-Figures)
	* [GenerateSupplFigure01.m](#GenerateSupplFigure01m)
	* [GenerateSupplFigure02.m](#GenerateSupplFigure02m)
	* [GenerateSupplFigure03.m](#GenerateSupplFigure03m)
* [Generate Supplementary Tables](#Generate-Supplementary-Tabels)
	* [GenerateSupplTables.m](#GenerateSupplTablesm)
* [Additional Files](#Additional-Files)
	* [RadiationInfo.xlsx](#RadiationInfoxlsx)
	* [GSEA\_REACTOME\_Selected\_CpGprobes.tsv](#GSEA_REACTOME_Selected_CpGprobestsv)
	* [GSEA\_TFT\_GTRD\_Selected\_CpGprobes.tsv](#GSEA_TFT_GTRD_Selected_CpGprobestsv)
* [Folders](#Folders)
	* [SampleAnnotation](#SampleAnnotation)

## Requirements
MATLAB R2024b was used for generating the figures in the publication, but older versions should also work.
### Other toolboxes needed
* Bioinformatics toolbox

### Other packages needed
* BioinformaticsAEB, My library for bioinformatics-related functions, [GitHub](https://github.com/aebergl/BioinformaticsAEB)
* MatSurv, Survival analysis in MATLAB, [GitHub](https://github.com/aebergl/MatSurv)
* DensScat, A fast MATLAB function for creating density scatter plots for large datasets, [GitHub](https://github.com/aebergl/DensScat)
* AEB_COLOR, Color-related functions, including color palettes, [GitHub](https://github.com/aebergl/AEB_COLOR)

## Initiation ##

### MRA\_Options.m ###
- Script defining the base directory and folder structure. Also allows for linking to already downloaded molecular data files.

**Please edit the 'Opt.BaseDir' to your folder of choice**

### InitiateMRA.m ##
- Function for initiating the folder structure and checking that all functions are available for the “A dysregulated methylome modulates the radiosensitivity of cancer" article.

## Downloading and Processing Files ##
Functions for downloading methylation and RNAseq data used in the article. 

### DownloadProcessTCGAPanCanM450.m ###
- This is a function for downloading and processing Illumina M450K Pancancer data for the article "A dysregulated methylome modulates the radiosensitivity of cancer. "The function will also download additional annotation files used in the article. It is recommended that the large "jhu-usc.edu_PANCAN_HumanMethylation450.betaValue_whitelisted.tsv" file is downloaded separately, as using "websave" takes significant time. The location of the files can be given in the MRA_Options.m files or can be directly put in the "/RawDataDir" folder.

- Additional annotation files will also be downloaded and placed in the "/SampleAnnotation" folder. These files can also be found in the [SampleAnnotation folder.](/SampleAnnotation)

- The processed data is saved in the M450K.mat file in the DataDir directory.

### ProcessTumorTypesM450.m ###
- Function for generating different tumor type methylation datasets and adding tumor type-specific annotation. The files are saved in the DataDir directory.

### DownloadProcessTCGAPanCanRNAseq.m ###
- Function for downloading and processing the TCGA PanCancer RNAseq data.

### ProcessTumorTypesRNAseq.m ###
- Function for generating different tumor type RNAseq datasets and adding tumor type-specific annotation. 

### ProcessCCLEM450.m ###
- Function for reading and processing the CCLE M450 methylation data [(GSE68379)](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE68379). We used ENmix for processing the raw IDAT files. I will also merge in the radiation resistance data from "A genetic basis for the variation in the vulnerability of cancer to DNA damage, PMID: 27109210. Cell line names will be normalized using data from [Cellosaurus](https://www.cellosaurus.org/index.html) and then merged. 


## Calculations ##
- Functions for calculating results used in the article. These results are used in the individual GeneratePanelFigure files.

### CalculateM450Results.m ###
- Calculates the Cox-regression models for the methylation data

### CalculatePCAModel.m ###
 - Calculates the PCA model with 50 components for the t-SNE plot using 3271 samples and 357584 variables. Took ~175 minutes on my 2023 Mac Studio M2 Ultra.

### CalculateRNAseqResults.m ###
- Calculate results from the RNAseq data

### CalculateCCLEResults.m ###
- Calculate results from the CCLE data

## Generate Figures ##
Functions for generating the individual graphs used in the panel figures. Graphs are exported as PDFs and PNGs for both best quality and compatibility.
### GeneratePanelFigure01.m ###
- Function for generating all individual graphs for panel figure 1

### GeneratePanelFigure02.m ###
- Function for generating all individual graphs for panel figure 2

### GeneratePanelFigure03.m ###
- Function for generating all individual graphs for panel figure 3

### GeneratePanelFigure04.m ###
- Function for generating all individual graphs for panel figure 4

## Generate Supplementary Figures ##
Functions for generating the individual graphs used in the supplementary panel figures. Graphs are exported as PDFs and PNGs for both best quality and compatibility.
### GenerateSupplFigure01.m ###
- Function for generating all individual graphs for supplementary panel figure 1

### GenerateSupplFigure02.m ###
- Function for generating all individual graphs for supplementary panel figure 2

### GenerateSupplFigure03.m ###
- Function for generating all individual graphs for supplementary panel figure 3

## Generate Supplementary Tables ##

### GenerateSupplTables.m ###
 - Function generating individual tab-separated text files for the supplementary tables. 

## Additional Files ##
### [RadiationInfo.xlsx](RadiationInfo.xlsx) ###
An Excel file with manually curated radiation therapy information for TCGA samples.
### [GSEA\_REACTOME\_Selected\_CpGprobes.tsv](GSEA_REACTOME_Selected_CpGprobes.tsv) ###
### [GSEA\_TFT_GTRD\_Selected\_CpGprobes.tsv](GSEA_TFT_GTRD_Selected_CpGprobes.tsv) ###
These two files are the output from the GSEA analysis and are used in the [GeneratePanelFigure04.m](GeneratePanelFigure04.m) function. They were generated as follows:

* Use the Gene symbols found in GeneSymbols\_SelectedCpGprobes.txt file located in the Result folder 
* Paste them in the Input Gene Identifiers field at https://www.gsea-msigdb.org/gsea/msigdb/human/annotate.jsp
* Select show top 20 gene sets and select the following gene sets
 
1. CP:REACTOME: Reactome gene sets and hit Compute overlaps. 
	* Select Save to: Text (as Tab separated values; \*.tsv) and rename the file from Overlap.tsv to GSEA\_REACTOME\_Selected\_CpGprobes.tsv

2. TFT:GTRD: GTRD transcription factor targets and hit Compute overlaps. 
	* 	Select Save to: Text (as Tab separated values; *.tsv) and rename the file to GSEA\_TFT\_GTRD\_Selected\_CpGprobes.tsv

## Folders ##

### SampleAnnotation ###
- Folder with sample annotation files used. 

