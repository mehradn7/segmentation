clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

nuage;

% Affichage du nuage :
figure('Name','Recherche du mode le plus proche','Position',[0.1*L,0,0.8*L,H]);
axis equal;
axis([x_min x_max y_min y_max]);
hold on;
for i = 1:size(X,1)
	plot(X(i,1),X(i,2),'.','Color',couleurs(classe(i)),'MarkerSize',12);
end
set(gca,'FontSize',20);
xlabel('$x$','Interpreter','Latex','FontSize',30);
ylabel('$y$','Interpreter','Latex','FontSize',30);
title('Cliquez sur un point de la figure !','FontSize',20);

% Parametres du mean-shift :
h = 3;
k_max = 10;
epsilon = 0.005;

% Boucle de recherche du mode le plus proche :
while true

	% Choix d'un point par l'utilisateur :
	pause(0.1);
	x_0 = ginput(1);

	% Recherche du mode le plus proche par mean-shift :
	x_k = meanshift(X,x_0,h^2,k_max,epsilon);

	% Affichage du chemin de x_0 au mode le plus proche :
	plot(x_k(:,1),x_k(:,2),'-r','MarkerSize',10,'LineWidth',2);
	title('Cliquez sur un nouveau point !','FontSize',20);
end
