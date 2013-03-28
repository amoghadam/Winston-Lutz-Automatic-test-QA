function newmap=find_new_map(xs,ys,amirx,amiry,radiusu)
newmap=zeros(xs,ys);
for i=1:xs
    for j=1:ys
        if (((i-amirx)^2)+((j-amiry)^2))<(radiusu^2)
            newmap(i,j)=1;
        end
    end
end