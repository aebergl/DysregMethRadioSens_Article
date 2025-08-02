function GenerateSupplFigure03
% Function for generating all individual graphs for supplementary panel figure 3

%% Load defaults
MRA_Options;


%% Supplementary Figure 2

FigureDir = fullfile(Opt.BaseDir,Opt.SubDirs.SupplMaterialDir,Opt.SupplMat(3));
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
%exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_3a_SARC_M450_RT_DSS_Volcano_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'SupplFigure_3a_SARC_M450_RT_DSS_Volcano_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_3a_SARC_M450_RT_DSS_Volcano_Plot.png'),'Resolution',Opt.png_res)
close(fh)

fh = VolcanoPlotResults(RESULTS_SARC_M450_NoRT_DSS,'HR coxreg DSS',0,'p coxreg DSS',2,'TopPrctile',99,'FigureSize',PlotSize,'FontSize',7,'EqualXLim','XlimCrop');
fh.Children.Position=[0.02    0.15    0.96    0.78];
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_3b_SARC_M450_NoRT_DSS_Volcano_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'SupplFigure_3b_SARC_M450_NoRT_DSS_Volcano_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_3b_SARC_M450_NoRT_DSS_Volcano_Plot.png'),'Resolution',Opt.png_res)
close(fh)


% STAD
fh = VolcanoPlotResults(RESULTS_STAD_M450_RT_DSS,'HR coxreg DSS',0,'p coxreg DSS',2,'TopPrctile',99,'FigureSize',PlotSize,'FontSize',7,'EqualXLim','XlimCrop');
fh.Children.Position=[0.02    0.15    0.96    0.78];
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_3c_STAD_M450_RT_DSS_Volcano_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'SupplFigure_3c_STAD_M450_RT_DSS_Volcano_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_3c_STAD_M450_RT_DSS_Volcano_Plot.png'),'Resolution',Opt.png_res)
close(fh)

fh = VolcanoPlotResults(RESULTS_STAD_M450_NoRT_DSS,'HR coxreg DSS',0,'p coxreg DSS',2,'TopPrctile',99,'FigureSize',PlotSize,'FontSize',7,'EqualXLim','XlimCrop');
fh.Children.Position=[0.02    0.15    0.96    0.78];
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_3d_STAD_M450_NoRT_DSS_Volcano_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'SupplFigure_3d_STAD_M450_NoRT_DSS_Volcano_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_3d_STAD_M450_NoRT_DSS_Volcano_Plot.png'),'Resolution',Opt.png_res)
close(fh)


% CESC
fh = VolcanoPlotResults(RESULTS_CESC_M450_RT_DSS,'HR coxreg DSS',0,'p coxreg DSS',2,'TopPrctile',99,'FigureSize',PlotSize,'FontSize',7,'EqualXLim','XlimCrop');
fh.Children.Position=[0.02    0.15    0.96    0.78];
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_3e_CESC_M450_RT_DSS_Volcano_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'SupplFigure_3e_CESC_M450_RT_DSS_Volcano_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_3e_CESC_M450_RT_DSS_Volcano_Plot.png'),'Resolution',Opt.png_res)
close(fh)


fh = VolcanoPlotResults(RESULTS_CESC_M450_NoRT_DSS,'HR coxreg DSS',0,'p coxreg DSS',2,'TopPrctile',99,'FigureSize',PlotSize,'FontSize',7,'EqualXLim','XlimCrop');
fh.Children.Position=[0.02    0.15    0.96    0.78];
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_3f_CESC_M450_NoRT_DSS_Volcano_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'SupplFigure_3f_CESC_M450_NoRT_DSS_Volcano_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_3f_CESC_M450_NoRT_DSS_Volcano_Plot.png'),'Resolution',Opt.png_res)
close(fh)


% GBM
fh = VolcanoPlotResults(RESULTS_GBM_M450_RT_DSS,'HR coxreg DSS',0,'p coxreg DSS',2,'TopPrctile',99,'FigureSize',PlotSize,'FontSize',7,'EqualXLim','XlimCrop');
fh.Children.Position=[0.02    0.15    0.96    0.78];
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_3g_GBM_M450_RT_DSS_Volcano_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'SupplFigure_3g_GBM_M450_RT_DSS_Volcano_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_3g_GBM_M450_RT_DSS_Volcano_Plot.png'),'Resolution',Opt.png_res)
close(fh)


fh = VolcanoPlotResults(RESULTS_GBM_M450_NoRT_DSS,'HR coxreg DSS',0,'p coxreg DSS',2,'TopPrctile',99,'FigureSize',PlotSize,'FontSize',7,'EqualXLim','XlimCrop');
fh.Children.Position=[0.02    0.15    0.96    0.78];
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_3h_GBM_M450_NoRT_DSS_Volcano_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'SupplFigure_3h_GBM_M450_NoRT_DSS_Volcano_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_3h_GBM_M450_NoRT_DSS_Volcano_Plot.png'),'Resolution',Opt.png_res)
close(fh)



% LGG
fh = VolcanoPlotResults(RESULTS_LGG_M450_RT_DSS,'HR coxreg DSS',0,'p coxreg DSS',2,'TopPrctile',99,'FigureSize',PlotSize,'FontSize',7,'EqualXLim','XlimCrop');
fh.Children.Position=[0.02    0.15    0.96    0.78];
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_3i_LGG_M450_RT_DSS_Volcano_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'SupplFigure_3i_LGG_M450_RT_DSS_Volcano_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_3i_LGG_M450_RT_DSS_Volcano_Plot.png'),'Resolution',Opt.png_res)
close(fh)


fh = VolcanoPlotResults(RESULTS_LGG_M450_NoRT_DSS,'HR coxreg DSS',0,'p coxreg DSS',2,'TopPrctile',99,'FigureSize',PlotSize,'FontSize',7,'EqualXLim','XlimCrop');
fh.Children.Position=[0.02    0.15    0.96    0.78];
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_3j_LGG_M450_NoRT_DSS_Volcano_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'SupplFigure_3j_LGG_M450_NoRT_DSS_Volcano_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_3j_LGG_M450_NoRT_DSS_Volcano_Plot.png'),'Resolution',Opt.png_res)
close(fh)

