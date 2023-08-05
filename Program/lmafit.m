function Y = lmafit(data, mask, rank)
    [n1, n2] = size(data);

    %zacnemo z nakljucno generiranima matrikama
    X = rand(n1, rank) * 255 - 127;
    Y = rand(rank, n2) * 255 - 127;
    %Z je na zacetku nastavljen na znane vrednosti
    Z = data .* mask;
    newXY = X*Y;
    stopCriteria = false;
    k = 0;
    while ~stopCriteria
        k = k + 1
        oldXY = newXY;

        %izracun X^(k + 1)
        X = Z*pinv(Y);
        %izracun Y^(k + 1)
        Y = pinv(X)*Z;
        newXY = X*Y;

        %izracun Z^(k + 1), znane vrednosti popravimo
        Z = newXY + ((data - newXY) .* mask);

        %preverimo ce je konvergenci pogoj dosezen
        stopCriteria = canStop(newXY, oldXY);
    end

    Y = Z;
end


%konvergencni pogoj
function b = canStop(A, B)
   
    parameter = norm(A-B, "fro")
    b = parameter < 1e-4;
        
end
