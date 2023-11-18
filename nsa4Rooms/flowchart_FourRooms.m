pathsLoad_FourRooms;
VARIABLES_FourRooms;

%% load sdata_big (spikes) and bdata_big (positions)
loadRawData;

Rat_name='r35'; session_name='S8';
%% get spike structre for the selected rat
Rat_spike_struct= buildSpikeStructure_FourRooms(sdata_big,Rat_name);

%% get position structure for the selected rat
Rat_pos_struct  = buildPositionStructure_FourRooms(bdata_big,Rat_name);

%% get spikes of the session 
% Rat_Spike_Struct_session=getNeuronFromSession(Rat_spike_struct,session_name);

%%
% AllNeuronIdentity=Rat_Spike_Struct_session.NeuronName;
return
event_to_plot=DA_open_attempt;
ind_part=1;
resync_event=EVENT_DELAY.(Rat_name).([session_name parts(ind_part)]).(['EV' DA_open_attempt]);

Sout=plot_DOOR_KNOCKS(Rat_spike_struct,Rat_pos_struct,session_name,ind_part,event_to_plot,resync_event,0);

% dat=prepare_trials(Sout);
% dat_name='r35_S8a';
% prepare_mats(dat,dat_name,mats_dir,[0,1500],20,1);
datS8a=prepare_trials(Sout);


%%
ind_part=4;
resync_event=EVENT_DELAY.(Rat_name).([session_name parts(ind_part)]).(['EV' DA_open_attempt]);
Sout=plot_DOOR_KNOCKS(Rat_spike_struct,Rat_pos_struct,session_name,ind_part,event_to_plot,resync_event,0);

N_Trials=size(Sout.t,1);
condition=ones(N_Trials,1)*2;
datS8d=prepare_trials(Sout,condition);

dat=[datS8a,datS8d];
dat_name='r35_S8a_S8d';
mats_dir='../MATS/';
prepare_mats(dat,dat_name,mats_dir,[0,1500],20,1);

return
%% plot all trials
% PlotSpikeRaster_mod([],Sout);

%% plot binned trials
% cfg.freqTheta=8;
% cfg.ifmean=1;
% cfg.newfigure=1;
% Sout.tvec=[0,1.5]; %% interval in seconds
% PlotSpikeRaster_mod(cfg,Sout);


% dat=S.dat;
% dat    =convertDatToFrequency(dat,[0,1500],20,1);
% meandat=convertDatToFrequency_MeanLabels(dat,[0,1500],20,1);


saveTESTS_FourRooms;

func_name=str2func('loadTEST_FourRooms');
runIdx=2;%runIdx=1;
[params, seqTrain, seqTest, explained]=main_test_NeuralSpace(runIdx,func_name);

keep=1:2;%keep=1;
cmaps=linspecer(length(keep));
cmapslight=lightCmaps(cmaps);
legplot=1;
out=plot_EachDimVsTime_mean(seqTest, keep, explained, cmaps, cmapslight, legplot, {'r35 S8a OPEN','CLOSE'}, params,0,1500);

return
%% plot knocks trials
main_plot_door_knocks(Rat_spike_struct,Rat_pos_struct,session_name,ind_part);
%% plot bells trials
main_plot_bell_rings(Rat_spike_struct,Rat_pos_struct,session_name,ind_part);

%% plot all bells
main_plot_bell_to_bells(Rat_spike_struct,Rat_pos_struct,session_name,ind_part);


return
%% get sessions names
sessions=Rat_pos_struct.sessions;
which_sessions=1:length(sessions);
which_parts=1:5;



if 0
    for ind_Sess=which_sessions
        %% choose a session
        session_name=sessions{ind_Sess};

        %% get spikes for the chosen session
        Rat_Spike_Struct_session=getNeuronFromSession(Rat_spike_struct,session_name);

        %% create pdf for neuron ratemaps
        [save_dirs, fakes]=plot_rate_maps (Rat_Spike_Struct_session,root_dir); convertEPS2PSD_cell(save_dirs);

        for part=which_parts
            %% create pdf of sessions per part 
            s=latexCompile_FourRooms(Rat_name,session_name,part,root_dir);
        end
    end
end

%% get part and session position
session_name='S8'; ind_part=1;
%% spikes for session/part in the selected interval
dt=10;
start=1000;
interval=[start,start+dt;];

sample_spike_position_plot(Rat_spike_struct,Rat_pos_struct,session_name,ind_part,interval);


printSessionStatus(Rat_pos_struct); %%% print session ports
% Session S8
% a=all doors open
% b=all doors open
% c=DC-CD doors closed
% d=DC-CD doors closed
% e=all doors open

%% get part and session position
session_name='S8'; ind_part=1;

[event_flag_times, event_flag_values]=getEventsFromStruct(Rat_pos_struct,session_name,ind_part);
DA_opens=event_flag_times((strcmp(event_flag_values,DA_open_attempt)));

