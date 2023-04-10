% A = [0 0 -1 0 0 ; 0 0 0 1 0; 1 1 -1 1 -1 ; 1 0 0 0 -1; 0 0 -1 0 0]
% M = [0 0 1 0 0; 0 0 0 1 0; 1 1 1 1 1 ; 1 0 0 0 1 ; 0 0 1 0 0]

% A = [1 0 3 4 0 ; 1 1 0 0 1; 0 3 0 5 0; 0 0 0 1 1; 3 0 5 0 7]
% M = [1 0 1 1 0; 1 1 0 0 1; 0 1 0 1 0 ; 0 0 0 1 1 ; 1 0 1 0 1]

function Y = matrixMinimization(data, mask, method, rank)

    if nargin < 2
        error('Zahtevani matriki s podatki in maska')
    end
    if nargin < 3
        method =   'nnm'
    end

    switch method 
        case 'nnm'
            Y = nnm(data, mask);
        case 'svt'
            Y = svt(data, mask);
    end


    if nargin < 4
        error('Ali ste pozabili podati rank')
    end

    switch method 
        case 'tnnm'
            Y = tnnm(data, mask, rank)

        otherwise
            error('Taka metoda ne obstaja')
    end


