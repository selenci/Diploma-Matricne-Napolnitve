%nalozimo sliko
img = imread('mestoTekst.png');

img = rgb2gray(img);
norma = norm(cast(img,"double"), "fro")
[n1, n2] = size(img)
A = zeros(n1, n2);
M = ones(n1, n2);

for i = 1:n1
    for j = 1:n2
        A(i, j) = img(i, j);
        %ce je piksel crn ga oznacimo za neznanega
        if(img(i, j) == 0)
            M(i, j) = 0;
        end
    end
end

%zazenemo na poljubnem algoritmu, tic meri cas
tic
Y = solver(sparse(A), sparse(M), "lmafit", 16);
casIzvajanja = toc

%za izracun napake nalozimo nezasumljeno sliko
orgSlika = rgb2gray(imread('mesto.jpg'));
napaka = norm(Y - cast(orgSlika,"double") , "fro")

%slike prikazemo
Aimg = cast(A, "uint8");
Yimg = cast(Y, "uint8");

figure(1)
imshow(Aimg);
figure(2)
imshow(Yimg);

