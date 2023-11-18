function Rat_pos_struct= buildPositionStructure_FourRooms(bdata_big,Rat_name)
VARIABLES_FourRooms;
bdata_big_Rat        =bdata_big(strcmp(bdata_big{:,i_Rat},Rat_name),:);
sessions = unique(bdata_big_Rat{:,i_session});
parts    = 'abcde';
Rat_pos_struct.sessions=sessions;
N_sessions             =length(sessions);

Rat_pos_struct.parts   =parts;
% N_parts                =length(parts);
Rat_pos_struct.position_table=cell(N_sessions,1);
for i_s=1:N_sessions
    Rat_pos_struct.position_table{i_s}=bdata_big_Rat(strcmp(bdata_big_Rat{:,i_session},sessions{i_s}),:);
end

Rat_pos_struct.Rat_name=Rat_name;