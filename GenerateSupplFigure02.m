function GenerateSupplFigure02
% Function for generating all individual graphs for supplementary panel figure 2

%% Load defaults
MRA_Options;


%% Supplementary Figure 3

FigureDir = fullfile(Opt.BaseDir,Opt.SubDirs.SupplMaterialDir,Opt.SupplMat(2));
DataDirectory = (fullfile(Opt.BaseDir,Opt.SubDirs.DataDir));


%% Figure 2a HNSC
load(fullfile(DataDirectory,"HNSC_M450_RT_HPVneg.mat"),'HNSC_M450_RT_HPVneg')

Width = 2;
Hight = 2;

indx_DSS = strcmp('DSS',HNSC_M450_RT_HPVneg.SURVIVAL.SurvivalTypes);
indx_TBR = strcmp('treatment_best_response',HNSC_M450_RT_HPVneg.RowAnnotationFields);

SurvTime = HNSC_M450_RT_HPVneg.SURVIVAL.SurvTime(:,indx_DSS);
SurvEvent = HNSC_M450_RT_HPVneg.SURVIVAL.SurvEvent(:,indx_DSS);
Group = cellstr(HNSC_M450_RT_HPVneg.RowAnnotation(:,indx_TBR));
GroupsToUse = {{'CR+PR','Complete Response','Partial Response'},{'RPD+SD','Radiographic Progressive Disease','Stable Disease'},{'NA','[Not Available]','[Unknown]'}};

[p_LR,fH,stats] = MatSurv(SurvTime,SurvEvent,Group,'cutpoint','median','GroupsToUse',GroupsToUse,...
'Title','HPV(-)HNSCC RT','TitleOptions',{'FontSize',6,'FontWeight','normal'},'PairWiseP',true,...
'Timeunit','Months','Print',1,'RT_KMplot',1,'BaseFontSize',5,'XStep',24,'LineWidth',0.75,'XLim',[0 120],'legend',false,'ylabel','Survival Probability',...
'XTickFontSize',0,'YTickFontSize',0,'LegendFontSize',0,'PvalFontSize',0,'CensorLineWidth',0.5,'LineColor',GetPalette('Tab10',[1 4 8]),'xlabel','DSS by RT (Months)');
fH.Children(1).Children(1).FontWeight='normal';
fH.Children(1).Children(2).FontWeight='normal';
fH.Children(1).Children(3).FontWeight='normal';
fH.Children(1).LineWidth=0.5;
fH.Units = 'inches';
fH.Position(3)=Width;fH.Position(4)=Hight;
s=findobj( fH.Children.Children, 'Tag', 'p-value' );
s.String(1) = {'CR+PR vs. RPD+SD'};
s.String(2) = {sprintf('p = %.3g',stats.ParwiseStats(1).p_MC)};
%exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_2a_HNSC_M450_HPVneg_DSS_KM_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'SupplFigure_2a_HNSC_M450_HPVneg_DSS_KM_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_2a_HNSC_M450_HPVneg_DSS_KM_Plot.png'),'Resolution',Opt.png_res)
close(fH)

%% Figure 2b PRAD
load(fullfile(DataDirectory,"PRAD_M450_RT.mat"),'PRAD_M450_RT')


indx_PFI = strcmp('PFI',PRAD_M450_RT.SURVIVAL.SurvivalTypes);
indx_TBR = strcmp('treatment_best_response',PRAD_M450_RT.RowAnnotationFields);


SurvTime = PRAD_M450_RT.SURVIVAL.SurvTime(:,indx_PFI);
SurvEvent = PRAD_M450_RT.SURVIVAL.SurvEvent(:,indx_PFI);
Group = cellstr(PRAD_M450_RT.RowAnnotation(:,indx_TBR));
GroupsToUse = {{'CR+PR','Complete Response','Partial Response'},{'RPD+SD','Radiographic Progressive Disease','Stable Disease'},{'NA','[Not Available]','[Unknown]'}};


