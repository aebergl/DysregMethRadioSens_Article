function GenerateSupplFigure02

% Script for generating all graphs in Panel Figure 1.

%% Load defaults
MRA_Options;


%% Supplementary Figure 2

FigureDir = fullfile(Opt.BaseDir,Opt.SubDirs.SupplMaterialDir,Opt.SupplMat(2));
ResultDirectory = (fullfile(Opt.BaseDir,Opt.SubDirs.ResultDir));


%%

load(fullfile(ResultDirectory,"RESULTS_SARC_M450_RT_DSS.mat"),'RESULTS_SARC_M450_RT_DSS')
load(fullfile(ResultDirectory,"RESULTS_SARC_M450_NoRT_DSS.mat"),'RESULTS_SARC_M450_NoRT_DSS')

load(fullfile(ResultDirectory,"RESULTS_STAD_M450_RT_DSS.mat"),'RESULTS_STAD_M450_RT_DSS')
load(fullfile(ResultDirectory,"RESULTS_STAD_M450_NoRT_DSS.mat"),'RESULTS_STAD_M450_NoRT_DSS')

load(fullfile(ResultDirectory,"RESULTS_CESC_M450_RT_DSS.mat"),'RESULTS_CESC_M450_RT_DSS')
load(fullfile(ResultDirectory,"RESULTS_CESC_M450_NoRT_DSS.mat"),'RESULTS_CESC_M450_NoRT_DSS')

load(fullfile(ResultDirectory,"RESULTS_GBM_M450_RT_DSS.mat"),'RESULTS_GBM_M450_RT_DSS')
load(fullfile(ResultDirectory,"RESULTS_GBM_M450_NoRT_DSS.mat"),'RESULTS_GBM_M450_NoRT_DSS')

load(fullfile(ResultDirectory,"RESULTS_LGG_M450_RT_DSS.mat"),'RESULTS_LGG_M450_RT_DSS')
load(fullfile(ResultDirectory,"RESULTS_LGG_M450_NoRT_DSS.mat"),'RESULTS_LGG_M450_NoRT_DSS')


PlotSize = [1.8 1.9];
%SARC
fh = VolcanoPlotResults(RESULTS_SARC_M450_RT_DSS,'HR coxreg DSS',0,'p coxreg DSS',2,'TopPrctile',99,'FigureSize',PlotSize,'FontSize',7,'EqualXLim','XlimCrop');
fh.Children.Position=[0.02    0.15    0.96    0.78];
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_2a_SARC_M450_RT_DSS_Volcano_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'SupplFigure_2a_SARC_M450_RT_DSS_Volcano_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_2a_SARC_M450_RT_DSS_Volcano_Plot.png'),'Resolution',Opt.png_res)
close(fh)

fh = VolcanoPlotResults(RESULTS_SARC_M450_NoRT_DSS,'HR coxreg DSS',0,'p coxreg DSS',2,'TopPrctile',99,'FigureSize',PlotSize,'FontSize',7,'EqualXLim','XlimCrop');
fh.Children.Position=[0.02    0.15    0.96    0.78];
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_2b_SARC_M450_NoRT_DSS_Volcano_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'SupplFigure_2b_SARC_M450_NoRT_DSS_Volcano_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_2b_SARC_M450_NoRT_DSS_Volcano_Plot.png'),'Resolution',Opt.png_res)
close(fh)


% STAD
fh = VolcanoPlotResults(RESULTS_STAD_M450_RT_DSS,'HR coxreg DSS',0,'p coxreg DSS',2,'TopPrctile',99,'FigureSize',PlotSize,'FontSize',7,'EqualXLim','XlimCrop');
fh.Children.Position=[0.02    0.15    0.96    0.78];
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_2c_STAD_M450_RT_DSS_Volcano_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'SupplFigure_2c_STAD_M450_RT_DSS_Volcano_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_2c_STAD_M450_RT_DSS_Volcano_Plot.png'),'Resolution',Opt.png_res)
close(fh)

