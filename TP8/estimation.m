function [poids,moyennes,variances] = estimation(configuration,x,n)

x = x(:);
% IDX = kmeans(x,n,'emptyaction','singleton','start','cluster');


poids = zeros(1,n);
moyennes = zeros(1,n);
variances = zeros(1,n);

for k=1:n
    indices_classe_k = find(configuration == k);
    poids(k) = length(x(indices_classe_k)) / length(x);
    moyennes(k) = sum(x(indices_classe_k)) / length(x(indices_classe_k));
    variances(k) = std(x(indices_classe_k))^2;
end
