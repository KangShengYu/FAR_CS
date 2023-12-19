function flg = Expr3_can_recovery(Phi_far, N, M, n, s, eps)
    Phi = zeros(n, N * M);
    indices = randperm(N, n);

    for i = 1:n
        Phi(i, :) = Phi_far(indices(i), :);
    end
    d = M*N;
    x = zeros(d, 1);
    random_indices = randperm(d, s);
    x(random_indices) = randn(s, 1);
    x = sign(x);

    for i = 1:M * N

        if x(i) ~= 0
            t = rand(1) * 2 * pi;
            x(i) = cos(t) + 1j * sin(t);
        end

    end

    y = Phi * x;

    cvx_begin quiet
        variable s1(d) complex
        minimize(norm(s1, 1))
        subject to
        norm(y - Phi * s1) <= eps
    cvx_end

    x = sign(real(x));
    s1 = real(s1);
    
    p = norm(x - s1, 2);
    disp(p);

    if p < eps
        flg = 1;
    else
        flg = 0;
    end

end
