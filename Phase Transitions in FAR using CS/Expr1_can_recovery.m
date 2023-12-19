function flg = Expr1_can_recovery(n, s, m, d, eps)
    theta = randn(n, m * d);

    x = zeros(d, 1);
    random_indices = randperm(d, s);
    x(random_indices) = randn(s, 1);
    x = sign(x);
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
