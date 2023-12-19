% Input:y,A,lambda,tau,Kit
% Output:x_hat_wl,x_hat_d
clear;
clc;
% rng(1); % �������

%% test_ϡ������
% �趨ϡ���
k = 100; % �趨ϡ���

% �����֪����D
m = 768; % ��֪��������
n = 1024; % ��֪�������� ��n>>m��

% D = randn(m,n);     % ���������˹�ֲ��ĸ�֪���� 64*256

F = dftmtx(n);
row_indices = randperm(n, m);
D = F(row_indices, :);

% ����ϡ���ź�X������n��Ԫ�أ�����k��Ԫ�ز�Ϊ0
X = zeros(n, 1);
index = randperm(n, k);
val = randn(1, k);
X(index) = val;

% �õ��۲����ѹ����
A = D * X;

%%
% % ͨ��cVMAP�㷨��ɻָ�X���õ��ָ����ź�
lambda = ones(n, 1) ./ 10;
[x_hat_wl, x_hat_d] = cVAMP(A, D, lambda, 1e-4, 200);

%%
% ��ʾ���
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