[p_LR,fH,stats] = MatSurv(SurvTime,SurvEvent,Group,'cutpoint','median','GroupsToUse',GroupsToUse,...
'Title','PRAD RT','TitleOptions',{'FontSize',6,'FontWeight','normal'},'TimeMax', 72,'PairWiseP',true,...
'Timeunit','Months','Print',1,'RT_KMplot',1,'BaseFontSize',5,'XStep',12,'LineWidth',0.75,'XLim',[0 72],'legend',false,'ylabel','Survival Probability',...
'XTickFontSize',0,'YTickFontSize',0,'LegendFontSize',0,'PvalFontSize',0,'CensorLineWidth',0.5,'LineColor',GetPalette('Tab10',[1 4 8]),'xlabel','PFI by RT (Months)');
fH.Children(1).Children(1).FontWeight='normal';
fH.Children(1).Children(2).FontWeight='normal';
fH.Children(1).Children(3).FontWeight='normal';
fH.Children(1).LineWidth=0.5;
fH.Units = 'inches';
fH.Position(3)=Width;fH.Position(4)=Hight;
s=findobj( fH.Children.Children, 'Tag', 'p-value' );
s.String(1) = {'CR+PR vs. RPD+SD'};
s.String(2) = {sprintf('p = %.3g',stats.ParwiseStats(1).p_MC)};
%exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_2b_PRAD_M450_PFI_KM_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'SupplFigure_2b_PRAD_M450_PFI_KM_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_2b_PRAD_M450_PFI_KM_Plot.png'),'Resolution',Opt.png_res)
close(fH)


%% Figure 2c SKCM
load(fullfile(DataDirectory,"SKCM_M450_RT.mat"),'SKCM_M450_RT')


indx_DSS = strcmp('DSS',SKCM_M450_RT.SURVIVAL.SurvivalTypes);
indx_TBR = strcmp('treatment_best_response',SKCM_M450_RT.RowAnnotationFields);

SurvTime = SKCM_M450_RT.SURVIVAL.SurvTime(:,indx_DSS);
SurvEvent = SKCM_M450_RT.SURVIVAL.SurvEvent(:,indx_DSS);
Group = cellstr(SKCM_M450_RT.RowAnnotation(:,indx_TBR));
GroupsToUse = {{'CR+PR','Complete Response','Partial Response'},{'RPD+SD','Radiographic Progressive Disease','Stable Disease'},{'NA','[Not Available]','[Unknown]'}};


[p_LR,fH,stats] = MatSurv(SurvTime,SurvEvent,Group,'cutpoint','median','GroupsToUse',GroupsToUse,...
'Title','SKCM RT','TitleOptions',{'FontSize',6,'FontWeight','normal'},'PairWiseP',true,...
'Timeunit','Months','Print',1,'RT_KMplot',1,'BaseFontSize',5,'XStep',24,'LineWidth',0.75,'XLim',[0 120],'legend',false,'ylabel','Survival Probability',...
'XTickFontSize',0,'YTickFontSize',0,'LegendFontSize',0,'PvalFontSize',0,'CensorLineWidth',0.5,'LineColor',GetPalette('Tab10',[1 4 8]),'xlabel','DSS by RT (Months)');
fH.Children(1).Children(1).FontWeight='normal';
fH.Children(1).Children(2).FontWeight='normal';
fH.Children(1).Children(3).FontWeight='normal';
fH.Children(1).LineWidth=0.5;
fH.Units = 'inches';
fH.Position(3)=Width;fH.Position(4)=Hight;
s=findobj( fH.Children.Children, 'Tag', 'p-value' );
s.String(1) = {'CR+PR vs. RPD+SD'};
s.String(2) = {sprintf('p = %.3g',stats.ParwiseStats(1).p_MC)};
%exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_2c_SKCM_M450_DSS_KM_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'SupplFigure_2c_SKCM_M450_DSS_KM_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_2c_SKCM_M450_DSS_KM_Plot.png'),'Resolution',Opt.png_res)
close(fH)

%% Figure 2d BRCA
load(fullfile(DataDirectory,"BRCA_M450_RT.mat"),'BRCA_M450_RT')


indx_DSS = strcmp('DSS',BRCA_M450_RT.SURVIVAL.SurvivalTypes);
indx_TBR = strcmp('treatment_best_response',BRCA_M450_RT.RowAnnotationFields);


SurvTime = BRCA_M450_RT.SURVIVAL.SurvTime(:,indx_DSS);
SurvEvent = BRCA_M450_RT.SURVIVAL.SurvEvent(:,indx_DSS);
Group = cellstr(BRCA_M450_RT.RowAnnotation(:,indx_TBR));

GroupsToUse = {{'CR+PR','Complete Response','Partial Response'},{'RPD+SD','Radiographic Progressive Disease','Stable Disease'},{'NA','[Not Available]','[Unknown]'}};

