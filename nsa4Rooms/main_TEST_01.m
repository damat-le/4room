% function main_TEST_01
VARIABLES_FourRooms;
addpath ('../../CTRNN/RasterPlot/');

try
    bdata_big;
    sdata_big;
catch
    fprintf('Loading 4 Rooms Data');
    [bdata_big,sdata_big]=loadRawData(data_path);
end
Rat_name='r35'; session_name='S8'; ind_part=1;
mode_approach=BELL_APPROACH;
%% get spike structre for the selected rat
Rat_spike_struct    = buildSpikeStructure_FourRooms(sdata_big,Rat_name);

%% get position structure for the selected rat
Rat_pos_struct      = buildPositionStructure_FourRooms(bdata_big,Rat_name);

event_indexes       = getEventsFromApproach(Rat_pos_struct,session_name,ind_part,mode_approach);

params.event_indexes=event_indexes;
Trials=events_capture(Rat_spike_struct,Rat_pos_struct,session_name,ind_part,params);

