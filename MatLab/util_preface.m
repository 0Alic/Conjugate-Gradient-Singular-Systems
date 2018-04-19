function [Preface] = util_preface(id_exp, gen_name, prec)
    %% Write a small preface in the spreadsheet, resuming the data involved
    
    Preface = cell(3, 3);
    Preface(:, 1) = {'Generator:'; 'Preconditioning:'; 'nnz D:'};
    
    DType = 'All (Identity)';

    if id_exp == 2
        DType = '75%';
    elseif id_exp == 3
        DType = '25%';
    end
    
    Preface(:, 3) = {gen_name, prec, DType};
end