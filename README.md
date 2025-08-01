# MethylationRadiationArticle
Matlab functions and scripts for downloading, processing, calculating and generating figures for our "A dysregulated methylome modulates the radiosensitivity of cancer" article. 

 
## Table of contents
* [Requirements](#Requirements)
* [Initiation](#Initiation)
	* [MRA_Options.m](#MRA_Optionsm)
	* [InitiateMRA.m](#InitiateMRAm)
* [Downloading and Processing Files](#Downloading-and-Processing-Files)
	* [DownloadProcessTCGAPanCanM450.m](#DownloadProcessTCGAPanCanM450m)
	* [ProcessTumorTypesM450.m](#ProcessTumorTypesM450m)
	* [DownloadProcessTCGAPanCanRNAseq.m](#DownloadProcessTCGAPanCanRNAseqm)
	* [ProcessTumorTypesRNAseq.m](#ProcessTumorTypesRNAseqm)
	* [ProcessCCLEM450.m](#ProcessCCLEM450m)
* [Calculations](#Calculations)
* [Generate Figures](#Generate-Figures)
* [Generate Supplementary Figures](#Generate-Supplementary-Figures)
* [Generate Supplementary Tables](#Generate-Supplementary-Tabels)
* [Additional Files](#Additional-Files)

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

### MRA_Options.m ###
Script defining the base directory and folder structure. Also allows for linking to already downloaded molecular data files.

**Please edit the 'Opt.BaseDir' to your folder of choice**

### InitiateMRA.m ##
Function for initiating the folder structure and checking that all functions are available for the “A dysregulated methylome modulates the radiosensitivity of cancer" article.

## Downloading and Processing Files ##

## Calculations ##

## Generate Figures ##

## Generate Supplementary Figures ##

## Generate Supplementary Tables ##

## Additional Files ##