[p_LR,fH,stats] = MatSurv(SurvTime,SurvEvent,Group,'cutpoint','median','GroupsToUse',GroupsToUse,...
'Title','BRCA RT','TitleOptions',{'FontSize',6,'FontWeight','normal'},'PairWiseP',true,...
'Timeunit','Months','Print',1,'RT_KMplot',1,'BaseFontSize',5,'XStep',24,'LineWidth',0.75,'XLim',[0 120],'legend',false,'ylabel','Survival Probability',...
'XTickFontSize',0,'YTickFontSize',0,'LegendFontSize',0,'PvalFontSize',0,'CensorLineWidth',0.5,'LineColor',GetPalette('Tab10',[1 4 8]),'xlabel','DSS by RT (Months)');
fH.Children(1).Children(1).FontWeight='normal';
fH.Children(1).Children(2).FontWeight='normal';
fH.Children(1).Children(3).FontWeight='normal';
fH.Children(1).LineWidth=0.5;
fH.Units = 'inches';
fH.Position(3)=Width;fH.Position(4)=Hight;
s=findobj( fH.Children.Children, 'Tag', 'p-value' );
s.String(1) = {'CR+PR vs. RPD+SD'};
s.String(2) = {sprintf('p = %.3g',stats.ParwiseStats(1).p_MC)};
%exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_2d_BRCA_M450_DSS_KM_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'SupplFigure_2d_BRCA_M450_DSS_KM_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_2d_BRCA_M450_DSS_KM_Plot.png'),'Resolution',Opt.png_res)
close(fH)

%% Figure 2e SARC
load(fullfile(DataDirectory,"SARC_M450_RT.mat"),'SARC_M450_RT')


indx_DSS = strcmp('DSS',SARC_M450_RT.SURVIVAL.SurvivalTypes);
indx_TBR = strcmp('treatment_best_response',SARC_M450_RT.RowAnnotationFields);

SurvTime = SARC_M450_RT.SURVIVAL.SurvTime(:,indx_DSS);
SurvEvent = SARC_M450_RT.SURVIVAL.SurvEvent(:,indx_DSS);
Group = cellstr(SARC_M450_RT.RowAnnotation(:,indx_TBR));
GroupsToUse = {{'CR+PR','Complete Response','Partial Response'},{'RPD+SD','Radiographic Progressive Disease','Stable Disease'},{'NA','[Not Available]','[Unknown]'}};

[p_LR,fH,stats] = MatSurv(SurvTime,SurvEvent,Group,'cutpoint','median','GroupsToUse',GroupsToUse,...
'Title','SARC RT','TitleOptions',{'FontSize',6,'FontWeight','normal'},'PairWiseP',true,...
'Timeunit','Months','Print',1,'RT_KMplot',1,'BaseFontSize',5,'XStep',24,'LineWidth',0.75,'XLim',[0 120],'legend',false,'ylabel','Survival Probability',...
'XTickFontSize',0,'YTickFontSize',0,'LegendFontSize',0,'PvalFontSize',0,'CensorLineWidth',0.5,'LineColor',GetPalette('Tab10',[1 4 8]),'xlabel','DSS by RT (Months)');
fH.Children(1).Children(1).FontWeight='normal';
fH.Children(1).Children(2).FontWeight='normal';
fH.Children(1).Children(3).FontWeight='normal';
fH.Children(1).LineWidth=0.5;
fH.Units = 'inches';
fH.Position(3)=Width;fH.Position(4)=Hight;
s=findobj( fH.Children.Children, 'Tag', 'p-value' );
s.String(1) = {'CR+PR vs. RPD+SD'};
s.String(2) = {sprintf('p = %.3g',stats.ParwiseStats(1).p_MC)};
%exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_2e_SARC_M450_DSS_KM_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'SupplFigure_2e_SARC_M450_DSS_KM_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_2e_SARC_M450_DSS_KM_Plot.png'),'Resolution',Opt.png_res)
close(fH)

%% Figure 2f STAD
load(fullfile(DataDirectory,"STAD_M450_RT.mat"),'STAD_M450_RT')

indx_DSS = strcmp('DSS',STAD_M450_RT.SURVIVAL.SurvivalTypes);
indx_TBR = strcmp('treatment_best_response',STAD_M450_RT.RowAnnotationFields);

SurvTime = STAD_M450_RT.SURVIVAL.SurvTime(:,indx_DSS);
SurvEvent = STAD_M450_RT.SURVIVAL.SurvEvent(:,indx_DSS);
Group = cellstr(STAD_M450_RT.RowAnnotation(:,indx_TBR));
GroupsToUse = {{'CR+PR','Complete Response','Partial Response'},{'RPD+SD','Radiographic Progressive Disease','Stable Disease'},{'NA','[Not Available]','[Unknown]'}};

