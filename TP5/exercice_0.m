clear;
close all;

donnees_simulees;
drawnow;

% Definitions utiles pour le trace des ellipses :
nb_points_ellipse = 100;
deux_pi = 2*pi;
theta_points_ellipse = deux_pi/nb_points_ellipse:deux_pi/nb_points_ellipse:deux_pi;
x = transpose(donnees(1,:));
y = transpose(donnees(2,:));
x_min = min(x);
x_max = max(x);
delta_x = x_max-x_min;
y_min = min(y);
y_max = max(y);
delta_y = y_max-y_min;
distances_au_carre = [];
for i = 1:n
	distances_au_carre = [distances_au_carre ; sum((donnees(:,i)*ones(1,n)-donnees).^2)];
end
distance_max = sqrt(max(distances_au_carre(:)));

% Valeurs reelles des parametres pour le calcul des scores des ellipses :
F_1_1_reel = F_1_1;
F_2_1_reel = F_2_1;
a_1_reel = a_1;
F_1_2_reel = F_1_2;
F_2_2_reel = F_2_2;
a_2_reel = a_2;

% Recherche du maximum de vraisemblance par tirages aleatoires :
pi_1 = n_1/(n_1+n_2);
pi_2 = n_2/(n_1+n_2);
pi_1_sur_sigma_1 = pi_1/sigma_1;
pi_2_sur_sigma_2 = pi_2/sigma_2;
un_sur_2_sigma_1_carre = 1/(2*sigma_1*sigma_1);
un_sur_2_sigma_2_carre = 1/(2*sigma_2*sigma_2);
deux_a_1_liste = [];
e_1_liste = [];
C_1_liste = [];
theta_1_liste = [];
deux_a_2_liste = [];
e_2_liste = [];
C_2_liste = [];
theta_2_liste = [];
log_vraisemblance_liste = [];
nb_tirages = 10000;
for k = 1:nb_tirages
	deux_a_1_test = distance_max*rand;
	e_1_test = 0.25+rand/2;
	c_1_test = e_1_test*deux_a_1_test/2;
	C_1_test = [x_min+delta_x*rand ; y_min+delta_y*rand];
	theta_1_test = 2*pi*rand;
	v_1_test = [cos(theta_1_test) ; sin(theta_1_test)];
	F_1_1_test = C_1_test-c_1_test*v_1_test;
	F_2_1_test = C_1_test+c_1_test*v_1_test;

	deux_a_1_liste = [deux_a_1_liste deux_a_1_test];
	e_1_liste = [e_1_liste e_1_test];
	C_1_liste = [C_1_liste C_1_test];
	theta_1_liste = [theta_1_liste theta_1_test];

	P_i_F_1_1 = donnees-F_1_1_test*ones(1,n);
	distances_P_i_F_1_1 = sqrt(sum(P_i_F_1_1.*P_i_F_1_1));
	P_i_F_2_1 = donnees-F_2_1_test*ones(1,n);
	distances_P_i_F_2_1 = sqrt(sum(P_i_F_2_1.*P_i_F_2_1));
	ecarts_1 = distances_P_i_F_1_1+distances_P_i_F_2_1-deux_a_1_test;

	deux_a_2_test = distance_max*rand;
	e_2_test = 0.25+rand/2;
	c_2_test = e_2_test*deux_a_2_test/2;
	C_2_test = [x_min+delta_x*rand ; y_min+delta_y*rand];
	theta_2_test = 2*pi*rand;
	v_2_test = [cos(theta_2_test) ; sin(theta_2_test)];
	F_1_2_test = C_2_test-c_2_test*v_2_test;
	F_2_2_test = C_2_test+c_2_test*v_2_test;

	deux_a_2_liste = [deux_a_2_liste deux_a_2_test];
	e_2_liste = [e_2_liste e_2_test];
	C_2_liste = [C_2_liste C_2_test];
	theta_2_liste = [theta_2_liste theta_2_test];

	P_i_F_1_2 = donnees-F_1_2_test*ones(1,n);
	distances_P_i_F_1_2 = sqrt(sum(P_i_F_1_2.*P_i_F_1_2));
	P_i_F_2_2 = donnees-F_2_2_test*ones(1,n);
	distances_P_i_F_2_2 = sqrt(sum(P_i_F_2_2.*P_i_F_2_2));
	ecarts_2 = distances_P_i_F_1_2+distances_P_i_F_2_2-deux_a_2_test;

	log_f_P_i = log(pi_1_sur_sigma_1*exp(-un_sur_2_sigma_1_carre*ecarts_1.*ecarts_1)...
			+pi_2_sur_sigma_2*exp(-un_sur_2_sigma_2_carre*ecarts_2.*ecarts_2));

	log_vraisemblance_liste = [log_vraisemblance_liste sum(log_f_P_i)];
