%% Exercice 3
clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

couleur_classes = [0 0.1250 1.0 ; 0.1750 1.0 0.2250 ; 1.0 1.0 0 ; 1.0 0.3750 0 ; 0.85 0 0 ; 0.5 0 0.3];

% Parametres du modele :
n = 2;			% Nombre de lois normales
beta = 10;		% Hyper-parametre

% Lecture et affichage de l'image a segmenter :
x = imread('Images/avion.jpg');
x = rgb2gray(x);
[nb_lignes,nb_colonnes] = size(x);
x = double(x);
figure('Name','Segmentation par classification','Position',[0,0,L,0.8*H]);
subplot 121;
colormap gray;
imagesc(x);
axis image off;
title('Image a segmenter','FontSize',20);

% Calcul et affichage de la configuration initiale k :
% Sélection d'un rectangle qui correspond à la forme : 
% 1 = forme, 2 = fond
[x1, y1] = ginput(1);
[x2, y2] = ginput(1);
x_min = min(x1,x2);
x_max = max(x1,x2);
y_min = min(y1,y2);
y_max = max(y1,y2);

k = 2*ones(size(x,1), size(x,2));
matrice_potts = beta * (ones(n,n) - eye(n));

for i=1:size(x,1)
    for j = 1:size(x,2)
        if(i>=x_min) && (i<= x_max) && (j>=y_min) && (j<= y_max)
            k(i,j) = 1;
        end
    end
end

continuer = true;
while continuer

    % Estimation des parametres des n lois normales :
    
    [poids,moyennes,variances] = estimation(k(:),x,n);

    % Permutation des parametres pour le calcul des bonnes classifications :
    [moyennes,indices] = sort(moyennes,'ascend');
    variances = variances(indices);
    poids = poids(indices);

    % Calcul de la vraisemblance relativement a chaque classe :
    attache_donnees = attache_donnees_n(x,poids,moyennes,variances);
    
    [gch] = GraphCut('open',attache_donnees,matrice_potts);
    [gch,nouveau_k] = GraphCut('expand',gch);
    nouveau_k = 1+nouveau_k;
    [gch] = GraphCut('close',gch);
    
    k_vect = k(:);
    nouveau_k_vect = nouveau_k(:);
    
    %% A FINIR
    
end

subplot 122;
imagesc(couleur_pixels);
axis image off;
title('Maximum de vraisemblance','FontSize',20);

fprintf('Tapez un caractere pour lancer le recuit simule\n');
pause;
