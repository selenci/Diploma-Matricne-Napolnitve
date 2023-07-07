function A = laplac(A, mask)
    Anew = A;
    [n1, n2] = size(A);
    parameter = 1
    while parameter > 1e-4

        for i = 1:n1
            for j = 1:n2
                if(mask(i, j) == 0)
                    vsota = 0;
                    count = 0;
                    [vsota, count] = dodaj(A, i + 1, j, vsota, count);
                    [vsota, count] = dodaj(A, i - 1, j, vsota, count);
                    [vsota, count] = dodaj(A, i, j + 1, vsota, count);
                    [vsota, count] = dodaj(A, i, j - 1, vsota, count);
                    Anew(i, j) = vsota / count;
                end
            end
        end
        parameter = norm(Anew - A, "fro")
        A = Anew;
    end
end

function [vsota, count] = dodaj(A, i, j, vsota, count)
    [n1, n2] = size(A);
    if i >= 1 && i <= n1 && j >= 1 && j <= n2
        vsota = vsota + A(i, j);
        count = count + 1;
    end
end

