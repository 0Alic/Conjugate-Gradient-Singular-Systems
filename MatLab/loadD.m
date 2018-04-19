function D = loadD (idExp, m, gen_name, edge_name, i)
    %% Load and return D matrix from file
    
    if idExp == 1
        D = speye(m);
    elseif idExp == 2
        matfile = load(sprintf('../Data/%s/%s/D/%s (%d)_25', ...
                    gen_name, edge_name, edge_name, i));
        D = spconvert(matfile);
    elseif idExp == 3
        matfile = load(sprintf('../Data/%s/%s/D/%s (%d)_75',...
                    gen_name, edge_name, edge_name, i));
        D = spconvert(matfile);
    end
end