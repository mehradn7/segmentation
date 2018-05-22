function X = estimation(x,y)

n = size(x,1);
A = [x.*x x.*y y.*y x y ones(n,1)];
[V,D] = eig(transpose(A)*A);
[valeurs_triees,indices_tries] = sort(diag(D),'ascend');
X = V(:,indices_tries(1));
