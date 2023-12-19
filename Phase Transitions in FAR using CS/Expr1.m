% Expr1.m to draw Fig 2(a)

max_n = 125;
max_s = 35;
trials_time = 50;
m = 4;
d = 32;
eps = 1e-5;

prob = zeros(max_n, max_s);

for n = 1:max_n

    parfor s = 1:max_s
        x = 0;

        for t = 1:trials_time
            x = x + Expr1_can_recovery(n, s, m, d, eps);
        end

        prob(n, s) = x / trials_time;
    end

end

save("Expr1.mat", "prob");
