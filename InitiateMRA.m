function InitiateMRA
% Function for initiating the folder structure and checking that all functions are available for the “A dysregulated methylome modulates the radiosensitivity of cancer" article.
% Anders Berglund 2025
%


%Read Options file
try
    MRA_Options;
catch
    error('Could not load MRA_Options.m file\n Make sure the GitHub library is added to the path')
end

% Create Folders
%Check if BaseDir exist, otherwise create it
if ~isfolder(Opt.BaseDir)
    warning('backtrace','off');
    warning('BasedDir [%s] not found, will try to create!',Opt.BaseDir)
    [status, Msg] = mkdir(Opt.BaseDir);
    if ~status
        error('Could not create %s, reason: %s',Opt.BaseDir,Msg)
    end
end

%Create Sub directories
FNs = fieldnames(Opt.SubDirs);
for i = 1:length(FNs)
    DirName = getfield(Opt.SubDirs,FNs{i});
        [status, Msg] = mkdir(fullfile(Opt.BaseDir,DirName));
    if ~status
        error('Could not create %s, reason: %s',fullfile(Opt.BaseDir,DirName),Msg)
    end
end

%Create individual Panel Figure folders
for i = 1:length(Opt.FigureFolders )
        [status, Msg] = mkdir(fullfile(Opt.BaseDir,Opt.SubDirs.PanelFigureDir,Opt.FigureFolders(i)));
    if ~status
        error('Could not create %s, reason: %s',fullfile(Opt.BaseDir,Opt.SubDirs.PanelFigureDir,Opt.FigureFolders(i)),Msg)
    end
end

%Create Supplementary material folders
for i = 1:length(Opt.SupplMat )
        [status, Msg] = mkdir(fullfile(Opt.BaseDir,Opt.SubDirs.SupplMaterialDir,Opt.SupplMat(i)));
    if ~status
        error('Could not create %s, reason: %s',fullfile(Opt.BaseDir,Opt.SubDirs.SupplMaterialDir,Opt.SupplMat(i)),Msg)
    end
end

%% Check that necessary funcions are available

if ~exist('GetPalette','file')
    error("Please download GetPalette.m from https://github.com/aebergl/AEB_COLOR and add it to the path") 
end

if ~exist('DensScat','file')
    error("Please download DensScat.m from https://github.com/aebergl/DensScat and add it to the path") 
end

if ~exist('MatSurv','file')
    error("Please download MatSurv.m from https://github.com/aebergl/MatSurv and add it to the path") 
end

if ~exist('BioinformaticsAEB','dir')
    error("Please download BioinformaticsAEB from https://github.com/aebergl/BioinformaticsAEB and add it to the path") 
end

