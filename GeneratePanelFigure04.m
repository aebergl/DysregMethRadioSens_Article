function GeneratePanelFigure04

% Script for generating all graphs in Panel Gigure 1.

%% Load defaults
MRA_Options;

%% Figure directory
FigureDir = fullfile(Opt.BaseDir,Opt.SubDirs.PanelFigureDir,Opt.FigureFolders(3));
ResultDirectory = (fullfile(Opt.BaseDir,Opt.SubDirs.ResultDir));
DataDirectory = (fullfile(Opt.BaseDir,Opt.SubDirs.DataDir));
RNAseqDataDirectory = (fullfile(Opt.BaseDir,Opt.SubDirs.RNAseqDataDir));
RNAseqResultDirectory = (fullfile(Opt.BaseDir,Opt.SubDirs.RNAseqResultDir));


%% Pie chart figure
load(fullfile(ResultDirectory,"RESULTS_HNSC_M450_RT_HPVneg_DSS.mat"),'RESULTS_HNSC_M450_RT_HPVneg_DSS')
load(fullfile(ResultDirectory,"SelectedCpG_probes.mat"),'SelectedCpG_probes')
RESULTS_HNSC_M450_RT_HPVneg_DSS = EditSamplesDATA(RESULTS_HNSC_M450_RT_HPVneg_DSS,SelectedCpG_probes,'Keep');


% Pie chart
indx_RFN = strcmp('Regulatory_Feature_Group',RESULTS_HNSC_M450_RT_HPVneg_DSS.RowAnnotationFields);
Groups = RESULTS_HNSC_M450_RT_HPVneg_DSS.RowAnnotation(:,indx_RFN);
Groups(Groups=="") = "Missing";
RFN_Groups = ["Promoter_Associated" "Promoter_Associated_Cell_type_specific" "Gene_Associated" "Gene_Associated_Cell_type_specific" "NonGene_Associated" "NonGene_Associated_Cell_type_specific" "Unclassified_Cell_type_specific" "Unclassified" "Missing"];
Groups = categorical(Groups,RFN_Groups);
GroupCount = countcats(Groups);
RFN_Groups(GroupCount == 0) = [];
GroupCount(GroupCount == 0) = [];
fh=figure('Name','Pie Chart','Color','w','Tag','Pie Chart','Units','inches');
fh.Colormap=flipud(fh.Colormap);
fh.Position(3:4) = [4.4 2];
explode_indx = zeros(length(GroupCount),1);
explode_indx(1) = 1;
ph = pie(GroupCount,explode_indx);
set(findobj(ph,'FontSize',10),'FontSize',7);
lh = legend(RFN_Groups);
lh.FontSize=7;
lh.Interpreter='none';
set( gca,'FontSize',7);
set(gcf, 'Color', 'w');
lh.Location='eastoutside';
fh.Renderer='painters';
ph(2).Position(1)=-1.1;
ph(4).Position=[0.3 -0.9];
ph(8).Position = [0.6 -0.77];
ph(10).Position(1) = 0.9;
ph(12).Position(2) = 0.6;

%exportgraphics(gcf,fullfile(FigureDir,'Figure_4a_CPG_Probe_Type_Pie_Chart.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_4a_CPG_Probe_Type_Pie_Chart.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_4a_CPG_Probe_Type_Pie_Chart.png'),'Resolution',Opt.png_res)
close(fh)


%% GSEA plots
% Use the Gene symbols found in GeneSymbols_SelectedCpGprobes.txt file located in the Result folder 
% Paste them in the Input Gene Identifiers field at https://www.gsea-msigdb.org/gsea/msigdb/human/annotate.jsp
% Select show top 20 genesets and select the follwoing gene sets
% 1. CP:REACTOME: Reactome gene sets and hit Compute overlaps. 
%    Select Save to: Text (as Tab separated values; *.tsv) and rename the file from Overlap.tsv to GSEA_REACTOME_Selected_CpGprobes.tsv
% 
% 2. TFT:GTRD: GTRD transcription factor targets and hit Compute overlaps. 
%    Select Save to: Text (as Tab separated values; *.tsv) and rename the file to GSEA_TFT_GTRD_Selected_CpGprobes.tsv
%
% These are also saved in the GitHub library

% Figure 4b
try
    GSEA_REACTOME= Read_GSEA_File(fullfile(ResultDirectory,'GSEA_REACTOME_Selected_CpGprobes.tsv'));
catch
    GSEA_REACTOME= Read_GSEA_File('GSEA_REACTOME_Selected_CpGprobes.tsv');
end
fh  = GSEA_Dot_Plot(GSEA_REACTOME,[],'FontSize',6,'FigSize', [5.1, 2.5], 'LegendSizeVal',[10 20 30],'MinMaxSize',[20 100],'YTickText','Description');
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_4b_GSEA_REACTOME.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_4b_GSEA_REACTOME.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_4b_GSEA_REACTOME.png'),'Resolution',Opt.png_res)
close(fh)

