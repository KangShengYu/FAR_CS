N = 100;
M = 100;
T = 50;

prob = zeros(N, M);
parfor n = 1: N
    for s = 1: M
        prob(n, s) = get_recovery_prob(n, s, T);
    end
end
heatmap(prob)