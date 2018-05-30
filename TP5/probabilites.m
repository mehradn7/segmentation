function [probas_1,probas_2,pi_1,pi_2] = ...
probabilites(donnees,n,F_1_1,F_2_1,a_1,pi_1,sigma_1,F_1_2,F_2_2,a_2,pi_2,sigma_2)


e_1 = sqrt((donnees(1,:) - F_1_1(1)).^2 + (donnees(2,:) - F_1_1(2)).^2) + ...
    sqrt((donnees(1,:) - F_2_1(1)).^2 + (donnees(2,:) - F_2_1(2)).^2) - (2*a_1);

e_2 = sqrt((donnees(1,:) - F_1_2(1)).^2 + (donnees(2,:) - F_1_2(2)).^2) + ...
    sqrt((donnees(1,:) - F_2_2(1)).^2 + (donnees(2,:) - F_2_2(2)).^2) - (2*a_2);


denominateur = ((pi_1/sigma_1)*exp(-(e_1.^2)./(2*sigma_1^2))) + ...
    ((pi_2/sigma_2)*exp(-(e_2.^2)/(2*sigma_2^2)));


probas_1 = ((pi_1/sigma_1)*exp(-(e_1.^2)./(2*sigma_1^2))) ./ denominateur;

probas_2 = ((pi_2/sigma_2)*exp(-(e_2.^2)./(2*sigma_2^2))) ./ denominateur;


pi_1 = sum(probas_1) / n;
pi_2 = sum(probas_2) / n;








end


