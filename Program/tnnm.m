function X = tnnm(data, mask, rank)
    %informacijo o rangu shranimo v globalno sprem.
    global passRank
    passRank = rank;


    X = data;
    stopCriteria = false;
    k = 0;
    while ~stopCriteria
        k = k + 1

        oldX = X;
        %izracunamo prvih rank lastnih vektorjev in sing. vrednosti
        [U, S, V] = svds(X, rank);

        %posodobimo z uporabo algoritma ADMM
        X = ADMM(U', V', data, mask);
        stopCriteria = canStop(X, oldX, 1);

    end
    k

end


function X = ADMM(A, B, data, mask)
    X = data; 
    W = data;
    Y = data;

    beta = 5e-3;
    stopCriteria = false;

    k = 0;
    while ~stopCriteria && k < 100
        k = 1 + k;
        oldX = X;
        %izracun X^(k + 1)
        X = regulate(W - (1/beta)*Y, 1/beta);
        %izracun W^(k + 1)
        W = X + (1/beta)*(A' * B + Y);
        W = W .* ~mask + data .* mask;
        %izracunamo K(K+ 1)
        Y = Y + beta*(X - W);

        %preverimo ce je konvergenci pogoj dosezen
        stopCriteria = canStop(X, oldX, 1);
    end

end

%operator praga
function X = regulate(X, t)
    [U, S, V] = svdTrial(X, t);
    [s1, s2] = size(S);
    for i = 1:min(s1, s2)
        S(i,i) = max(S(i,i) - t, 0);
    end

    X = U * S * V';
end

%Povecuje stevilo izracunanih sing. vrednosti dokler ni najmanjsa singularna vrednost manjsa od reg
function [U, D, V] = svdTrial(M, reg)
    [n1, n2] = size(M);
    global passRank
    p = passRank;
    [U, D, V] = svds(M, p);

    while ( p <= min(n1, n2) && D(p, p) > reg  )
        p = p * 2;
        [U, D, V] = svds(M, p);
    end

    if(p > min(n1, n2))
        [U, D, V] = svds(M, min(n1, n2));
    end

end

%konvergencni pogoj
function b = canStop(A, B, print)

    parameter = norm(A - B, "fro");
    if print
        parameter
    end
    b = parameter < 1e-4;

end