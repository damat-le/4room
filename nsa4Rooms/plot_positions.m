function [hNeu,h_traj,hstart,hend,leg_str]=plot_positions(time,positions,interval,Rat_Spike_Struct_session,ind_part,add_start_end,col_trajectory,cmap_neurons)
hold on; box on; grid on;

sel_indexes=time>interval(1)&time<interval(end);
X=positions(sel_indexes,1);
Y=positions(sel_indexes,2);
% h_traj_all=plot(X,Y,'Color',[1,0.2,0.2],'linewidth',2);

try
    plottraj=plot_traj;
catch
	plottraj=1;
end

%% 
try
    col_traj=col_trajectory;
catch
    col_traj=ones(1,3)*0.4;% [1,0.2,0.2]
end
if ~isempty(col_traj)
    % h_traj=plot(X,Y,'Color',col_traj,'linewidth',8);
    h_traj=plot(X,Y,'.','Color',col_traj,'markersize',35);
else
    h_traj=nan;
end

N_neurons=length(Rat_Spike_Struct_session.NeuronName);
try
    cmaps=cmap_neurons;
catch
    cmaps=linspecer(N_neurons);
end
hNeu=[]; toplot=ones(N_neurons,1);
for ind_Neuron=1:N_neurons
    spike_times=getSpikesFromStruct(Rat_Spike_Struct_session,ind_Neuron,ind_part);

    sel_logical=spike_times>interval(1) & spike_times< interval(2);    
    pos=interp1(time,positions,spike_times(sel_logical));
    
   
%     pos_i=all_positions(spike_index(sel_logical),:);
%     abs(pos-pos_i)
%     pause
    if sum(sel_logical)==0
        if isempty(spike_times)
            fprintf('Neuron %g: %s all session empty spikes\n',ind_Neuron,Rat_Spike_Struct_session.NeuronName{ind_Neuron});
        elseif isempty(pos)
            
            fprintf('Neuron %g: %s empty spike in position \n',ind_Neuron,Rat_Spike_Struct_session.NeuronName{ind_Neuron});
        end
        toplot(ind_Neuron)=0;
        continue;
    end
    hN=plot(pos(:,1),pos(:,2),'.','Color',cmaps(ind_Neuron,:),'markersize',8);
    if isempty(hN)
        toplot(ind_Neuron)=0;
    else
        hNeu(end+1)=hN;
    end
%     fprintf('Neuron %g\n',ind_Neuron);

%     hNeu(ind_Neuron)=hN;
end

toplot=logical(toplot);
% xlim([min(positions(:,1)),max(positions(:,1))]);
% ylim([min(positions(:,2)),max(positions(:,2))]);
leg_str=[Rat_Spike_Struct_session.NeuronName(toplot)'];
try
    add_start_end_=add_start_end;
catch
    add_start_end_=[1,1];
end
if length(add_start_end_)>0
    hstart=plot(X(1),  Y(1),  'ko','markersize',8,'linewidth',4);
    hend  =plot(X(end),Y(end),'ks','markersize',8,'linewidth',5);
    if ~add_start_end_(1)
        set(hstart,'Visible','off')
    end
    if ~add_start_end_(2)
        set(hend,'Visible','off')
    end
    legend([hstart,hend,hNeu],['start','end',leg_str],'Location','WestOutside');
else
    legend(hNeu,leg_str,'Location','WestOutside');
end