% Figure 4c
try
GSEA_TFT_GRD = Read_GSEA_File(fullfile(ResultDirectory,'GSEA_TFT_GTRD_Selected_CpGprobes.tsv'));
catch
GSEA_TFT_GRD = Read_GSEA_File('GSEA_TFT_GTRD_Selected_CpGprobes.tsv');
end
fh  = GSEA_Dot_Plot(GSEA_TFT_GRD,[],'FontSize',6,'FigSize', [3.95, 2.5], 'LegendSizeVal',[10 20 30],'MinMaxSize',[20 100],'YTickText','Name');
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_4c_GSEA_GTRD.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_4c_GSEA_GTRD.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_4c_GSEA_GTRD.png'),'Resolution',Opt.png_res)
close(fh)



%% KM Plots Figure 4d - 3h
load(fullfile(DataDirectory,"HNSC_M450_RT_HPVneg.mat"),'HNSC_M450_RT_HPVneg')
load(fullfile(DataDirectory,"PRAD_M450_RT.mat"),'PRAD_M450_RT')
load(fullfile(DataDirectory,"SKCM_M450_RT.mat"),'SKCM_M450_RT')
load(fullfile(DataDirectory,"BRCA_M450_RT.mat"),'BRCA_M450_RT')
load(fullfile(DataDirectory,"SARC_M450_RT.mat"),'SARC_M450_RT')

load(fullfile(ResultDirectory,"SelectedCpG_probes.mat"),'SelectedCpG_probes')


HNSC_M450_RT_HPVneg = EditVariablesDATA(HNSC_M450_RT_HPVneg,SelectedCpG_probes,'Keep');
SKCM_M450_RT        = EditVariablesDATA(SKCM_M450_RT,SelectedCpG_probes,'Keep');
PRAD_M450_RT        = EditVariablesDATA(PRAD_M450_RT,SelectedCpG_probes,'Keep');
BRCA_M450_RT        = EditVariablesDATA(BRCA_M450_RT,SelectedCpG_probes,'Keep');
SARC_M450_RT        = EditVariablesDATA(SARC_M450_RT,SelectedCpG_probes,'Keep');

% load(fullfile(DataDirectory,"HNSC_M450_Normal.mat"),'HNSC_M450_Normal')
% load(fullfile(DataDirectory,"PRAD_M450_Normal.mat"),'PRAD_M450_Normal')
% load(fullfile(DataDirectory,"SKCM_M450_Normal.mat"),'SKCM_M450_Normal')
% load(fullfile(DataDirectory,"BRCA_M450_Normal.mat"),'BRCA_M450_Normal')
% load(fullfile(DataDirectory,"SARC_M450_Normal.mat"),'SARC_M450_Normal')
% 
% HNSC_M450_Normal = EditVariablesDATA(HNSC_M450_Normal,SelectedCpG_probes,'Keep');
% PRAD_M450_Normal        = EditVariablesDATA(PRAD_M450_Normal,SelectedCpG_probes,'Keep');
% SKCM_M450_Normal        = EditVariablesDATA(SKCM_M450_Normal,SelectedCpG_probes,'Keep');
% BRCA_M450_Normal        = EditVariablesDATA(BRCA_M450_Normal,SelectedCpG_probes,'Keep');
% SARC_M450_Normal        = EditVariablesDATA(SARC_M450_Normal,SelectedCpG_probes,'Keep');
% 
% HyperHypo_HNSC_M450_RT = CalculateDiffMethylation(HNSC_M450_RT_HPVneg,HNSC_M450_Normal);
% HyperHypo_PRAD_M450_RT = CalculateDiffMethylation(PRAD_M450_RT,PRAD_M450_Normal);
% HyperHypo_SKCM_M450_RT = CalculateDiffMethylation(SKCM_M450_RT,SKCM_M450_Normal);
% HyperHypo_BRCA_M450_RT = CalculateDiffMethylation(BRCA_M450_RT,BRCA_M450_Normal);
% HyperHypo_SARC_M450_RT = CalculateDiffMethylation(SARC_M450_RT,SARC_M450_Normal);
% 
% 
% 
% X=[ HNSC_M450_NoRT_HPVneg.X;  HNSC_M450_RT_HPVneg.X; ...
%     PRAD_M450_NoRT.X;         PRAD_M450_RT.X;...
%     SKCM_M450_NoRT.X;         SKCM_M450_RT.X;...
%     BRCA_M450_NoRT.X;         BRCA_M450_RT.X;...
%     SARC_M450_NoRT.X;         SARC_M450_RT.X];
% 
% tic,[PCA_ALL] = NIPALS_PCA(X,'NumComp',6,'ScaleX',false,'MVAverage',false);toc



Width=1.68;
Hight = 1.6;

