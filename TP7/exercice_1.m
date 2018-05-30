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
subplot(1,2,1)
hold on;
for i = 1:size(X,1)
	plot(X(i,1),X(i,2),'.','Color',couleurs(classe(i)),'MarkerSize',12);
end
set(gca,'FontSize',20);
xlabel('$x$','Interpreter','Latex','FontSize',30);
ylabel('$y$','Interpreter','Latex','FontSize',30);
title('Données initiales','FontSize',20);

% Parametres du mean-shift :
h = 4;
k_max = 10;
epsilon = 0.005;

liste_pseudo_modes = [];
for k=1:size(X,1)
    x_k = meanshift(X,X(k,:),h^2,k_max,epsilon);
    liste_pseudo_modes = [liste_pseudo_modes ; x_k(end,:)];
end

plot(liste_pseudo_modes(:,1), liste_pseudo_modes(:,2), '*r');

nouvelles_classes = zeros(size(X,1), 1);
compteur_classe = 0;
for k=1:size(liste_pseudo_modes,1)
    if (nouvelles_classes(k) == 0)
        distances_carrees_aux_autres_modes = ((liste_pseudo_modes(k,1) - liste_pseudo_modes(:,1)).^2 + (liste_pseudo_modes(k,2) - liste_pseudo_modes(:,2)).^2);

        indices_modes_proches = find(distances_carrees_aux_autres_modes < h^2);
        
        compteur_classe = compteur_classe + 1;
        nouvelles_classes(indices_modes_proches) = compteur_classe;

    end
end

subplot(1,2,2)
title([num2str(compteur_classe), ' classes trouvées'], 'FontSize', 20)
hold on;
for i=1:size(X,1)
    plot(X(i,1),X(i,2),'.','Color',couleurs(nouvelles_classes(i)),'MarkerSize',12);
end

