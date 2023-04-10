function X = tnnm(data, mask, rank)

    X = data;
    stopCriteria = false;
     k = 0;
    while ~stopCriteria
        k = k + 1

        oldX = X;
        [U, S, V] = svd(X);
        A = U(:, 1:rank)';
        B = V(:, 1:rank)';

        X = ADMM(A, B, data, mask);
        stopCriteria = canStop(X, oldX, 1);
    end

end


function X = ADMM(A, B, data, mask)
    X = data; 
    W = data;
    Y = data;

    beta = 1;
    stopCriteria = false;

    k = 0;
    while ~stopCriteria
        k = 1 + k;
        oldX = X;
        
        X = D(W - (1/beta)*Y, 1/beta);

        W = X + (1/beta)*(A' * B + Y);
        W = W .* ~mask + data .* mask;

        Y = Y + beta*(X - W);

        stopCriteria = canStop(X, oldX, 0);
    end

end

function X = D(X, t)
    [U, S, V] = svd(X);
    [s1, s2] = size(S);
    for i = 1:min(s1, s2)
        S(i,i) = max(S(i,i) - t, 0);
    end

    X = U * S * V';
end

function b = canStop(A, B, print)

    parameter = norm(A - B, "fro");
    if print
        parameter
    end
    b = parameter < 1e-4;

end