load 'Expr 1.mat'
p = rot90(prob, 3);
imagesc(p)

set(gca, 'xtick', 1:10:100);
set(gca, 'xticklabel', {'0', '10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
xlabel('Sparsity of signal (s)')

set(gca, 'ytick', 1:10:100);
set(gca, 'yticklabel', {'0', '10', '20', '30', '40', '50', '60', '70', '80', '90', '100'})
ylabel('Number of Mersurements (n)')