% Figure 4d
indx_DSS = strcmp('DSS',HNSC_M450_RT_HPVneg.SURVIVAL.SurvivalTypes);
val = mean(HNSC_M450_RT_HPVneg.X,2,'omitnan');
%val = NIPALS_PCA(HNSC_M450_RT_HPVneg.X,'NumComp',1,'ScaleX',false,'Tonly',true);
%val = NIPALS_PCA_Predict(HNSC_M450_RT_HPVneg.X,PCA_ALL);
%val = HyperHypo_HNSC_M450_RT.X(:,2);

[~,fH,~] = MatSurv(HNSC_M450_RT_HPVneg.SURVIVAL.SurvTime(:,indx_DSS),HNSC_M450_RT_HPVneg.SURVIVAL.SurvEvent(:,indx_DSS),val,'cutpoint','median',...
'Timeunit','Months','Print',1,'RT_KMplot',1,'BaseFontSize',5,'XStep',24,'LineWidth',0.75,'XLim',[0 120],'legend',false,'ylabel','Survival Probability',...
'XTickFontSize',0,'YTickFontSize',0,'LegendFontSize',0,'PvalFontSize',0,'CensorLineWidth',0.5,'LineColor',GetPalette('Lancet',[2 1]),'xlabel','DSS by RRMS (Months)');
fH.Children(1).Children(1).String = {'Low'};
fH.Children(1).Children(2).String = {'High'};
fH.Children(1).Children(1).FontWeight='normal';
fH.Children(1).Children(2).FontWeight='normal';
fH.Children(1).LineWidth=0.5;
fH.Units = 'inches';
fH.Position(3)=Width;fH.Position(4)=Hight;
fH.Children(1).Position=[0.18 0.18 0.78 0.8];
fH.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_4d_Methylation_Score_HNSC_M450_RT_HPVneg_DSS_KM_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_4d_Methylation_Score_HNSC_M450_RT_HPVneg_DSS_KM_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_4d_Methylation_Score_HNSC_M450_RT_HPVneg_DSS_KM_Plot.png'),'Resolution',Opt.png_res)
close(fH)


% Figure 4e
indx_PFI = strcmp('PFI',PRAD_M450_RT.SURVIVAL.SurvivalTypes);
val = mean(PRAD_M450_RT.X,2,'omitnan');
%val = NIPALS_PCA(PRAD_M450_RT.X,'NumComp',1,'ScaleX',false,'Tonly',true);
%val = HyperHypo_PRAD_M450_RT.X(:,2);
[~,fH,~] = MatSurv(PRAD_M450_RT.SURVIVAL.SurvTime(:,indx_PFI),PRAD_M450_RT.SURVIVAL.SurvEvent(:,indx_PFI),val,'cutpoint','median',...
'Timeunit','Months','Print',1,'RT_KMplot',1,'BaseFontSize',5,'XStep',12,'LineWidth',0.75,'XLim',[0 60],'legend',false,'ylabel','Progression Free Probability',...
'XTickFontSize',0,'YTickFontSize',0,'LegendFontSize',0,'PvalFontSize',0,'CensorLineWidth',0.5,'LineColor',GetPalette('Lancet',[2 1]),'xlabel','PFI by RRMS (Months)');
fH.Children(1).Children(1).String = {'Low'};
fH.Children(1).Children(2).String = {'High'};
fH.Children(1).Children(1).FontWeight='normal';
fH.Children(1).Children(2).FontWeight='normal';
fH.Children(1).LineWidth=0.5;
fH.Units = 'inches';
fH.Position(3)=Width;fH.Position(4)=Hight;
fH.Children(1).Position=[0.18 0.18 0.78 0.8];
fH.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_4e_Methylation_Score_PRAD_M450_RT_PFI_KM_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_4e_Methylation_Score_PRAD_M450_RT_PFI_KM_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_4e_Methylation_Score_PRAD_M450_RT_PFI_KM_Plot.png'),'Resolution',Opt.png_res)
close(fH)

% Figure 4f
indx_DSS = strcmp('DSS',SKCM_M450_RT.SURVIVAL.SurvivalTypes);
val = mean(SKCM_M450_RT.X,2,'omitnan');
%val = NIPALS_PCA(SKCM_M450_RT.X,'NumComp',1,'ScaleX',false,'Tonly',true);

