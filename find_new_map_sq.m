function newmap=find_new_map_sq(xs,ys,amirx,amiry,radiusux,radiusuy)
newmap=zeros(xs,ys);
for i=1:xs
    for j=1:ys
        if abs((i-amirx))<radiusux && + abs((j-amiry))<radiusuy
            newmap(i,j)=1;
        end
    end
end