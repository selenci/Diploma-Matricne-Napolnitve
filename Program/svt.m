function Y = svt(data, mask)
    [n1, n2] = size(mask);
    m = sum( mask , "all" ); %stevilo omejitev

    step = 1.2*n1*n2/m;
    reg = 5*n1;
    k0 = floor(reg / (step * normest(data .* mask) ));
    k0 = 0;
    Y = k0 * step * (data .* mask);
    stopCriteria = false;

    k = 0;
    while ~stopCriteria
        [U, D, V] = svdTrial(Y, reg);

        X = U * regulate(D, reg) * V';
        Y = Y + step * ( (data .* mask) - (X .* mask) );
        stopCriteria = canStop(data, X, mask);
        k = k + 1
    end

    Y = X;
end

function [U, D, V] = svdTrial(M, reg)
    [n1, n2] = size(M);
    step = 10;
    p = step;
    [U, D, V] = svds(M, p);

    while (p <= min(n1, n2) && D(p, p) > reg)
        p = p + step;
        [U, D, V] = svds(M, p);
    end

    if(p > min(n1, n2))
        [U, D, V] = svd(M);
    end
end

function data = regulate(data, reg)
    [n1, n2] = size(data);
    for j = 1:min(n1, n2)
        data(j,j) = max(data(j,j) - reg, 0);
    end
end

function b = canStop(data, X, mask)
   
    parameter = normest( (X - data) .* mask) / normest(data .* mask) 
    b = parameter < 1e-4;
    
end
