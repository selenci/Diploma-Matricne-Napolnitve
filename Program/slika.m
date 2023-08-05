%nalozimo sliko
img = imread('dvobarvna.png');
znanihVrednosti = 0.6;

%pretvorimo v crno belo
img = rgb2gray(img);
norma = norm(cast(img,"double"), "fro")
[n1, n2] = size(img)
A = zeros(n1, n2);
M = zeros(n1, n2);

for i = 1:n1
    for j = 1:n2
        %z verjetnostjo znanihVrednosti piksel poznamo
        if(rand() <= znanihVrednosti)
            A(i, j) = img(i, j);
            M(i, j) = 1;
        end
    end
end

%zazenemo na poljubnem algoritmu, tic meri cas
tic
Y = solver(A, M, "tnnm", 1);
casIzvajanja = toc

%izracun napak
napaka = norm(Y - cast(img,"double") , "fro")

%prikazemo slike
Aimg = cast(A, "uint8");
Yimg = cast(Y, "uint8");

figure(1)
imshow(Aimg);
figure(2)
imshow(Yimg);

