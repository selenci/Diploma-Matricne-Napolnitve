function Y = svt(data, mask)
    [n1, n2] = size(mask);
    m = sum( mask , "all" ); %stevilo omejitev

    step = 1.2*n1*n2/m;
    reg = 5*n1;

    k0 = floor(reg / (step * norm(data .* mask) ))
    Y = k0 * step * (data .* mask);
    stopCriteria = false;

    k = 0;
    while ~stopCriteria
        [U, D, V] = svd(Y);

        X = U * regulate(D, reg) * V';
        Y = Y + step * ( (data .* mask) - (X .* mask) );
        stopCriteria = canStop(data, X, mask);
        k = k + 1
    end

    Y = X;
end

function data = regulate(data, reg)
    [n1, n2] = size(data);
    for j = 1:min(n1, n2)
        data(j,j) = max(data(j,j) - reg, 0);
    end
end

function b = canStop(data, X, mask)
   
    parameter = norm( (X - data) .* mask, "fro") / norm(data .* mask, "fro") ;
    b = parameter < 1e-4;
    
end
