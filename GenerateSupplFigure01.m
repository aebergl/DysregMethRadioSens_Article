function GenerateSupplFigure01

% Script for generating all graphs in Panel Figure 1.

%% Load defaults
MRA_Options;


%% Supplementary Figure 1

FigureDir = fullfile(Opt.BaseDir,Opt.SubDirs.SupplMaterialDir,Opt.SupplMat(1));
DataDirectory = (fullfile(Opt.BaseDir,Opt.SubDirs.DataDir));


%% Figure 1a HNSC
load(fullfile(DataDirectory,"HNSC_M450_RT_HPVneg.mat"),'HNSC_M450_RT_HPVneg')
load(fullfile(DataDirectory,"HNSC_M450_NoRT_HPVneg.mat"),'HNSC_M450_NoRT_HPVneg')

x1=cell(HNSC_M450_RT_HPVneg.nRow,1);
x2=cell(HNSC_M450_NoRT_HPVneg.nRow,1);
x1(:)={'RT'};
x2(:)={'NoRT'};
Group=[x1;x2];

Width=1.68;
Hight = 1.7;

indx_DSS = strcmp('DSS',HNSC_M450_RT_HPVneg.SURVIVAL.SurvivalTypes);

SurvTime = [HNSC_M450_RT_HPVneg.SURVIVAL.SurvTime(:,indx_DSS);HNSC_M450_NoRT_HPVneg.SURVIVAL.SurvTime(:,indx_DSS)];
SurvEvent = [HNSC_M450_RT_HPVneg.SURVIVAL.SurvEvent(:,indx_DSS);HNSC_M450_NoRT_HPVneg.SURVIVAL.SurvEvent(:,indx_DSS)];
[p_LR,fH,stats] = MatSurv(SurvTime,SurvEvent,Group,'cutpoint','median','GroupOrder',{'NoRT,','RT'},...
'Title','HPV(-)HNSCC','TitleOptions',{'FontSize',7,'FontWeight','normal'},...
'Timeunit','Months','Print',1,'RT_KMplot',1,'BaseFontSize',5,'XStep',24,'LineWidth',0.75,'XLim',[0 120],'legend',false,'ylabel','Survival Probability',...
'XTickFontSize',0,'YTickFontSize',0,'LegendFontSize',0,'PvalFontSize',0,'CensorLineWidth',0.5,'LineColor',GetPalette('Tab20',[1 2]),'xlabel','DSS by RT (Months)');
fH.Children(1).Children(1).FontWeight='normal';
fH.Children(1).Children(2).FontWeight='normal';
fH.Children(1).LineWidth=0.5;
fH.Units = 'inches';
fH.Position(3)=Width;fH.Position(4)=Hight;
%exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_1a_HNSC_M450_HPVneg_DSS_KM_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'SupplFigure_1a_HNSC_M450_HPVneg_DSS_KM_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_1a_HNSC_M450_HPVneg_DSS_KM_Plot.png'),'Resolution',Opt.png_res)
close(fH)

%% Figure 1b PRAD
load(fullfile(DataDirectory,"PRAD_M450_RT.mat"),'PRAD_M450_RT')
load(fullfile(DataDirectory,"PRAD_M450_NoRT.mat"),'PRAD_M450_NoRT')

x1=cell(PRAD_M450_RT.nRow,1);
x2=cell(PRAD_M450_NoRT.nRow,1);
x1(:)={'RT'};
x2(:)={'NoRT'};
Group=[x1;x2];

Width=1.68;
Hight = 1.7;

indx_PFI = strcmp('PFI',PRAD_M450_RT.SURVIVAL.SurvivalTypes);

