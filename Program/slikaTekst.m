img = imread('mestoTekst.png');

img = rgb2gray(img);
norma = norm(cast(img,"double"), "fro")
[n1, n2] = size(img)
A = zeros(n1, n2);
M = ones(n1, n2);

for i = 1:n1
    for j = 1:n2
        A(i, j) = img(i, j);
        if(img(i, j) == 0)
            M(i, j) = 0;
        end
    end
end

tic
Y = solver(sparse(A), sparse(M), "lmafit", 16);
casIzvajanja = toc
orgSlika = rgb2gray(imread('mesto.jpg'));
napaka = norm(Y - cast(orgSlika,"double") , "fro")

% bestNapaka = inf
% bestInd = 0
% for i = 1:100
%     Y = solver(A, M, "lmafit", i);
%     napaka = norm(Y - cast(orgSlika,"double") , "fro")
%     if(napaka < bestNapaka)
%         bestNapaka = napaka
%         bestInd = i
%     end
% end



Aimg = cast(A, "uint8");
Yimg = cast(Y, "uint8");

figure(1)
imshow(Aimg);
figure(2)
imshow(Yimg);

