function [S, sel_indexes]=getSpikeForRasterPlor(Rat_Spike_Struct_session,interval,ind_part)
%% interval
% dt=10;
% start=100;
% interval=[start,start+dt;];
min_max=[];
N_neurons=length(Rat_Spike_Struct_session.NeuronName);
for ind_Neuron=1:N_neurons
    [spike_times,spike_indexes]=getSpikesFromStruct(Rat_Spike_Struct_session,ind_Neuron,ind_part);
    sel_logical=spike_times>interval(1) & spike_times< interval(2);    
    s_i=spike_indexes(sel_logical);
    min_max=[min([min_max,min(s_i)]),max([min_max,max(s_i)])];
    
    S.t{1,ind_Neuron}=spike_times(sel_logical)';
    S.label{1,ind_Neuron}=Rat_Spike_Struct_session.NeuronName{ind_Neuron};
end
if isempty(min_max) 
    sel_indexes=[];
else
    sel_indexes=min(min_max):max(min_max);
end


% cfg.freqTheta=8;
% cfg.ifmean=0;
% cfg.nTrials=1;
% 
% dt=10;
% S.tvec=dt;
