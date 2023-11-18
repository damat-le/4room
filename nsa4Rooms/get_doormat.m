function [doormat, open_doors, open_comps]=get_doormat(Rat_pos_struct,session_name)
%% function doormat=get_doormat(Rat_pos_struct,session_name)
partname=[session_name,Rat_pos_struct.parts(3)];
wo=strcmp(Rat_pos_struct.sessions,session_name);
sub_table=Rat_pos_struct.position_table{wo};
sub_sub_table=sub_table(strcmp(sub_table{:,4},partname),:);
doormat=sub_sub_table.doormat{1};

closed_door = find(logical(sum(doormat,1)));
door_lookup2 = circshift(1:4,-(closed_door-1)); % vector 1:4 shifted so the closed door will now be in position 1
open_doors = [door_lookup2(2) door_lookup2(end)];
open_comps = [door_lookup2(1) door_lookup2(2)];

