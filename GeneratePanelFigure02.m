function GeneratePanelFigure02

% Script for generating all graphs in Panel Gigure 1.

%% Load defaults
MRA_Options;

%% Figure directory
FigureDir = fullfile(Opt.BaseDir,Opt.SubDirs.PanelFigureDir,Opt.FigureFolders(2));
ResultDirectory = (fullfile(Opt.BaseDir,Opt.SubDirs.ResultDir));


%% HNSC HPV-
% Figure 2a
load(fullfile(ResultDirectory,"RESULTS_HNSC_M450_RT_HPVneg_DSS.mat"),'RESULTS_HNSC_M450_RT_HPVneg_DSS');
fh = ChrPlotDiff(RESULTS_HNSC_M450_RT_HPVneg_DSS,'CpG_beg','CpG_chrm','chr1','HR coxreg DSS','HR coxreg DSS','p coxreg DSS','cytoband','mb','REGION',{[203000000 226100000] [-2 4],''});
fh.Children(4).YLim = [-4.5 4.5];
fh.Children(4).YTick = -4:1:4;
fh.Children(4).CLim = [0 6];
text(fh.Children(4),fh.Children(4).XLim(2)/2,fh.Children(4).YLim(2)-0.5,'HPV(-)HNSCC RT','HorizontalAlignment','center','VerticalAlignment','middle','FontSize',7)
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_2a_Chr_01_Cox_HNSC_RT_HPVneg.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_2a_Chr_01_Cox_HNSC_RT_HPVneg.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_2a_Chr_01_Cox_HNSC_RT_HPVneg.png'),'Resolution',Opt.png_res)
close(fh)

%Figure 2b
genes={'TMEM183A','RBBP5','ELK4','RASSF5','DYRK3','MAPKAPK2','CD55','TRAF5','SLC30A1','ATF3','SDE2'};
fh = ChrPlotDiff(RESULTS_HNSC_M450_RT_HPVneg_DSS,'CpG_beg','CpG_chrm','chr1','HR coxreg DSS','HR coxreg DSS','p coxreg DSS','PlotRange',[203000000 226100000],'FigSize',[4 1.6],'GENES','gene_HGNC',genes);
fh.Children(2).CLim = [0 6];

% Adjust position of the legend for highlighted genes
h_SDE2 = findobj(fh,'String','SDE2');
h_SDE2.Position = [224.5 2.543 0];

h_TMEM183A = findobj(fh,'String','TMEM183A');
h_TMEM183A.Position = [202.7 3.55 0];

h_RBBP5 = findobj(fh,'String','RBBP5');
h_RBBP5.Position = [205.6 3.35 0];

h_RASSF5 = findobj(fh,'String','RASSF5');
h_RASSF5.Position = [206.9 1.3 0];

h_CD55 = findobj(fh,'String','CD55');
h_CD55.Position = [207.7 1.92 0];

h_MAPKAPK2 = findobj(fh,'String','MAPKAPK2');
h_MAPKAPK2.Position = [206.7092 2.13 0];

h_TRAF5 = findobj(fh,'String','TRAF5');
h_TRAF5.Position = [209.7000 1.3100 0];

fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_2b_Chr_01_Cox_HNSC_RT_HPVneg_Zoom.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_2b_Chr_01_Cox_HNSC_RT_HPVneg_Zoom.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_2b_Chr_01_Cox_HNSC_RT_HPVneg_Zoom.png'),'Resolution',Opt.png_res)
close(fh)
clear genes h_* fh


%Figure 2c
load(fullfile(ResultDirectory,"RESULTS_HNSC_M450_NoRT_HPVneq_DSS.mat"),'RESULTS_HNSC_M450_NoRT_HPVneq_DSS')

fh = ChrPlotDiff(RESULTS_HNSC_M450_NoRT_HPVneq_DSS,'CpG_beg','CpG_chrm','chr1','HR coxreg DSS','HR coxreg DSS','p coxreg DSS','cytoband','mb');

fh.Children(4).YLim=[-4.5 4.5];
fh.Children(4).YTick = -4:1:4;
fh.Children(4).CLim = [0 6];
text(fh.Children(4),fh.Children(4).XLim(2)/2,fh.Children(4).YLim(2)-1,'HPV(-)HNSCC NoRT','HorizontalAlignment','center','VerticalAlignment','middle','FontSize',7)
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_2c_Chr_01_Cox_HNSC_NoRT_HPVneg.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_2c_Chr_01_Cox_HNSC_NoRT_HPVneg.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_2c_Chr_01_Cox_HNSC_NoRT_HPVneg.png'),'Resolution',Opt.png_res)
close(fh)

