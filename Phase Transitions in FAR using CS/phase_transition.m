% Eq 20
tau_min = 0;
tau_max = 100;
tau_interval = 0.1;
tau_range = tau_min:tau_interval:tau_max;

s_b_min = 1;
s_b_max = 100;
s_b_range = s_b_min:s_b_max;

result = zeros(32, 1);

cache_filename = "I.mat";

if exist(cache_filename, "file")
    load(cache_filename);
else
    I = zeros(length(tau_range), 0);

    for tau_idx = 1:length(tau_range)
        tau = tau_range(tau_idx);
        I(tau_idx) = calc_integral(tau);
    end

end

for s_b_idx = 1:length(s_b_range)
    s_b = s_b_range(s_b_idx);
    f_set = zeros(length(tau_range), 1);

    for tau_idx = 1:length(tau_range)
        tau = tau_range(tau_idx);
        f_set(tau_idx) = s_b * (1 + tau ^ 2) + (100 - s_b) * I(tau_idx);
    end

    result(s_b_idx) = min(f_set);
end