%val = HyperHypo_SKCM_M450_RT.X(:,2);
[~,fH,~] = MatSurv(SKCM_M450_RT.SURVIVAL.SurvTime(:,indx_DSS),SKCM_M450_RT.SURVIVAL.SurvEvent(:,indx_DSS),val,'cutpoint','median',...
'Timeunit','Months','Print',1,'RT_KMplot',1,'BaseFontSize',5,'XStep',24,'LineWidth',0.75,'XLim',[0 120],'legend',false,'ylabel','Survival Probability',...
'XTickFontSize',0,'YTickFontSize',0,'LegendFontSize',0,'PvalFontSize',0,'CensorLineWidth',0.5,'LineColor',GetPalette('Lancet',[2 1]),'xlabel','DSS by RRMS (Months)');
fH.Children(1).Children(1).String = {'Low'};
fH.Children(1).Children(2).String = {'High'};
fH.Children(1).Children(1).FontWeight='normal';
fH.Children(1).Children(2).FontWeight='normal';
fH.Children(1).LineWidth=0.5;
fH.Units = 'inches';
fH.Position(3)=Width;fH.Position(4)=Hight;
fH.Children(1).Position=[0.18 0.18 0.78 0.8];
fH.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_4f_Methylation_Score_SKCM_M450_RT_DSS_KM_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_4f_Methylation_Score_SKCM_M450_RT_DSS_KM_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_4f_Methylation_Score_SKCM_M450_RT_DSS_KM_Plot.png'),'Resolution',Opt.png_res)
close(fH)


% Figure 4g
indx_DSS = strcmp('DSS',BRCA_M450_RT.SURVIVAL.SurvivalTypes);
val=mean(BRCA_M450_RT.X,2,'omitnan');
%val = NIPALS_PCA(BRCA_M450_RT.X,'NumComp',1,'ScaleX',false,'Tonly',true);

%val = HyperHypo_BRCA_M450_RT.X(:,2);
[~,fH,~] = MatSurv(BRCA_M450_RT.SURVIVAL.SurvTime(:,indx_DSS),BRCA_M450_RT.SURVIVAL.SurvEvent(:,indx_DSS),val,'cutpoint','median','TimeMax',120,...
'Timeunit','Months','Print',1,'RT_KMplot',1,'BaseFontSize',5,'XStep',24,'LineWidth',0.75,'XLim',[0 120],'legend',false,'ylabel','Survival Probability',...
'XTickFontSize',0,'YTickFontSize',0,'LegendFontSize',0,'PvalFontSize',0,'CensorLineWidth',0.5,'LineColor',GetPalette('Lancet',[2 1]),'xlabel','DSS by RRMS (Months)');
fH.Children(1).Children(1).String = {'Low'};
fH.Children(1).Children(2).String = {'High'};
fH.Children(1).Children(1).FontWeight='normal';
fH.Children(1).Children(2).FontWeight='normal';
fH.Children(1).LineWidth=0.5;
fH.Units = 'inches';
fH.Position(3)=Width;fH.Position(4)=Hight;
fH.Children(1).Position=[0.18 0.18 0.78 0.8];
fH.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_4g_Methylation_Score_BRCA_M450_RT_DSS_KM_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_4g_Methylation_Score_BRCA_M450_RT_DSS_KM_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_4g_Methylation_Score_BRCA_M450_RT_DSS_KM_Plot.png'),'Resolution',Opt.png_res)
close(fH)


% Figure 4h
indx_DSS = strcmp('DSS',SARC_M450_RT.SURVIVAL.SurvivalTypes);
val = mean(SARC_M450_RT.X,2,'omitnan');
%val = NIPALS_PCA(SARC_M450_RT.X,'NumComp',1,'ScaleX',false,'Tonly',true);

%val = HyperHypo_SARC_M450_RT.X(:,2);
[~,fH,~] = MatSurv(SARC_M450_RT.SURVIVAL.SurvTime(:,indx_DSS),SARC_M450_RT.SURVIVAL.SurvEvent(:,indx_DSS),val,'cutpoint','median',...
'Timeunit','Months','Print',1,'RT_KMplot',1,'BaseFontSize',5,'XStep',12,'LineWidth',0.75,'XLim',[0 60],'legend',false,'ylabel','Survival Probability',...
'XTickFontSize',0,'YTickFontSize',0,'LegendFontSize',0,'PvalFontSize',0,'CensorLineWidth',0.5,'LineColor',GetPalette('Lancet',[2 1]),'xlabel','DSS by RRMS (Months)');
fH.Children(1).Children(1).String = {'Low'};
fH.Children(1).Children(2).String = {'High'};
fH.Children(1).Children(1).FontWeight='normal';
fH.Children(1).Children(2).FontWeight='normal';
fH.Children(1).LineWidth=0.5;
fH.Units = 'inches';
fH.Position(3)=Width;fH.Position(4)=Hight;
fH.Children(1).Position=[0.18 0.18 0.78 0.8];
fH.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_4h_Methylation_Score_SARC_M450_RT_DSS_KM_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_4h_Methylation_Score_SARC_M450_RT_DSS_KM_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_4h_Methylation_Score_SARC_M450_RT_DSS_KM_Plot.png'),'Resolution',Opt.png_res)
close(fH)

load(fullfile(DataDirectory,"HNSC_M450_NoRT_HPVneg.mat"),'HNSC_M450_NoRT_HPVneg')
load(fullfile(DataDirectory,"PRAD_M450_NoRT.mat"),'PRAD_M450_NoRT')
load(fullfile(DataDirectory,"SKCM_M450_NoRT.mat"),'SKCM_M450_NoRT')
load(fullfile(DataDirectory,"BRCA_M450_NoRT.mat"),'BRCA_M450_NoRT')
load(fullfile(DataDirectory,"SARC_M450_NoRT.mat"),'SARC_M450_NoRT')


