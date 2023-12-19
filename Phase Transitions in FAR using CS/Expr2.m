% Expr2.m to draw Fig 2(b)

max_n = 100;
max_s = 100;
trials_time = 50;
d = 100;
eps = 1e-5;

prob = zeros(max_n, max_s);

for n = 1:max_n

    for s = 1:max_s
        x = 0;

        for t = 1:trials_time
            x = x + Expr2_can_recovery(n, s, d, eps);
        end

        prob(n, s) = x / trials_time;
    end

end

save("Expr2.mat", "prob");
