function c=deletezeros_umc(a)
[xs,ys]=size(a);
b=reshape(a,1,xs*ys);
c=zeros(1,sum(b>0));
j=1;
for i=1:xs*ys
    if b(1,i)>0
    c(1,j)=(b(1,i));
    j=j+1;
    end
    
end