function x_k = meanshift(X,x_0,h_carre,k_max,epsilon)

n = size(X,1);
deja_converge = 0;
k = 1;
x_k = x_0;
x = x_0;
while ~deja_converge & k<=k_max
	% Distances avec les points du nuage :
	ecarts_carre = (ones(n,1)*x-X).^2;
	distances_carre = sum(ecarts_carre,2);

	% Points du voisinage :
	indices = find(distances_carre<=h_carre);

	% Moyenne des points du voisinage :
	M = mean(X(indices,:),1);	

	% L'iteration a-t-elle converge :
	if sum((x_0-M).^2)<epsilon
		deja_converge = 1;
	end

	% Remplacement par la moyenne (mean-shift) :
	x = M;
	x_k = [x_k ; x];
	k = k+1;
end