HNSC_M450_NoRT_HPVneg = EditVariablesDATA(HNSC_M450_NoRT_HPVneg,SelectedCpG_probes,'Keep');
PRAD_M450_NoRT        = EditVariablesDATA(PRAD_M450_NoRT,SelectedCpG_probes,'Keep');
SKCM_M450_NoRT        = EditVariablesDATA(SKCM_M450_NoRT,SelectedCpG_probes,'Keep');
BRCA_M450_NoRT        = EditVariablesDATA(BRCA_M450_NoRT,SelectedCpG_probes,'Keep');
SARC_M450_NoRT        = EditVariablesDATA(SARC_M450_NoRT,SelectedCpG_probes,'Keep');


% HyperHypo_HNSC_M450_NoRT = CalculateDiffMethylation(HNSC_M450_NoRT_HPVneg,HNSC_M450_Normal);
% HyperHypo_PRAD_M450_NoRT = CalculateDiffMethylation(PRAD_M450_NoRT,PRAD_M450_Normal);
% HyperHypo_SKCM_M450_NoRT = CalculateDiffMethylation(SKCM_M450_NoRT,SKCM_M450_Normal);
% HyperHypo_BRCA_M450_NoRT = CalculateDiffMethylation(BRCA_M450_NoRT,BRCA_M450_Normal);
% HyperHypo_SARC_M450_NoRT = CalculateDiffMethylation(SARC_M450_NoRT,SARC_M450_Normal);
% 


Width=1.68;
Hight = 1.6;

% Figure 4i
indx_DSS = strcmp('DSS',HNSC_M450_NoRT_HPVneg.SURVIVAL.SurvivalTypes);
val = mean(HNSC_M450_NoRT_HPVneg.X,2,'omitnan');
%val = NIPALS_PCA(HNSC_M450_NoRT_HPVneg.X,'NumComp',1,'ScaleX',false,'Tonly',true);
%val = HyperHypo_HNSC_M450_NoRT.X(:,2);

[~,fH,~] = MatSurv(HNSC_M450_NoRT_HPVneg.SURVIVAL.SurvTime(:,indx_DSS),HNSC_M450_NoRT_HPVneg.SURVIVAL.SurvEvent(:,indx_DSS),val,'cutpoint','median',...
'Timeunit','Months','Print',1,'RT_KMplot',1,'BaseFontSize',5,'XStep',24,'LineWidth',0.75,'XLim',[0 120],'legend',false,'ylabel','Survival Probability',...
'XTickFontSize',0,'YTickFontSize',0,'LegendFontSize',0,'PvalFontSize',0,'CensorLineWidth',0.5,'LineColor',GetPalette('Lancet',[2 1]),'xlabel','DSS by RRMS (Months)');
fH.Children(1).Children(1).String = {'Low'};
fH.Children(1).Children(2).String = {'High'};
fH.Children(1).Children(1).FontWeight='normal';
fH.Children(1).Children(2).FontWeight='normal';
fH.Children(1).LineWidth=0.5;
fH.Units = 'inches';
fH.Position(3)=Width;fH.Position(4)=Hight;
fH.Children(1).Position=[0.18 0.18 0.78 0.8];
fH.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_4i_Methylation_Score_HNSC_M450_NoRT_HPVneg_DSS_KM_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_4i_Methylation_Score_HNSC_M450_NoRT_HPVneg_DSS_KM_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_4i_Methylation_Score_HNSC_M450_NoRT_HPVneg_DSS_KM_Plot.png'),'Resolution',Opt.png_res)
close(fH)


% Figure 4j
indx_PFI = strcmp('PFI',PRAD_M450_NoRT.SURVIVAL.SurvivalTypes);
val = mean(PRAD_M450_NoRT.X,2,'omitnan');
%val = NIPALS_PCA(PRAD_M450_NoRT.X,'NumComp',1,'ScaleX',false,'Tonly',true);
%val = HyperHypo_PRAD_M450_NoRT.X(:,2);

