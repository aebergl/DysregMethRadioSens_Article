function CalculateRNAseqResults
% Calculate results from the RNAseq data


%% Directory paths
try
    MRA_Options;
catch
    error('Could not load MRA_Options.m file\n Make sure the GitHub library is added to the path')
end


%% Data directory

DataDirectory = (fullfile(Opt.BaseDir,Opt.SubDirs.DataDir));
RNAseqDataDirectory = (fullfile(Opt.BaseDir,Opt.SubDirs.RNAseqDataDir));
RNAseqResultDirectory = (fullfile(Opt.BaseDir,Opt.SubDirs.RNAseqResultDir));



load(fullfile(Opt.BaseDir,Opt.SubDirs.ResultDir,"SelectedCpG_probes.mat"),'SelectedCpG_probes')
%% HNSC

load(fullfile(DataDirectory,"HNSC_M450_RT_HPVneg.mat"),'HNSC_M450_RT_HPVneg')
load(fullfile(RNAseqDataDirectory,"HNSC_RNAseq_RT_HPVneg.mat"),'HNSC_RNAseq_RT_HPVneg')


if ~strcmp('RRMS Group',HNSC_RNAseq_RT_HPVneg.RowAnnotationFields)
    % Select 174 CpG-probes
    HNSC_M450_RT_HPVneg =  EditVariablesDATA(HNSC_M450_RT_HPVneg,SelectedCpG_probes,'Keep');

    % Calculate RRMS and select high and low samples
    RRMS = mean(HNSC_M450_RT_HPVneg.X,2,'omitnan');
    median_RRMS = median(RRMS);
    indx_low = RRMS<median_RRMS;
    indx_high = ~indx_low;
    indx_Participant = strcmp('Participant',HNSC_M450_RT_HPVneg.RowAnnotationFields);
    Participant_low = HNSC_M450_RT_HPVneg.RowAnnotation(indx_low,indx_Participant);
    Participant_high = HNSC_M450_RT_HPVneg.RowAnnotation(indx_high,indx_Participant);

    % Select samples with RNAseq data
    tmp = cell(HNSC_RNAseq_RT_HPVneg.nRow,1);
    tmp(:) = {'NA'};
    indx_h = ismember(HNSC_RNAseq_RT_HPVneg.RowAnnotation(:,5),Participant_high);
    indx_l = ismember(HNSC_RNAseq_RT_HPVneg.RowAnnotation(:,5),Participant_low);
    tmp(indx_h) = {'High'};
    tmp(indx_l) = {'Low'};
    HNSC_RNAseq_RT_HPVneg.RowAnnotation = [HNSC_RNAseq_RT_HPVneg.RowAnnotation, tmp];
    HNSC_RNAseq_RT_HPVneg.RowAnnotationFields(end+1) = {'RRMS Group'};
    save(fullfile(RNAseqDataDirectory,"HNSC_RNAseq_RT_HPVneg.mat"),"HNSC_RNAseq_RT_HPVneg");
end
% Calculate RRMS high vs low for RNAseq data
RESULTS_HNSC_RNAseq_RT_HPVneg_RRMS_HighVsLow = CalculateDiffResults(HNSC_RNAseq_RT_HPVneg,{'Low'},{'High'},'RRMS Group',[]);
save(fullfile(RNAseqResultDirectory,"RESULTS_HNSC_RNAseq_RT_HPVneg_RRMS_HighVsLow.mat"),"RESULTS_HNSC_RNAseq_RT_HPVneg_RRMS_HighVsLow");

% Write .rnk file for GSEA Preranked analysis
[fid,Msg] = fopen(fullfile(RNAseqResultDirectory,"RESULTS_HNSC_RNAseq_RT_HPVneg_RRMS_HighVsLow.rnk"),'w');
if fid == -1
    error('Could not create %s, reason: %s',fullfile(RNAseqResultDirectory,"RESULTS_HNSC_RNAseq_RT_HPVneg_RRMS_HighVsLow.rnk"),Msg)
end
indx_S2N = strcmp('Signal2Noise',RESULTS_HNSC_RNAseq_RT_HPVneg_RRMS_HighVsLow.ColId);
indx_GS = strcmp('Symbol',RESULTS_HNSC_RNAseq_RT_HPVneg_RRMS_HighVsLow.RowAnnotationFields);

for i=1:RESULTS_HNSC_RNAseq_RT_HPVneg_RRMS_HighVsLow.nRow
    fprintf(fid,'%s\t%g\n',RESULTS_HNSC_RNAseq_RT_HPVneg_RRMS_HighVsLow.RowAnnotation{i,indx_GS},RESULTS_HNSC_RNAseq_RT_HPVneg_RRMS_HighVsLow.X(i,indx_S2N));