%Figure 2d
load(fullfile(ResultDirectory,"RESULTS_HyperHypo_HNSC_RT_HPVneg_DSS.mat"),'RESULTS_HyperHypo_HNSC_RT_HPVneg_DSS')
indx = strncmp('Hyper Chr',RESULTS_HyperHypo_HNSC_RT_HPVneg_DSS.RowId,9);
RowsToUse = RESULTS_HyperHypo_HNSC_RT_HPVneg_DSS.RowId(indx);
fh=Chr_Survival_Dot_Plot(RESULTS_HyperHypo_HNSC_RT_HPVneg_DSS,'HR logrank DSS',RowsToUse,'p logrank DSS',[1 0.05 0.01],[5 20 50],GetPalette('Tab10',1),3,1.7);
ylabel('Chromosome')
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_2d_hr_Survival_HNSC_M450_RT_HPVneg_logrank.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_2d_hr_Survival_HNSC_M450_RT_HPVneg_logrank.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_2d_hr_Survival_HNSC_M450_RT_HPVneg_logrank.png'),'Resolution',Opt.png_res)
close(fh)
clear RowsToUse RESULTS_HNSC_M450_NoRT_HPV_Neg_167_DSS SURVIVAL_HyperHypo_HNSC_M450_RT_HPV_Neg_187 RESULTS_HNSC_M450_RT_HPV_Neg_187_DSS fh


%% PRAD
% Figure 2e
load(fullfile(ResultDirectory,"RESULTS_PRAD_M450_RT_PFI.mat"),'RESULTS_PRAD_M450_RT_PFI')
fh = ChrPlotDiff(RESULTS_PRAD_M450_RT_PFI,'CpG_beg','CpG_chrm','chr19','HR coxreg PFI','HR coxreg PFI','p coxreg PFI','cytoband','mb','FigSize',[6 1.95],'REGION',{[43500000 47230900] [-4 8],''});
fh.Children(4).YLim=[-8.5 8.5];
fh.Children(4).YTick=-8:2:8;
fh.Children(4).CLim = [0 5];
text(fh.Children(4),fh.Children(4).XLim(2)/2,fh.Children(4).YLim(2)-1,'PRAD RT','HorizontalAlignment','center','VerticalAlignment','middle','FontSize',7)
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_2e_Chr_19_Cox_PRAD_RT.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_2e_Chr_19_Cox_PRAD_RT.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_2e_Chr_19_Cox_PRAD_RT.png'),'Resolution',Opt.png_res)
close(fh)



% Figure 2f
genes={'ZNF575','CLPTM1','ERCC1','IRF2BP1','BBC3'};
fh = ChrPlotDiff(RESULTS_PRAD_M450_RT_PFI,'CpG_beg','CpG_chrm','chr19','HR coxreg PFI','HR coxreg PFI','p coxreg PFI','PlotRange',[43500000 47230900],'FigSize',[4 1.6],'GENES','gene_HGNC',genes);

fh.Children(2).CLim = [0 5];
% Adjust position of the legend for highlighted genes
fh_BBC3 = findobj(fh,'String','BBC3');
fh_BBC3.Position = [46.83 6.65 0];
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_2f_Chr_19_Cox_PRAD_RT_Zoom.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_2f_Chr_19_Cox_PRAD_RT_Zoom.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_2f_Chr_19_Cox_PRAD_RT_Zoom.png'),'Resolution',Opt.png_res)
close(fh)

% Figure 2g
load(fullfile(ResultDirectory,"RESULTS_PRAD_M450_NoRT_PFI.mat"),'RESULTS_PRAD_M450_NoRT_PFI')
fh = ChrPlotDiff(RESULTS_PRAD_M450_NoRT_PFI,'CpG_beg','CpG_chrm','chr19','HR coxreg PFI','HR coxreg PFI','p coxreg PFI','FigSize',[6 1.95],'cytoband','mb');
fh.Children(4).YLim=[-8.5 8.5];
fh.Children(4).YTick=-8:2:8;
fh.Children(4).CLim = [0 5];
text(fh.Children(4),fh.Children(4).XLim(2)/2,fh.Children(4).YLim(2)-1,'PRAD NoRT','HorizontalAlignment','center','VerticalAlignment','middle','FontSize',7)
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_2g_Chr_19_Cox_PRAD_NoRT.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_2g_Chr_19_Cox_PRAD_NoRT.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_2g_Chr_19_Cox_PRAD_NoRT.png'),'Resolution',Opt.png_res)
close(fh)


