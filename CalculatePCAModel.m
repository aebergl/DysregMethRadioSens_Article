function CalculatePCAModel

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



load(fullfile(DataDirectory,"HNSC_M450_RT_HPVneg.mat"),'HNSC_M450_RT_HPVneg')
load(fullfile(DataDirectory,"HNSC_M450_NoRT_HPVneg.mat"),'HNSC_M450_NoRT_HPVneg')
load(fullfile(DataDirectory,"HNSC_M450_RT_HPVpos.mat"),'HNSC_M450_RT_HPVpos')

load(fullfile(DataDirectory,"PRAD_M450_RT.mat"),'PRAD_M450_RT')
load(fullfile(DataDirectory,"PRAD_M450_NoRT.mat"),'PRAD_M450_NoRT')

load(fullfile(DataDirectory,"SKCM_M450_RT.mat"),'SKCM_M450_RT')
load(fullfile(DataDirectory,"SKCM_M450_NoRT.mat"),'SKCM_M450_NoRT')

load(fullfile(DataDirectory,"BRCA_M450_RT.mat"),'BRCA_M450_RT')
load(fullfile(DataDirectory,"BRCA_M450_NoRT.mat"),'BRCA_M450_NoRT')

load(fullfile(DataDirectory,"SARC_M450_RT.mat"),'SARC_M450_RT')
load(fullfile(DataDirectory,"SARC_M450_NoRT.mat"),'SARC_M450_NoRT')

load(fullfile(DataDirectory,"STAD_M450_RT.mat"),'STAD_M450_RT')
load(fullfile(DataDirectory,"STAD_M450_NoRT.mat"),'STAD_M450_NoRT')

load(fullfile(DataDirectory,"CESC_M450_RT.mat"),'CESC_M450_RT')
load(fullfile(DataDirectory,"CESC_M450_NoRT.mat"),'CESC_M450_NoRT')

load(fullfile(DataDirectory,"GBM_M450_RT.mat"),'GBM_M450_RT')
load(fullfile(DataDirectory,"GBM_M450_NoRT.mat"),'GBM_M450_NoRT')

load(fullfile(DataDirectory,"LGG_M450_RT.mat"),'LGG_M450_RT')
load(fullfile(DataDirectory,"LGG_M450_NoRT.mat"),'LGG_M450_NoRT')

% Generate Names
Legend_Names = {
'HPV(-)HNSCC NoRT', 'HPV(-)HNSCC RT','HPV(+)HNSCC RT',...    
'PRAD NoRT','PRAD RT',...
'SKCM NoRT','SKCM RT',...
'BRCA NoRT','BRCA RT',...
'SARC NoRT','SARC RT',...
'STAD NoRT','STAD RT',...
'CESC NoRT','CESC RT',...
'GBM NoRT','GBM RT',...
'LGG NoRT','LGG RT'};


NumSamples=[HNSC_M450_NoRT_HPVneg.nRow;HNSC_M450_RT_HPVneg.nRow;HNSC_M450_RT_HPVpos.nRow;...
    PRAD_M450_NoRT.nRow; PRAD_M450_RT.nRow;...
    SKCM_M450_NoRT.nRow; SKCM_M450_RT.nRow;...
    BRCA_M450_NoRT.nRow; BRCA_M450_RT.nRow;...
    SARC_M450_NoRT.nRow; SARC_M450_RT.nRow;...
    STAD_M450_NoRT.nRow; STAD_M450_RT.nRow;...
    CESC_M450_NoRT.nRow; CESC_M450_RT.nRow;...
    GBM_M450_NoRT.nRow;  GBM_M450_RT.nRow;...
    LGG_M450_NoRT.nRow;  LGG_M450_RT.nRow];

GroupId = [repmat(Legend_Names(1),NumSamples(1),1);...
repmat(Legend_Names(2),NumSamples(2),1);...
repmat(Legend_Names(3),NumSamples(3),1)
repmat(Legend_Names(4),NumSamples(4),1);...
repmat(Legend_Names(5),NumSamples(5),1);...
repmat(Legend_Names(6),NumSamples(6),1);...
repmat(Legend_Names(7),NumSamples(7),1);...
repmat(Legend_Names(8),NumSamples(8),1);...
repmat(Legend_Names(9),NumSamples(9),1);...
repmat(Legend_Names(10),NumSamples(10),1);...
repmat(Legend_Names(11),NumSamples(11),1);...
repmat(Legend_Names(12),NumSamples(12),1);...
repmat(Legend_Names(13),NumSamples(13),1);...
repmat(Legend_Names(14),NumSamples(14),1);...
repmat(Legend_Names(15),NumSamples(15),1);...
repmat(Legend_Names(16),NumSamples(16),1);...
repmat(Legend_Names(17),NumSamples(17),1);...
repmat(Legend_Names(18),NumSamples(18),1);...
repmat(Legend_Names(19),NumSamples(19),1)];

save(fullfile(ResultDirectory,"GroupId.mat"),"GroupId")

