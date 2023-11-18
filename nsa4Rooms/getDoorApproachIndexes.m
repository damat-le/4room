function [event_indexes,description,doormat]=getDoorApproachIndexes(Rat_pos_struct,session_name,ind_part,mode)
VARIABLES_FourRooms;
[~,~,comp_index]    = getPositionsFromStruct(Rat_pos_struct,session_name,ind_part);
doormat             = get_doormat(Rat_pos_struct,session_name);

%% get transitions towards "open door"
[dc1,compartment]=getTransitions(doormat,comp_index,mode);


event_indexes=dc1(:,1);
if isnan(compartment)
    description='';
else
    description=['DOOR_APPROACH_' COMPS{compartment}];
end