end
[log_vraisemblance_max,indice_max] = max(log_vraisemblance_liste);

% Parametres de la premiere densite estimee :
a_1_chapeau = deux_a_1_liste(1,indice_max)/2;
e_1_chapeau = e_1_liste(1,indice_max);
b_1_chapeau = a_1_chapeau*sqrt(1-e_1_chapeau^2);
c_1_chapeau = e_1_chapeau*a_1_chapeau;
C_1_chapeau = C_1_liste(:,indice_max);
theta_1_chapeau = theta_1_liste(1,indice_max);
v_1_chapeau = [cos(theta_1_chapeau) ; sin(theta_1_chapeau)];
F_1_1_chapeau = C_1_chapeau-c_1_chapeau*v_1_chapeau;
F_2_1_chapeau = C_1_chapeau+c_1_chapeau*v_1_chapeau;

% Parametres de la deuxieme densite estimee :
a_2_chapeau = deux_a_2_liste(1,indice_max)/2;
e_2_chapeau = e_2_liste(1,indice_max);
b_2_chapeau = a_2_chapeau*sqrt(1-e_2_chapeau^2);
c_2_chapeau = e_2_chapeau*a_2_chapeau;
C_2_chapeau = C_2_liste(:,indice_max);
theta_2_chapeau = theta_2_liste(1,indice_max);
v_2_chapeau = [cos(theta_2_chapeau) ; sin(theta_2_chapeau)];
F_1_2_chapeau = C_2_chapeau-c_2_chapeau*v_2_chapeau;
F_2_2_chapeau = C_2_chapeau+c_2_chapeau*v_2_chapeau;

% Calcul de la premiere densite estimee pour l'ensemble des donnees :
P_i_F_1_1_chapeau = donnees-F_1_1_chapeau*ones(1,n);
distances_P_i_F_1_1_chapeau = sqrt(sum(P_i_F_1_1_chapeau.*P_i_F_1_1_chapeau));
P_i_F_2_1_chapeau = donnees-F_2_1_chapeau*ones(1,n);
distances_P_i_F_2_1_chapeau = sqrt(sum(P_i_F_2_1_chapeau.*P_i_F_2_1_chapeau));
ecarts_1 = distances_P_i_F_1_1_chapeau+distances_P_i_F_2_1_chapeau-2*a_1_chapeau;
f_1_P_i = pi_1_sur_sigma_1*exp(-un_sur_2_sigma_1_carre*ecarts_1.*ecarts_1);

% Calcul de la deuxieme densite estimee pour l'ensemble des donnees :
P_i_F_1_2_chapeau = donnees-F_1_2_chapeau*ones(1,n);
distances_P_i_F_1_2_chapeau = sqrt(sum(P_i_F_1_2_chapeau.*P_i_F_1_2_chapeau));
P_i_F_2_2_chapeau = donnees-F_2_2_chapeau*ones(1,n);
distances_P_i_F_2_2_chapeau = sqrt(sum(P_i_F_2_2_chapeau.*P_i_F_2_2_chapeau));
ecarts_2 = distances_P_i_F_1_2_chapeau+distances_P_i_F_2_2_chapeau-2*a_2_chapeau;
f_2_P_i = pi_2_sur_sigma_2*exp(-un_sur_2_sigma_2_carre*ecarts_2.*ecarts_2);