end
fclose(fid);


%% PRAD

load(fullfile(DataDirectory,"PRAD_M450_RT.mat"),'PRAD_M450_RT')
load(fullfile(RNAseqDataDirectory,"PRAD_RNAseq_RT.mat"),'PRAD_RNAseq_RT')

if ~strcmp('RRMS Group',PRAD_RNAseq_RT.RowAnnotationFields)
    % Select 174 CpG-probes
    PRAD_M450_RT =  EditVariablesDATA(PRAD_M450_RT,SelectedCpG_probes,'Keep');

    % Calculate RRMS and select high and low samples
    RRMS = mean(PRAD_M450_RT.X,2,'omitnan');
    median_RRMS = median(RRMS);
    indx_low = RRMS<median_RRMS;
    indx_high = ~indx_low;
    indx_Participant = strcmp('Participant',PRAD_M450_RT.RowAnnotationFields);
    Participant_low = PRAD_M450_RT.RowAnnotation(indx_low,indx_Participant);
    Participant_high = PRAD_M450_RT.RowAnnotation(indx_high,indx_Participant);

    % Select samples with RNAseq data
    tmp = cell(PRAD_RNAseq_RT.nRow,1);
    tmp(:) = {'NA'};
    indx_h = ismember(PRAD_RNAseq_RT.RowAnnotation(:,5),Participant_high);
    indx_l = ismember(PRAD_RNAseq_RT.RowAnnotation(:,5),Participant_low);
    tmp(indx_h) = {'High'};
    tmp(indx_l) = {'Low'};
    PRAD_RNAseq_RT.RowAnnotation = [PRAD_RNAseq_RT.RowAnnotation, tmp];
    PRAD_RNAseq_RT.RowAnnotationFields(end+1) = {'RRMS Group'};
    save(fullfile(RNAseqDataDirectory,"PRAD_RNAseq_RT.mat"),"PRAD_RNAseq_RT");

end

% Calculate RRMS high vs low for RNAseq data
RESULTS_PRAD_RNAseq_RT_RRMS_HighVsLow = CalculateDiffResults(PRAD_RNAseq_RT,{'Low'},{'High'},'RRMS Group',[]);
save(fullfile(RNAseqResultDirectory,"RESULTS_PRAD_RNAseq_RT_RRMS_HighVsLow.mat"),"RESULTS_PRAD_RNAseq_RT_RRMS_HighVsLow");

% Write .rnk file for GSEA Preranked analysis
[fid,Msg] = fopen(fullfile(RNAseqResultDirectory,"RESULTS_PRAD_RNAseq_RT_RRMS_HighVsLow.rnk"),'w');
if fid == -1
    error('Could not create %s, reason: %s',fullfile(RNAseqResultDirectory,"RESULTS_PRAD_RNAseq_RT_RRMS_HighVsLow.rnk"),Msg)
end
indx_S2N = strcmp('Signal2Noise',RESULTS_PRAD_RNAseq_RT_RRMS_HighVsLow.ColId);
indx_GS = strcmp('Symbol',RESULTS_PRAD_RNAseq_RT_RRMS_HighVsLow.RowAnnotationFields);

for i=1:RESULTS_PRAD_RNAseq_RT_RRMS_HighVsLow.nRow
    fprintf(fid,'%s\t%g\n',RESULTS_PRAD_RNAseq_RT_RRMS_HighVsLow.RowAnnotation{i,indx_GS},RESULTS_PRAD_RNAseq_RT_RRMS_HighVsLow.X(i,indx_S2N));
end
fclose(fid);

%% SKCM

load(fullfile(DataDirectory,"SKCM_M450_RT.mat"),'SKCM_M450_RT')
load(fullfile(RNAseqDataDirectory,"SKCM_RNAseq_RT.mat"),'SKCM_RNAseq_RT')

if ~strcmp('RRMS Group',SKCM_RNAseq_RT.RowAnnotationFields)
    % Select 174 CpG-probes
    SKCM_M450_RT =  EditVariablesDATA(SKCM_M450_RT,SelectedCpG_probes,'Keep');

    % Calculate RRMS and select high and low samples
    RRMS = mean(SKCM_M450_RT.X,2,'omitnan');
    median_RRMS = median(RRMS);
    indx_low = RRMS<median_RRMS;
    indx_high = ~indx_low;
    indx_Participant = strcmp('Participant',SKCM_M450_RT.RowAnnotationFields);
    Participant_low = SKCM_M450_RT.RowAnnotation(indx_low,indx_Participant);
    Participant_high = SKCM_M450_RT.RowAnnotation(indx_high,indx_Participant);

    % Select samples with RNAseq data
    tmp = cell(SKCM_RNAseq_RT.nRow,1);
    tmp(:) = {'NA'};
    indx_h = ismember(SKCM_RNAseq_RT.RowAnnotation(:,5),Participant_high);
    indx_l = ismember(SKCM_RNAseq_RT.RowAnnotation(:,5),Participant_low);
    tmp(indx_h) = {'High'};
    tmp(indx_l) = {'Low'};
    SKCM_RNAseq_RT.RowAnnotation = [SKCM_RNAseq_RT.RowAnnotation, tmp];
    SKCM_RNAseq_RT.RowAnnotationFields(end+1) = {'RRMS Group'};
    save(fullfile(RNAseqDataDirectory,"SKCM_RNAseq_RT.mat"),"SKCM_RNAseq_RT");

