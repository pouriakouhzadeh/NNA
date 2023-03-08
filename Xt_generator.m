function [Xt,L_C] = Xt_generator(X)
n=size(X,1);
while(X(n,32)==hour(now))
    n=n-1;
end
X=X(1:n,:);
X=X(:,1:end-1);
for(i=5:size(X,1))
p=0;
n=0;
for(k=1:4)
for(j=1:size(X,2))
    n=n+1;
    X2(i,n)=X(i-p,j);
end
p=p+1;
end
end
Xt=X2;
L_C=X(end,4);
end

