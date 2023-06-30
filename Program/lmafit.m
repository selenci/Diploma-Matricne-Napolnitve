function Y = lmafit(data, mask, rank)
    [n1, n2] = size(data);
    X = rand(n1, rank) * 255 - 127;
    Y = rand(rank, n2) * 255 - 127;
    Z = data .* mask;
    newXY = X*Y;
    stopCriteria = false;
    k = 0;
    while ~stopCriteria
        k = k + 1
        oldXY = newXY;
        X = Z*pinv(Y);
        Y = pinv(X)*Z;
        newXY = X*Y;
        Z = newXY + ((data - newXY) .* mask);
        stopCriteria = canStop(newXY, oldXY);
    end

    Y = X*Y;
end



function b = canStop(A, B)
   
    parameter = norm(A-B, "fro")
    b = parameter < 1e-4;
        
end
