function Sout=events_capture(Rat_spike_struct,Rat_pos_struct,session_name,ind_part,params)
%% function Sout=events_capture(Rat_spike_struct,Rat_pos_struct,session_name,ind_part,params)

% ind_part=1;
VARIABLES_FourRooms;
sessions=Rat_pos_struct.sessions;
ind_sess=find(strcmp(sessions,session_name));
% hfig=nan;
try
    ifplot=params.if_plot;
catch
    ifplot=1;
end
try
    save_dir=params.root_dir;
catch
    save_dir=sprintf('../FIGURES/%s/KNOCKS/%s/',Rat_spike_struct.Rat_name,[session_name,parts(ind_part)]);
end
try
    initial_ev=params.start;
catch
    initial_ev=1;
end
try
    dt=params.dt;  %% duration of the interval
catch
    dt=1.5;
end
try
    sas=params.after; %% after event in seconds
catch
    sas=0;
end
try
    show_behaviour=params.show_behaviour;
catch
    show_behaviour=0;
end
try
    debug_mode=params.debug_mode;
catch
    debug_mode=0;
end

Rat_Spike_Struct_session   =getNeuronFromSession(Rat_spike_struct,session_name);

behaviour =Rat_pos_struct.position_table{ind_sess}.behaviour_index{ind_part};
[positions,time,~,speed, acceleration]           =getPositionsFromStruct(Rat_pos_struct,session_name,ind_part);

event_indexes=params.event_indexes;

N_neurons=length(Rat_Spike_Struct_session.NeuronName);

   
if ~isfolder(save_dir)
    mkdir(save_dir);
end

event_flag_times =time(event_indexes);
    
N_events=length(event_flag_times); %% number of events
fprintf('Session %s: Total trials %g\n',[sessions{ind_sess} parts(ind_part)],N_events);
    
%% save directories
save_spike_dir=[save_dir '/SPIKES/'];
if ~isfolder(save_spike_dir)
    mkdir(save_spike_dir);
end
save_traj_dir=[save_dir '/TRAJ/'];
if ~isfolder(save_traj_dir)
    mkdir(save_traj_dir);
end
png_dir=[save_traj_dir '/PNG/'];
if ~isfolder(png_dir)
    mkdir(png_dir);
end
    
%% split per event

we=initial_ev:N_events;
    
% we=1;
% sbs=zeros(N_events,1)-2; %seconds before
% sas=sbs+dt;              %seconds after
sbs=sas-dt;
t=cell(N_events,N_neurons);
exclude_trials=false(size(we));

%    =length(0+min(diff(time)):min(diff(time)):dt);
Time_Steps   =round(dt/mean(diff(time)));
sout_X       =nan(N_events,Time_Steps);
sout_Y       =nan(N_events,Time_Steps);
sout_time    =nan(N_events,Time_Steps);
sout_interval=nan(N_events,2);
sout_V       =nan(N_events,Time_Steps);
sout_A       =nan(N_events,Time_Steps);
% t            =nan(N_events,Time_Steps);