X=[ HNSC_M450_NoRT_HPVneg.X;  HNSC_M450_RT_HPVneg.X; HNSC_M450_RT_HPVpos.X;...
    PRAD_M450_NoRT.X;         PRAD_M450_RT.X;...
    SKCM_M450_NoRT.X;         SKCM_M450_RT.X;...
    BRCA_M450_NoRT.X;         BRCA_M450_RT.X;...
    SARC_M450_NoRT.X;         SARC_M450_RT.X;...
    STAD_M450_NoRT.X;         STAD_M450_RT.X;...
    CESC_M450_NoRT.X;         CESC_M450_RT.X;...
    GBM_M450_NoRT.X;          GBM_M450_RT.X;...
    LGG_M450_NoRT.X;          LGG_M450_RT.X];

tic,[PCA_ALL_50] = NIPALS_PCA(X,'NumComp',50,'ScaleX',false,'MVAverage',true);toc
% Checking for missing values....
% 85 columns removed with more than 20 % missing values
% Removing mean....
% Initiate PCA calculations....
% Number of rows: 3271	 Number of columns: 357584
% #Comp  Iter   EigVal   %Var %VarCum ConvValue Orthogonality
%     1    57   618.80  18.92   18.92   8.4e-26           NaN
%     2   112   304.77   9.32   28.24     2e-25         2e-10
%     3   187   218.60   6.68   34.92   6.7e-26       7.2e-10
%     4   114   180.12   5.51   40.42   8.6e-26         5e-10
%     5   117   124.77   3.81   44.24     1e-25       8.4e-10
%     6   199    93.28   2.85   47.09   2.7e-26       4.6e-10
%     7   190    77.46   2.37   49.46   2.7e-26       8.9e-10
%     8   150    64.07   1.96   51.42     5e-26       7.2e-10
%     9   159    49.94   1.53   52.94     2e-26       3.2e-10
%    10   105    39.98   1.22   54.17   3.1e-26       2.7e-10
%    11   319    27.33   0.84   55.00   4.1e-26       3.8e-10
%    12   440    24.62   0.75   55.75   2.9e-26       1.6e-10
%    13   608    22.80   0.70   56.45   1.2e-25       4.2e-10
%    14   523    21.63   0.66   57.11   8.4e-26         4e-10
%    15   289    20.31   0.62   57.73   4.7e-26         4e-10
%    16   392    18.13   0.55   58.29   1.5e-26       2.7e-10
%    17   597    16.66   0.51   58.80   9.3e-26       1.8e-10
%    18   601    15.78   0.48   59.28   5.7e-26       5.3e-10
%    19   307    14.93   0.46   59.74   9.9e-27       3.9e-10
%    20   369    13.29   0.41   60.14     2e-26       1.2e-10
%    21   448    12.13   0.37   60.51   1.8e-26       3.4e-10
%    22   364    11.25   0.34   60.86   5.1e-26       2.2e-10
%    23  1504    10.30   0.31   61.17   5.3e-25       3.7e-10
%    24   479    10.10   0.31   61.48   1.7e-26         3e-10
%    25   345     9.42   0.29   61.77   9.2e-27         5e-10
%    26  1169     8.51   0.26   62.03   1.4e-25       1.7e-10
%    27   496     8.30   0.25   62.28   4.5e-26       1.6e-10
%    28  1104     7.78   0.24   62.52     1e-25       2.2e-10
%    29   844     7.57   0.23   62.75   2.7e-25       1.3e-10
%    30  1520     7.31   0.22   62.98   2.5e-25       1.2e-10
%    31   695     7.15   0.22   63.19   3.8e-26       3.3e-10
%    32   455     6.84   0.21   63.40   2.4e-26       1.6e-10
%    33  3108     6.36   0.19   63.60   8.7e-24       1.1e-10
%    34   862     6.30   0.19   63.79   9.6e-26       6.3e-10
%    35   645     6.09   0.19   63.98   2.2e-26       1.4e-10
%    36  3121     5.79   0.18   64.15   4.9e-24       1.7e-10
%    37   691     5.74   0.18   64.33   4.1e-26       4.8e-10
%    38  1326     5.51   0.17   64.50   5.6e-25       1.6e-10
%    39  2219     5.38   0.16   64.66   2.3e-24       2.3e-10
%    40  1251     5.31   0.16   64.82   1.7e-25       3.1e-10
%    41   877     5.18   0.16   64.98   3.9e-26       2.9e-10
%    42  1184     5.00   0.15   65.14   1.1e-25       7.6e-11
%    43   465     4.88   0.15   65.28   3.9e-26       1.2e-10
%    44  2334     4.53   0.14   65.42   1.8e-24       1.8e-10
%    45  1144     4.48   0.14   65.56   9.9e-26       2.3e-10
%    46  1144     4.36   0.13   65.69   3.6e-25       1.3e-10
%    47  2789     4.24   0.13   65.82   4.8e-24       1.1e-10
%    48   447     4.20   0.13   65.95   1.4e-26         4e-10
%    49  1659     3.90   0.12   66.07   2.6e-25       1.4e-10
%    50  1518     3.83   0.12   66.19   1.3e-25       1.1e-10
% Elapsed time is 10514.625554 seconds.

save(fullfile(ResultDirectory,"PCA_ALL_50.mat"),"PCA_ALL_50")