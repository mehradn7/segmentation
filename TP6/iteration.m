function [x,y] = iteration(x,y,Fx,Fy,gamma,A)

    Bx = -gamma * Fx(round(y), round(x));
    Bx = diag(Bx);
    
    By = -gamma * Fy(round(y), round(x));
    By = diag(By);
    x = A*x + Bx;
    y = A*y + By;



end
