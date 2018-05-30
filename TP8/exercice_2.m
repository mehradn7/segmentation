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

fprintf('Tapez un caractere pour lancer le GraphCut\n');
pause;

matrice_potts = beta * (ones(n,n) - eye(n));
[gch] = GraphCut('open',attache_donnees,matrice_potts);
[gch,labels] = GraphCut('expand',gch);
[gch] = GraphCut('close',gch);

% Affichage de l'image finale:
	for i = 1:nb_lignes
		for j = 1:nb_colonnes
			couleur_pixels(i,j,:) = couleur_classes(1 + labels(i,j),:);
		end
	end
	imagesc(couleur_pixels);
    title('Résultat final', 'FontSize', 20)
	axis image off;


% Calcul du pourcentage de pixels correctement classes :
load classification_OK;
pixels_correctement_classes = find(y2== 1+labels);
fprintf('Pixels correctement classes : %.2f %%\n',100*length(pixels_correctement_classes(:))/(nb_lignes*nb_colonnes));
