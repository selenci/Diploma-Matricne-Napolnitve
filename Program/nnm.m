function Y = nnm(data, M)
    n1 = size(M, 1);
    n2 = size(M, 2);
    m = sum( M , "all" ); %stevilo omejitev
    b = zeros(m, 1);

    A = zeros((n1 + n2)^2, m);

    count = 1;
    for i = 1:n1
        for j = 1:n2
            if(M(i, j) == 1)
                X = zeros(n1+n2);
                X(i,j+n1) = 1;
                A(:,count)= vec(X);
                b(count) = data(i, j);
                count = count + 1;
            end
        end
    end 
    

    e = vec(eye(n1 + n2)); 
    K.s = n1 + n2;
    [x,y,info] = sedumi(sparse(A),b,sparse(e),K);
    Y = reshape(x,n1 + n2, n1 + n2);

    Y = Y(1:n1, n1 + 1:(n1 + n2));