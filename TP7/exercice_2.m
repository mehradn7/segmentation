clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

% Parametres communs aux differents tests :
reduction = 0.25;			% Coefficient de reduction des images
k_max = 100; 
epsilon = 0.01;

% Parametres specifiques aux differents tests :
images = {'oignon.png','piments.png','pommes.png','guadeloupe.jpg'};
valeurs_T = [15 20 15 15];		% Parametres a ajuster
valeurs_h = [20 15 15 15];		% Parametres a ajuster
positions = {[0,0.5*H,0.5*L,0.37*H],[0.5*L,0.5*H,0.5*L,0.37*H],[0,0,0.5*L,0.37*H],[0.5*L,0,0.5*L,0.37*H]};

for i = 1:length(images)

	% Lecture et affichage de l'image a segmenter :
	nom_fichier = fullfile('Images/', images{i});
	I = imread(nom_fichier);
	I = imresize(I,reduction);
	[nb_lignes,nb_colonnes,nb_canaux] = size(I);
	figure('Name',nom_fichier,'Position',positions{i});
	subplot(1,2,1);
	imagesc(I);
	axis image off;
	T = valeurs_T(i);
	h = valeurs_h(i);
	t = title(['$(T,h) = ($' num2str(T) '$,$' num2str(h) ')'],'Interpreter','Latex','FontSize',20); 
	p = get(t,'Position');
 	set(t,'Position',p+[0 0.5 0]);

	% Conversion de l'image au format LUV :
	I = double(I)/255; 
	I = transpose(reshape(I(:),nb_lignes*nb_colonnes,3));
	I = rgb2luv(I);
	I = reshape(transpose(I),nb_lignes,nb_colonnes,nb_canaux);

	% Segmentation par la methode mean-shift :
	[S,C] = meanshift_2(I,T,h^2,k_max,epsilon);

	% Conversion de l'image segmentee au format RVB :
	S = transpose(S(:));
	S = transpose(reshape(S,length(S)/3,3));
	S = luv2rgb(S);
	S = reshape(transpose(S),nb_lignes,nb_colonnes,nb_canaux);

	% Affichage de l'image segmentee :
	figure(i);
	subplot(1,2,2);
	imagesc(S);
	axis image off;
	title(['Partition en ' num2str(C) ' classes'],'FontSize',20);
	drawnow;
end
