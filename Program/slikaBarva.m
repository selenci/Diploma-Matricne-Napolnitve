img = imread('mesto.jpg');
znanihVrednosti = 0.35;
[n1, n2, n3] = size(img)
A = zeros(n1*n3, n2);
M = zeros(n1*n3, n2);

for i = 1:n1
    for j = 1:n2
        if(rand() <= znanihVrednosti)
            for z = 0:(n3 - 1)
                A(i + n1*z, j) = img(i, j, z + 1);
                M(i + n1*z, j) = 1;
            end
        end
    end
end




Aimg = transform(A, n3);

tic
Y = solver(sparse(A), sparse(M), "tnnm", 1);
casIzvajanja = toc

Yimg = transform(Y, n3);
napaka = norm(Yimg - cast(img, "double"), "fro")

% bestNapaka = inf
% bestInd = 0
% for r = 21:100
%     Y = solver(sparse(A), sparse(M), "lmafit", r);
%     Yimg = transform(Y, n3);
%     napaka = norm(Yimg - cast(img, "double"), "fro")
%     if(napaka < bestNapaka)
%         bestNapaka = napaka
%         bestInd = r
%     end
% end

Aimg = cast(Aimg, "uint8");
Yimg = cast(Yimg, "uint8");

figure(1)
imshow(Aimg);
figure(2)
imshow(Yimg);


function Y = transform(A, dimens)
    [n1, n2] = size(A);
    n1 = n1 / dimens;
    for z = 1:dimens
        Y(:, :, z) = A((z-1)*n1+1 : z*n1, :);
    end
end
