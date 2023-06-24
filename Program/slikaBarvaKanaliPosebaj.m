img = imread('mesto.jpg');
znanihVrednosti = 0.35;
[n1, n2, n3] = size(img)
A = zeros(n1, n2, n3);
M = zeros(n1, n2);

for i = 1:n1
    for j = 1:n2
        if(rand() <= znanihVrednosti)
            for z = 0:(n3 - 1)
                A(i, j, :) = img(i, j, :);
                M(i, j) = 1;
            end
        end
    end
end
imshow(cast(A, "uint8"))

R = solver(sparse(A(:, :, 1)), sparse(M), "tnnm", 1);
G = solver(sparse(A(:, :, 2)), sparse(M), "tnnm", 1);
B = solver(sparse(A(:, :, 3)), sparse(M), "tnnm", 1);

Y = cat(3, R, G, B)

imshow(cast(A, "uint8"))
imshow(cast(Y, "uint8"))