SurvTime = [PRAD_M450_RT.SURVIVAL.SurvTime(:,indx_PFI);PRAD_M450_NoRT.SURVIVAL.SurvTime(:,indx_PFI)];
SurvEvent = [PRAD_M450_RT.SURVIVAL.SurvEvent(:,indx_PFI);PRAD_M450_NoRT.SURVIVAL.SurvEvent(:,indx_PFI)];
[p_LR,fH,stats] = MatSurv(SurvTime,SurvEvent,Group,'cutpoint','median','GroupOrder',{'NoRT,','RT'},...
'Title','PRAD','TitleOptions',{'FontSize',7,'FontWeight','normal'},...
'Timeunit','Months','Print',1,'RT_KMplot',1,'BaseFontSize',5,'XStep',24,'LineWidth',0.75,'XLim',[0 120],'legend',false,'ylabel','Survival Probability',...
'XTickFontSize',0,'YTickFontSize',0,'LegendFontSize',0,'PvalFontSize',0,'CensorLineWidth',0.5,'LineColor',GetPalette('Tab20',[3 4]),'xlabel','PFI by RT (Months)');
fH.Children(1).Children(1).FontWeight='normal';
fH.Children(1).Children(2).FontWeight='normal';
fH.Children(1).LineWidth=0.5;
fH.Units = 'inches';
fH.Position(3)=Width;fH.Position(4)=Hight;
%exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_1b_PRAD_M450_PFI_KM_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'SupplFigure_1b_PRAD_M450_PFI_KM_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_1b_PRAD_M450_PFI_KM_Plot.png'),'Resolution',Opt.png_res)
close(fH)

%% Figure 1c SKCM
load(fullfile(DataDirectory,"SKCM_M450_RT.mat"),'SKCM_M450_RT')
load(fullfile(DataDirectory,"SKCM_M450_NoRT.mat"),'SKCM_M450_NoRT')

x1=cell(SKCM_M450_RT.nRow,1);
x2=cell(SKCM_M450_NoRT.nRow,1);
x1(:)={'RT'};
x2(:)={'NoRT'};
Group=[x1;x2];

Width=1.68;
Hight = 1.7;

indx_DSS = strcmp('DSS',SKCM_M450_RT.SURVIVAL.SurvivalTypes);

SurvTime = [SKCM_M450_RT.SURVIVAL.SurvTime(:,indx_DSS);SKCM_M450_NoRT.SURVIVAL.SurvTime(:,indx_DSS)];
SurvEvent = [SKCM_M450_RT.SURVIVAL.SurvEvent(:,indx_DSS);SKCM_M450_NoRT.SURVIVAL.SurvEvent(:,indx_DSS)];
[p_LR,fH,stats] = MatSurv(SurvTime,SurvEvent,Group,'cutpoint','median','GroupOrder',{'NoRT,','RT'},...
'Title','SKCM','TitleOptions',{'FontSize',7,'FontWeight','normal'},...
'Timeunit','Months','Print',1,'RT_KMplot',1,'BaseFontSize',5,'XStep',24,'LineWidth',0.75,'XLim',[0 120],'legend',false,'ylabel','Survival Probability',...
'XTickFontSize',0,'YTickFontSize',0,'LegendFontSize',0,'PvalFontSize',0,'CensorLineWidth',0.5,'LineColor',GetPalette('Tab20',[5 6]),'xlabel','DSS by RT (Months)');
fH.Children(1).Children(1).FontWeight='normal';
fH.Children(1).Children(2).FontWeight='normal';
fH.Children(1).LineWidth=0.5;
fH.Units = 'inches';
fH.Position(3)=Width;fH.Position(4)=Hight;
%exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_1c_SKCM_M450_DSS_KM_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'SupplFigure_1c_SKCM_M450_DSS_KM_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_1c_SKCM_M450_DSS_KM_Plot.png'),'Resolution',Opt.png_res)
close(fH)

%% Figure 1d BRCA
load(fullfile(DataDirectory,"BRCA_M450_RT.mat"),'BRCA_M450_RT')
load(fullfile(DataDirectory,"BRCA_M450_NoRT.mat"),'BRCA_M450_NoRT')

x1=cell(BRCA_M450_RT.nRow,1);
x2=cell(BRCA_M450_NoRT.nRow,1);
x1(:)={'RT'};
x2(:)={'NoRT'};
Group=[x1;x2];

Width=1.68;
Hight = 1.7;

indx_DSS = strcmp('DSS',BRCA_M450_RT.SURVIVAL.SurvivalTypes);

