function [x, k, t, rr, status] = CG(mm, b, n, eps, P)
        %% Conjugate Gradient Method
        %
        % Solve: Ax = b by applying the Conjugate Gradient method.
        % The matrix is implicitly contained inside the lambda function. 
        
        % Params:
        % mm: Matrix Multiplier function: describes the matrix 
        %       multiplication step of the gradient method. It
        %       contains the system matrix;
        % b: The known vector of the linear system;
        % n: The matrix dimension, and then max number of iterations of CG.
        % eps: The precision required for the solution,
        %       used to stop the algorithm before n iteration

        % Returns:
        % x: The vector solution
        % k: The number of iterations
        % t: The time spent (in seconds)
        % rr: the history of the norm of the residuals
        % status: state of the function in the end of CG
        
        %% Checking Input

        % checking the vector b
        if size(b, 1) ~= n
            error('b must be a vector of length n');
        end
        if ~ isreal( b )
            error('b must be a real vector');
        end
        % checking n
        if  ~ isreal( n ) || ~ isscalar( n )
            error('n must be a real scalar');
        end
        % checking eps
        if  ~ isreal( eps ) || ~ isscalar( eps )
            error('eps must be a real scalar');
        end
        % checking the matrix P
        if ~ isreal( P )
            error('P must be a real matrix');
        end
        if size(P, 1) ~= n && size(P, 2) ~= n
           error('P must be a square matrix nxn' );
        end
        
        %% Initial Setup
        tic();     
        correction = ones(1,n) * P;     % Correction
        %b = b - sum(b) / n;            % Ensure b lies on the Img(A)
        x = zeros(n, 1);
        d = b; r = b; k = 0;            % Inizialise some variables
        rr = zeros(n, 1);
        
        %% CG loop
        while (k < n) && (norm(r)/norm(b) >= eps)
            Ad = mm(d);                % Compute A*d
            alpha = (r'*r) / (d'*Ad);  % Compute step size
            x = x + alpha*d;           % Move current point along d
            rk = r - alpha*Ad;         % Compute the residual     
            rk = rk - (correction*rk) / sum(correction);
            d = rk + ((rk'*rk) / (r'*r))*d; % Update search direction
            d = d - (correction*d) / sum(correction);
            r = rk;
            k = k + 1;
            rr(k) = norm(r)/norm(b);
        end
        
        %% Ending status
        if k == n
            status = "No convergence";
        else
            status = "Found Solution";
        end
        
        t = toc();
end