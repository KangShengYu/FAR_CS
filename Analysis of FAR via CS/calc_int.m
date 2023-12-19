function I = calc_int(tau, m)

    if tau < 0
        I = 0;
    else
        syms x f;
        f = (x - tau) ^ 2 * x ^ (m - 1) * exp(-x ^ 2/2) / (2 ^ (m / 2 - 1) * gamma(m / 2));
        I = double(int(f, [tau, +inf]));
    end

end
