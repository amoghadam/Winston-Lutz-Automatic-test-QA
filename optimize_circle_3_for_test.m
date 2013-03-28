function [out,f_x,f_y,sumic]=optimize_circle_3_for_test(jtest,xi,yi,radius,region,rxi,ryi,big)
[xs,ys]=size(jtest);
% mamapu=(~(jtest==500)).*jtest;

% avgu=sum(sum(mamapu))/sum(sum(~(jtest==500)));
% totalu=sum(sum(jtest<499));
% cat2=sum(sum(jtest<(avgu/10)));
% cat1=max(max(mamapu))-min(min(jtest));
% region=12;
num=1;
for ii=fix(xi)-region:fix(xi)+region
    for jj=fix(yi)-region:fix(yi)+region
        newmap1=find_new_map(xs,ys,ii,jj,radius);
        numnumnum=newmap1.*jtest;
%         [xsnum*ysnum]=size(numnumnum);
%         rspnumnum=reshape(numnumnum,xsnum*ysnum,1);
        
        
        sumic(num,3)=sum(sum(numnumnum))/sum(sum(newmap1));
        sumic(num,4)=std(deletezeros_umc(numnumnum));
        if sqrt((ii-rxi)^2 + (jj-ryi)^2) + radius < big-2
            sumic(num,5)=sumic(num,3);
        else
            sumic(num,5)=sumic(num,3)+(5*sumic(num,4));
        end
        sumic(num,2)=jj;
        sumic(num,1)=ii;
        
        
        num=num+1;
    end
end
% aaaa=reshape(sumsumic(1:81,5,i),9,9)
% bbbb=-1*ones(3,3)
% bbb(2,2)=-0.5;
% cccc=conv2(aaaa,bbbb);
% imagesc(cccc)

% [aa,bb]=min(sumic(:,3));
% [aa,bb]=min(sumic(:,3)+(50*sumic(:,4)));
[aa,bb]=min(sumic(:,5));
% if cat1>=avgu && cat2>(totalu/100)
%     f_x=xi;
%     f_y=yi;
%     0
% else
f_x=sumic(bb,1);
f_y=sumic(bb,2);
out=find_new_map(xs,ys,f_x,f_y,radius);
% 1
% end

% imagesc(jtest)
% newmap1=find_new_map(xs,ys,f_x,f_y,30);
%    hold on
%    contour(newmap1,[0,1],'b')
        
        
