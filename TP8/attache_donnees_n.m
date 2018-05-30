function attache_donnees = attache_donnees_n(I,poids, moyennes,variances)

n = length(poids);
N = 2; % nombre de classes (fond, forme)
[p,q] = size(I);
attache_donnees = zeros(p,q,N);

for k=1:N
    attache_donnees(:,:,k) = attache_donnees(:,:,k) + (poids(k)/(sqrt(2*pi)*variances(k)))*exp(-((I(:,:)-moyennes(k)).^2)/(2*variances(k).^2));
    attache_donnees(:,:,k) = -log(attache_donnees(:,:,k));
end
end