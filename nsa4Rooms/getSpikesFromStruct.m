function [spike_times,spike_indexes]=getSpikesFromStruct(Rat_spike_struct,ind_Neuron,ind_part)
%% warning Rat_spike_struct
% spike_indexes=Rat_spike_struct.Neuron_table{ind_Neuron}.spike_index{ind_part};
spike_indexes=Rat_spike_struct.Neuron_table{ind_Neuron}.part_spike_index{ind_part};
spike_times  =Rat_spike_struct.Neuron_table{ind_Neuron}.spike_times{ind_part};

