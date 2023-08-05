%nalozimo sliko
img = imread('mesto.jpg');
znanihVrednosti = 0.35;
[n1, n2, n3] = size(img)
A = zeros(n1, n2, n3);
M = zeros(n1, n2);

for i = 1:n1
    for j = 1:n2
        %z verjetnostjo znanihVrednosti piksel poznamo, matriko pretvorimo v pokoncno
        if(rand() <= znanihVrednosti)
            for z = 0:(n3 - 1)
                A(i, j, :) = img(i, j, :);
                M(i, j) = 1;
            end
        end
    end
end
imshow(cast(A, "uint8"))

%izberemo algoritem, resujemo za vsak kanal posebej
algoritem = "lmafit"
r = 20
tic
R = solver(sparse(A(:, :, 1)), sparse(M), algoritem, r);
G = solver(sparse(A(:, :, 2)), sparse(M), algoritem, r);
B = solver(sparse(A(:, :, 3)), sparse(M), algoritem, r);

%rezultate zdruzimo
Y = cat(3, R, G, B);
casIzvajanja = toc

%izracunamo napako
napaka = norm(Y - cast(img,"double") , "fro")

%prikazemo slike
imshow(cast(A, "uint8"))
imshow(cast(Y, "uint8"))
