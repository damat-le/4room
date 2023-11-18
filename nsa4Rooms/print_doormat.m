function LOCKS=print_doormat(doormat)
% get doormat which tells us which doors were closed and in which direction
% we extract doormat from the 3rd session because thats the one where the doors
% were closed (doormats for session 1,2 and 5 will all be 0s which isn't useful)
% doormat = bdata_big.doormat{ ismember(bdata_big.rat,config.rat) & ismember(bdata_big.date,config.date) & bdata_big.partn==3 };
% doormat has 3 rows, rows represent directions: clockwise (AB), cclockwise (BA), both (AB-BA)
% columns represent doorways: 1 (AB), 2 (BC), 3 (CD), 4 (DA)
% doormat is true when the door is closed in a direction. If the door is closed in both directions all rows will be true
% doormat is false when the door is open in a direction. If the door is open completely all rows will be false
VARIABLES_FourRooms;
N_dir=length(DIRECTIONS);
N_doors=length(DOORS);
LOCKS=cell(1,N_doors);

for ind_doors=1:N_doors
    
    for ind_dir=1:N_dir
        lock=[];
        if doormat(ind_dir,ind_doors)
           lock=DOORS{ind_doors}(DIRECTIONS(ind_dir,:));
        end
        if ~isempty(LOCKS{ind_doors}) && ~isempty(lock)
            LOCKS{ind_doors}=[LOCKS{ind_doors},'-',lock];
        elseif ~isempty(lock)
            LOCKS{ind_doors}=lock;
        end
    end 
end
