img = imread('slika.jpg');
img = rgb2gray(img);
norma = norm(cast(img,"double"), "fro")
[n1, n2] = size(img)
A = zeros(n1, n2);
M = zeros(n1, n2);

for i = 1:n1
    for j = 1:n2
        if(rand() <= 0.35)
            A(i, j) = img(i, j);
            M(i, j) = 1;
        end
    end
end

tic
Y = solver(sparse(A), sparse(M), "asd", 400);
casIzvajanja = toc

napaka = norm(Y - cast(img,"double") , "fro")

Aimg = cast(A, "uint8");
Yimg = cast(Y, "uint8");

figure(1)
imshow(Aimg);
figure(2)
imshow(Yimg);

