function flg = can_recovery(n, s)
    d = 100;
    eps = 1e-5;
    theta = randn(n, d);
    
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

    p = norm(x-s1, 2);
    if p < eps
        flg = 1;
    else
        flg = 0;
    end
end
