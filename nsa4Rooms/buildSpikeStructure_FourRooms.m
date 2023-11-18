function Rat_struct= buildSpikeStructure_FourRooms(sdata_big,Rat_name)
VARIABLES_FourRooms;

sdata_big_Rat        =sdata_big(strcmp(sdata_big{:,i_Rat},Rat_name),:);
distinct_ucies_Rat   =unique(sdata_big_Rat{:,i_Uci});
Rat_struct.NeuronName=distinct_ucies_Rat;

N=length(Rat_struct.NeuronName);
Rat_struct.Neuron_table=cell(N,1);
Rat_struct.Neuron_session=cell(N,1);
for ind_Neuron=1:N
    NeuronName_Rat         =Rat_struct.NeuronName{ind_Neuron};
    Rat_struct.Neuron_table{ind_Neuron}=sdata_big_Rat(strcmp(sdata_big_Rat{:,i_Uci},NeuronName_Rat),:);
    Rat_struct.Neuron_session{ind_Neuron}=Rat_struct.Neuron_table{ind_Neuron}.part{1}(1:end-1);
end

Rat_struct.Rat_name=Rat_name;