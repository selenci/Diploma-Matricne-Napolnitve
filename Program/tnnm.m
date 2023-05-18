function X = tnnm(data, mask, rank)
    global passRank
    passRank = rank;


    X = data .* mask;
    stopCriteria = false;
    k = 0;
    while ~stopCriteria
        k = k + 1

        [U, S, V] = svds(X, rank);
        oldX = X;
        % X = ADMM(U', V', data, mask, 90 + k*10);
        para.admm_iter = 600 + k*10;
        para.admm_tol = 1e-4;
        para.admm_rho = 5e-2;

        [X, ~] = admmAXB(U', V', data, data, mask, para);
        stopCriteria = canStop(X, oldX, 1, 5.312856700495526e+04);

    end

end


function X = ADMM(A, B, data, mask, stevilo)
    X = data; 
    W = data;
    Y = data;

    beta = 1;
    stopCriteria = false;

    k = 0;
    while ~stopCriteria
        k = 1 + k
        oldX = X;
        
        X = D(W - (Y/beta), 1/beta); 

        W = X + ((A' * B + Y)/beta);
        W = (W .* ~mask) + (data .* mask);

        Y = Y + beta*(X - W);

        stopCriteria = canStop(X, oldX, 1);

        if(k > stevilo)
            break
        end
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
        [U, D, V] = svds(M, min(n1, n2));
    end
end

function x = normfro(A)
    [~,~,x] = find(A);
    x = sqrt(x'*x)
end

function b = canStop(A, B, print, norma)

    parameter = norm(A - B, "fro")/ norma
    if(print == 1)
        disp(parameter)
    end
    b = parameter < 3e-4;

end