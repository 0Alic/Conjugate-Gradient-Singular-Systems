function [cnd, nrm] = util_results(E, Ep, D, b, x)
	%% Compute condition number of A and accuracy of the solution
	% Needs to compute A = E\D*E' explicitly
	
    A = E * (D \ E'); 
    nrm = norm(A*x-b) / norm(b);

    % Compute condition number := lmax / lmin
    %   where lmin is the first min eig != 0          
    A = Ep * (D \ Ep'); 
    splmin = eigs(A,2,0);
    splmin = splmin(2);
    splmax = eigs(A,1);
    cnd = splmax / splmin;
end