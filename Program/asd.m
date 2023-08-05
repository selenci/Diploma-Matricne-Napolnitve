function Y = asd(data, mask, rank)
    [n1, n2] = size(data);
    %zacnemo z nakljucno generiranima matrikama
    X = sqrt(rand(n1, rank) * 255);
    Y = sqrt(rand(rank, n2) * 255);

    stopCriteria = false;
    k = 0;
    while ~stopCriteria
        k = k + 1
        oldXY = X*Y;
        %izracun gradienta po sprem. X
        gradient = gradX(X, Y, data, mask); 

        %premik sprem. X
        X = X - stepsizeX(gradient, Y, mask) * gradient;

        %izracun gradienta po sprem. Y
        gradient = gradY(X, Y, data, mask);
        
        %premik sprem. Y
        Y = Y - stepsizeY(gradient, X, mask) * gradient;

        %preverimo ce je konvergenci pogoj dosezen
        stopCriteria = canStop(oldXY, X*Y);
    end

    Y = X*Y;
end

%funkcija izracuna gradient po sprem. X
function f = gradX(X, Y, data, mask)
    f = - (data.*mask - (X*Y) .* mask ) * Y';
end

%funkcija izracuna optimalni korak premika sprem. X
function t = stepsizeX(grad, Y, mask) 
    a = norm(grad, "fro") ^ 2;
    b = norm( mask .* (grad * Y), "fro" ) ^ 2;
    t = a / b;
end

%funkcija izracuna gradient po sprem. Y
function f = gradY(X, Y, data, mask)
    f = -X' * (data.*mask - (X*Y) .* mask ) ;
end

%funkcija izracuna optimalni korak premika sprem. Y
function t = stepsizeY(grad, X, mask) 
    a = norm(grad, "fro") ^ 2;
    b = norm( mask .* (X * grad), "fro" ) ^ 2;
    t = a / b;
end

%konvergencni pogoj
function b = canStop(A, B)
    parameter = norm(A-B, "fro")
    b = parameter < 1e-4;
end