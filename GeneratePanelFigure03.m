function  GeneratePanelFigure03
% Script for generating all graphs in Panel Figure 1.

%% Load defaults
MRA_Options;

%% Figure directory
FigureDir = fullfile(Opt.BaseDir,Opt.SubDirs.PanelFigureDir,Opt.FigureFolders(4));
CCLEDir = (fullfile(Opt.BaseDir,Opt.SubDirs.CCLEDir));
ResultDirectory = (fullfile(Opt.BaseDir,Opt.SubDirs.ResultDir));


%%

load(fullfile(CCLEDir,"RESULTS_CCLE_Melanoma_AUC_High_vs_Low.mat"),"RESULTS_CCLE_Melanoma_AUC_High_vs_Low")
load(fullfile(CCLEDir,"RESULTS_CCLE_Melanoma_AUC_Corr.mat"),"RESULTS_CCLE_Melanoma_AUC_Corr")

load(fullfile(CCLEDir,"CCLE_Melanoma.mat"),"CCLE_Melanoma");
load(fullfile(CCLEDir,"AUC_MEL.mat"),"AUC_MEL");

load(fullfile(ResultDirectory,"SelectedCpG_probes.mat"),'SelectedCpG_probes')

% Figure 3a
PlotSize = [2.5 2.5];
fh = VolcanoPlotResults(RESULTS_CCLE_Melanoma_AUC_High_vs_Low,'Delta Average',0,'p t-test',2,'TopPrctile',99,'FigureSize',PlotSize,'FontSize',7,'EqualXLim','XlimCrop');
fh.Children.Position=[0.05    0.15    0.90    0.75];
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_3a_CCLE_Melanoma_AUC_High_vs_Low_Volcano_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_3a_CCLE_Melanoma_AUC_High_vs_Low_Volcano_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_3a_CCLE_Melanoma_AUC_High_vs_Low_Volcano_Plot.png'),'Resolution',Opt.png_res)
close(fh)


% Figure 3b
[r_MEL, p_MEL] = corr(B2M(CCLE_Melanoma.X),AUC_MEL,'Type','Spearman','Rows','pairwise');
Range_MEL = range(B2M(CCLE_Melanoma.X))';
fh=figure('Name','Volcano Plot','Color','w','Tag','Volcano Plot figure','GraphicsSmoothing','off','Units','inches','Renderer','painters');
fh.Position(3:4) = [3 2.5];
ah = axes(fh,'NextPlot','add','tag','Volcano Plot','box','off','Linewidth',0.5,'YAxisLocation','origin','Layer','top','FontSize',7);
ah.XGrid = 'on';
ah.YGrid = 'on';
uistack(ah,'top');
indx_NS = ~(p_MEL < 0.05);
indx_S = (p_MEL < 0.05);
h_NS = line(ah,r_MEL(indx_NS),Range_MEL(indx_NS),'LineStyle','none','Marker','.','MarkerEdgeColor',[0.7 0.7 0.7],'MarkerSize',2);
ah.XLim = [-1 1];
ah.YLim = [0 ceil(max(Range_MEL))];
ah.YAxisLocation='left';
box on;
fh = DensScat( r_MEL(indx_S),Range_MEL(indx_S),'TargetAxes',ah);
xlabel('Spearman''s \rho');
ylabel('M-value range');
line([0 0],fh.Children(2).YLim,'LineWidth',1,'Color','k','LineStyle','--');
fh.Children(2).XTick=-1:0.5:1;
fh.Children(2).YTick=0:2:ceil(max(Range_MEL));
fh.Children(2).Position = [0.10   0.10    0.67    0.87];
%exportgraphics(gcf,fullfile(FigureDir,'Figure_3b_CCLE_Melanoma_AUC_Range_vs_Corr.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_3b_CCLE_Melanoma_AUC_Range_vs_Corr.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_3b_CCLE_Melanoma_AUC_Range_vs_Corr.png'),'Resolution',Opt.png_res)
close(fh)


