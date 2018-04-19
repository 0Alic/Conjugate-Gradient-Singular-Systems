function [p] = diagOfA(E, D)
    %% Computes the diagonal of A = E*D\E' 
    p = E.^2 * diag(inv(D));
end