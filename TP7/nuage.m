clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

% Couleurs pour l'affichage des classes :
couleurs = ['g','b','c','m','r','k','y'];

% Parametres :
N = 3;
nb_points_min = 250;
nb_points_max = 300;
borne_sup = 10;
borne_inf = -borne_sup;
x_min = 1.5*borne_inf;
x_max = 1.5*borne_sup;
y_min = 1.5*borne_inf;
y_max = 1.5*borne_sup;
r_min = 1;
r_max = 10;
dimension = 2;

% Tirage du nuage de points :
X = [];
classe = [];
for k = 1:N
	nb_points_classe = floor((nb_points_max-nb_points_min)*rand+nb_points_min);
	mu = (borne_sup-borne_inf)*rand(1,dimension)+borne_inf;
	Sigma = diag((r_max-r_min)*rand(dimension,1)+r_min);
	[U,V] = hess(rand(dimension,dimension));
	Sigma = U*Sigma*U';
	R = chol(Sigma);
	X_k = repmat(mu,nb_points_classe,1)+randn(nb_points_classe,dimension)*R;
	X = [X ; X_k];
	classe = [classe ; k*ones(size(X_k,1),1)];
end
