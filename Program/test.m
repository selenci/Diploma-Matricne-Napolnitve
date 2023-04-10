n1 = 100
n2 = 100
r = 10;

M1 = randn(n1, r);
M2 = randn(n2, r);

x1 = M1 * M2';

A = zeros(n1, n2);
M = zeros(n1, n2);

for i = 1:n1
    for j = 1:n2
        if(rand() <= 0.3)
            A(i, j) = x1(i, j);
            M(i, j) = 1;
        end
    end
end
M
Y = solver(A, M, "tnnm", r);

lowrank = sum(svd(x1))
gotten = sum(svd(Y))