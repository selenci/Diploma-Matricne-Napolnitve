n1 = 1000
n2 = 1000

x1 = randi([-10, 10], [n1,n2]);

[U, S, V] = svd(x1);
for i = 11:min(n1, n2)
    S(i, i) = 0;
end
x1 = U*S*V';

A = zeros(n1, n2);
M = zeros(n1, n2);

for i = 1:n1
    for j = 1:n2
        if(rand() <= 0.12)
            A(i, j) = x1(i, j);
            M(i, j) = 1;
        end
    end
end
M
Y = solver(A, M, "svt");

lowrank = sum(svd(x1))
gotten = sum(svd(Y))