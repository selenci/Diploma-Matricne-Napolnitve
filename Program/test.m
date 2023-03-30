x1 = randi([-10, 10], [100,100]);

[U, S, V] = svd(x1);
for i = 6:100
    S(i, i) = 0;
end
x1 = U*S*V';

A = zeros(100);
M = zeros(100);

for i = 1:100
    for j = 1:100
        if(rand() <= 0.3)
            A(i, j) = x1(i, j);
            M(i, j) = 1;
        end
    end
end
M
Y = solver(A, M);

lowrank = sum(svd(x1))
gotten = sum(svd(Y))

