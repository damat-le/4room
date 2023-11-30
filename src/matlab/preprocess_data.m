function preprocess_data = preprocess_data(T, data_type, out_dir)

%set filename maker function according to data type
if data_type=="neural"
    filename_maker = @make_nfilename;
elseif data_type=="behaviour"
    filename_maker = @make_bfilename;
    % remove graph column
    T = removevars(T, 'graph');
end 

%get column size
n_rows = size(T, 1);
n_cols = size(T, 2);

%iterate over rows
for i = 1:n_rows
    
    %get info to build output path and filename
    rat_name = T{i, 1}{1};
    session_name = T{i, 4}{1};
    uci_name = T{i, 5}{1};

    %iterate over cols
    for j = 1:n_cols

        %content to be written
        elem = T{i,j};
        elem_name = T.Properties.VariableNames{j};
        
        %filename and path
        filename = filename_maker( ...
            out_dir, ...
            rat_name, ...
            session_name, ...
            uci_name, ...
            elem_name ...
            );
        file_parts = fileparts(filename);
        mkdir(file_parts);
        
        %try to write `cell` columns
        if class(elem)=="cell"
            try
                writematrix(elem{1}, filename, "WriteMode","overwrite");
            catch ME
                %try to write `cellNested` columns
                try 
                    writematrix(elem{1}{1}, filename, "WriteMode","overwrite");
                catch ME
                    % if not working, print error message
                    fprintf('Error while writing column %s as cell', elem_name);
                    fprintf(ME.message);
                end
            end
        %write non `cell` columns
        else
            writematrix(elem, filename, "WriteMode","overwrite");
        end
    end
end
end


function bfilename = make_bfilename(out_dir, rat_name, session_name, uci_name, elem_name)
% Build the filename (and path) for each column of the input table.
% NOTE: this function takes as input `uci_name` even though it is not used.
% This is done to avoid memory fragmentation in the for loops of the main
% function
bfilename = sprintf( ...
            '%s/%s/%s/%s.csv', ...
            out_dir, ...
            rat_name, ...
            session_name, ...
            elem_name ...
            );
end


function nfilename = make_nfilename(out_dir, rat_name, session_name, uci_name, elem_name)
% Build the filename (and path) for each column of the input table.
nfilename = sprintf( ...
            '%s/%s/%s/%s/%s.csv', ...
            out_dir, ...
            rat_name, ...
            session_name, ...
            uci_name, ...
            elem_name ...
            );
end
