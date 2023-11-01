N = 100;
M = 100;
T = 50;

prob = zeros(N, M);
for n = 1: N
    parfor s = 1: M
        prob(n, s) = get_recovery_prob(n, s, T);
    end
end
c