%Figure 3c

CCLE_M450_Melanoma_Average_Methylation = CalculateDiffMethylation(CCLE_Melanoma,[]);
indx = strncmp('Average Chr',CCLE_M450_Melanoma_Average_Methylation.ColId,11);
[rb, pb] = corr(CCLE_M450_Melanoma_Average_Methylation.X, AUC_MEL,'Type','Spearman');

FontSize = 7;
LineWidth = 0.5;
GridLines = 'on';
fh=Dot_Plot(rb(indx),pb(indx),[1 0.10 0.05],[5 20 40],GetPalette('Tab10',3),3,2.5);
xlabel('Spearman''s \rho');
ylabel('Chromosome');
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_3c_CCLE_Melanoma_Chr_AUC_Corr.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_3c_CCLE_Melanoma_Chr_AUC_Corr.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_3c_CCLE_Melanoma_Chr_AUC_Corr.png'),'Resolution',Opt.png_res)
close(fh)

%Figure 3d

fh = ChrPlotDiff(RESULTS_CCLE_Melanoma_AUC_Corr,'CpG_beg','CpG_chrm','chr8','r Spearman','p Spearman','Range','cytoband','mb','FigSize',[6 2.15],'SizeLegend',[1 0.05 0.01 0.001],[5 20 40 80],[0.45 0.6 0.75 0.9]);

fh.Children(4).YLim=[-1 1];
fh.Children(4).YTick = -1:-.2:1;
fh.Children(4).CLim = [0 16];
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_3d_CCLE_Melanoma_Chr_08_Corr_AUC.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_3d_CCLE_Melanoma_Chr_08_Corr_AUC.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_3d_CCLE_Melanoma_Chr_08_Corr_AUC.png'),'Resolution',Opt.png_res)
close(fh)


%Figure 3e

CCLE_Melanoma_174 =  EditVariablesDATA(CCLE_Melanoma,SelectedCpG_probes,'Keep');
x=mean(CCLE_Melanoma_174.X,2,'omitnan');
[r] = corr(x, AUC_MEL,'Type','Spearman');

fh=figure('Name','Bar Plot','Color','w','Tag','Scatter Plot','Units','inches');
fh.Position(3:4) = [2.2,2.2];
ah = axes(fh,'NextPlot','add','tag','Volcano Plot','box','off','Layer','top','FontSize',7);
ah.XGrid = 'on';
ah.YGrid = 'on';
ah.LineWidth = 0.5;
sh=scatter(ah,x,AUC_MEL,50,'o','MarkerFaceColor',GetPalette('Tab10',3),'MarkerEdgeColor',[0.2 0.2 0.2]);
AlphaValue=0.9;
sh.MarkerEdgeAlpha = AlphaValue;
sh.MarkerFaceAlpha = AlphaValue;
box on
xlabel('RRMS')
ylabel({'AUC'});
p = polyfit(x,AUC_MEL,1);
f = polyval(p,x);
hold on
line(x,f,'Color','black');
axis square

nudgeX=range(x)/20;
ah.XLim = [min(x)-nudgeX  max(x) + nudgeX];

nudgeY=range(AUC_MEL)/20;
ah.YLim = [min(AUC_MEL)-nudgeY  max(AUC_MEL) + nudgeY];


TxtStr=cell(2,1);
TxtStr{1} = sprintf('\\rho=%.3f',r);

text(ah,ah.XLim(1)+nudgeX,5.5,TxtStr,'FontSize',7)
%exportgraphics(gcf,fullfile(FigureDir,'Figure_3e_AUC_vs_RRMS_CCLE_Melanoma.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_3e_AUC_vs_RRMS_CCLE_Melanoma.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_3e_AUC_vs_RRMS_CCLE_Melanoma.png'),'Resolution',Opt.png_res)
close(fh)


