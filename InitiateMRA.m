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
