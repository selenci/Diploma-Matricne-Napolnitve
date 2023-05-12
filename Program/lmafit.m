function Y = lmafit(data, mask, rank)
    [n1, n2] = size(data);
    X = rand(n1, rank) * 255;
    Y = rand(rank, n2) * 255;
    Z = data .* mask;

    stopCriteria = false;
    while ~stopCriteria
        X = Z*pinv(Y);
        Y = pinv(X)*Z;
        Z = X*Y + ((data - X*Y) .* mask);
        stopCriteria = canStop(data, X*Y, mask);
    end

    Y = X*Y;
end



function b = canStop(data, X, mask)
   
    parameter = normest( (X - data) .* mask) / normest(data .* mask) 
    b = parameter < 1e-4;
        
end
