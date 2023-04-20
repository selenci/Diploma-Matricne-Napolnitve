n1 = 10000
n2 = 10000
r = 30;

M1 = randn(n1, r);
M2 = randn(n2, r);

x1 = M1 * M2';

A = zeros(n1, n2);
M = zeros(n1, n2);

for i = 1:n1
    i
    for j = 1:n2
        if(rand() <= 0.03)
            A(i, j) = x1(i, j);
            M(i, j) = 1;
        end
    end
end

Y = solver(sparse(A), sparse(M), "svt");
lowrank = sum(svd(x1))
gotten = sum(svd(Y))