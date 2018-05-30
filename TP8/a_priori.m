function p = a_priori(i,j,k_mat,k_n,beta)

[n,m] = size(k_mat);
v= voisins(i,j,n,m);

taille = size(v,2);

p = 0;
for k=1:taille
    l = v(:,k);
    i = l(1);
    j = l(2);
    p = p  +(k_n ~= k_mat(i,j));
    
end
p = p*beta;
end

function liste = voisins(i,j,n,m)

li = [i   i    i-1  i-1 i-1 i+1 i+1 i+1];
lj = [j-1 j+1  j-1  j   j+1 j-1 j   j+1];

ind = find(li>0);
li = li(ind);
lj = lj(ind);
ind = find(li < n+1);
li = li(ind);
lj = lj(ind);
ind = find(lj>0);
li = li(ind);
lj = lj(ind);
ind = find(lj < m+1);
li = li(ind);
lj = lj(ind);

liste = [li;lj];

end