[p_LR,fH,stats] = MatSurv(SurvTime,SurvEvent,Group,'cutpoint','median','GroupsToUse',GroupsToUse,...
'Title','STAD RT','TitleOptions',{'FontSize',7,'FontWeight','normal'},'PairWiseP',true,...
'Timeunit','Months','Print',1,'RT_KMplot',1,'BaseFontSize',5,'XStep',24,'LineWidth',0.75,'XLim',[0 120],'legend',false,'ylabel','Survival Probability',...
'XTickFontSize',0,'YTickFontSize',0,'LegendFontSize',0,'PvalFontSize',0,'CensorLineWidth',0.5,'LineColor',GetPalette('Tab10',[1 4 8]),'xlabel','DSS by RT (Months)');
fH.Children(1).Children(1).FontWeight='normal';
fH.Children(1).Children(2).FontWeight='normal';
fH.Children(1).Children(3).FontWeight='normal';
fH.Children(1).LineWidth=0.5;
fH.Units = 'inches';
fH.Position(3)=Width;fH.Position(4)=Hight;
s=findobj( fH.Children.Children, 'Tag', 'p-value' );
s.String(1) = {'CR+PR vs. RPD+SD'};
s.String(2) = {sprintf('p = %.3g',stats.ParwiseStats(1).p_MC)};

%exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_2f_STAD_M450_DSS_KM_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'SupplFigure_2f_STAD_M450_DSS_KM_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_2f_STAD_M450_DSS_KM_Plot.png'),'Resolution',Opt.png_res)
close(fH)

%% Figure 2g CESC
load(fullfile(DataDirectory,"CESC_M450_RT.mat"),'CESC_M450_RT')

indx_DSS = strcmp('DSS',CESC_M450_RT.SURVIVAL.SurvivalTypes);
indx_TBR = strcmp('treatment_best_response',CESC_M450_RT.RowAnnotationFields);

SurvTime = CESC_M450_RT.SURVIVAL.SurvTime(:,indx_DSS);
SurvEvent = CESC_M450_RT.SURVIVAL.SurvEvent(:,indx_DSS);
Group = cellstr(CESC_M450_RT.RowAnnotation(:,indx_TBR));
GroupsToUse = {{'CR+PR','Complete Response','Partial Response'},{'RPD+SD','Radiographic Progressive Disease','Stable Disease'},{'NA','[Not Available]','[Unknown]'}};

[p_LR,fH,stats] = MatSurv(SurvTime,SurvEvent,Group,'cutpoint','median','GroupsToUse',GroupsToUse,...
'Title','CESC RT','TitleOptions',{'FontSize',7,'FontWeight','normal'},'PairWiseP',true,...
'Timeunit','Months','Print',1,'RT_KMplot',1,'BaseFontSize',5,'XStep',24,'LineWidth',0.75,'XLim',[0 120],'legend',false,'ylabel','Survival Probability',...
'XTickFontSize',0,'YTickFontSize',0,'LegendFontSize',0,'PvalFontSize',0,'CensorLineWidth',0.5,'LineColor',GetPalette('Tab10',[1 4 8]),'xlabel','DSS by RT (Months)');
fH.Children(1).Children(1).FontWeight='normal';
fH.Children(1).Children(2).FontWeight='normal';
fH.Children(1).Children(3).FontWeight='normal';
fH.Children(1).LineWidth=0.5;
fH.Units = 'inches';
fH.Position(3)=Width;fH.Position(4)=Hight;
s=findobj( fH.Children.Children, 'Tag', 'p-value' );
s.String(1) = {'CR+PR vs. RPD+SD'};
s.String(2) = {sprintf('p = %.3g',stats.ParwiseStats(1).p_MC)};
%exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_2g_CESC_M450_DSS_KM_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'SupplFigure_2g_CESC_M450_DSS_KM_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_2g_CESC_M450_DSS_KM_Plot.png'),'Resolution',Opt.png_res)
close(fH)



%% Figure 2h GBM
load(fullfile(DataDirectory,"GBM_M450_RT.mat"),'GBM_M450_RT')

indx_DSS = strcmp('DSS',GBM_M450_RT.SURVIVAL.SurvivalTypes);
indx_TBR = strcmp('treatment_best_response',GBM_M450_RT.RowAnnotationFields);