% Figure 2h
load(fullfile(ResultDirectory,"RESULTS_HyperHypo_PRAD_RT_PFI.mat"),'RESULTS_HyperHypo_PRAD_RT_PFI')
indx = strncmp('Hyper Chr',RESULTS_HyperHypo_PRAD_RT_PFI.RowId,9);

RowsToUse = RESULTS_HyperHypo_PRAD_RT_PFI.RowId(indx);

fh=Chr_Survival_Dot_Plot(RESULTS_HyperHypo_PRAD_RT_PFI,'HR logrank PFI',RowsToUse,'p logrank PFI',[1 0.05 0.01],[5 20 50],GetPalette('Tab10',2),3,1.7);
ylabel('Chromosome')
%exportgraphics(gcf,fullfile(FigureDir,'Figure_2h_Chr_Survival_PRAD_M450_RT_59_logrank.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_2h_Chr_Survival_PRAD_M450_RT_59_logrank.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_2h_Chr_Survival_PRAD_M450_RT_59_logrank.png'),'Resolution',Opt.png_res)
close(fh)
clear RowsToUse RESULTS_PRAD_M450_RT_PFI RESULTS_PRAD_M450_NoRT_411_PFI SURVIVAL_HyperHypo_RT_59 fh fh_BBC3



%SKCM

% Figure 2i
load(fullfile(ResultDirectory,"RESULTS_SKCM_M450_RT_DSS.mat"),'RESULTS_SKCM_M450_RT_DSS')
fh = ChrPlotDiff(RESULTS_SKCM_M450_RT_DSS,'CpG_beg','CpG_chrm','chr2','HR coxreg DSS','HR coxreg DSS','p coxreg DSS','cytoband','mb','FigSize',[6 1.95],'REGION',{[235500000 242088874] [-6 8],''});
fh.Children(4).YLim=[-8.4 8.4];
fh.Children(4).YTick=-8:2:8;
fh.Children(4).CLim = [0 5];
text(fh.Children(4),fh.Children(4).XLim(2)/2,fh.Children(4).YLim(2)-1,'SKCM RT','HorizontalAlignment','center','VerticalAlignment','middle','FontSize',7)
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_2i_Chr_02_Cox_SKCM_RT.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_2i_Chr_02_Cox_SKCM_RT.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_2i_Chr_02_Cox_SKCM_RT.png'),'Resolution',Opt.png_res)
close(fh)


% Figure 2j
genes={'AGAP1','RBM44','HDAC4','ING5'};
fh = ChrPlotDiff(RESULTS_SKCM_M450_RT_DSS,'CpG_beg','CpG_chrm','chr2','HR coxreg DSS','HR coxreg DSS','p coxreg DSS','PlotRange',[235500000 242088874],'FigSize',[4 1.6],'GENES','gene_HGNC',genes);
fh.Children(2).YLim=[-6 8];
fh.Children(2).CLim = [0 5];
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_2j_Chr_02_Cox_SKCM_RT_Zoom.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_2j_Chr_02_Cox_SKCM_RT_Zoom.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_2j_Chr_02_Cox_SKCM_RT_Zoom.png'),'Resolution',Opt.png_res)
close(fh)


% Figure 2k
load(fullfile(ResultDirectory,"RESULTS_SKCM_M450_NoRT_DSS.mat"),'RESULTS_SKCM_M450_NoRT_DSS')
fh = ChrPlotDiff(RESULTS_SKCM_M450_NoRT_DSS,'CpG_beg','CpG_chrm','chr2','HR coxreg DSS','HR coxreg DSS','p coxreg DSS','cytoband','mb','FigSize',[6 1.95]);

fh.Children(4).YLim=[-8.4 8.4];
fh.Children(4).YTick=-8:2:8;
fh.Children(4).CLim = [0 5];
text(fh.Children(4),fh.Children(4).XLim(2)/2,fh.Children(4).YLim(2)-1,'SKCM NoRT','HorizontalAlignment','center','VerticalAlignment','middle','FontSize',7)
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_2k_Chr_02_Cox_SKCM_NoRT.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_2k_Chr_02_Cox_SKCM_NoRT.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_2k_Chr_02_Cox_SKCM_NoRT.png'),'Resolution',Opt.png_res)
close(fh)

clear fh RESULTS_SKCM_M450_RT_67_DSS RESULTS_SKCM_M450_NoRT_351_DSS genes FigureDir