SurvTime = [BRCA_M450_RT.SURVIVAL.SurvTime(:,indx_DSS);BRCA_M450_NoRT.SURVIVAL.SurvTime(:,indx_DSS)];
SurvEvent = [BRCA_M450_RT.SURVIVAL.SurvEvent(:,indx_DSS);BRCA_M450_NoRT.SURVIVAL.SurvEvent(:,indx_DSS)];
[p_LR,fH,stats] = MatSurv(SurvTime,SurvEvent,Group,'cutpoint','median','GroupOrder',{'NoRT,','RT'},...
'Title','BRCA','TitleOptions',{'FontSize',7,'FontWeight','normal'},...
'Timeunit','Months','Print',1,'RT_KMplot',1,'BaseFontSize',5,'XStep',24,'LineWidth',0.75,'XLim',[0 120],'legend',false,'ylabel','Survival Probability',...
'XTickFontSize',0,'YTickFontSize',0,'LegendFontSize',0,'PvalFontSize',0,'CensorLineWidth',0.5,'LineColor',GetPalette('Tab20',[7 8]),'xlabel','DSS by RT (Months)');
fH.Children(1).Children(1).FontWeight='normal';
fH.Children(1).Children(2).FontWeight='normal';
fH.Children(1).LineWidth=0.5;
fH.Units = 'inches';
fH.Position(3)=Width;fH.Position(4)=Hight;
%exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_1d_BRCA_M450_DSS_KM_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'SupplFigure_1d_BRCA_M450_DSS_KM_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_1d_BRCA_M450_DSS_KM_Plot.png'),'Resolution',Opt.png_res)
close(fH)

%% Figure 1e SARC
load(fullfile(DataDirectory,"SARC_M450_RT.mat"),'SARC_M450_RT')
load(fullfile(DataDirectory,"SARC_M450_NoRT.mat"),'SARC_M450_NoRT')

x1=cell(SARC_M450_RT.nRow,1);
x2=cell(SARC_M450_NoRT.nRow,1);
x1(:)={'RT'};
x2(:)={'NoRT'};
Group=[x1;x2];

Width=1.68;
Hight = 1.7;

indx_DSS = strcmp('DSS',SARC_M450_RT.SURVIVAL.SurvivalTypes);

SurvTime = [SARC_M450_RT.SURVIVAL.SurvTime(:,indx_DSS);SARC_M450_NoRT.SURVIVAL.SurvTime(:,indx_DSS)];
SurvEvent = [SARC_M450_RT.SURVIVAL.SurvEvent(:,indx_DSS);SARC_M450_NoRT.SURVIVAL.SurvEvent(:,indx_DSS)];
[p_LR,fH,stats] = MatSurv(SurvTime,SurvEvent,Group,'cutpoint','median','GroupOrder',{'NoRT,','RT'},...
'Title','SARC','TitleOptions',{'FontSize',7,'FontWeight','normal'},...
'Timeunit','Months','Print',1,'RT_KMplot',1,'BaseFontSize',5,'XStep',24,'LineWidth',0.75,'XLim',[0 120],'legend',false,'ylabel','Survival Probability',...
'XTickFontSize',0,'YTickFontSize',0,'LegendFontSize',0,'PvalFontSize',0,'CensorLineWidth',0.5,'LineColor',GetPalette('Tab20',[9 10]),'xlabel','DSS by RT (Months)');
fH.Children(1).Children(1).FontWeight='normal';
fH.Children(1).Children(2).FontWeight='normal';
fH.Children(1).LineWidth=0.5;
fH.Units = 'inches';
fH.Position(3)=Width;fH.Position(4)=Hight;
%exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_1e_SARC_M450_DSS_KM_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'SupplFigure_1e_SARC_M450_DSS_KM_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_1e_SARC_M450_DSS_KM_Plot.png'),'Resolution',Opt.png_res)
close(fH)

%% Figure 1f STAD
load(fullfile(DataDirectory,"STAD_M450_RT.mat"),'STAD_M450_RT')
load(fullfile(DataDirectory,"STAD_M450_NoRT.mat"),'STAD_M450_NoRT')

x1=cell(STAD_M450_RT.nRow,1);
x2=cell(STAD_M450_NoRT.nRow,1);
x1(:)={'RT'};
x2(:)={'NoRT'};
Group=[x1;x2];

Width=1.68;
Hight = 1.7;

indx_DSS = strcmp('DSS',STAD_M450_RT.SURVIVAL.SurvivalTypes);

