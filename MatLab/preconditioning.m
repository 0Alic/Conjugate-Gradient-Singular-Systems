function [P, tp, Ep, bp] = preconditioning (prec, E, D, b, n)
    %% Compute preconditioning
    
    % Params
    % prec  = string identifying the type of preconditioning
    % E     = node-edge matrix
    % D     = weight matrix
    % b     = random vector
    % n     = number of nodes

    % Results
    % P     = Preconditioning matrix; 0 if no preconditioning
    % tp    = time spent computing preconditioning
    % Ep    = Perturbed E
    % bp    = Perturbed b

    tp = 0;
    Ep = E;
    bp = b;

    if prec == "no"
       P = speye(n);
    elseif prec == "jacobi"
        tic();
        p = diagOfA(E, D); 
        P = speye(n) .* sqrt(p);
        Ep = P\E;                   
        bp = P\b;
        tp = toc();
    elseif prec == "cholesky"
        tic();
        L = ichol(E * (D \ E'));
        P = L;
        Ep = P\E;                   
        bp = P\b;
        tp = toc();
    else 
        error("Use 'no', 'jacobi' or 'cholesky' as prec parameter");
    end
end