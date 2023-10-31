function x = get_recovery_prob(n, s, N)
    x = 0;
    for t = 1: N
        x = x + can_recovery(n, s);
    end
    x = x / N;
end