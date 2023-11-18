function [event_indexes,description,correct_bell_index,events]=getBellIndexes(Rat_pos_struct,session_name,part)
%% function positions=getPositionsFromStruct(Rat_pos_struct,session_name,part)

% column 1: 1st bell time (trial start)
% column 2: 2nd bell time (trial end)
% column 3: 1st compartment (box at start/when bell happens)
% column 4: 2nd compartment (box at end/rewarded box)   
% column 5: error messages as a formatted string
% column 6: 1st foraging compartment
% column 7: 1st foraging correct or not
% column 8: Time between bell and foraging in the correct compartment                
% column 9: Time between bell and moving to a new (any) compartment
% column 10: Average speed 1s before the bell
% column 11: Average speed 1s after the bell
% column 12: 1st door push choice after the bell
% column 13: Time of the 1st door push choice after the bell
% column 14: Time between the bell and 1st door push
% column 15: Shortest path the rat could have taken to correct box
% column 16: Optimal door the rat should have pushed on
% column 17: 1st push optimal or not 


% t_starts  = cell2mat(correct_bell_index(:,1));
% ptimes    = cell2mat(correct_bell_index(:,13));       
% t_ends    = cell2mat(correct_bell_index(:,2)); 
VARIABLES_FourRooms;
partname=[session_name,Rat_pos_struct.parts(part)];
wo=strcmp(Rat_pos_struct.sessions,session_name);
sub_table=Rat_pos_struct.position_table{wo};
sub_sub_table=sub_table(strcmp(sub_table{:,4},partname),:);
correct_bell_index=sub_sub_table.correct_bell_index{1};


events  = cell2mat(correct_bell_index(:,1));
add     = cell2mat(correct_bell_index(:,2));
events=[events;add(end)];
description ='BELL_APPROACH';

compstart    = COMPS(cell2mat(correct_bell_index(:,3)));
compstart{end+1}='';
compgoals    = COMPS(cell2mat(correct_bell_index(:,4)));
compgoals{end+1}='';
for i=1:length(compstart)
    fprintf('Start in %s, Goal in %s\n',compstart{i},compgoals{i})
end

[~, time]=getPositionsFromStruct(Rat_pos_struct,session_name,part);
event_indexes=nan(length(events),1);
for ev=1:length(events)
    [~,event_indexes(ev)]=min(abs(time-events(ev)));
end