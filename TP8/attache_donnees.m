function AD = attache_donnees(I,moyennes,variances)

N = length(moyennes);
[n,m] = size(I);
AD = zeros(n,m,N);

for i=1:N
    AD(:,:,i) = 0.5*log(variances(i)) + ...
        0.5* ((I-moyennes(i))/ sqrt(variances(i))).^2;
end
end