dt=10;
start=DA_opens(2)-15;
interval=[round(start),round(start)+dt;];

sample_spike_position_plot(Rat_spike_struct,Rat_pos_struct,session_name,ind_part,interval);


plot_visits(Rat_pos_struct,session_name,ind_part);
return
N_neurons=length(Rat_Spike_Struct_session.NeuronName);
for ind_Neuron=1:N_neurons
    [spike_times,spike_indexes]=getSpikesFromStruct(Rat_Spike_Struct_session,ind_Neuron,ind_part);
    S.t{1,ind_Neuron}=spike_times';
    S.label{1,ind_Neuron}=Rat_Spike_Struct_session.NeuronName{ind_Neuron};
end

cfg.freqTheta=8;
cfg.ifmean=0;
cfg.nTrials=1;

S.tvec=dt;

PlotSpikeRaster_mod(cfg,S);
return


indNeuron=1;
Rat_spike_struct.Neuron_table{1}.part{3}

bdata_big_Rat        =bdata_big(strcmp(bdata_big{:,i_Rat},Rat_name),:);
bdata_big_Rat{:,8}{1}

% strcmp(bdata_big{:,i_session},)
sessions = unique(bdata_big{:,i_session});
sessions_with_parts=bdata_big{:,ind_session};
idx = ismember(sdata.uci,uci) & ismember(sdata.part,part_now);
    
 ppox = pdata.(part_now).pox; % position data for this part
    ppoy = pdata.(part_now).poy;
    ppot = pdata.(part_now).pot; 
    pspx = pdata.pox(sdata.spike_index{idx}); % the spike positions are retrieved using the spike times and part positions
    pspy = pdata.poy(sdata.spike_index{idx});
    pspt = sdata.spike_times{idx};

    % plot position data as a grey line and spikes as red dots
    figure;
    plot(ppox(:),ppoy(:),'Color',[.5 .5 .5]); 
    hold on;
    plot(pspx,pspy,'ro','MarkerFaceColor','r','MarkerSize',3)    
    daspect([1 1 1])
    axis xy off square tight
%% ################################################################# %% Examples
%% Example 1, plotting the position data and spikes for a specific cluster in a specific part
    % the easiest way to index into sdata is using the cell UCI and the part name
    % for instance we might be interested in a cell with the uci: RAT.10122020.10.1 
    % in the part named 'part1'
    % in which case:
    
    i_Rat        =    1;
    i_Uci        =    5;
    i_spike_times=   10;
    i_spike_index=    8;
    i_part       =    4;
    i_rate_map   =   27;
    Rat35_name   ='r35';
    
    sdata_big_Rat35          =sdata_big(strcmp(sdata_big{:,i_Rat},Rat35_name),:);
    distinct_ucies_Rat35     =unique(sdata_big_Rat35{:,i_Uci});
    NeuronNumber_Rat35       =length(distinct_ucies_Rat35);
    
    ind_Neuron=1;
    
    
    NeuronName_Rat35         =distinct_ucies_Rat35{ind_Neuron};
    sdata_big_Rat35_Neuron{ind_Neuron}=sdata_big_Rat35(strcmp(sdata_big_Rat35{:,i_Uci},NeuronName_Rat35),:);
    
    for ind_p=1:5
        ind_p
%         rate_map_Rat35_Neuron=sdata_big_Rat35_Neuron{ind_Neuron}{ind_p,i_rate_map}{1};

%         hfig=plot_rate_map(rate_map_Rat35_Neuron);

%         save_dir=sprintf('%s',Rat35_name);
%         nf = sprintf('Ratemap_%s_Part%g_%s.eps',NeuronName_Rat35,ind_p,part{ind_p});
%         print (hfig,'-depsc2',[save_dir nf])
%         close all;
    end
    
    
    pspt                     =sdata_big_Rat35_Neuron{1}{1,i_spike_times}{1};
    
    i_pspt                   =sdata_big_Rat35_Neuron{1}{1,i_spike_index}{1};
    
    bdata_big_Rat35          =bdata_big(strcmp(bdata_big{:,i_Rat},Rat35_name),:);
    
    
    
    part{ind_p}=sdata_big_Rat35_Neuron{ind_Neuron}{ind_p,i_part}{1};
    
    bdata_big_Rat35_part=bdata_big_Rat35(strcmp(bdata_big_Rat35{:,i_part},part{ind_p}),:);
    
%     rate_map_Rat35_Neuron=sdata_big_Rat35_Neuron{ind_Neuron}{ind_p,i_rate_map}{1};
%     hfig=plot_rate_map(rate_map_Rat35_Neuron);
    
%     save_dir=sprintf('%s',Rat35_name);
%     nf = sprintf('Ratemap_%s_Part%g_%s.eps',NeuronName_Rat35,ind_p,part{ind_p});
%     print (hfig,'-depsc2',[save_dir nf])