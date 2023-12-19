function I = calc_integral(tau, m)

    if (~exist('m', 'var'))
        m = 1;
    end

    if tau < 0
        I = 0;
    else
        syms x f;
        f = (x - tau) ^ 2 * exp(-x ^ 2/2) * u ^ (m - 1) / (2 ^ (m / 2 - 1) * gamma(m / 2));
        I = double(int(f, [tau, +inf]));
    end

end
