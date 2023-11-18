function Sout=plot_BELL_RINGS(Rat_spike_struct,Rat_pos_struct,session_name,ind_part,sas,dt_in_s,if_plot,root_dir,debug_params)
% ind_part=1;
VARIABLES_FourRooms;
sessions=Rat_pos_struct.sessions;
ind_sess=find(strcmp(sessions,session_name));
try
    dt=dt_in_s;
catch
    dt=1.5;
end
% hfig=nan;
try
    ifplot=if_plot;
catch
    ifplot=1;
end

correct_bell_index=Rat_pos_struct.position_table{ind_sess}.correct_bell_index{ind_part};

b1     =[correct_bell_index{:,1}];
b2     =[correct_bell_index{:,2}];

bells_flag_times  =unique([b1,b2]);
N_bells=length(bells_flag_times);
if length(b1)+1==N_bells
    fprintf('Number of bells ok!\n');
else
    fprintf('Expected % bells, found %g! press a key to continue\n',length(b1)+1,N_bells); pause;
end


% N_bell_segments=size(correct_bell_index,1);
% column 1: 1st bell time (trial start)
% column 2: 2nd bell time (trial end)
% column 3: 1st compartment (box at start/when bell happens)
% column 4: 2nd compartment (box at end/rewarded box)   
% column 5: error messages as a formatted string
% column 6: 1st foraging compartment
% column 7: 1st foraging correct or not
% column 8: Time between bell and foraging in the correct compartment                
% column 9: Time between bell and moving to a new (any) compartment
% column 10: Average speed 1s before the bell
% column 11: Average speed 1s after the bell
% column 12: 1st door push choice after the bell
% column 13: Time of the 1st door push choice after the bell
% column 14: Time between the bell and 1st door push
% column 15: Shortest path the rat could have taken to correct box
% column 16: Optimal door the rat should have pushed on
% column 17: 1st push optimal or not 


% t_starts  = cell2mat(correct_bell_index(:,1));
% ptimes    = cell2mat(correct_bell_index(:,13));       
% t_ends    = cell2mat(correct_bell_index(:,2));        

where_am_I       =[comps([correct_bell_index{:,3}]) ,{''}];
where_is_the_bell=[comps([correct_bell_index{:,4}]) ,{''}];


behaviour =Rat_pos_struct.position_table{ind_sess}.behaviour_index{ind_part};
[positions,time]           =getPositionsFromStruct(Rat_pos_struct,session_name,ind_part);

Rat_Spike_Struct_session   =getNeuronFromSession(Rat_spike_struct,session_name);

N_neurons=length(Rat_Spike_Struct_session.NeuronName);


try
%     debug_mode=debug_params.debug_mode;
    show_behaviour=debug_params.show_behaviour;
    initial_ev    =debug_params.initial_ev;
    debug_mode=1;
catch
    debug_mode=0;
    initial_ev=1;
    show_behaviour=0;
end
th=1; th=0.2; %th=0;
    
try
    save_dir=root_dir;
catch
    save_dir=sprintf('../FIGURES/%s/BELLS/%s/',Rat_Spike_Struct_session.Rat_name,[session_name,parts(ind_part)]);
end
if ~isfolder(save_dir)
    mkdir(save_dir);
end



good_events      =~isnan(sas);
if length(good_events)>N_bells
    good_events=good_events(1:N_bells);
end
bells_flag_times =bells_flag_times(good_events);
where_am_I       =where_am_I(good_events);
where_is_the_bell=where_is_the_bell(good_events);
sas              =sas(good_events);


    
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
    

    
% we=1;
% sbs=zeros(N_events,1)-2; %seconds before
% sas=sbs+dt;              %seconds after
sbs=sas-dt;
good_events=true(N_bells,1);
for ind_trial=1:N_bells
    interval         =[bells_flag_times(ind_trial)+sbs(ind_trial),bells_flag_times(ind_trial)+sas(ind_trial)];    
    sel_indexes      =time>=interval(1)&time<interval(end);
   
    if ind_trial==1
        T_length     =sum(sel_indexes);
    else
        if T_length~=sum(sel_indexes)
            good_events(ind_trial)=false;
            fprintf('Warning: skipping Trial %g\n',ind_trial);
            
        end
    end
end

bells_flag_times =bells_flag_times(good_events);
where_am_I       =where_am_I(good_events);
where_is_the_bell=where_is_the_bell(good_events);
sas              =sas(good_events);
N_bells          =length(bells_flag_times);
bell_strings     =printBells(bells_flag_times,where_am_I, where_is_the_bell,0);
    
