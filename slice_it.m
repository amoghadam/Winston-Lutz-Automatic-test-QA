function siliced_out=slice_it(a,cordins,SSQ)
[cxs,cys]=size(cordins);
for imi=1:cxs
   cordinius=fix(cordins(imi,:));
   p1=a(fix(cordinius(1,2)-SSQ):fix(cordinius(1,2)+SSQ),fix(cordinius(1,1))-SSQ:fix(cordinius(1,1))+SSQ);
   [xso,yso]=size(p1);
   siliced_out(1:xso,1:yso,imi)=p1;
end