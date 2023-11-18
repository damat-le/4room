function Rat_Spike_Struct_session=getNeuronFromSession(Rat_Spike_Struct,session_name)
% function Rat_Spike_Struct_session=getNeuronFromSession(Rat_Spike_Struct)

inds=strcmp(Rat_Spike_Struct.Neuron_session,session_name);


Rat_Spike_Struct_session.NeuronName     =Rat_Spike_Struct.NeuronName(inds);
Rat_Spike_Struct_session.Neuron_table   =Rat_Spike_Struct.Neuron_table(inds);
Rat_Spike_Struct_session.Neuron_session =Rat_Spike_Struct.Neuron_session(inds);
Rat_Spike_Struct_session.Rat_name       =Rat_Spike_Struct.Rat_name;
