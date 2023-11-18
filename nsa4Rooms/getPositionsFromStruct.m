function [positions, time, comp_index, speed, acceleration]=getPositionsFromStruct(Rat_pos_struct,session_name,part)
%% function positions=getPositionsFromStruct(Rat_pos_struct,session_name,part)
partname=[session_name,Rat_pos_struct.parts(part)];
wo=strcmp(Rat_pos_struct.sessions,session_name);
sub_table=Rat_pos_struct.position_table{wo};
sub_sub_table=sub_table(strcmp(sub_table{:,4},partname),:);
positions=sub_sub_table.positions{1};
comp_index=sub_sub_table.comp_index{1};
time=positions(:,3);
positions=positions(:,1:2);
speed=sub_sub_table.speed{1};

dt=sub_sub_table.duration/length(speed);
acceleration=[0;diff(sub_sub_table.speed{1})/dt];