SurvTime = GBM_M450_RT.SURVIVAL.SurvTime(:,indx_DSS);
SurvEvent = GBM_M450_RT.SURVIVAL.SurvEvent(:,indx_DSS);
Group = cellstr(GBM_M450_RT.RowAnnotation(:,indx_TBR));
GroupsToUse = {{'CR+PR','Complete Response','Partial Response'},{'RPD+SD','Radiographic Progressive Disease','Stable Disease'},{'NA','[Not Available]','[Unknown]'}};

[p_LR,fH,stats] = MatSurv(SurvTime,SurvEvent,Group,'cutpoint','median','GroupsToUse',GroupsToUse,...
'Title','GBM RT','TitleOptions',{'FontSize',7,'FontWeight','normal'},'PairWiseP',true,...
'Timeunit','Months','Print',1,'RT_KMplot',1,'BaseFontSize',5,'XStep',12,'LineWidth',0.75,'XLim',[0 36],'legend',false,'ylabel','Survival Probability',...
'XTickFontSize',0,'YTickFontSize',0,'LegendFontSize',0,'PvalFontSize',0,'CensorLineWidth',0.5,'LineColor',GetPalette('Tab10',[1 4 8]),'xlabel','DSS by RT (Months)');
fH.Children(1).Children(1).FontWeight='normal';
fH.Children(1).Children(2).FontWeight='normal';
fH.Children(1).Children(3).FontWeight='normal';
fH.Children(1).LineWidth=0.5;
fH.Units = 'inches';
fH.Position(3)=Width;fH.Position(4)=Hight;
s=findobj( fH.Children.Children, 'Tag', 'p-value' );
s.String(1) = {'CR+PR vs. RPD+SD'};
s.String(2) = {sprintf('p = %.3g',stats.ParwiseStats(1).p_MC)};
%exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_2h_GBM_M450_DSS_KM_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'SupplFigure_2h_GBM_M450_DSS_KM_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_2h_GBM_M450_DSS_KM_Plot.png'),'Resolution',Opt.png_res)
close(fH)

%% Figure 2i LGG
load(fullfile(DataDirectory,"LGG_M450_RT.mat"),'LGG_M450_RT')

indx_DSS = strcmp('DSS',LGG_M450_RT.SURVIVAL.SurvivalTypes);
indx_TBR = strcmp('treatment_best_response',LGG_M450_RT.RowAnnotationFields);
SurvTime = LGG_M450_RT.SURVIVAL.SurvTime(:,indx_DSS);
SurvEvent = LGG_M450_RT.SURVIVAL.SurvEvent(:,indx_DSS);
Group = cellstr(LGG_M450_RT.RowAnnotation(:,indx_TBR));
GroupsToUse = {{'CR+PR','Complete Response','Partial Response'},{'RPD+SD','Radiographic Progressive Disease','Stable Disease'},{'NA','[Not Available]','[Unknown]'}};

[p_LR,fH,stats] = MatSurv(SurvTime,SurvEvent,Group,'cutpoint','median','GroupsToUse',GroupsToUse,...
'Title','LGG RT','TitleOptions',{'FontSize',7,'FontWeight','normal'},'PairWiseP',true,...
'Timeunit','Months','Print',1,'RT_KMplot',1,'BaseFontSize',5,'XStep',24,'LineWidth',0.75,'XLim',[0 120],'legend',false,'ylabel','Survival Probability',...
'XTickFontSize',0,'YTickFontSize',0,'LegendFontSize',0,'PvalFontSize',0,'CensorLineWidth',0.5,'LineColor',GetPalette('Tab10',[1 4 8]),'xlabel','DSS by RT (Months)');
fH.Children(1).Children(1).FontWeight='normal';
fH.Children(1).Children(2).FontWeight='normal';
fH.Children(1).Children(3).FontWeight='normal';
fH.Children(1).LineWidth=0.5;
fH.Units = 'inches';
fH.Position(3)=Width;fH.Position(4)=Hight;
s=findobj( fH.Children.Children, 'Tag', 'p-value' );
s.String(1) = {'CR+PR vs. RPD+SD'};
s.String(2) = {sprintf('p = %.3g',stats.ParwiseStats(1).p_MC)};
%exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_2i_LGG_M450_DSS_KM_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'SupplFigure_2i_LGG_M450_DSS_KM_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_2i_LGG_M450_DSS_KM_Plot.png'),'Resolution',Opt.png_res)
close(fH)