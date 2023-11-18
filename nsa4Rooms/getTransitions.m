function [dc1,compartment,door,all_transitions]=getTransitions(doormat,comp_index,open_index)
%% function [dc1,dc2,all_transitions]=getTransitions(doormat,comp_index)
% all_transitions = [index in position data for compartment transition, 1st compartment in transition, 2nd compartment in transition]
VARIABLES_FourRooms;
comp_index      =double(comp_index);


move_indices    = logical(diff(comp_index));
all_transitions = [ find(move_indices(:))  comp_index([move_indices(:); false]) comp_index([false; move_indices(:)]) ];

closed_door     = find(logical(sum(doormat,1)));
door_lookup2    = circshift(1:4,-(closed_door-1)); % vector 1:4 shifted so the closed door will now be in position 1
open_doors      = [door_lookup2(2) door_lookup2(end)];
open_comps      = [door_lookup2(1) door_lookup2(2)];

sort_compartment_sorted = sort(all_transitions(:,2:3),2,'ascend');                      % all transition sorted by "smallest" compartment
[~,transition_index] = ismember(sort_compartment_sorted, ALLOWED_TRANSITIONS, 'rows' ); % transitions index (bidirectional)

dc1 = all_transitions( ismember(transition_index, open_doors(open_index)) & (all_transitions(:,2)==open_comps(1) | all_transitions(:,2)==open_comps(2)),:);
% dc2 = all_transitions( ismember(transition_index, open_doors(2)) & (all_transitions(:,2)==open_comps(1) | all_transitions(:,2)==open_comps(2)),:);
if isempty(dc1)
    compartment=nan;
    door=nan;
else
    compartment=dc1(1,2);
    door=open_doors(open_index);
end