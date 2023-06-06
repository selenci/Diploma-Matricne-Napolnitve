img = imread('knjigaTekst.tiff');
img = img(:,:,1:3);

img = rgb2gray(img);
norma = norm(cast(img,"double"), "fro")
[n1, n2] = size(img)
A = zeros(n1, n2);
M = zeros(n1, n2);

for i = 1:n1
    for j = 1:n2
        A(i, j) = img(i, j);
        M(i, j) = 1;
        if(img(i, j) == 0)
            M(i, j) = 0;
        end
    end
end

tic
Y = solver(sparse(A), sparse(M), "svt");
casIzvajanja = toc
orgSlika = rgb2gray(imread('knjiga.jpg'));

napaka = norm(Y - cast(orgSlika,"double") , "fro")


Aimg = cast(A, "uint8");
Yimg = cast(Y, "uint8");

figure(1)
imshow(Aimg);
figure(2)
imshow(Yimg);

