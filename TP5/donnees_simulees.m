clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

% Fenetre d'affichage :
figure('Name','Simulation des donnees','Position',[0,0,0.33*L,0.5*H]);
axis equal;
hold on;

% Parametres :
taille = 20;
echelle = [-taille taille -taille taille];

% Tirage aleatoire des parametres de l'ellipse 1 :
a_1 = 2*taille/5*(rand+1);
e_1 = 0.25+rand/2;
b_1 = a_1*sqrt(1-e_1^2);
c_1 = e_1*a_1;
C_1 = (taille-a_1)*(2*rand(2,1)-1);
theta_1 = 2*pi*rand;
v_1 = [cos(theta_1) ; sin(theta_1)];
F_1_1 = C_1-c_1*v_1;
F_2_1 = C_1+c_1*v_1;

% Tirage aleatoire des parametres de l'ellipse 2 :
a_2 = 2*taille/5*(rand+1);
e_2 = 0.25+rand/2;
b_2 = a_2*sqrt(1-e_2^2);
c_2 = e_2*a_2;
C_2 = (taille-a_2)*(2*rand(2,1)-1);
theta_2 = 2*pi*rand;
v_2 = [cos(theta_2) ; sin(theta_2)];
F_1_2 = C_2-c_2*v_2;
F_2_2 = C_2+c_2*v_2;

% Donnees au voisinage de l'ellipse 1 :
n_1 = 200;
theta_donnees_1 = 2*pi*rand(1,n_1);
donnees_1 = [a_1*cos(theta_donnees_1) ; b_1*sin(theta_donnees_1)];
donnees_1 = [cos(theta_1) -sin(theta_1) ; sin(theta_1) cos(theta_1)]*donnees_1;
sigma_1 = 0.5;
donnees_1 = donnees_1+C_1*ones(1,n_1)+sigma_1*randn(2,n_1);

% Donnees au voisinage de l'ellipse 2 :
n_2 = 200;
theta_donnees_2 = 2*pi*rand(1,n_2);
donnees_2 = [a_2*cos(theta_donnees_2) ; b_2*sin(theta_donnees_2)];
donnees_2 = [cos(theta_2) -sin(theta_2) ; sin(theta_2) cos(theta_2)]*donnees_2;
sigma_2 = 0.5;
donnees_2 = donnees_2+C_2*ones(1,n_2)+sigma_2*randn(2,n_2);

% Affichage des donnees :
donnees = [donnees_1 donnees_2];
n = n_1+n_2;
plot(donnees(1,:),donnees(2,:),'r*');
set(gca,'FontSize',20);
xlabel('$x$','Interpreter','Latex','FontSize',30);
ylabel('$y$','Interpreter','Latex','FontSize',30);
axis(echelle);
