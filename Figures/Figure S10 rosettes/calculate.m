function TRInew = calculate(p, TRI)
TRInew = TRI;
while size(TRInew, 1)-(2*size(unique(TRInew), 1)-4) ~= 0
    look = 1;
    while sum(look)
        E = edges(triangulation(TRInew, p(:, 1), p(:, 2), p(:, 3)));
        tal = zeros(size(E, 1), 1);
        USE = zeros(size(TRInew));
        for i = 1:size(E, 1)
            prov = (sum((TRInew == E(i, 1)) + (TRInew == E(i, 2)), 2) == 2);
            tal(i) = sum(prov);
            for j = find(prov == 1)'
                USE(j, find(USE(j, :) == 0, 1)) = tal(i);
            end
        end
        look = (sum(USE ~= 2, 2) > 1);
        TRInew(look == 1, :) = [];
    end
    a = 0; c = 1; k = 1; l = 0; r = 1; TRIadd = zeros(100, 3);
    lis = [E(tal == 1, :) zeros(sum(tal == 1), 3) tal(tal == 1)];
    while any(lis(:, 3) == 0)
        l = l + 1;
        lis(r, 3) = k;
        lis(r, 4) = l;
        lis(r, 5) = lis(r, c);
        [rn, cn] = find(lis == lis(r, abs(floor(c/2)-2)));
        if r == rn(1)
            r = rn(2);
            c = cn(2);
        else
            r = rn(1);
            c = cn(1);
        end
        if lis(r, 3) ~= 0
            [r, ~] = find(lis(:, 3) == 0, 1);
            k = k + 1;
            c = 1;
            l = 0;
        end
    end
    for i = 1:k-1
        lisN = lis(lis(:, 3) == i, :);
        v = sortrows(lisN, 4);
        for j = 3:size(v, 1)
            a = a + 1;
            TRIadd(a, :) = [v(1, 5) v(j-1, 5) v(j, 5)];
        end
    end
    TRIadd = sort(TRIadd(1:a, :), 2);
    TRInew = unique([TRInew; TRIadd], 'rows');
end