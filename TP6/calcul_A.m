function A = calcul_A(N,alpha,beta,gamma)

    I = speye(N);
    e = ones(N,1);
    D2 = spdiags([e -2*e e], -1:1, N, N);
    D2(1,200) = 1;
    D2(200,1) = 1;


    A = I + gamma*(alpha*D2 - beta*D2'*D2);


end
