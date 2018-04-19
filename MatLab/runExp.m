function runExp(idExp, prec, compare)
    %% Generic experiment structure
    
	%
    % Setup the inputs, run CG and prints the results in .xls files
    %
    % Params:
    % idExp = the id of the experiment (identifies the D to use)
    % prec  = string identifying the type of preconditioning
    % compare = bool identifies wheter or not execute also matlab's pcg()
    
    %
    % Data involved:
    % E = node-edge matrix
    % D = weight matrix
    % P = preconditioning matrix
    % b = random vector
    % MM = Lambda function, describing the Black Box operation of CG

    % gen_name = name of the current generator
    % edge_name = number of edges of current graph
    % outname = output file name, xls sheet file
    % OutData = Create spreadsheet data as a Matlab's cell array
    
    %% Check Input
    if idExp < 0 || idExp > 4
        error("idExp supported are 1, 2 and 3");
    end
    if prec ~= "no" && prec ~= "jacobi" && prec ~= "cholesky"
        error("please type: 'no', 'jacobi' or 'cholesky'")        
    end
    if ~islogical(compare)
        error("compare must be a boolean (logical)")
    end
    
    %% Iterate over our test data
    
    % Indexes to iterate through the directories
        % NB: indexes are
        % 1) .
        % 2) ..
        % 3) file1
		% 4) file2
        % etc
    initGen = 3;
    initEdge = 3;
    
    % Gets the generator names from the folder
    generators = dir ('../Data');
    generators = {generators.name};
    [~, nGen] = size(generators);
    
    for gen = initGen:nGen
        %% For each generator available
        gen_name = generators(gen);
        gen_name = gen_name{1};
        
        fprintf("\t\tGenerator: %s;\n", gen_name);

        % Gets the number of edges of our graphs
        edges = dir (sprintf('../Data/%s', gen_name));
        edges = {edges.name};
        [~, nEdges] = size(edges);

        outname = sprintf('../Spreadsheets/%s_%s_%d.xls', ... 
            gen_name, prec, idExp);

%        delete outname;
        Preface = util_preface(idExp, gen_name, prec);
        xlswrite(outname, Preface, 1);

        for e = initEdge:nEdges
             %% For each edge class available 
            
            edge_name = edges(e);
            edge_name = edge_name{1};

            fprintf("\t\t\tEdge size: %s\n", edge_name);
            
            % Count the number of instances of matrices
            istances = dir (sprintf('../Data/%s/%s/E/*_E', ...
                                gen_name, edge_name));
            instances = {istances.name};
            [~, nGraphs] = size(instances);
        
            fprintf("\t\t\tInstances: %d\n\t\t\t\t", nGraphs);
            
            % header + 'instances' rows; 11 columns
            OutData = cell(nGraphs+1, 11);
            OutData(1, :) = {'ID', 'nEdge', 'nNodes', 'Cond', ...
                'Norm(Ax-b)', 'nIter', 'CGTime', 'PrecOverhead', ...
                'Total', 'PcgIter', 'PcgTime'};

            for i = 1:nGraphs
                %% For each instace of graph
                fprintf("*");

                % Read matrix E
                matfile = load(sprintf('../Data/%s/%s/E/%s (%d)_E', ...
                    gen_name, edge_name, edge_name, i));
                
                E = spconvert(matfile);
                [n, m] = size(E);

                % Read vector b
                b = loadB(n, gen_name, edge_name, i);

                % Read matrix D
                D = loadD(idExp, m, gen_name, edge_name, i);

                % Choosing preconditioner
                [P, tp, Ep, bp] = preconditioning(prec, E, D, b, n);
                
                % CG's Black Box operation
                MM = @(v) (Ep*(D \(Ep'*v)));

                % Compute CG
                [xp, k, t] = CG(MM, bp, n, 10e-6, P');
                
                itercg = 0;
                tpcg = 0;
                if compare 
                    % Compute Matlab CG
                    tic();
                    [~,~,~,itercg] = pcg(MM, bp, 10e-6, n);
                    tpcg = toc();
                end
                
                x = xp;

                if prec == "no"
                    % do nothing
                elseif prec == "jacobi" || prec == "cholesky"
                    tic();
                    x = P \ x;
                    x = x - sum(x)/n;
                    temp = toc();
                    tp = temp + tp;
                else
                    error("Wrong prec parameter");
                end
                 
                tp = tp*1000;   % Eventual precoditioning overhead
                t = t*1000;     % CG's elapsed time
                tpcg = tpcg*1000; % Matlab CG time

                % Get some useful data
                [cnd, nrm] = util_results(E, Ep, D, b, x);
                OutData(i+1, :) = {i, m, n, cnd, nrm, k, t, tp, ...
                    t + tp, itercg, tpcg+tp};
            end

            fprintf("\n\t\t\tWriting results in file...\n");            
            xlswrite(outname, OutData, edge_name);
        end
    end
end