fprintf('Session %s: Total trials %g\n',[sessions{ind_sess} parts(ind_part)],N_bells);
    
printBells(bells_flag_times,where_am_I, where_is_the_bell);

% ind=0;
% 
% ind=ind+1;sas(ind)=-6;  sbs(ind)=sas(ind)-dt; % Trial 01
% ind=ind+1;sas(ind)=-6;  sbs(ind)=sas(ind)-dt; % Trial 02
% ind=ind+1;sas(ind)=-2;  sbs(ind)=sas(ind)-dt; % Trial 03
% ind=ind+1;sas(ind)=-1.9;sbs(ind)=sas(ind)-dt; % Trial 04
% ind=ind+1;sas(ind)=-3.5;sbs(ind)=sas(ind)-dt; % Trial 05
% ind=ind+1;sas(ind)=-3.2;sbs(ind)=sas(ind)-dt; % Trial 06
% ind=ind+1;sas(ind)=-1;  sbs(ind)=sas(ind)-dt; % Trial 07
% ind=ind+1;sas(ind)=-1;  sbs(ind)=sas(ind)-dt; % Trial 08
% ind=ind+1;sas(ind)=-1.5;sbs(ind)=sas(ind)-dt; % Trial 09
% ind=ind+1;sas(ind)=-2.3;sbs(ind)=sas(ind)-dt; % Trial 10
% ind=ind+1;sas(ind)=-1.5;sbs(ind)=sas(ind)-dt; % Trial 11
% ind=ind+1;sas(ind)=-2;  sbs(ind)=sas(ind)-dt; % Trial 11


t            =cell(N_bells,N_neurons);
sout_X       =nan(N_bells ,T_length);
sout_Y       =nan(N_bells ,T_length);
sout_time    =nan(N_bells ,T_length);
sout_interval=nan(N_bells ,2);

%% split per event
we=initial_ev:N_bells;

for ind_trial=we
    if ind_trial < 10
        add='0';
    else
        add='';
    end

    interval         =[bells_flag_times(ind_trial)+sbs(ind_trial),bells_flag_times(ind_trial)+sas(ind_trial)];
    
    sel_indexes      =time>=interval(1)&time<interval(end);
    
    %% plot spike rasters
    S           =getSpikeForRasterPlor(Rat_Spike_Struct_session,interval,ind_part);
    
    if ifplot
        hfig=figure;
        PlotSpikeRaster_mod([],S);
        p=[0,0,5500,400];
        set(hfig,'visible','off');
        set(hfig, 'PaperPositionMode','auto');
        set(hfig,'Position',p);
        append_string=sprintf('TRIAL%s%g',add,ind_trial);
        nf=sprintf('spikes_%s_%s%s',Rat_Spike_Struct_session.Rat_name,[session_name parts(ind_part)],append_string);

        fprintf('Saving %s\n',[save_spike_dir '/' nf]);
        print(hfig,[save_spike_dir '/' nf],'-depsc2')
        print(hfig,[save_spike_dir '/' nf],'-dpng')
    end
    %% plot positions
    current_behaviour=behaviour(sel_indexes);
    sel_time         =time(sel_indexes);
    sel_positions    =positions(sel_indexes,:);

    if show_behaviour
        hfig=figure;plot(time(sel_indexes),current_behaviour,'ko');hfig.Children.YTick=unique(behaviour);hfig.Children.YTickLabel=BEHAVIOURS; 
        xlim([min(time(sel_indexes)),max(time(sel_indexes))])
    end

    
    
    if ifplot
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
%             pause;
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
    sout_X(ind_trial,:)       =sel_positions(:,1);
    sout_Y(ind_trial,:)       =sel_positions(:,2);
    sout_time(ind_trial,:)    =sel_time;
    sout_interval(ind_trial,:)=interval;
%     Trials.S.t(ind_trial,:) =S.t;
%     Trials.S.labels(ind_trial) =S.t;

    t(ind_trial,:)=S.t;
end
Sout.label    =S.label;
Sout.interval =sout_interval;
Sout.time     =sout_time;
Sout.t        =t;
Sout.X        =sout_X;
Sout.Y        =sout_Y;

convertEPS2PSD_cell({save_spike_dir});
convertEPS2PSD_cell({save_traj_dir});
close all;
end   
