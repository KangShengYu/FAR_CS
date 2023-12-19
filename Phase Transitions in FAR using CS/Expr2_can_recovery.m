function flg = Expr2_can_recovery(n, s, d, eps)
    theta_real = randn(n, d);
    theta_imag = randn(n, d);
    theta = theta_real + 1j * theta_imag;

    x = zeros(d, 1);
    random_indices = randperm(d, s);
    x(random_indices) = randn(s, 1);

    for i = 1:d

        if x(i) ~= 0
            t = rand(1);
            x(i) = cos(t) + 1j * sin(t);
        end

    end

    y = theta * x;

    cvx_begin
    variable s1(d)
    minimize(norm(s1, 1))
    subject to
    norm(y - theta * s1) <= eps
    cvx_end

    p = norm(x - s1, 2);

    if p < eps
        flg = 1;
    else
        flg = 0;
    end

end