SurvTime = [STAD_M450_RT.SURVIVAL.SurvTime(:,indx_DSS);STAD_M450_NoRT.SURVIVAL.SurvTime(:,indx_DSS)];
SurvEvent = [STAD_M450_RT.SURVIVAL.SurvEvent(:,indx_DSS);STAD_M450_NoRT.SURVIVAL.SurvEvent(:,indx_DSS)];
[p_LR,fH,stats] = MatSurv(SurvTime,SurvEvent,Group,'cutpoint','median','GroupOrder',{'NoRT,','RT'},...
'Title','STAD','TitleOptions',{'FontSize',7,'FontWeight','normal'},...
'Timeunit','Months','Print',1,'RT_KMplot',1,'BaseFontSize',5,'XStep',24,'LineWidth',0.75,'XLim',[0 120],'legend',false,'ylabel','Survival Probability',...
'XTickFontSize',0,'YTickFontSize',0,'LegendFontSize',0,'PvalFontSize',0,'CensorLineWidth',0.5,'LineColor',GetPalette('Tab20',[11 12]),'xlabel','DSS by RT (Months)');
fH.Children(1).Children(1).FontWeight='normal';
fH.Children(1).Children(2).FontWeight='normal';
fH.Children(1).LineWidth=0.5;
fH.Units = 'inches';
fH.Position(3)=Width;fH.Position(4)=Hight;
%exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_1f_STAD_M450_DSS_KM_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'SupplFigure_1f_STAD_M450_DSS_KM_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_1f_STAD_M450_DSS_KM_Plot.png'),'Resolution',Opt.png_res)
close(fH)

%% Figure 1g CESC
load(fullfile(DataDirectory,"CESC_M450_RT.mat"),'CESC_M450_RT')
load(fullfile(DataDirectory,"CESC_M450_NoRT.mat"),'CESC_M450_NoRT')

x1=cell(CESC_M450_RT.nRow,1);
x2=cell(CESC_M450_NoRT.nRow,1);
x1(:)={'RT'};
x2(:)={'NoRT'};
Group=[x1;x2];

Width=1.68;
Hight = 1.7;

indx_DSS = strcmp('DSS',CESC_M450_RT.SURVIVAL.SurvivalTypes);

SurvTime = [CESC_M450_RT.SURVIVAL.SurvTime(:,indx_DSS);CESC_M450_NoRT.SURVIVAL.SurvTime(:,indx_DSS)];
SurvEvent = [CESC_M450_RT.SURVIVAL.SurvEvent(:,indx_DSS);CESC_M450_NoRT.SURVIVAL.SurvEvent(:,indx_DSS)];
[p_LR,fH,stats] = MatSurv(SurvTime,SurvEvent,Group,'cutpoint','median','GroupOrder',{'NoRT,','RT'},...
'Title','CESC','TitleOptions',{'FontSize',7,'FontWeight','normal'},...
'Timeunit','Months','Print',1,'RT_KMplot',1,'BaseFontSize',5,'XStep',24,'LineWidth',0.75,'XLim',[0 120],'legend',false,'ylabel','Survival Probability',...
'XTickFontSize',0,'YTickFontSize',0,'LegendFontSize',0,'PvalFontSize',0,'CensorLineWidth',0.5,'LineColor',GetPalette('Tab20',[15 16]),'xlabel','DSS by RT (Months)');
fH.Children(1).Children(1).FontWeight='normal';
fH.Children(1).Children(2).FontWeight='normal';
fH.Children(1).LineWidth=0.5;
fH.Units = 'inches';
fH.Position(3)=Width;fH.Position(4)=Hight;
%exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_1g_CESC_M450_DSS_KM_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'SupplFigure_1g_CESC_M450_DSS_KM_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_1g_CESC_M450_DSS_KM_Plot.png'),'Resolution',Opt.png_res)
close(fH)

%% Figure 1h GBM
load(fullfile(DataDirectory,"GBM_M450_RT.mat"),'GBM_M450_RT')
load(fullfile(DataDirectory,"GBM_M450_NoRT.mat"),'GBM_M450_NoRT')

x1=cell(GBM_M450_RT.nRow,1);
x2=cell(GBM_M450_NoRT.nRow,1);
x1(:)={'RT'};
x2(:)={'NoRT'};
Group=[x1;x2];

