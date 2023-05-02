img = imread('slika.jpg');
img = rgb2gray(img);

[n1, n2] = size(img)
A = zeros(n1, n2)
M = zeros(n1, n2)

for i = 1:n1
    for j = 1:n2
        if(rand() <= 0.6)
            A(i, j) = img(i, j);
            M(i, j) = 1;
        end
    end
end

Y = solver(sparse(A), sparse(M), "svt");

Aimg = cast(A, "uint8");
Yimg = cast(Y, "uint8");

imshow(Aimg);
imshow(Yimg);