[~,fH,~] = MatSurv(PRAD_M450_NoRT.SURVIVAL.SurvTime(:,indx_PFI),PRAD_M450_NoRT.SURVIVAL.SurvEvent(:,indx_PFI),val,'cutpoint','median',...
'Timeunit','Months','Print',1,'RT_KMplot',1,'BaseFontSize',5,'XStep',12,'LineWidth',0.75,'XLim',[0 60],'legend',false,'ylabel','Progression Free Probability',...
'XTickFontSize',0,'YTickFontSize',0,'LegendFontSize',0,'PvalFontSize',0,'CensorLineWidth',0.5,'LineColor',GetPalette('Lancet',[2 1]),'xlabel','PFI by RRMS (Months)');
fH.Children(1).Children(1).String = {'Low'};
fH.Children(1).Children(2).String = {'High'};
fH.Children(1).Children(1).FontWeight='normal';
fH.Children(1).Children(2).FontWeight='normal';
fH.Children(1).LineWidth=0.5;
fH.Units = 'inches';
fH.Position(3)=Width;fH.Position(4)=Hight;
fH.Children(1).Position=[0.18 0.18 0.78 0.8];
fH.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_4j_Methylation_Score_PRAD_M450_NoRT_PFI_KM_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_4j_Methylation_Score_PRAD_M450_NoRT_PFI_KM_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_4j_Methylation_Score_PRAD_M450_NoRT_PFI_KM_Plot.png'),'Resolution',Opt.png_res)
close(fH)


% Figure 4k
indx_DSS = strcmp('DSS',SKCM_M450_NoRT.SURVIVAL.SurvivalTypes);
val = mean(SKCM_M450_NoRT.X,2,'omitnan');
%val = NIPALS_PCA(SKCM_M450_NoRT.X,'NumComp',1,'ScaleX',false,'Tonly',true);
%val = HyperHypo_SKCM_M450_NoRT.X(:,2);

[~,fH,~] = MatSurv(SKCM_M450_NoRT.SURVIVAL.SurvTime(:,indx_DSS),SKCM_M450_NoRT.SURVIVAL.SurvEvent(:,indx_DSS),val,'cutpoint','median',...
'Timeunit','Months','Print',1,'RT_KMplot',1,'BaseFontSize',5,'XStep',24,'LineWidth',0.75,'XLim',[0 120],'legend',false,'ylabel','Survival Probability',...
'XTickFontSize',0,'YTickFontSize',0,'LegendFontSize',0,'PvalFontSize',0,'CensorLineWidth',0.5,'LineColor',GetPalette('Lancet',[2 1]),'xlabel','DSS by RRMS (Months)');
fH.Children(1).Children(1).String = {'Low'};
fH.Children(1).Children(2).String = {'High'};
fH.Children(1).Children(1).FontWeight='normal';
fH.Children(1).Children(2).FontWeight='normal';
fH.Children(1).LineWidth=0.5;
fH.Units = 'inches';
fH.Position(3)=Width;fH.Position(4)=Hight;
fH.Children(1).Position=[0.18 0.18 0.78 0.8];
fH.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_4k_Methylation_Score_SKCM_M450_NoRT_DSS_KM_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_4k_Methylation_Score_SKCM_M450_NoRT_DSS_KM_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_4k_Methylation_Score_SKCM_M450_NoRT_DSS_KM_Plot.png'),'Resolution',Opt.png_res)
close(fH)


% Figure 4l
indx_DSS = strcmp('DSS',BRCA_M450_NoRT.SURVIVAL.SurvivalTypes);
val=mean(BRCA_M450_NoRT.X,2,'omitnan');
%val = NIPALS_PCA(BRCA_M450_NoRT.X,'NumComp',1,'ScaleX',false,'Tonly',true);
%val = HyperHypo_BRCA_M450_NoRT.X(:,2);

[~,fH,~] = MatSurv(BRCA_M450_NoRT.SURVIVAL.SurvTime(:,indx_DSS),BRCA_M450_NoRT.SURVIVAL.SurvEvent(:,indx_DSS),val,'cutpoint','median','TimeMax',120,...
'Timeunit','Months','Print',1,'RT_KMplot',1,'BaseFontSize',5,'XStep',24,'LineWidth',0.75,'XLim',[0 120],'legend',false,'ylabel','Survival Probability',...
'XTickFontSize',0,'YTickFontSize',0,'LegendFontSize',0,'PvalFontSize',0,'CensorLineWidth',0.5,'LineColor',GetPalette('Lancet',[2 1]),'xlabel','DSS by RRMS (Months)');
fH.Children(1).Children(1).String = {'Low'};
fH.Children(1).Children(2).String = {'High'};
fH.Children(1).Children(1).FontWeight='normal';
fH.Children(1).Children(2).FontWeight='normal';
fH.Children(1).LineWidth=0.5;
fH.Units = 'inches';
fH.Position(3)=Width;fH.Position(4)=Hight;
fH.Children(1).Position=[0.18 0.18 0.78 0.8];
fH.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_4l_Methylation_Score_BRCA_M450_NoRT_DSS_KM_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_4l_Methylation_Score_BRCA_M450_NoRT_DSS_KM_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_4l_Methylation_Score_BRCA_M450_NoRT_DSS_KM_Plot.png'),'Resolution',Opt.png_res)
close(fH)


% Figure 4m
indx_DSS = strcmp('DSS',SARC_M450_NoRT.SURVIVAL.SurvivalTypes);
val = mean(SARC_M450_NoRT.X,2,'omitnan');
%val = NIPALS_PCA(SARC_M450_NoRT.X,'NumComp',1,'ScaleX',false,'Tonly',true);
%val = HyperHypo_SARC_M450_NoRT.X(:,2);

