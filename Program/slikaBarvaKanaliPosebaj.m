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
algoritem = "tnnm"
r = 1
tic
R = solver(sparse(A(:, :, 1)), sparse(M), algoritem, r);
G = solver(sparse(A(:, :, 2)), sparse(M), algoritem, r);
B = solver(sparse(A(:, :, 3)), sparse(M), algoritem, r);
Y = cat(3, R, G, B);
casIzvajanja = toc
napaka = norm(Y - cast(img,"double") , "fro")
% bestNapaka = inf
% bestInd = 0
% for r = 1:100
%     R = solver(sparse(A(:, :, 1)), sparse(M), algoritem, r);
%     G = solver(sparse(A(:, :, 2)), sparse(M), algoritem, r);
%     B = solver(sparse(A(:, :, 3)), sparse(M), algoritem, r);
%     Y = cat(3, R, G, B)
%     napaka = norm(Y - cast(img,"double") , "fro")
%     if(napaka < bestNapaka)
%         bestNapaka = napaka
%         bestInd = r
%     end
% end


imshow(cast(A, "uint8"))
imshow(cast(Y, "uint8"))