fh = VolcanoPlotResults(RESULTS_STAD_M450_NoRT_DSS,'HR coxreg DSS',0,'p coxreg DSS',2,'TopPrctile',99,'FigureSize',PlotSize,'FontSize',7,'EqualXLim','XlimCrop');
fh.Children.Position=[0.02    0.15    0.96    0.78];
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_2d_STAD_M450_NoRT_DSS_Volcano_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'SupplFigure_2d_STAD_M450_NoRT_DSS_Volcano_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_2d_STAD_M450_NoRT_DSS_Volcano_Plot.png'),'Resolution',Opt.png_res)
close(fh)


% CESC
fh = VolcanoPlotResults(RESULTS_CESC_M450_RT_DSS,'HR coxreg DSS',0,'p coxreg DSS',2,'TopPrctile',99,'FigureSize',PlotSize,'FontSize',7,'EqualXLim','XlimCrop');
fh.Children.Position=[0.02    0.15    0.96    0.78];
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_2e_CESC_M450_RT_DSS_Volcano_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'SupplFigure_2e_CESC_M450_RT_DSS_Volcano_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_2e_CESC_M450_RT_DSS_Volcano_Plot.png'),'Resolution',Opt.png_res)
close(fh)


fh = VolcanoPlotResults(RESULTS_CESC_M450_NoRT_DSS,'HR coxreg DSS',0,'p coxreg DSS',2,'TopPrctile',99,'FigureSize',PlotSize,'FontSize',7,'EqualXLim','XlimCrop');
fh.Children.Position=[0.02    0.15    0.96    0.78];
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_2f_CESC_M450_NoRT_DSS_Volcano_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'SupplFigure_2f_CESC_M450_NoRT_DSS_Volcano_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_2f_CESC_M450_NoRT_DSS_Volcano_Plot.png'),'Resolution',Opt.png_res)
close(fh)


% GBM
fh = VolcanoPlotResults(RESULTS_GBM_M450_RT_DSS,'HR coxreg DSS',0,'p coxreg DSS',2,'TopPrctile',99,'FigureSize',PlotSize,'FontSize',7,'EqualXLim','XlimCrop');
fh.Children.Position=[0.02    0.15    0.96    0.78];
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_2g_GBM_M450_RT_DSS_Volcano_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'SupplFigure_2g_GBM_M450_RT_DSS_Volcano_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_2g_GBM_M450_RT_DSS_Volcano_Plot.png'),'Resolution',Opt.png_res)
close(fh)


fh = VolcanoPlotResults(RESULTS_GBM_M450_NoRT_DSS,'HR coxreg DSS',0,'p coxreg DSS',2,'TopPrctile',99,'FigureSize',PlotSize,'FontSize',7,'EqualXLim','XlimCrop');
fh.Children.Position=[0.02    0.15    0.96    0.78];
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_2h_GBM_M450_NoRT_DSS_Volcano_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'SupplFigure_2h_GBM_M450_NoRT_DSS_Volcano_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_2h_GBM_M450_NoRT_DSS_Volcano_Plot.png'),'Resolution',Opt.png_res)
close(fh)



% LGG
fh = VolcanoPlotResults(RESULTS_LGG_M450_RT_DSS,'HR coxreg DSS',0,'p coxreg DSS',2,'TopPrctile',99,'FigureSize',PlotSize,'FontSize',7,'EqualXLim','XlimCrop');
fh.Children.Position=[0.02    0.15    0.96    0.78];
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_2i_LGG_M450_RT_DSS_Volcano_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'SupplFigure_2i_LGG_M450_RT_DSS_Volcano_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_2i_LGG_M450_RT_DSS_Volcano_Plot.png'),'Resolution',Opt.png_res)
close(fh)


fh = VolcanoPlotResults(RESULTS_LGG_M450_NoRT_DSS,'HR coxreg DSS',0,'p coxreg DSS',2,'TopPrctile',99,'FigureSize',PlotSize,'FontSize',7,'EqualXLim','XlimCrop');
fh.Children.Position=[0.02    0.15    0.96    0.78];
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_2j_LGG_M450_NoRT_DSS_Volcano_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'SupplFigure_2j_LGG_M450_NoRT_DSS_Volcano_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_2j_LGG_M450_NoRT_DSS_Volcano_Plot.png'),'Resolution',Opt.png_res)
close(fh)

