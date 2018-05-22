clear;
close all;

load donnees_reelles;

% Affichage de l'image en niveaux de gris :
figure('Name','Image reelle','Position',[0,0,0.33*L,0.5*H]);
imagesc(I);
axis image off;
colormap gray;
drawnow;

% Parametres :
n = length(x);
n_1 = floor(n/2);
pi_1 = n_1/n;
n_2 = n-n_1;
pi_2 = n_2/n;
nb_tirages = 500;
delta_x = x_max-x_min;
delta_y = y_max-y_min;
delta = min(delta_x,delta_y);
sigma_1 = delta/2;
sigma_2 = delta/2;

% Maximisation de la vraisemblance par tirages aleatoires :
for k=1:nb_tirages
    mu1_x = x_min + rand*(x_max-x_min);
    mu1_y = y_min + rand*(y_max-y_min);
    mu2_x = x_min + rand*(x_max-x_min);
    mu2_y = y_min + rand*(y_max-y_min);

    
    
end

% Initialisation des vraisemblances des donnees relativement aux deux lois normales :


% Partition des donnees :


% Affichage de la partition dans l'espace (moyenne,variance) :
figure('Name','Partition des donnees','Position',[0.33*L,0,0.33*L,0.5*H]);
hold on;
plot(x_1,y_1,'g.');
plot(x_2,y_2,'b.');
axis equal;
x_min = min(x);
x_max = max(x);
y_min = min(y);
y_max = max(y);
set(gca,'FontSize',20);
xlabel('Moyenne','FontSize',30);
ylabel('Variance','FontSize',30);
echelle = [x_min x_max y_min y_max];
axis(echelle);

% Affichage de la partition de l'image :
figure('Name','Segmentation par l''algorithme EM','Position',[0.66*L,0,0.33*L,0.5*H]);
hold on;
plot(coordonnees(classe_1,2),coordonnees(classe_1,1),'g.','MarkerSize',12);
plot(coordonnees(classe_2,2),coordonnees(classe_2,1),'b.','MarkerSize',12);
axis image off;
axis ij;
axis([1 nb_colonnes 1 nb_lignes]);

% Estimation des parametres de la loi normale associee a la premiere classe :


% Estimation des parametres de la loi normale associee a la deuxieme classe :


% Estimation en boucle :
while 0

	pause(0.5);

	% Calcul des vraisemblances des donnees relativement aux deux lois normales estimees :


	% Partition des donnees :


	% Affichage de la partition dans l'espace (moyenne,variance) :


	% Affichage de la partition de l'image :


	% Estimation des parametres de la loi normale associee a la premiere classe :


	% Estimation des parametres de la loi normale associee a la deuxieme classe :

end
