function runAll()
    %% Run experiments
    
    warning('off', 'all');
    
    %% No Preconditioning involved
    fprintf("**************************\nExperiment 1\n");
    fprintf("\tD=I;\n");
    fprintf("\tPreconditioning: NO\n");
    runExp(1, 'no', true);

    fprintf("\n**************************\nExperiment 2\n");
    fprintf("\tD: 75%% nnz;\n");
    fprintf("\tPreconditioning: NO\n");
    runExp(2, 'no', true);

    fprintf("\n**************************\nExperiment 3\n");
    fprintf("\tD: 25%% nnz;\n");
    fprintf("\tPreconditioning: NO\n");
    runExp(3, 'no', true);
    
    %% Diagonal Preconditioning involved
    fprintf("**************************\nExperiment 1\n");
    fprintf("\tD=I;\n");
    fprintf("\tPreconditioning: Jacobian, diagonal\n");
    runExp(1, 'jacobi', true);

    fprintf("\n**************************\nExperiment 2\n");
    fprintf("\tD: 75%% nnz;\n");
    fprintf("\tPreconditioning: Jacobian, diagonal\n");
    runExp(2, 'jacobi', true);
    
    fprintf("\n**************************\nExperiment 3\n");
    fprintf("\tD: 25%% nnz;\n");
    fprintf("\tPreconditioning: Jacobian, diagonal\n");
    runExp(3, 'jacobi', true);
    
    %% Done
    fprintf("Done\n");
end