for ind_trial=we
    if ind_trial < 10
        add='0';
    else
        add='';
    end

    interval=[event_flag_times(ind_trial)+sbs,event_flag_times(ind_trial)+sas];

    war='';
    
    sel_indexes      =time>=interval(1)&time<interval(end);
    if sum(sel_indexes)<Time_Steps
        exclude_trials(ind_trial)=true;
        war=[war, '_NO_TIME'];
    end
    
    S           =getSpikeForRasterPlor(Rat_Spike_Struct_session,interval,ind_part);
    if isempty([S.t{:}])
        exclude_trials(ind_trial)=true;
        war=[war, '_NO_SPIKES'];
    end
    append_string=sprintf('TRIAL%s%g%s',add,ind_trial,war);
        
    %continue; end
    if ifplot
        
        %% plot spikes rasters
        hfig=figure;
        PlotSpikeRaster_mod([],S);
        p=[0,0,5500,400];
        set(hfig,'visible','off');
        set(hfig, 'PaperPositionMode','auto');
        set(hfig,'Position',p);
        nf=sprintf('spikes_%s_%s%s',Rat_Spike_Struct_session.Rat_name,[session_name parts(ind_part)],append_string);

        fprintf('Saving %s\n',[save_spike_dir '/' nf]);
        print(hfig,[save_spike_dir '/' nf],'-depsc2')
        print(hfig,[save_spike_dir '/' nf],'-dpng')
    end
    %% plot positions
    current_behaviour=behaviour(sel_indexes);
    sel_time         =time(sel_indexes);
    sel_positions    =positions(sel_indexes,:);
    sel_speed        =speed(sel_indexes);
    sel_acceleration =acceleration(sel_indexes);
    
    if show_behaviour
        hfig=figure;plot(time(sel_indexes),current_behaviour,'ko');hfig.Children.YTick=unique(behaviour);hfig.Children.YTickLabel=BEHAVIOURS; 
        xlim([min(time(sel_indexes)),max(time(sel_indexes))])
    end
    
    if ifplot
        %% plot trial trajectories
        wb              =logical([1,1]);
        Xd              =sel_positions(current_behaviour==direct,1);
        Yd              =sel_positions(current_behaviour==direct,2);
        Xf              =sel_positions(current_behaviour==foraging,1);
        Yf              =sel_positions(current_behaviour==foraging,2);

        hfig=figure; hold on; box on; grid on;

        plot_raw_positions(positions);   
        cmaps=[ones(1,3)*0;                     %% direct 
               ones(1,3)*0.5];%[0.9,0.2,0.2]];  %% foraging

        h_traj_direct   =plot(Xd,Yd,'Color',cmaps(1,:), 'linewidth', 8);
        h_traj_foraging =plot(Xf,Yf,'Color',cmaps(2,:), 'linewidth', 8);

        if isempty(h_traj_direct)
            wb(1)=0;
        end
        if isempty(h_traj_foraging)
            wb(2)=0;
        end

        h_traj_direct2  =plot(Xd,Yd,'.','Color',cmaps(1,:),'markersize',30);
        h_traj_foraging2=plot(Xf,Yf,'.','Color',cmaps(2,:),'markersize',30);

        h_traj=[h_traj_direct, h_traj_foraging];

        [hNeu,~,hstart,hend,leg_str]=plot_positions(sel_time,sel_positions,interval,Rat_Spike_Struct_session,ind_part,[1,1],[]);

        start_string=sprintf('Start(%gs)',interval(1));
        end_string  =sprintf('End  (%gs)',interval(2));

        xlim([min(positions(:,1)),max(positions(:,1))]);
        ylim([min(positions(:,2)),max(positions(:,2))]);
        uistack(hstart,'top');
        uistack(hend,'top');
        legend([hstart,hend,hNeu,h_traj],[start_string,end_string,leg_str,BEHAVIOURS{wb}],'Location','WestOutside');
    %         p=round([0,0,1000,600]*0.6);
    %     pause;
        p=round([0,0,1000,600]*0.8);
        title(['Trial' num2str(ind_trial)]);
        if debug_mode
            pause;
            return
        end
        
        set(hfig,'visible','off');
        set(hfig, 'PaperPositionMode','auto');
        set(hfig,'Position',p);

        nf=sprintf('traj_%s_%s%s',Rat_Spike_Struct_session.Rat_name,[session_name parts(ind_part)],append_string);
        fprintf('Saving %s\n',[save_traj_dir '/' nf]);
        print(hfig,[save_traj_dir '/' nf],'-depsc2')
        print(hfig,[save_traj_dir '/' nf],'-dpng')
        print(hfig,[png_dir '/' nf],'-dpng')
        
    end
%     if ind_trial==2 || ind_trial==1
%         pause;
%     else
%     end
    if ~exclude_trials(ind_trial)
        sout_X(ind_trial,:)       =sel_positions(:,1);
        sout_Y(ind_trial,:)       =sel_positions(:,2);
        sout_time(ind_trial,:)    =sel_time;
        sout_interval(ind_trial,:)=interval;
        sout_V(ind_trial,:)       =sel_speed;
        sout_A(ind_trial,:)       =sel_acceleration;
        t(ind_trial,:)            =S.t;
    end
%     Trials.S.t(ind_trial,:) =S.t;
%     Trials.S.labels(ind_trial) =S.t;

    
end
sout_X(exclude_trials,:)       =[];
sout_Y(exclude_trials,:)       =[];
sout_time(exclude_trials,:)    =[];
sout_interval(exclude_trials,:)=[];
sout_V(exclude_trials,:)       =[];
sout_A(exclude_trials,:)       =[];
t(exclude_trials,:)            =[];
%  

Sout.label    =S.label;
Sout.interval =sout_interval;
Sout.time     =sout_time;
Sout.t        =t;
Sout.X        =sout_X;
Sout.Y        =sout_Y;
Sout.V        =sout_V;
Sout.A        =sout_A;

convertEPS2PDF({save_spike_dir});
convertEPS2PDF({save_traj_dir});
% convertEPS2PSD_cell({save_spike_dir});
% convertEPS2PSD_cell({save_traj_dir});
close all;
end   
