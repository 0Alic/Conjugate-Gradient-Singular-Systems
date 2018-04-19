function b = loadB(n, gen_name, edge_name, i)
    %% Load and return b vector from file
    
    file_name = sprintf('../Data/%s/%s/b/%s (%d)_b', gen_name, edge_name, edge_name, i);
    fileID = fopen(file_name,'r');
    formatSpec = '%f';
    b = fscanf(fileID, formatSpec); % Read Data
    fclose(fileID);                % Closes file
    b = b - sum(b) / n;            % Ensure b lies on the Img(A)
end