function main_plot_bell_rings(Rat_spike_struct,Rat_pos_struct,session_name,ind_part,fig_directory)
%% 
try
    fig_dir=fig_directory;
catch
	fig_dir='../FIGURES/';
end
VARIABLES_FourRooms;
Rat_name      =Rat_pos_struct.Rat_name;

folder        =[fig_dir Rat_name '/BELLS/' session_name parts(ind_part)  '/'];
save_spike_dir=[folder '/SPIKES/'];
save_traj_dir =[folder '/TRAJ/'];

if 1

% root_dir=sprintf('%s/%s/KNOCKS/%s/',fig_dir,Rat_name,[session_name,parts(ind_part)]);
sas=zeros(20,1)+BELL_T_AFTER;
% dt=1.5;
dt=BELL_T_DELTA;
Trials=plot_BELL_RINGS(Rat_spike_struct,Rat_pos_struct,session_name,ind_part,sas,dt,1,folder);
% Trials=plot_BELL_RINGS(Rat_spike_struct,Rat_pos_struct,session_name,ind_part,resync_event,1,1,folder);

mat_dir='../MATS/';
nf=sprintf('%s/Trials_Bells_%s_%s',mat_dir,Rat_name,[session_name parts(ind_part)]);
fprintf('Saving %s\n',nf);
save(nf,'Trials');

%% plot all trials
N_Trials      =size(Trials.t,1);
if N_Trials< 10
    add='0';
else
    add='';
end
hfig=figure;
[~, plotted_neurons]=PlotSpikeRaster_mod([],Trials);
p=[0,0,5500,400];
set(hfig,'visible','off');
set(hfig,'PaperPositionMode','auto');
set(hfig,'Position',p);
append_string=sprintf('TRIAL_ALL%s%g',add,N_Trials);
nf=sprintf('spikes_%s_%s%s',Rat_name,[session_name parts(ind_part)],append_string);

fprintf('Saving %s\n',[save_spike_dir '/' nf]);
print(hfig,[save_spike_dir '/' nf],'-depsc2')
print(hfig,[save_spike_dir '/' nf],'-dpng')



end % end 1

convertEPS2PSD_cell({save_spike_dir});

out_dir=[fig_dir Rat_name '/BELLS/'];

% folder=[fig_dir Rat_name '/KNOCKS/' session_name parts(ind_part)  '/'];

% source_dir=[folder '/SPIKES/'];
params.wm=200; params.N_subfigures=1; params.file_type   ='pdf';
latexCompile_FourRooms_plus(save_spike_dir,out_dir,params);

latexCompile_FourRooms_plus(save_traj_dir,out_dir);
params.wm          =100; params.N_subfigures=  4; params.file_type   ='png';
latexCompile_FourRooms_plus([save_traj_dir '/PNG/'],out_dir,params);



which_neurons=find(plotted_neurons'); selection_name='RATEMAPS_TRIAL';
save_maps_dir=plot_rate_maps_knocks (Rat_spike_struct,session_name,ind_part,fig_dir,selection_name,which_neurons); convertEPS2PSD_cell({save_maps_dir});
latexCompile_FourRooms_plus(save_maps_dir,out_dir);

which_neurons=find(~plotted_neurons'); selection_name='RATEMAPS_EXCLUDED';
save_maps_dir=plot_rate_maps_knocks (Rat_spike_struct,session_name,ind_part,fig_dir,selection_name,which_neurons); convertEPS2PSD_cell({save_maps_dir});
latexCompile_FourRooms_plus(save_maps_dir,out_dir);

end
