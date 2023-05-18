function Y = asd(data, mask, rank)
    [n1, n2] = size(data);
    X = rand(n1, rank) * 255;
    Y = rand(rank, n2) * 255;

    stopCriteria = false;
    k = 0;
    while ~stopCriteria
        k = k + 1
        oldXY = X*Y;
        gradient = gradX(X, Y, data, mask); 
        X = X - stepsizeX(gradient, Y, mask) * gradient;

        gradient = gradY(X, Y, data, mask);
        Y = Y - stepsizeY(gradient, X, mask) * gradient;

        stopCriteria = canStop(oldXY, X*Y);
    end

    Y = X*Y;
end

function f = gradX(X, Y, data, mask)
    f = - (data.*mask - (X*Y) .* mask ) * Y';
end

function t = stepsizeX(grad, Y, mask) 
    a = norm(grad, "fro") ^ 2;
    b = norm( mask .* (grad * Y), "fro" ) ^ 2;
    t = a / b;
end

function f = gradY(X, Y, data, mask)
    f = -X' * (data.*mask - (X*Y) .* mask ) ;
end

function t = stepsizeY(grad, X, mask) 
    a = norm(grad, "fro") ^ 2;
    b = norm( mask .* (X * grad), "fro" ) ^ 2;
    t = a / b;
end

function b = canStop(A, B)
   
    parameter = norm(A-B, "fro")
    b = parameter < 1e-4;
        
end