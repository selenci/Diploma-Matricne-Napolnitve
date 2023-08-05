function Y = matrixMinimization(data, mask, method, rank)

    %vedno moramo podati vsaj data in mask
    if nargin < 2
        error('Zahtevani matriki s podatki in maska')
    end

    %ce metoda ni podana privzamemo algoritem nnm
    if nargin < 3
        method =   'nnm'
    end

    %ce je izbrana metoda nnm ali svt, klicemo primerne funkcije
    switch method 
        case 'nnm'
            Y = nnm(data, mask);
            return
        case 'svt'
            Y = svt(data, mask);
            return
    end

    %ce izbrana metoda ni nnm ali svt je potrebno podati informacijo o rangu
    if nargin < 4
        error('Ali ste pozabili podati rang')
    end

    %izberemo primeren algoritem ali obvestimo da ne obstaja
    switch method 
        case 'tnnm'
            Y = tnnm(data, mask, rank);
            return
        case 'lmafit'
            Y = lmafit(data, mask, rank);
            return
        case 'asd'
            Y = asd(data, mask, rank);
            return

        otherwise
            error('Taka metoda ne obstaja')
    end


