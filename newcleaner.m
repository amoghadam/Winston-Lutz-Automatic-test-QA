function [newpic,xcm,ycm]=newcleaner(atix,xcm,ycm,BIG,margin)
[xs,ys]=size(atix);
radiusu=fix((ys/2)-(abs(((ys/2)-ycm))+1));
while radiusu>BIG+margin
    newmap=find_new_map(xs,ys,xcm,ycm,radiusu);
    newpic=atix.*newmap;
    [xcm,ycm]=find_CM(newpic);
    radiusu=radiusu-1;
end