[~,fH,~] = MatSurv(SARC_M450_NoRT.SURVIVAL.SurvTime(:,indx_DSS),SARC_M450_NoRT.SURVIVAL.SurvEvent(:,indx_DSS),val,'cutpoint','median',...
'Timeunit','Months','Print',1,'RT_KMplot',1,'BaseFontSize',5,'XStep',12,'LineWidth',0.75,'XLim',[0 60],'legend',false,'ylabel','Survival Probability',...
'XTickFontSize',0,'YTickFontSize',0,'LegendFontSize',0,'PvalFontSize',0,'CensorLineWidth',0.5,'LineColor',GetPalette('Lancet',[2 1]),'xlabel','DSS by RRMS (Months)');
fH.Children(1).Children(1).String = {'Low'};
fH.Children(1).Children(2).String = {'High'};
fH.Children(1).Children(1).FontWeight='normal';
fH.Children(1).Children(2).FontWeight='normal';
fH.Children(1).LineWidth=0.5;
fH.Units = 'inches';
fH.Position(3)=Width;fH.Position(4)=Hight;
fH.Children(1).Position=[0.18 0.18 0.78 0.8];
fH.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_4m_Methylation_Score_SARC_M450_NoRT_DSS_KM_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_4m_Methylation_Score_SARC_M450_NoRT_DSS_KM_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_4m_Methylation_Score_SARC_M450_NoRT_DSS_KM_Plot.png'),'Resolution',Opt.png_res)
close(fH)

clear CpG_probes_216 Width Hight fH p_LR stats HNSC_M450_NoRT_HPVneg PRAD_M450_NoRT SKCM_M450_NoRT BRCA_M450_NoRT SARC_M450_NoRT 


%% RNAseq results 
% Start GSEA tool
% Select Load Data and drop these 5 files in the load window:
% RESULTS_HNSC_RNAseq_RT_HPVneg_RRMS_HighVsLow.rnk
% RESULTS_PRAD_RNAseq_RT_RRMS_HighVsLow.rnk
% RESULTS_SKCM_RNAseq_RT_RRMS_HighVsLow.rnk
% RESULTS_BRCA_RNAseq_RT_RRMS_HighVsLow.rnk
% RESULTS_SARC_RNAseq_RT_RRMS_HighVsLow.rnk
% located in the RNAseq Results folder
%
% Select "Run GSEAPreranked"
% Select h.all.v2024.1.Hs.symbols.gmt from "Gene sets database"
% Select each of the loaded file
% Choose 'No_Collapse"
% Select a Analysis name for each of the five GSEA calulations
% Locate the "results.edb" file in the edb folder in atch of the results forlder for each of the
% five GSEA results folder
% rename it to:
% RESULTS_HNSC_RNAseq_RT_HPVneg_RRMS_HighVsLow.edb
% RESULTS_PRAD_RNAseq_RT_RRMS_HighVsLow.edb
% RESULTS_SKCM_RNAseq_RT_RRMS_HighVsLow.edb
% RESULTS_BRCA_RNAseq_RT_RRMS_HighVsLow.edb
% RESULTS_SARC_RNAseq_RT_RRMS_HighVsLow.edb
% and place them in the RNAseq Results folder
% These are also saved in the GitHub library


% Figure 4n
GSEA_HNSC_RT = Read_GSEA_edb_File(fullfile(RNAseqResultDirectory,"RESULTS_HNSC_RNAseq_RT_HPVneg_RRMS_HighVsLow.edb"),'HPV(-)HNSCC RT','Hallmark');
GSEA_PRAD_RT = Read_GSEA_edb_File(fullfile(RNAseqResultDirectory,"RESULTS_PRAD_RNAseq_RT_RRMS_HighVsLow.edb"),'PRAD RT','Hallmark');
GSEA_SKCM_RT = Read_GSEA_edb_File(fullfile(RNAseqResultDirectory,"RESULTS_SKCM_RNAseq_RT_RRMS_HighVsLow.edb"),'SKCM RT','Hallmark');
GSEA_BRCA_RT = Read_GSEA_edb_File(fullfile(RNAseqResultDirectory,"RESULTS_BRCA_RNAseq_RT_RRMS_HighVsLow.edb"),'BRCA RT','Hallmark');
GSEA_SARC_RT = Read_GSEA_edb_File(fullfile(RNAseqResultDirectory,"RESULTS_SARC_RNAseq_RT_RRMS_HighVsLow.edb"),'SARC RT','Hallmark');



DATA_GSEA = Merge_DATA_Vertical(GSEA_HNSC_RT,GSEA_PRAD_RT);
DATA_GSEA = Merge_DATA_Vertical(DATA_GSEA,GSEA_SKCM_RT);
DATA_GSEA = Merge_DATA_Vertical(DATA_GSEA,GSEA_BRCA_RT);
DATA_GSEA = Merge_DATA_Vertical(DATA_GSEA,GSEA_SARC_RT);


