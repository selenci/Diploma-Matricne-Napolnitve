function X = tnnm(data, mask, rank)
    global passRank
    passRank = rank;


    X = data;
    stopCriteria = false;
     k = 0;
    while ~stopCriteria
        k = k + 1

        oldX = X;
        [U, S, V] = svds(X, rank);

        X = ADMM(U', V', data, mask);
        stopCriteria = canStop(X, oldX, 1);
    end

end


function X = ADMM(A, B, data, mask)
    X = data; 
    W = data;
    Y = data;

    beta = 1/100;
    stopCriteria = false;

    k = 0;
    while ~stopCriteria
        k = 1 + k;
        oldX = X;
        
        X = D(W - (1/beta)*Y, 1/beta);

        W = X + (1/beta)*(A' * B + Y);
        W = W .* ~mask + data .* mask;

        Y = Y + beta*(X - W);

        stopCriteria = canStop(X, oldX, 1);
    end

end

function X = D(X, t)
    [U, S, V] = svdTrial(X, t);
    [s1, s2] = size(S);
    for i = 1:min(s1, s2)
        S(i,i) = max(S(i,i) - t, 0);
    end

    X = U * S * V';
end

function [U, D, V] = svdTrial(M, reg)
    [n1, n2] = size(M);
    global passRank
    step = passRank;
    p = step;
    [U, D, V] = svds(M, p);

    while ( p <= min(n1, n2) && D(p, p) > reg  )
        p = p * 2;
        [U, D, V] = svds(M, p);
    end

    if(p > min(n1, n2))
        [U, D, V] = svd(M);
    end
end

function b = canStop(A, B, print)

    parameter = norm(A - B, "fro");
    if print
        parameter
    end
    b = parameter < 1e-3;

end