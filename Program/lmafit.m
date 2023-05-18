function Y = lmafit(data, mask, rank)
    [n1, n2] = size(data);
    X = rand(n1, rank) * 255;
    Y = rand(rank, n2) * 255;
    Z = data .* mask;

    stopCriteria = false;
    k = 0;
    while ~stopCriteria
        k = k + 1
        oldXY = X*Y;
        X = Z*pinv(Y);
        Y = pinv(X)*Z;
        Z = X*Y + ((data - X*Y) .* mask);
        stopCriteria = canStop(X*Y, oldXY);
    end

    Y = X*Y;
end



function b = canStop(A, B)
   
    parameter = norm(A-B, "fro")
    b = parameter < 1e-4;
        
end
