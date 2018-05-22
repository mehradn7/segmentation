clear;
close all;

% Initialisation des parametres :
exercice_0;

% Valeurs initiales des proportions :
pi_1 = n_1/(n_1+n_2);
pi_2 = n_2/(n_1+n_2);

% Algorithme EM :
score_1_courant = 0;
score_1_nouveau = 1;
score_2_courant = 0;
score_2_nouveau = 1;
seuil = 0.001;
k = 1;
while abs(score_1_nouveau-score_1_courant)>seuil | abs(score_2_nouveau-score_2_courant)>seuil

	% Calcul des probabilites d'appartenance aux deux classes et mise a jour des proportions :
	[probas_1,probas_2,pi_1,pi_2] = ...
		probabilites(donnees,n,F_1_1,F_2_1,a_1,pi_1,sigma_1,F_1_2,F_2_2,a_2,pi_2,sigma_2);

	% Partition des donnees :
	indices_1 = find(probas_1>=probas_2);
	donnees_1 = donnees(:,indices_1);
	indices_2 = find(probas_1<probas_2);
	donnees_2 = donnees(:,indices_2);

	% Affichage de la partition :
	figure(2);
	affichage_ellipse(C_1,theta_1,a_1,b_1,theta_points_ellipse,'c-');
	hold on;
	plot(donnees_1(1,:),donnees_1(2,:),'c*');
	affichage_ellipse(C_2,theta_2,a_2,b_2,theta_points_ellipse,'m-');
	plot(donnees_2(1,:),donnees_2(2,:),'m*');
	axis equal;
	axis(echelle);
	legend(' Densite estimee 1',' Classe 1',' Densite estimee 2',' Classe 2','Location','Best');
	hold off;
	set(gca,'FontSize',20);
	xlabel('$x$','Interpreter','Latex','FontSize',30);
	ylabel('$y$','Interpreter','Latex','FontSize',30);
	drawnow;

	% Estimation des parametres de l'ellipse correspondant a la classe 1 :
	X_1 = estimation_ponderee(x,y,probas_1);

	% Conversion des parametres de la premiere ellipse :
	[C_1,theta_1,a_1,b_1] = conversion(X_1);
	v_1 = [cos(theta_1) ; sin(theta_1)];
	c_1 = sqrt(a_1*a_1-b_1*b_1);
	F_1_1 = C_1-c_1*v_1;
	F_2_1 = C_1+c_1*v_1;

	% Estimation des parametres de l'ellipse correspondant a la classe 2 :
	X_2 = estimation_ponderee(x,y,probas_2);

	% Conversion des parametres de la deuxieme ellipse :
	[C_2,theta_2,a_2,b_2] = conversion(X_2);
	v_2 = [cos(theta_2) ; sin(theta_2)];
	c_2 = sqrt(a_2*a_2-b_2*b_2);
	F_1_2 = C_2-c_2*v_2;
	F_2_2 = C_2+c_2*v_2;

	% Affichage du resultat :
	figure(3);
	plot(x,y,'r*');
	hold on;

	% Correspondance entre ellipses et calcul des scores :
	score_1_1 = scores(F_1_1_reel,F_2_1_reel,a_1_reel,F_1_1,F_2_1,a_1);
	score_2_2 = scores(F_1_2_reel,F_2_2_reel,a_2_reel,F_1_2,F_2_2,a_2);
	score_sans_echange = (score_1_1+score_2_2)/2;
	score_2_1 = scores(F_1_2_reel,F_2_2_reel,a_2_reel,F_1_1,F_2_1,a_1);
	score_1_2 = scores(F_1_1_reel,F_2_1_reel,a_1_reel,F_1_2,F_2_2,a_2);
	score_avec_echange = (score_2_1+score_1_2)/2;
	disp(['Tour de boucle numero ' num2str(k) ' :']);
	if score_sans_echange>score_avec_echange
		affichage_ellipse(C_1,theta_1,a_1,b_1,theta_points_ellipse,'b-');
		affichage_ellipse(C_2,theta_2,a_2,b_2,theta_points_ellipse,'g-');
		disp(['Score ellipse 1 = ' num2str(score_1_1,'%.3f')]);
		disp(['Score ellipse 2 = ' num2str(score_2_2,'%.3f')]);
		score_1_courant = score_1_nouveau;
		score_1_nouveau = score_1_1;
		score_2_courant = score_2_nouveau;
		score_2_nouveau = score_2_2;
	else
		affichage_ellipse(C_2,theta_2,a_2,b_2,theta_points_ellipse,'b-');
		affichage_ellipse(C_1,theta_1,a_1,b_1,theta_points_ellipse,'g-');
		disp(['Score ellipse 1 = ' num2str(score_2_1,'%.3f')]);
		disp(['Score ellipse 2 = ' num2str(score_1_2,'%.3f')]);
		score_1_courant = score_1_nouveau;
		score_1_nouveau = score_2_1;
		score_2_courant = score_2_nouveau;
		score_2_nouveau = score_1_2;
	end
	axis equal;
	axis(echelle);
	legend(' Donnees',' Ellipse 1',' Ellipse 2','Location','Best');
	hold off;
	set(gca,'FontSize',20);
	xlabel('$x$','Interpreter','Latex','FontSize',30);
	ylabel('$y$','Interpreter','Latex','FontSize',30);
	drawnow;

	pause(0.1);
	k = k+1;
end
