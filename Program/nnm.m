function Y = nnm(data, mask)
    [n1, n2] = size(mask);
    m = sum( mask , "all" ); %stevilo omejitev
    b = zeros(m, 1);

    %matrika, ki predstavlja A_1, ..., A_k, vsak vektor je svoja matrika
    A = sparse((n1 + n2)^2, m);

    %stevec omejitev
    count = 1;
    for i = 1:n1
        for j = 1:n2
            %za omejitev nastavimo matriko A in b
            if(mask(i, j) == 1)
                X = sparse(n1+n2, n1+n2);
                X(i,j+n1) = 1;
                A(:,count)= vec(X);
                b(count) = data(i, j);
                count = count + 1;
            end
        end
    end 
    %oznacimo da minimiziramo trace
    e = vec(eye(n1 + n2)); 

    %Podamo dimenzije omejitev
    K.s = n1 + n2;

    %uporabimo orodje sedumi
    [x,y,info] = sedumi(A,b,e,K);
    Y = reshape(x,n1 + n2, n1 + n2);

    Y = Y(1:n1, n1 + 1:(n1 + n2));