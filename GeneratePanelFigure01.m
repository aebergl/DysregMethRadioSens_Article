function GeneratePanelFigure01
% Script for generating all graphs in Panel Figure 1.

%% Load defaults
MRA_Options;

%% Figure directory
FigureDir = fullfile(Opt.BaseDir,Opt.SubDirs.PanelFigureDir,Opt.FigureFolders(1));
ResultDirectory = (fullfile(Opt.BaseDir,Opt.SubDirs.ResultDir));


%% Figure 1


% Figure 1a

% load pre calculated PCA model and Groups 
load(fullfile(ResultDirectory,"PCA_ALL_50.mat"),"PCA_ALL_50")
load(fullfile(ResultDirectory,"GroupId.mat"),"GroupId")

%Calculate t-SNE model
rng('default')
Ytsne = tsne(PCA_ALL_50.T,'Algorithm','exact','NumPCAComponents',0,'Perplexity',30);

% Create figure
CMap = [GetPalette('Tab20',[2 1]);[ 0 0 0];GetPalette('Tab20',[4 3 6 5 8 7 10 9 14 13 16 15 18 17 20 19])];
nx=1;ny=2;
fh=figure('Name','Scatter Plot','Color','w','Tag','Bar Plot','Units','inches');
fh.Position(3:4) = [3.8 2.7];
ah = axes(fh,'NextPlot','add','tag','Scatter Plot','box','on','Layer','top','FontSize',7);
axis square
ah.LineWidth = 0.5;
gh=gscatter(ah,Ytsne(:,nx),Ytsne(:,ny),GroupId,CMap,'o',4);
nudgeX=range(Ytsne(:,nx))/50;
ah.XLim = [min(Ytsne(:,nx))-nudgeX  max(Ytsne(:,nx)) + nudgeX];
nudgeY=range(Ytsne(:,ny))/50;
ah.YLim = [min(Ytsne(:,ny))-nudgeY  max(Ytsne(:,ny)) + nudgeY];
legend('off')
% create legend with thicker lines
hCopy = copyobj(fh.Children(1).Children, ah); 
for i=1:19;set(hCopy(i),'XData', NaN', 'YData', NaN);end
for i=1:19;hCopy(i).LineWidth = 1;end
legend(flipud(hCopy))
fh.Children(1).Location='eastoutside';
fh.Children(1).Box='off';
ah.XTick=[];
ah.YTick=[];
ah.XLabel.String = 't-SNE 1';
ah.YLabel.String = 't-SNE 2';
ah.Position=[0.0340    0.0869    0.7222    0.9035];
fh.Children(1).Position = [0.6702    0.175    0.3412    0.8015];fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_1a_tSNE_All_Samples.pdf'));
fh.Renderer='painters';
SavePDF_AEB(fullfile(FigureDir,'Figure_1a_tSNE_All_Samples.pdf'));

exportgraphics(gcf,fullfile(FigureDir,'Figure_1a_tSNE_All_Samples.png'),'Resolution',Opt.png_res)
close(fh)
clear PCA_ALL_50 GroupId status Msg CMap Ytsne nx ny fh ah gh nudgeY nudgeX hCopy i 


% Figure 1b Volcano Plots
% Load Result files
load(fullfile(ResultDirectory,"RESULTS_HNSC_M450_RT_HPVneg_DSS.mat"),'RESULTS_HNSC_M450_RT_HPVneg_DSS')
load(fullfile(ResultDirectory,"RESULTS_HNSC_M450_NoRT_HPVneq_DSS.mat"),'RESULTS_HNSC_M450_NoRT_HPVneq_DSS')

load(fullfile(ResultDirectory,"RESULTS_PRAD_M450_RT_PFI.mat"),'RESULTS_PRAD_M450_RT_PFI')
load(fullfile(ResultDirectory,"RESULTS_PRAD_M450_NoRT_PFI.mat"),'RESULTS_PRAD_M450_NoRT_PFI')

load(fullfile(ResultDirectory,"RESULTS_SKCM_M450_RT_DSS.mat"),'RESULTS_SKCM_M450_RT_DSS')
load(fullfile(ResultDirectory,"RESULTS_SKCM_M450_NoRT_DSS.mat"),'RESULTS_SKCM_M450_NoRT_DSS')

load(fullfile(ResultDirectory,"RESULTS_BRCA_M450_RT_DSS.mat"),'RESULTS_BRCA_M450_RT_DSS')
load(fullfile(ResultDirectory,"RESULTS_BRCA_M450_NoRT_DSS.mat"),'RESULTS_BRCA_M450_NoRT_DSS')


PlotSize = [1.8 1.9];

% Create Volcano Plots, highligthing top 1% of the CpG-probes

fh = VolcanoPlotResults(RESULTS_HNSC_M450_RT_HPVneg_DSS,'HR coxreg DSS',0,'p coxreg DSS',2,'TopPrctile',99,'FigureSize',PlotSize,'FontSize',7,'EqualXLim','XlimCrop');
fh.Children.Position=[0.02    0.15    0.96    0.78];
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_1b_HNSC_M450_RT_HPV_Neg_DSS_Volcano_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_1b_HNSC_M450_RT_HPV_Neg_DSS_Volcano_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_1b_HNSC_M450_RT_HPV_Neg_DSS_Volcano_Plot.png'),'Resolution',Opt.png_res)
close(fh)

fh = VolcanoPlotResults(RESULTS_HNSC_M450_NoRT_HPVneq_DSS,'HR coxreg DSS',0,'p coxreg DSS',2,'TopPrctile',99,'FigureSize',PlotSize,'FontSize',7,'EqualXLim','XlimCrop' );
fh.Children.Position=[0.02    0.15    0.96    0.78];
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_1b_HNSC_M450_NoRT_HPV_Neg_DSS_Volcano_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_1b_HNSC_M450_NoRT_HPV_Neg_DSS_Volcano_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_1b_HNSC_M450_NoRT_HPV_Neg_DSS_Volcano_Plot.png'),'Resolution',Opt.png_res)
close(fh)

fh = VolcanoPlotResults(RESULTS_PRAD_M450_RT_PFI,'HR coxreg PFI',0,'p coxreg PFI',2,'TopPrctile',99,'FigureSize',PlotSize,'FontSize',7,'EqualXLim','XlimCrop');
fh.Children.Position=[0.02    0.15    0.96    0.78];
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_1b_PRAD_M450_RT_PFI_Volcano_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_1b_PRAD_M450_RT_PFI_Volcano_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_1b_PRAD_M450_RT_PFI_Volcano_Plot.png'),'Resolution',Opt.png_res)
close(fh)

fh = VolcanoPlotResults(RESULTS_PRAD_M450_NoRT_PFI,'HR coxreg PFI',0,'p coxreg PFI',2,'TopPrctile',99,'FigureSize',PlotSize,'FontSize',7,'EqualXLim','XlimCrop');
fh.Children.Position=[0.02    0.15    0.96    0.78];
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_1b_PRAD_M450_NoRT_PFI_Volcano_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_1b_PRAD_M450_NoRT_PFI_Volcano_Plot.pdf'));

exportgraphics(gcf,fullfile(FigureDir,'Figure_1b_PRAD_M450_NoRT_PFI_Volcano_Plot.png'),'Resolution',Opt.png_res)
close(fh)

fh = VolcanoPlotResults(RESULTS_SKCM_M450_RT_DSS,'HR coxreg DSS',0,'p coxreg DSS',2,'TopPrctile',99,'FigureSize',PlotSize,'FontSize',7,'EqualXLim','XlimCrop');
fh.Children.Position=[0.02    0.15    0.96    0.78];
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_1b_SKCM_M450_RT_DSS_Volcano_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_1b_SKCM_M450_RT_DSS_Volcano_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_1b_SKCM_M450_RT_DSS_Volcano_Plot.png'),'Resolution',Opt.png_res)
close(fh)

fh = VolcanoPlotResults(RESULTS_SKCM_M450_NoRT_DSS,'HR coxreg DSS',0,'p coxreg DSS',2,'TopPrctile',99,'FigureSize',PlotSize,'FontSize',7,'EqualXLim','XlimCrop');
fh.Children.Position=[0.02    0.15    0.96    0.78];
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_1b_SKCM_M450_NoRT_DSS_Volcano_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_1b_SKCM_M450_NoRT_DSS_Volcano_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_1b_SKCM_M450_NoRT_DSS_Volcano_Plot.png'),'Resolution',Opt.png_res)
close(fh)

fh = VolcanoPlotResults(RESULTS_BRCA_M450_RT_DSS,'HR coxreg DSS',0,'p coxreg DSS',2,'TopPrctile',99,'FigureSize',PlotSize,'FontSize',7,'EqualXLim','XlimCrop');
fh.Children.Position=[0.02    0.15    0.96    0.78];
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_1b_BRCA_M450_RT_DSS_Volcano_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_1b_BRCA_M450_RT_DSS_Volcano_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_1b_BRCA_M450_RT_DSS_Volcano_Plot.png'),'Resolution',Opt.png_res)
close(fh)

fh = VolcanoPlotResults(RESULTS_BRCA_M450_NoRT_DSS,'HR coxreg DSS',0,'p coxreg DSS',2,'TopPrctile',99,'FigureSize',PlotSize,'FontSize',7,'EqualXLim','XlimCrop');
fh.Children.Position=[0.02    0.15    0.96    0.78];
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_1b_BRCA_M450_NoRT_DSS_Volcano_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_1b_BRCA_M450_NoRT_DSS_Volcano_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_1b_BRCA_M450_NoRT_DSS_Volcano_Plot.png'),'Resolution',Opt.png_res)
close(fh)

% Figure 1c 
load(fullfile(ResultDirectory,"RESULTS_HNSC_M450_RT_HPVpos_DSS.mat"),"RESULTS_HNSC_M450_RT_HPVpos_DSS")

fh = VolcanoPlotResults(RESULTS_HNSC_M450_RT_HPVpos_DSS,'HR coxreg DSS',0,'p coxreg DSS',2,'TopPrctile',99,'FigureSize',PlotSize,'FontSize',7,'EqualXLim','XlimCrop' );
fh.Children.Position=[0.02    0.15    0.96    0.78];
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_1c_HNSC_M450_RT_HPV_Pos_DSS_Volcano_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_1c_HNSC_M450_RT_HPV_Pos_DSS_Volcano_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_1c_HNSC_M450_RT_HPV_Pos_DSS_Volcano_Plot.png'),'Resolution',Opt.png_res)
close(fh)

% Figure 1d Comparing degree of methylation across all cohorts

load(fullfile(ResultDirectory,"RESULTS_SARC_M450_RT_DSS.mat"),"RESULTS_SARC_M450_RT_DSS")
load(fullfile(ResultDirectory,"RESULTS_SARC_M450_NoRT_DSS.mat"),"RESULTS_SARC_M450_NoRT_DSS")

load(fullfile(ResultDirectory,"RESULTS_STAD_M450_RT_DSS.mat"),"RESULTS_STAD_M450_RT_DSS")
load(fullfile(ResultDirectory,"RESULTS_STAD_M450_NoRT_DSS.mat"),"RESULTS_STAD_M450_NoRT_DSS")

load(fullfile(ResultDirectory,"RESULTS_CESC_M450_RT_DSS.mat"),"RESULTS_CESC_M450_RT_DSS")
load(fullfile(ResultDirectory,"RESULTS_CESC_M450_NoRT_DSS.mat"),"RESULTS_CESC_M450_NoRT_DSS")

load(fullfile(ResultDirectory,"RESULTS_GBM_M450_RT_DSS.mat"),"RESULTS_GBM_M450_RT_DSS")
load(fullfile(ResultDirectory,"RESULTS_GBM_M450_NoRT_DSS.mat"),"RESULTS_GBM_M450_NoRT_DSS")

load(fullfile(ResultDirectory,"RESULTS_LGG_M450_RT_DSS.mat"),"RESULTS_LGG_M450_RT_DSS")
load(fullfile(ResultDirectory,"RESULTS_LGG_M450_NoRT_DSS.mat"),"RESULTS_LGG_M450_NoRT_DSS")


X = zeros(9,2);
[X(1,1)] = CalcVolcanoStatResults(RESULTS_HNSC_M450_RT_HPVneg_DSS,'HR coxreg DSS','p coxreg DSS');
[X(1,2)] = CalcVolcanoStatResults(RESULTS_HNSC_M450_NoRT_HPVneq_DSS,'HR coxreg DSS','p coxreg DSS');
[X(2,1)] = CalcVolcanoStatResults(RESULTS_PRAD_M450_RT_PFI,'HR coxreg PFI','p coxreg PFI');
[X(2,2)] = CalcVolcanoStatResults(RESULTS_PRAD_M450_NoRT_PFI,'HR coxreg PFI','p coxreg PFI');
[X(3,1)] = CalcVolcanoStatResults(RESULTS_SKCM_M450_RT_DSS,'HR coxreg DSS','p coxreg DSS');
[X(3,2)] = CalcVolcanoStatResults(RESULTS_SKCM_M450_NoRT_DSS,'HR coxreg DSS','p coxreg DSS');
[X(4,1)] = CalcVolcanoStatResults(RESULTS_BRCA_M450_RT_DSS,'HR coxreg DSS','p coxreg DSS');
[X(4,2)] = CalcVolcanoStatResults(RESULTS_BRCA_M450_NoRT_DSS,'HR coxreg DSS','p coxreg DSS');
[X(5,1)] = CalcVolcanoStatResults(RESULTS_SARC_M450_RT_DSS,'HR coxreg DSS','p coxreg DSS');
[X(5,2)] = CalcVolcanoStatResults(RESULTS_SARC_M450_NoRT_DSS,'HR coxreg DSS','p coxreg DSS');
[X(6,1)] = CalcVolcanoStatResults(RESULTS_STAD_M450_RT_DSS,'HR coxreg DSS','p coxreg DSS');
[X(6,2)] = CalcVolcanoStatResults(RESULTS_STAD_M450_NoRT_DSS,'HR coxreg DSS','p coxreg DSS');
[X(7,1)] = CalcVolcanoStatResults(RESULTS_CESC_M450_RT_DSS,'HR coxreg DSS','p coxreg DSS');
[X(7,2)] = CalcVolcanoStatResults(RESULTS_CESC_M450_NoRT_DSS,'HR coxreg DSS','p coxreg DSS');
[X(8,1)] = CalcVolcanoStatResults(RESULTS_GBM_M450_RT_DSS,'HR coxreg DSS','p coxreg DSS');
[X(8,2)] = CalcVolcanoStatResults(RESULTS_GBM_M450_NoRT_DSS,'HR coxreg DSS','p coxreg DSS');
[X(9,1)] = CalcVolcanoStatResults(RESULTS_LGG_M450_RT_DSS,'HR coxreg DSS','p coxreg DSS');
[X(9,2)] = CalcVolcanoStatResults(RESULTS_LGG_M450_NoRT_DSS,'HR coxreg DSS','p coxreg DSS');

TCGA_Ids={'HPV(-)HNSCC','PRAD','SKCM','BRCA','SARC','STAD','CESC','GBM','LGG'};
fh=figure('Name','Bar Plot','Color','w','Tag','Bar Plot','Units','inches');
fh.Position(3:4) = [4,2];
ah = axes(fh,'NextPlot','add','tag','Volcano Plot','box','off','Layer','top','FontSize',7);
ah.LineWidth = 0.5;
scatter(1:9,X(:,1),100,GetPalette('Tab20',[1 3 5 7 9 13 15 17 19]),'MarkerFaceColor','flat','MarkerEdgeColor',[0.1 0.1 0.1]);
scatter(1:9,X(:,2),100,GetPalette('Tab20',[2 4 6 8 10 14 16 18 20]),'Linewidth',1);
ylabel('(\SigmaHyper - \SigmaHypo) /\SigmaTotal');
ah.XLim=[0.5 9.5];
ah.XTick=1:9;
ah.XTickLabel=TCGA_Ids;
ah.XTickLabelRotation=-45;
line(ah.XLim,[0 0],'Linewidth',1,'Color','k','LineStyle','-.')
line(1:9,X(:,1),'Linewidth',1,'Color','k')
scatter(8.2,0.9,100,[0.3 0.3 0.3],'MarkerFaceColor','flat','MarkerEdgeColor',[0.1 0.1 0.1]);
text(8.5,0.9,'RT','HorizontalAlignment','left','VerticalAlignment','middle','FontSize',7)
scatter(8.2,0.65,100,[0.3 0.3 0.3],'MarkerEdgeColor',[0.1 0.1 0.1],'Linewidth',1);
text(8.5,0.65,'NoRT','HorizontalAlignment','left','VerticalAlignment','middle','FontSize',7)
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_1d_DotPlot_RT_vs_NoRT.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_1d_DotPlot_RT_vs_NoRT.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_1d_DotPlot_RT_vs_NoRT.png'),'Resolution',Opt.png_res)
close(fh)

clear X TCGA_Ids fh ah sh1 sh2 

% Figure 1e Density scatter plots comparing HNSC RT vs NoRT
indx = strcmp('p coxreg DSS',RESULTS_HNSC_M450_RT_HPVneg_DSS.ColId);
x = -log10(RESULTS_HNSC_M450_RT_HPVneg_DSS.X(:,indx));
y = -log10(RESULTS_HNSC_M450_NoRT_HPVneq_DSS.X(:,indx));
fh=figure('Name','Scatter Plot','Color','w','Tag','Bar Plot','Units','inches');
fh.Position(3:4) = [2 2.1];
ah = axes(fh,'NextPlot','add','tag','Scatter Plot','box','on','Layer','top','FontSize',6);
ah.LineWidth = 0.5;
DensScat(x,y,'ColorMap',colorcet('L08'),'TargetAxes',ah,'mSize',10);
ah.XLim=[0 max(x)+0.2];
ah.YLim=[0 max(y)+0.2];
xlabel('HPV(−)HNSCC RT -log_1_0(p)')
ylabel('HPV(−)HNSCC NoRT -log_1_0(p)')
[r, ~]=corr(x,y,'Type','Pearson','Rows','pairwise');
text(max(x),max(y),sprintf('r=%.2f',r),'HorizontalAlignment','right','VerticalAlignment','top','FontSize',6)
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_1e_HNSC_RT_vs_NoRT_p_values_Density_Scatter.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_1e_HNSC_RT_vs_NoRT_p_values_Density_Scatter.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_1e_HNSC_RT_vs_NoRT_p_values_Density_Scatter.png'),'Resolution',Opt.png_res)
close(fh)
clear indx x y fh ah r 

% Figure 1f Density scatter plots comparing LGG RT vs NoRT
indx = strcmp('p coxreg DSS',RESULTS_LGG_M450_RT_DSS.ColId);
x = -log10(RESULTS_LGG_M450_RT_DSS.X(:,indx));
y = -log10(RESULTS_LGG_M450_NoRT_DSS.X(:,indx));
fh=figure('Name','Scatter Plot','Color','w','Tag','Bar Plot','Units','inches');
fh.Position(3:4) = [2 2.1];
ah = axes(fh,'NextPlot','add','tag','Scatter Plot','box','on','Layer','top','FontSize',6);
ah.LineWidth = 0.5;
DensScat(x,y,'ColorMap',colorcet('L08'),'TargetAxes',ah,'mSize',10);
ah.XLim=[0 max(x)+0.2];
ah.YLim=[0 max(y)+0.2];
xlabel('LGG RT -log_1_0(p)')
ylabel('LGG NoRT -log_1_0(p)')
[r, ~]=corr(x,y,'Type','Pearson','Rows','pairwise');
text(max(x),max(y),sprintf('r=%.2f',r),'HorizontalAlignment','right','VerticalAlignment','top','FontSize',6)
fh.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_1f_LGG_RT_vs_NoRT_p_values_Density_Scatter.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_1f_LGG_RT_vs_NoRT_p_values_Density_Scatter.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_1f_LGG_RT_vs_NoRT_p_values_Density_Scatter.png'),'Resolution',Opt.png_res)
close(fh)
clear indx x y fh ah r 




% KM plots
% Figure 1g
load(fullfile(ResultDirectory,"HyperHypo_HNSC_M450_RT_HPVneg.mat"),"HyperHypo_HNSC_M450_RT_HPVneg")
indx_HypMet = strcmp('Hyper methylation',HyperHypo_HNSC_M450_RT_HPVneg.ColId);
indx_DSS = strcmp('DSS',HyperHypo_HNSC_M450_RT_HPVneg.SURVIVAL.SurvivalTypes);

[~,fH,~] = MatSurv(HyperHypo_HNSC_M450_RT_HPVneg.SURVIVAL.SurvTime(:,indx_DSS),HyperHypo_HNSC_M450_RT_HPVneg.SURVIVAL.SurvEvent(:,indx_DSS),HyperHypo_HNSC_M450_RT_HPVneg.X(:,indx_HypMet),'cutpoint','median',...
'Timeunit','Months','Print',1,'RT_KMplot',1,'BaseFontSize',6,'XStep',24,'LineWidth',0.75,'XLim',[0 120],'legend',false,'ylabel','Survival Probability',...
'XTickFontSize',0,'YTickFontSize',0,'LegendFontSize',0,'PvalFontSize',0,'CensorLineWidth',0.5,'LineColor',GetPalette('Lancet',[2 1]),'xlabel','DSS by Hyper-methylation (Months)');
%fH.Children(1).String = {'High Hyper','Low hyper'};
fH.Children(1).Children(1).String = {'Low'};
fH.Children(1).Children(2).String = {'High'};
fH.Children(1).Children(1).FontWeight='normal';
fH.Children(1).Children(2).FontWeight='normal';
fH.Children(1).LineWidth=0.5;
fH.Units = 'inches';
fH.Position(3:4)= [2.1 2.2];
fH.Children(1).Position=[0.1747 0.1549 0.7892 0.8210];
fH.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_1g_Hyper_HNSC_M450_RT_HPVneg_DSS_KM_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_1g_Hyper_HNSC_M450_RT_HPVneg_DSS_KM_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_1g_Hyper_HNSC_M450_RT_HPVneg_DSS_KM_Plot.png'),'Resolution',Opt.png_res)
close(fH)
clear indx_HypMet indx_DSS fH


% Figure 1h
load(fullfile(ResultDirectory,"HyperHypo_PRAD_M450_RT.mat"),"HyperHypo_PRAD_M450_RT")
indx_HypMet = strcmp('Hyper methylation',HyperHypo_PRAD_M450_RT.ColId);
indx_PFI = strcmp('PFI',HyperHypo_PRAD_M450_RT.SURVIVAL.SurvivalTypes);


[p_LR,fH,stats] = MatSurv(HyperHypo_PRAD_M450_RT.SURVIVAL.SurvTime(:,indx_PFI),HyperHypo_PRAD_M450_RT.SURVIVAL.SurvEvent(:,indx_PFI),HyperHypo_PRAD_M450_RT.X(:,indx_HypMet),'cutpoint','median',...
'Timeunit','Months','Print',1,'RT_KMplot',1,'BaseFontSize',6,'XStep',12,'LineWidth',0.75,'XLim',[0 60],'legend',false,'ylabel','Progression Free Probability',...
'XTickFontSize',0,'YTickFontSize',0,'LegendFontSize',0,'PvalFontSize',0,'CensorLineWidth',0.5,'LineColor',GetPalette('Lancet',[2 1]),'xlabel','PFI by Hyper-methylation (Months)');
%fH.Children(1).String = {'High Hyper','Low hyper'};
fH.Children(1).Children(1).String = {'Low'};
fH.Children(1).Children(2).String = {'High'};
fH.Children(1).Children(1).FontWeight='normal';
fH.Children(1).Children(2).FontWeight='normal';
fH.Children(1).LineWidth=0.5;
fH.Units = 'inches';
fH.Position(3:4)= [2.1 2.2];
fH.Children(1).Position=[0.1747 0.1549 0.7892 0.8210];
fH.Renderer='painters';
%exportgraphics(gcf,fullfile(FigureDir,'Figure_1h_Hyper_PRAD_M450_RT_PFI_KM_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'Figure_1h_Hyper_PRAD_M450_RT_PFI_KM_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'Figure_1h_Hyper_PRAD_M450_RT_PFI_KM_Plot.png'),'Resolution',Opt.png_res)
close(fH)
clear indx_HypMet indx_PFI fH