Width=1.68;
Hight = 1.7;

indx_DSS = strcmp('DSS',GBM_M450_RT.SURVIVAL.SurvivalTypes);

SurvTime = [GBM_M450_RT.SURVIVAL.SurvTime(:,indx_DSS);GBM_M450_NoRT.SURVIVAL.SurvTime(:,indx_DSS)];
SurvEvent = [GBM_M450_RT.SURVIVAL.SurvEvent(:,indx_DSS);GBM_M450_NoRT.SURVIVAL.SurvEvent(:,indx_DSS)];
[p_LR,fH,stats] = MatSurv(SurvTime,SurvEvent,Group,'cutpoint','median','GroupOrder',{'NoRT,','RT'},...
'Title','GBM','TitleOptions',{'FontSize',7,'FontWeight','normal'},...
'Timeunit','Months','Print',1,'RT_KMplot',1,'BaseFontSize',5,'XStep',12,'LineWidth',0.75,'XLim',[0 36],'legend',false,'ylabel','Survival Probability',...
'XTickFontSize',0,'YTickFontSize',0,'LegendFontSize',0,'PvalFontSize',0,'CensorLineWidth',0.5,'LineColor',GetPalette('Tab20',[17 18]),'xlabel','DSS by RT (Months)');
fH.Children(1).Children(1).FontWeight='normal';
fH.Children(1).Children(2).FontWeight='normal';
fH.Children(1).LineWidth=0.5;
fH.Units = 'inches';
fH.Position(3)=Width;fH.Position(4)=Hight;
%exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_1h_GBM_M450_DSS_KM_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'SupplFigure_1h_GBM_M450_DSS_KM_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_1h_GBM_M450_DSS_KM_Plot.png'),'Resolution',Opt.png_res)
close(fH)

%% Figure 1i LGG
load(fullfile(DataDirectory,"LGG_M450_RT.mat"),'LGG_M450_RT')
load(fullfile(DataDirectory,"LGG_M450_NoRT.mat"),'LGG_M450_NoRT')

x1=cell(LGG_M450_RT.nRow,1);
x2=cell(LGG_M450_NoRT.nRow,1);
x1(:)={'RT'};
x2(:)={'NoRT'};
Group=[x1;x2];

Width=1.68;
Hight = 1.7;

indx_DSS = strcmp('DSS',LGG_M450_RT.SURVIVAL.SurvivalTypes);

SurvTime = [LGG_M450_RT.SURVIVAL.SurvTime(:,indx_DSS);LGG_M450_NoRT.SURVIVAL.SurvTime(:,indx_DSS)];
SurvEvent = [LGG_M450_RT.SURVIVAL.SurvEvent(:,indx_DSS);LGG_M450_NoRT.SURVIVAL.SurvEvent(:,indx_DSS)];
[p_LR,fH,stats] = MatSurv(SurvTime,SurvEvent,Group,'cutpoint','median','GroupOrder',{'NoRT,','RT'},...
'Title','LGG','TitleOptions',{'FontSize',7,'FontWeight','normal'},...
'Timeunit','Months','Print',1,'RT_KMplot',1,'BaseFontSize',5,'XStep',24,'LineWidth',0.75,'XLim',[0 120],'legend',false,'ylabel','Survival Probability',...
'XTickFontSize',0,'YTickFontSize',0,'LegendFontSize',0,'PvalFontSize',0,'CensorLineWidth',0.5,'LineColor',GetPalette('Tab20',[19 20]),'xlabel','DSS by RT (Months)');
fH.Children(1).Children(1).FontWeight='normal';
fH.Children(1).Children(2).FontWeight='normal';
fH.Children(1).LineWidth=0.5;
fH.Units = 'inches';
fH.Position(3)=Width;fH.Position(4)=Hight;
%exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_1i_LGG_M450_DSS_KM_Plot.pdf'));
SavePDF_AEB(fullfile(FigureDir,'SupplFigure_1i_LGG_M450_DSS_KM_Plot.pdf'));
exportgraphics(gcf,fullfile(FigureDir,'SupplFigure_1i_LGG_M450_DSS_KM_Plot.png'),'Resolution',Opt.png_res)
close(fH)