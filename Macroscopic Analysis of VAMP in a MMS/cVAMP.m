% Input:y,A,lambda,tau,Kit
% Output:x_hat_wl,x_hat_d

function [x_hat_wl, x_hat_d] = cVAMP(y, A, lambda, tau, Kit)
    % Initialization
    gamma = 768 ./ 1024;
    k = 0;
    p = ctranspose(A) * y;
    h_1 = p;
    Q_1 = gamma;
    tau_d = 1;

    % while
    while (k < Kit) && (tau_d > tau)
        % Factorized Part
        x_1 = ST(h_1, lambda, Q_1); % \hat{x}_1^{(k)}
        chi_1 = F1(x_1, lambda, Q_1); % \chi_1^{(k)}
        % Message Passing
        h_2 = x_1 ./ chi_1 - h_1; % h_2^{(k)}
        Q_2 = 1 ./ chi_1 - Q_1; % \hat{Q}_2^{(k)}
        % Gaussian Part
        t1 = (p + h_2) ./ Q_2;
        t2 = ctranspose(A) * (A * (p + h_2)) / ((Q_2 + 1) * Q_2);
        x_2 = t1 + t2; % \hat{x}_2^{(k)}
        chi_2 = gamma ./ (Q_2 + 1) + (1 - gamma) ./ Q_2;
        % Message Passing
        h_1_next = x_2 ./ chi_2 - h_2;
        Q_1_next = 1 ./ chi_2 - Q_2;
        tau_d = norm(h_1_next - h_1) ./ norm(h_1_next);
        k = k + 1;
        % output
        x_hat_wl = x_1;
        x_hat_d = h_1_next ./ Q_1_next;
        % next
        h_1 = h_1_next;
        Q_1 = Q_1_next;
    end

end

% SoftThreshold function
function x = ST(h_1, lambda, Q_1)
    [N, M] = size(h_1);
    x = zeros(N, M);

    for i = 1:N
        % sign = h_1(i) ./ abs(h_1(i));
        diff = abs(h_1(i)) - lambda(i);
        x(i) = sign(h_1(i)) .* (diff ./ Q_1) .* SF(diff);
    end

end

% Heaviside's step function
function v = SF(a)
    % if a > 0
    %     v = 1;
    % elseif a == 0
    %     v = 0;  % at zero points
    % else
    %     v = 0;
    % end
    v = heaviside(a);
end

% SoftThreshold function
function v = F1(x_1, lambda, Q_1)
    [N, M] = size(x_1);
    count = 0;

    for i = 1:N
        temp = Q_1 .* abs(x_1(i)) + lambda(i);
        count = count + (2 - lambda(i) ./ temp) .* SF(abs(x_1(i)));
    end

    v = count ./ (2 .* N .* Q_1);
end