end

% Calculate RRMS high vs low for RNAseq data
RESULTS_SKCM_RNAseq_RT_RRMS_HighVsLow = CalculateDiffResults(SKCM_RNAseq_RT,{'Low'},{'High'},'RRMS Group',[]);
save(fullfile(RNAseqResultDirectory,"RESULTS_SKCM_RNAseq_RT_RRMS_HighVsLow.mat"),"RESULTS_SKCM_RNAseq_RT_RRMS_HighVsLow");

% Write .rnk file for GSEA Preranked analysis
[fid,Msg] = fopen(fullfile(RNAseqResultDirectory,"RESULTS_SKCM_RNAseq_RT_RRMS_HighVsLow.rnk"),'w');
if fid == -1
    error('Could not create %s, reason: %s',fullfile(RNAseqResultDirectory,"RESULTS_SKCM_RNAseq_RT_RRMS_HighVsLow.rnk"),Msg)
end
indx_S2N = strcmp('Signal2Noise',RESULTS_SKCM_RNAseq_RT_RRMS_HighVsLow.ColId);
indx_GS = strcmp('Symbol',RESULTS_SKCM_RNAseq_RT_RRMS_HighVsLow.RowAnnotationFields);

for i=1:RESULTS_SKCM_RNAseq_RT_RRMS_HighVsLow.nRow
    fprintf(fid,'%s\t%g\n',RESULTS_SKCM_RNAseq_RT_RRMS_HighVsLow.RowAnnotation{i,indx_GS},RESULTS_SKCM_RNAseq_RT_RRMS_HighVsLow.X(i,indx_S2N));
end
fclose(fid);

%% BRCA

load(fullfile(DataDirectory,"BRCA_M450_RT.mat"),'BRCA_M450_RT')
load(fullfile(RNAseqDataDirectory,"BRCA_RNAseq_RT.mat"),'BRCA_RNAseq_RT')

if ~strcmp('RRMS Group',BRCA_RNAseq_RT.RowAnnotationFields)
    % Select 174 CpG-probes
    BRCA_M450_RT =  EditVariablesDATA(BRCA_M450_RT,SelectedCpG_probes,'Keep');

    % Calculate RRMS and select high and low samples
    RRMS = mean(BRCA_M450_RT.X,2,'omitnan');
    median_RRMS = median(RRMS);
    indx_low = RRMS<median_RRMS;
    indx_high = ~indx_low;
    indx_Participant = strcmp('Participant',BRCA_M450_RT.RowAnnotationFields);
    Participant_low = BRCA_M450_RT.RowAnnotation(indx_low,indx_Participant);
    Participant_high = BRCA_M450_RT.RowAnnotation(indx_high,indx_Participant);

    % Select samples with RNAseq data
    tmp = cell(BRCA_RNAseq_RT.nRow,1);
    tmp(:) = {'NA'};
    indx_h = ismember(BRCA_RNAseq_RT.RowAnnotation(:,5),Participant_high);
    indx_l = ismember(BRCA_RNAseq_RT.RowAnnotation(:,5),Participant_low);
    tmp(indx_h) = {'High'};
    tmp(indx_l) = {'Low'};
    BRCA_RNAseq_RT.RowAnnotation = [BRCA_RNAseq_RT.RowAnnotation, tmp];
    BRCA_RNAseq_RT.RowAnnotationFields(end+1) = {'RRMS Group'};
    save(fullfile(RNAseqDataDirectory,"BRCA_RNAseq_RT.mat"),"BRCA_RNAseq_RT");

end

% Calculate RRMS high vs low for RNAseq data
RESULTS_BRCA_RNAseq_RT_RRMS_HighVsLow = CalculateDiffResults(BRCA_RNAseq_RT,{'Low'},{'High'},'RRMS Group',[]);
save(fullfile(RNAseqResultDirectory,"RESULTS_BRCA_RNAseq_RT_RRMS_HighVsLow.mat"),"RESULTS_BRCA_RNAseq_RT_RRMS_HighVsLow");

