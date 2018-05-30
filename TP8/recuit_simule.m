function [k,u] = recuit_simule(k_cour,k_nouv,U_cour,U_nouv,T)

if (U_nouv < U_cour) 
    k = k_nouv;
    u = U_nouv;
else
    p = rand;
    pa = exp(-(U_nouv - U_cour)/T);
    if (p<pa)
        k = k_nouv;
        u = U_nouv;
    else
        k = k_cour;
        u = U_cour;
    end
end