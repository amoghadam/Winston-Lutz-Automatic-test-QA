function [t_out4,t_cont,t_cent,t_org]=find_centers(c3,cordints,rad2,DPI,orginal_p)
[aaasx,aaasy]=size(c3)
[oaasx,oaasy]=size(orginal_p)


%%
radiusu=52;
[cxs,cys]=size(cordints);
for imi=1:cxs
   cordins=cordints(imi,:);

   p1=c3(fix(cordins(1,2)-rad2):fix(cordins(1,2)+rad2),fix(cordins(1,1))-rad2:fix(cordins(1,1))+rad2);
   orginal_p2=orginal_p(fix(cordins(1,2)-rad2):fix(cordins(1,2)+rad2),fix(cordins(1,1))-rad2:fix(cordins(1,1))+rad2);
   %
%    subplot(2,3,1)
%    imagesc(p1)
   
   %
   [out,out4,out4_org]=find_edge(p1,orginal_p2);
   outmap=out4>10;
%    subplot(2,3,2)
%    imagesc(outmap)
%    subplot(2,3,3)
%    imagesc(out4)
%    subplot(2,3,4)
   [xs,ys]=size(outmap);
   jcul=[1:ys];
   amiry=fix((sum(outmap)*jcul')/sum(sum(outmap)));
   icul=[1:xs];
   amirx=fix((sum(outmap')*icul')/sum(sum(outmap)));
   newmap=find_new_map(xs,ys,amirx,amiry,radiusu);
   newmapbigu=find_new_map(xs,ys,amirx,amiry,radiusu+12);
%    imagesc(newmap)
   jtest=(~newmap*500)+(newmap.*out4);
%    imagesc(jtest)
   
   totalmass=sum(sum(newmap));
   centersiu=0;
   for i=20:max(max(out4))
       if (sum(sum(jtest<i))/totalmass)>0.01 && (sum(sum(jtest<i))/totalmass)<0.32
           centersiu(i,2)=fix((sum(jtest<i)*jcul')/sum(sum(jtest<i)));
           centersiu(i,1)=fix((sum((jtest<i)')*icul')/sum(sum((jtest<i))));
       end  
%       imagesc(jtest<i)
%       title(char([num2str(i),'  ',num2str(sum(sum(jtest<i))/totalmass)]))
%       drawnow
%       pause(0.25)
   end
   
   kjji=sum(centersiu)./sum((centersiu)>0);
   xcent_b=kjji(1);
   ycent_b=kjji(2);
   newmap2=find_new_map(xs,ys,kjji(1),kjji(2),35);
   
   jtesti=jtest;
   
%    jtest=(newmap2.*jtest)+;
   jtest=((~newmap2*500)+(newmap2.*out4));
%    imagesc(jtesti)
%    imagesc(newmap2)
   totalmass=sum(sum(newmap2));
   centersiu2=0;
   for i=20:max(max(out4))
       if (sum(sum(jtest<i))/totalmass)>0.06 && (sum(sum(jtest<i))/totalmass)<0.7
%            centersiu2(i,2)=fix((sum(jtest<i)*jcul')/sum(sum(jtest<i)));
%            centersiu2(i,1)=fix((sum((jtest<i)')*icul')/sum(sum((jtest<i))));
%            centersiu2(i,3)=sum(sum((jtest<i)));
%            centersiu2(i,4)=(sum(sum(jtest<i))/totalmass)*100;
           if sum(sum(jtest==i))>0
           centersiu2(i,2)=fix((sum(jtest==i)*jcul')/sum(sum(jtest==i)));
           centersiu2(i,1)=fix((sum((jtest==i)')*icul')/sum(sum((jtest==i))));
           centersiu2(i,3)=sum(sum((jtest==i)));
           centersiu2(i,4)=(sum(sum(jtest==i))/totalmass)*100;
           centersiu2(i,5)=(sum(sum(jtest<i))/totalmass)*100;
           
           
%            newmap3=find_new_map(xs,ys,centersiu2(i,1),centersiu2(i,2),30);
%       imagesc(jtest==i)
%       hold on
%       contour((newmap.*(~newmap3)+(5*newmap3)),[0,1],'b')
%       contour((newmap.*(~newmap3)+(5*newmap3)),[0,5],'g')
%       title(char([num2str(i),'  ',num2str(sum(sum(jtest<i))/totalmass)]))
%       drawnow
%       pause(1)
           end
       end  
      
   end
   kjji2=sum(centersiu2)./sum((centersiu2)>0);
   xcent_s2=sum((centersiu2(:,1).*centersiu2(:,4)))/sum(centersiu2(:,4));
   ycent_s2=sum((centersiu2(:,2).*centersiu2(:,4)))/sum(centersiu2(:,4));
   [A,B]=max(centersiu2(:,4));
   newmap3=find_new_map(xs,ys,centersiu2(B,1),centersiu2(B,2),30);
   [f_x,f_y]=optimize_circle(jtest,centersiu2(B,1),centersiu2(B,2));
   newmap3=find_new_map(xs,ys,f_x,f_y,30);
%    imagesc(newmap3)
%    imagesc(newmap.*(~newmap3)+(5*newmap3))
%    imagesc(p1)
%    figure
%    imagesc(out4)
%    hold on
%    contour((newmapbigu.*(~newmap3)+(5*newmap3)),[0,1],'b')
%    contour((newmapbigu.*(~newmap3)+(5*newmap3)),[0,5],'g')
%    drawnow
   [xso44,yso44]=size(out4_org)
   [xso,yso]=size(out4)
   t_org(1:xso,1:yso,imi)=out4_org;
   t_out4(1:xso,1:yso,imi)=out4;
   t_cont(1:xso,1:yso,imi)=(newmapbigu.*(~newmap3)+(5*newmap3));
   t_cent(1,1,imi)=amirx;
   t_cent(1,2,imi)=amiry;
   t_cent(1,3,imi)=f_x;
   t_cent(1,4,imi)=f_y;
   t_cent(1,6,imi)=xs;
   t_cent(1,7,imi)=ys;
   t_cent(1,8,imi)=radiusu;
   t_cent(1,5,imi)=sqrt((amirx-f_x)^2+(amiry-f_y)^2)*25.4/DPI;
end