% Write .rnk file for GSEA Preranked analysis
[fid,Msg] = fopen(fullfile(RNAseqResultDirectory,"RESULTS_BRCA_RNAseq_RT_RRMS_HighVsLow.rnk"),'w');
if fid == -1
    error('Could not create %s, reason: %s',fullfile(RNAseqResultDirectory,"RESULTS_SARC_RNAseq_RT_RRMS_HighVsLow.rnk"),Msg)
end
indx_S2N = strcmp('Signal2Noise',RESULTS_BRCA_RNAseq_RT_RRMS_HighVsLow.ColId);
indx_GS = strcmp('Symbol',RESULTS_BRCA_RNAseq_RT_RRMS_HighVsLow.RowAnnotationFields);

for i=1:RESULTS_BRCA_RNAseq_RT_RRMS_HighVsLow.nRow
    fprintf(fid,'%s\t%g\n',RESULTS_BRCA_RNAseq_RT_RRMS_HighVsLow.RowAnnotation{i,indx_GS},RESULTS_BRCA_RNAseq_RT_RRMS_HighVsLow.X(i,indx_S2N));
end
fclose(fid);

%% SARC

load(fullfile(DataDirectory,"SARC_M450_RT.mat"),'SARC_M450_RT')
load(fullfile(RNAseqDataDirectory,"SARC_RNAseq_RT.mat"),'SARC_RNAseq_RT')

if ~strcmp('RRMS Group',SARC_RNAseq_RT.RowAnnotationFields)
    % Select 174 CpG-probes
    SARC_M450_RT =  EditVariablesDATA(SARC_M450_RT,SelectedCpG_probes,'Keep');

    % Calculate RRMS and select high and low samples
    RRMS = mean(SARC_M450_RT.X,2,'omitnan');
    median_RRMS = median(RRMS);
    indx_low = RRMS<median_RRMS;
    indx_high = ~indx_low;
    indx_Participant = strcmp('Participant',SARC_M450_RT.RowAnnotationFields);
    Participant_low = SARC_M450_RT.RowAnnotation(indx_low,indx_Participant);
    Participant_high = SARC_M450_RT.RowAnnotation(indx_high,indx_Participant);

    % Select samples with RNAseq data
    tmp = cell(SARC_RNAseq_RT.nRow,1);
    tmp(:) = {'NA'};
    indx_h = ismember(SARC_RNAseq_RT.RowAnnotation(:,5),Participant_high);
    indx_l = ismember(SARC_RNAseq_RT.RowAnnotation(:,5),Participant_low);
    tmp(indx_h) = {'High'};
    tmp(indx_l) = {'Low'};
    SARC_RNAseq_RT.RowAnnotation = [SARC_RNAseq_RT.RowAnnotation, tmp];
    SARC_RNAseq_RT.RowAnnotationFields(end+1) = {'RRMS Group'};
    save(fullfile(RNAseqDataDirectory,"SARC_RNAseq_RT.mat"),"SARC_RNAseq_RT");

end

% Calculate RRMS high vs low for RNAseq data
RESULTS_SARC_RNAseq_RT_RRMS_HighVsLow = CalculateDiffResults(SARC_RNAseq_RT,{'Low'},{'High'},'RRMS Group',[]);
save(fullfile(RNAseqResultDirectory,"RESULTS_SARC_RNAseq_RT_RRMS_HighVsLow.mat"),"RESULTS_SARC_RNAseq_RT_RRMS_HighVsLow");

% Write .rnk file for GSEA Preranked analysis
[fid,Msg] = fopen(fullfile(RNAseqResultDirectory,"RESULTS_SARC_RNAseq_RT_RRMS_HighVsLow.rnk"),'w');
if fid == -1
    error('Could not create %s, reason: %s',fullfile(RNAseqResultDirectory,"RESULTS_SARC_RNAseq_RT_RRMS_HighVsLow.rnk"),Msg)
end
indx_S2N = strcmp('Signal2Noise',RESULTS_SARC_RNAseq_RT_RRMS_HighVsLow.ColId);
indx_GS = strcmp('Symbol',RESULTS_SARC_RNAseq_RT_RRMS_HighVsLow.RowAnnotationFields);

for i=1:RESULTS_SARC_RNAseq_RT_RRMS_HighVsLow.nRow
    fprintf(fid,'%s\t%g\n',RESULTS_SARC_RNAseq_RT_RRMS_HighVsLow.RowAnnotation{i,indx_GS},RESULTS_SARC_RNAseq_RT_RRMS_HighVsLow.X(i,indx_S2N));
end
fclose(fid);