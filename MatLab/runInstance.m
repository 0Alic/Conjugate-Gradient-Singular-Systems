function [] = runInstance(gen_name, edge_name, idExp, i, prec, yesplot, compare)
    %% Run the CG on a single graph instance and print results

    % Params:
    % gen_name = identifies the graph generator to use
    % edge_name = identifies the size of the graph
    % idExp = the id of the experiment (identifies the D to use)
    % i = the instance of the graph
    % prec  = string identifying the type of preconditioning
    % yesplot = if "yep" then plot the behaviour of the norm 
    %   of the residual during the CG algorithm
    % compare = bool identifies wheter or not execute also matlab's pcg()

    % Data involved:
    % E = node-edge matrix
    % D = weight matrix
    % P = preconditioning matrix
    % b = random vector
    % MM = Lambda function, describing the Black Box operation of CG

    %% Checking Input
    
    if gen_name ~= "netgen" && gen_name ~= "complete" && gen_name ~= "goto"
        error('The generators available are netgen, complete or goto');
    end
    if idExp ~= 1 && idExp ~= 2 && idExp ~= 3
        error('idExp con assume values 1, 2 or 3 that are respectively D = I, D = 75 or D = 25');
    end
    if floor(i)~=i 
        error('i must be an integer number');
    end
    if prec ~= "no" && prec ~= "jacobi" && prec ~= "cholesky"
        error('Preconditioner can be either "jacobi" or "cholesky", or "no" preconditioning at all');
    end
    
    %% Loading files
  
    %load E   
    fprintf("Loading E..\n");
    matfile = load(sprintf('../Data/%s/%s/E/%s (%d)_E', ...
                        gen_name, edge_name, edge_name, i));
	E = spconvert(matfile);
    [n, m] = size(E);
    
    % Read vector b
    fprintf("Loading b..\n");
    b = loadB(n, gen_name, edge_name, i);

    % Read matrix D
    fprintf("Loading D..\n");
    D = loadD(idExp, m, gen_name, edge_name, i);
    
    %% Solve the system
    
    % Choosing preconditioner
    [P, tp, Ep, bp] = preconditioning(prec, E, D, b, n);

    % CG's Black Box operation
    MMp = @(v) (Ep*(D \(Ep'*v))); % preconditioned
    MM = @(v) (E*(D \(E'*v))); % not preconditioned

    % Compute CG
    fprintf("Computing CG; preconditioning: NO\n");
    [x, k, t, rr] = CG(MM, b, n, 10e-6, speye(n));
    
    fprintf("Computing CG; preconditioning: %s\n", prec);
    [xp, kp, tpp, rrp] = CG(MMp, bp, n, 10e-6, P);

    itercg = 0; iterpcg = 0; tcg = 0; tpcg = 0;
    if compare
        fprintf("Computing PCG; preconditioning: NO\n");
        tic();
        [~,~,~,itercg] = pcg(MM, b, 10e-6, n);
        tcg = toc();

        fprintf("Computing PCG; preconditioning: %s\n", prec);
        tic();
        [~,~,~,iterpcg] = pcg(MMp, bp, 10e-6, n);
        tpcg = toc();
    end
    
    tic();
    xp = P' \ xp;
    xp = xp - sum(xp)/n;
    temp = toc();
 
	tp = temp + tp;
	tpcg = tpcg+tp;
	tp = tp*1000;       % Eventual precoditioning overhead
	t = t*1000;         % CG's elapsed time
	tcg = tcg*1000;     % matlab no prec time
	tpp = tpp * 1000;   % Preconditioned CG's elapsed time
	tpcg = tpcg*1000;   % matlab prec time
	 
    %% Collecting Results
    
	% Get some useful data
	fprintf("Collecting results..\n");
	[cnd, nrm] = util_results(E, E, D, b, x);
	[cndp, nrmp] = util_results(E, Ep, D, b, xp);

    fprintf("\nidExp: %d\nnEdge: %d\nnNodes: %d\n\n", idExp, m, n);    
    fprintf("## Cond - CondP:\n%e - %e\n", cnd, cndp);
    fprintf("## nrm(r)/nrm(b) - nrm(r)/nrm(b)P:\n%e - %e\n", nrm, nrmp);
    fprintf("## nIter - nIterP:\n%d - %d\n", k, kp);
    fprintf("## CGTime - CGTimeP:\n%f ms - %f ms\n", t, tp);
    fprintf("## Prec-Overhead:\n%f ms\n", tpp);    
    fprintf("## Total - TotalP:\n%f ms - %f ms\n", t, tp+tpp);
    if compare
        fprintf("## pcg: nIter - nIterP:\n%d - %d\n", itercg, iterpcg);
        fprintf("## pcg: CGTime - CGTimeP:\n%f ms - %f ms\n", tcg, tpcg);
    end
    
    % Plot residual's advancement
    if yesplot == "yep"
        subplot(2,1,1);
        semilogy(rrp);
        xlabel('iter');
        ylabel('prec norm(r)/norm(b)');
        subplot(2,1,2);
        semilogy(rr);
        xlabel('iter');
        ylabel('norm(r)/norm(b)');
    end
end
