function [events,description,labels,doormat]=getEventsFromApproach(Rat_pos_struct,session_name,ind_part,mode_approach)
%% function [events,description,labels]=getEventsFromApproach(Rat_pos_struct,session_name,ind_part,mode_approach)
VARIABLES_FourRooms;
if mode_approach==BELL_APPROACH
    val_approach=DOOR_APPROACH_1;
else
    val_approach=mode_approach;
end
[events,description,doormat]=getDoorApproachIndexes(Rat_pos_struct,session_name,ind_part,val_approach);

st_lock=print_doormat(doormat);
labels               ={'OPEN'};% 'CD-DC LOCKED'};
for i_s=1:length(st_lock)
    if ~isempty(st_lock{i_s})
        labels{end+1}=[st_lock{i_s} ' LOCKED'];
    end
end

if mode_approach==BELL_APPROACH
    [events,description]=getBellIndexes(Rat_pos_struct,session_name,ind_part);
    
end