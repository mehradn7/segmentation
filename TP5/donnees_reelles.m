clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

% Lecture et affichage d'une image en niveaux de gris :
% I = imread('Images/Lauren.png');
I = imread('Images/zebre.jpg');
[nb_lignes,nb_colonnes,nb_canaux] = size(I);
if nb_canaux==3
	I = rgb2gray(I);
end
figure('Name','Image a segmenter','Position',[0,0,0.33*L,0.5*H]);
imagesc(I);
axis image off;
colormap gray;
drawnow;

% Creation du nuage de points :
x = [];
y = [];
coordonnees = [];
T = 3;
for i = 1+T:nb_lignes-T
	for j = 1+T:nb_colonnes-T
		fenetre = I(i-T:i+T,j-T:j+T);
		fenetre = fenetre(:);
		moyenne = mean(fenetre);
		x = [x moyenne];
		fenetre_centree = fenetre-moyenne;
		variance = mean(fenetre_centree.^2);
		y = [y variance];
		coordonnees = [coordonnees ; i j];
	end
end

% Affichage du nuage de points :
figure('Name','Nuage a partitionner','Position',[0.33*L,0,0.33*L,0.5*H]);
hold on;
set(gca,'FontSize',20);
xlabel('Moyenne','FontSize',30);
ylabel('Variance','FontSize',30);
plot(x,y,'r.');
axis equal;
x_min = min(x);
x_max = max(x);
y_min = min(y);
y_max = max(y);
axis([x_min x_max y_min y_max]);

save donnees_reelles;
