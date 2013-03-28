function [newpic,xcm,ycm]=newcleaner_sq2(atix,xcm,ycm,Bsqx,Bsqy,margin)
% Bsqx=152/2;
% Bsqy=162/2;
[xs,ys]=size(atix);
radiusuy=fix((ys/2)-(abs(((ys/2)-ycm))+1));
radiusux=fix((xs/2)-(abs(((xs/2)-xcm))+1));
while radiusuy>Bsqy+margin
    newmap=find_new_map_sq(xs,ys,xcm,ycm,radiusux,radiusuy);
    newpic=atix.*newmap;
    [xcm,ycm]=find_CM(newpic);
    radiusuy=radiusuy-1;
    if radiusux>Bsqx+margin
        radiusux=radiusux-1;
    end
        
end

