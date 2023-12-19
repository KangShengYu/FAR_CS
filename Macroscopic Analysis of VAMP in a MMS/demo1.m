% Input:y,A,lambda,tau,Kit
% Output:x_hat_wl,x_hat_d
clear;
clc;
% rng(1); % 随机种子

%% test_稀疏向量
% 设定稀疏度
k = 100; % 设定稀疏度

% 构造感知矩阵D
m = 768; % 感知矩阵行数
n = 1024; % 感知矩阵列数 （n>>m）

% D = randn(m,n);     % 生成满足高斯分布的感知矩阵 64*256

F = dftmtx(n);
row_indices = randperm(n, m);
D = F(row_indices, :);

% 构造稀疏信号X——共n个元素，其中k个元素不为0
X = zeros(n, 1);
index = randperm(n, k);
val = randn(1, k);
X(index) = val;

% 得到观测矩阵（压缩后）
A = D * X;

%%
% % 通过cVMAP算法完成恢复X，得到恢复后信号
lambda = ones(n, 1) ./ 10;
[x_hat_wl, x_hat_d] = cVAMP(A, D, lambda, 1e-4, 200);

%%
% 显示结果
figure;
subplot(3, 1, 1)
stem(X);
title('origin signal')
subplot(3, 1, 2)
stem(x_hat_wl);
title('restored signal')
subplot(3, 1, 3)
stem(X - x_hat_wl);
title('differ')
