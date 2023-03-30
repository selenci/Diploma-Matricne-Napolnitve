% A = [0 0 -1 0 0 ; 0 0 0 1 0; 1 1 -1 1 -1 ; 1 0 0 0 -1; 0 0 -1 0 0]
% M = [0 0 1 0 0; 0 0 0 1 0; 1 1 1 1 1 ; 1 0 0 0 1 ; 0 0 1 0 0]

% A = [1 0 3 4 0 ; 1 1 0 0 1; 0 3 0 5 0; 0 0 0 1 1; 3 0 5 0 7]
% M = [1 0 1 1 0; 1 1 0 0 1; 0 1 0 1 0 ; 0 0 0 1 1 ; 1 0 1 0 1]

function Y = matrixMinimization(data, M, method)

    if nargin < 2
        error('Zahtevani matriki s podatki in maska')
    end
    if nargin < 3
        method =   'nnm'
    end

    switch method 
        case 'nnm'
            Y = nnm(data, M);
        otherwise
            error('Taka metoda ne obstaja')
    end


