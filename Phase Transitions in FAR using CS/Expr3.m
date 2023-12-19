% Expr2.m to draw Fig 3(a)
clc;
clear;

M = 4;
N = 128;
rate = 0.02; % \Delta f / f_c = 0.02
beta = 1;

max_n = 125;
max_k = 25;
trials_time = 10;
eps = 1e-5;

prob = zeros(max_n, max_k);

rng(1)

Phi_far = zeros(N, N * M);

C = randi([0, M-1], 1, N);
vecn = 0:N-1;
xi = 1 + rate .* C;

for i = 1:N
    for j = 1:M
        t = (i-1)*M+j;
        temp = 1/sqrt(N) .* exp(1j * 2 * pi + (j-1) / M .* C + 1j * 2 * pi * (i-1)/N .* vecn .* xi);
        Phi_far(:, t) = temp;
    end
    disp(ctranspose(Phi_far(:,1)) * Phi_far(:,1))
end


% n = 60; 0
n = 70;
k = 7;

s = beta * k * M;
x = 0;

for t = 1:trials_time
    x = x + Expr3_can_recovery(Phi_far, N, M, n, s, eps);
end
disp(x);


for n = 1:max_n

    parfor k = 1:max_k
        s = beta * k * M;
        x = 0;

        for t = 1:trials_time
            x = x + Expr3_can_recovery(Phi_far, N, M, n, s, eps);
        end

        prob(n, k) = x / trials_time;
    end

end

save("Expr3.mat", "prob");