% Partition des donnees :
indices_1 = find(f_1_P_i>=f_2_P_i);
indices_2 = find(f_1_P_i<f_2_P_i);

% Affichage de la partition :
figure('Name','Partition des donnees','Position',[0.33*L,0,0.33*L,0.5*H]);
axis equal;
hold on;
affichage_ellipse(C_1_chapeau,theta_1_chapeau,a_1_chapeau,b_1_chapeau,theta_points_ellipse,'c-');
plot(donnees(1,indices_1),donnees(2,indices_1),'c*');
affichage_ellipse(C_2_chapeau,theta_2_chapeau,a_2_chapeau,b_2_chapeau,theta_points_ellipse,'m-');
plot(donnees(1,indices_2),donnees(2,indices_2),'m*');
set(gca,'FontSize',20);
xlabel('$x$','Interpreter','Latex','FontSize',30);
ylabel('$y$','Interpreter','Latex','FontSize',30);
axis(echelle);
legend(' Densite estimee 1',' Classe 1',' Densite estimee 2',' Classe 2','Location','Best');
hold off;
drawnow;

% Estimation des parametres de l'ellipse correspondant a la classe 1 :
X_1 = estimation(x(indices_1),y(indices_1));

% Conversion des parametres de la premiere ellipse :
[C_1,theta_1,a_1,b_1] = conversion(X_1);
c_1 = sqrt(a_1*a_1-b_1*b_1);
v_1 = [cos(theta_1) ; sin(theta_1)];
F_1_1 = C_1-c_1*v_1;
F_2_1 = C_1+c_1*v_1;

% Estimation des parametres de l'ellipse correspondant a la classe 2 :
X_2 = estimation(x(indices_2),y(indices_2));

% Conversion des parametres de la deuxieme ellipse :
[C_2,theta_2,a_2,b_2] = conversion(X_2);
c_2 = sqrt(a_2*a_2-b_2*b_2);
v_2 = [cos(theta_2) ; sin(theta_2)];
F_1_2 = C_2-c_2*v_2;
F_2_2 = C_2+c_2*v_2;

% Affichage du resultat de l'estimation :
figure('Name','Resultat de l''estimation','Position',[0.66*L,0,0.33*L,0.5*H]);
plot(x,y,'r*');
hold on;
set(gca,'FontSize',20);
xlabel('$x$','Interpreter','Latex','FontSize',30);
ylabel('$y$','Interpreter','Latex','FontSize',30);
axis equal;

% Affichage des ellipses et calcul des scores :
score_1_1 = scores(F_1_1_reel,F_2_1_reel,a_1_reel,F_1_1,F_2_1,a_1);
score_2_2 = scores(F_1_2_reel,F_2_2_reel,a_2_reel,F_1_2,F_2_2,a_2);
score_sans_echange = (score_1_1+score_2_2)/2;
score_2_1 = scores(F_1_2_reel,F_2_2_reel,a_2_reel,F_1_1,F_2_1,a_1);
score_1_2 = scores(F_1_1_reel,F_2_1_reel,a_1_reel,F_1_2,F_2_2,a_2);
score_avec_echange = (score_2_1+score_1_2)/2;
if score_sans_echange>score_avec_echange
	affichage_ellipse(C_1,theta_1,a_1,b_1,theta_points_ellipse,'b-');
	affichage_ellipse(C_2,theta_2,a_2,b_2,theta_points_ellipse,'g-');
	disp(['Score ellipse bleue = ' num2str(score_1_1,'%.3f')]);
	disp(['Score ellipse verte = ' num2str(score_2_2,'%.3f')]);
else
	affichage_ellipse(C_2,theta_2,a_2,b_2,theta_points_ellipse,'b-');
	affichage_ellipse(C_1,theta_1,a_1,b_1,theta_points_ellipse,'g-');
	disp(['Score ellipse bleue = ' num2str(score_2_1,'%.3f')]);
	disp(['Score ellipse verte = ' num2str(score_1_2,'%.3f')]);
end
axis(echelle);
legend(' Donnees',' Ellipse estimee 1',' Ellipse estimee 2','Location','Best');
drawnow;
