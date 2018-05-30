clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

couleur_classes = [0 0.1250 1.0 ; 0.1750 1.0 0.2250 ; 1.0 1.0 0 ; 1.0 0.3750 0 ; 0.85 0 0 ; 0.5 0 0.3];

% Parametres du modele :
n = 6;			% Nombre de lois normales
beta = 10;		% Hyper-parametre

% Lecture et affichage de l'image a segmenter :
x = imread('Images/image.bmp');
[nb_lignes,nb_colonnes] = size(x);
x = double(x);
figure('Name','Segmentation par classification','Position',[0,0,L,0.8*H]);
subplot 121;
imagesc(x);
colormap gray;
axis image off;
title('Image a segmenter','FontSize',20);

% Estimation des parametres des n lois normales :
[poids,moyennes,variances] = estimation(x,n);


% Permutation des parametres pour le calcul des bonnes classifications :
[moyennes,indices] = sort(moyennes,'ascend');
variances = variances(indices);
poids = poids(indices);

% Calcul de la vraisemblance relativement a chaque classe :
attache_donnees = attache_donnees(x,moyennes,variances);

% Calcul et affichage de la configuration initiale k :
[U,k] = min(attache_donnees,[],3);
couleur_pixels = zeros(nb_lignes,nb_colonnes,3);
for i = 1:nb_lignes
	for j = 1:nb_colonnes
		couleur_pixels(i,j,:) = couleur_classes(k(i,j),:);
	end
end
subplot 122;
imagesc(couleur_pixels);
axis image off;
title('Maximum de vraisemblance','FontSize',20);

fprintf('Tapez un caractere pour lancer le recuit simule\n');
pause;

% Parametres du recuit simule :
q_max = 100;		% Nombre d'iterations
T_0 = 1.0;		% Temperature initiale
alpha = 0.99;		% Coefficient de decroissance de la temperature

% Initialisation de l'energie U :
for i = 1:nb_lignes
	for j = 1:nb_colonnes
		U(i,j) = U(i,j)+a_priori(i,j,k,k(i,j),beta);
	end
end

% Boucle du recuit simule :
T = T_0;
for q = 1:q_max
	for i = 1:nb_lignes
		for j = 1:nb_colonnes
			k_cour = k(i,j);
			U_cour = U(i,j);
			k_nouv = ceil(rand*n);
			while k_nouv==k_cour
				k_nouv = ceil(rand*n);
			end

			% Calcul de l'energie correspondant a la nouvelle classe :
			U_nouv = attache_donnees(i,j,k_nouv)+a_priori(i,j,k,k_nouv,beta);

			% Dynamique de Metropolis :
			[k(i,j),U(i,j)] = recuit_simule(k_cour,k_nouv,U_cour,U_nouv,T);
		end
	end

	% Affichage de la configuration courante :
	for i = 1:nb_lignes
		for j = 1:nb_colonnes
			couleur_pixels(i,j,:) = couleur_classes(k(i,j),:);
		end
	end
	imagesc(couleur_pixels);
	axis image off;
	title(['Recuit simule : iteration ' num2str(q) '/' num2str(q_max)],'FontSize',20);
	pause(0.05);

	T = alpha*T;
end

% Calcul du pourcentage de pixels correctement classes :
load classification_OK;
pixels_correctement_classes = find(k==y2);
fprintf('Pixels correctement classes : %.2f %%\n',100*length(pixels_correctement_classes(:))/(nb_lignes*nb_colonnes));
