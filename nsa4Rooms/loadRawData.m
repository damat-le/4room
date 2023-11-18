function [bdata_big,sdata_big]=loadRawData(data_dir)
% function [bdata_big,sdata_big]=loadRawData(data_dir)
% data_path='~/DATA/4ROOMS/Analysed Data 20200514/;
% data_version='20200513';
%data_version='20200514';   % last
% data_version='20200421';  % version of the pca analysis
% data_dir=['../Analysed Data ' data_version '/'];
if ~exist('bdata_big','var')
    nf_bdata='quaddata_bdata_big';
%     nf_bdata='bdata_big';
    
    nf=[data_dir, nf_bdata];
    t=tic; fprintf('loading %s\n',nf);
    f1=load(nf);
    bdata_big=f1.bdata_big;
    fprintf('Done: Time Elamsed %g s\n',toc(t));
end
if ~exist('sdata_big','var')
    nf_sdata='quaddata_sdata_big';
    nf=[data_dir, nf_sdata];
    t=tic; fprintf('loading %s\n',nf);
    
    try
        f2=load(nf);
    catch
        fprintf('Warning: cannot load from pcloud\n');
        bdir=['D:\Analysed Data ' data_version '\'];
        nf=[bdir,nf_sdata];
        fprintf('loading %s\n',nf);
        f2=load(nf);
    end
    sdata_big=f2.sdata_big;
    fprintf('Done: Time Elamsed %g s\n',toc(t));
end