DataSets = unique(DATA_GSEA.RowAnnotation(:,2),'stable');

fh = GSEA_DotPlot_MultiDataSets(DATA_GSEA,"Result Name",DataSets,"Short Gene Set Name" ,[],'FDR q-val','NES','FontSize',5,'FigSize',[1.8 3.7 ],'LegendSizeVal',[1 0.05 0.01 0.001 0.0001],[1 5 10 15 20] );
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_4n_GSEA_RNAseq_DotPlot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_4n_GSEA_RNAseq_DotPlot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_4n_GSEA_RNAseq_DotPlot.png'),'Resolution',Opt.png_res)
close(fh)

% Figure 

load(fullfile(RNAseqDataDirectory,"HNSC_RNAseq_RT_HPVneg.mat"),'HNSC_RNAseq_RT_HPVneg')
load(fullfile(RNAseqDataDirectory,"PRAD_RNAseq_RT.mat"),'PRAD_RNAseq_RT')
load(fullfile(RNAseqDataDirectory,"SKCM_RNAseq_RT.mat"),'SKCM_RNAseq_RT')
load(fullfile(RNAseqDataDirectory,"BRCA_RNAseq_RT.mat"),'BRCA_RNAseq_RT')
load(fullfile(RNAseqDataDirectory,"SARC_RNAseq_RT.mat"),'SARC_RNAseq_RT')


genes={'CD3E','CD4','CD8A','CD247','GZMB','PRF1','MS4A1','CD19','CD40'};

for i=1:length(genes)
    GeneSymbol = genes(i);
    fh = figure('Color','w','Units','inches');
    fh.Position(3:4) = [2.25 1.0];
    th = tiledlayout(fh,1,5,'TileSpacing','compact','padding','compact');
    options={'VariableIdentifier','Symbol','CalcStats',[],'MarkerSize',4,'MarkerLineWidth',0.2,'BoxLineWidth',0.25,'FontSize',4.5,'FigSize',[2.2 1],'BoxWidth',0.8,'XJitterWidth',0.6,'StatType','MW','PlotStars',true,'Show_NS',true,'XTickAngle',-45};


    ah = nexttile(th); ah.NextPlot = 'add'; ah.Box='on'; ah.FontSize = 4; ah.LineWidth = 0.25; ah.XGrid = 'on'; ah.YGrid = 'on';
    PlotBoxPlotDATA(HNSC_RNAseq_RT_HPVneg,GeneSymbol,'RRMS Group',{'Low','High'},options{:},'TargetAxes',ah,'TitleText','HPV(-)HNSCC RT');

    ah = nexttile(th); ah.NextPlot = 'add'; ah.Box='on'; ah.FontSize = 4; ah.LineWidth = 0.25; ah.XGrid = 'on'; ah.YGrid = 'on';
    PlotBoxPlotDATA(PRAD_RNAseq_RT,GeneSymbol,'RRMS Group',{'Low','High'},options{:},'TargetAxes',ah,'TitleText','PRAD RT');

    ah = nexttile(th); ah.NextPlot = 'add'; ah.Box='on'; ah.FontSize = 4; ah.LineWidth = 0.25; ah.XGrid = 'on'; ah.YGrid = 'on';
    PlotBoxPlotDATA(SKCM_RNAseq_RT,GeneSymbol,'RRMS Group',{'Low','High'},options{:},'TargetAxes',ah,'TitleText','SKCM RT');

    ah = nexttile(th); ah.NextPlot = 'add'; ah.Box='on'; ah.FontSize = 4; ah.LineWidth = 0.25; ah.XGrid = 'on'; ah.YGrid = 'on';
    PlotBoxPlotDATA(BRCA_RNAseq_RT,GeneSymbol,'RRMS Group',{'Low','High'},options{:},'TargetAxes',ah,'TitleText','BRCA RT');

    ah = nexttile(th); ah.NextPlot = 'add'; ah.Box='on'; ah.FontSize = 4; ah.LineWidth = 0.25; ah.XGrid = 'on'; ah.YGrid = 'on';
    PlotBoxPlotDATA(SARC_RNAseq_RT,GeneSymbol,'RRMS Group',{'Low','High'},options{:},'TargetAxes',ah,'TitleText','SARC RT');
    
    fh.Renderer='painters';
    FileName = sprintf('Figure_4o_%s_BoxPlot_TCGA_RNAseq',GeneSymbol{1});
    %exportgraphics(gcf,fullfile(FigureDir,strcat(FileName,'.pdf')));
    SavePDF_AEB(fullfile(FigureDir,strcat(FileName,'.pdf')));
    exportgraphics(gcf,fullfile(FigureDir,strcat(FileName,'.png')),'Resolution',Opt.png_res)
    close(fh)
end