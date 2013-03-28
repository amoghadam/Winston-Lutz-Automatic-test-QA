function out=find_cut_off(a,BIG,SML)

[ssaaxx,ssaayy]=size(a);
big_circs_rat=((pi*(BIG/2)^2))/(ssaaxx*ssaayy)
for mincut=1:max(max(a))
    bu(mincut,1)=sum(sum((a>=mincut)))/(ssaaxx*ssaayy);
    bu(mincut,2)=(sum(sum((a>=mincut)))/(ssaaxx*ssaayy))-big_circs_rat;
end
[aaaa,bbbb]=min(bu(:,2));

out=bbbb-(bbbb/3);