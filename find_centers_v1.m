function [amirx,amiry,xcent_s2,ycent_s2,xs,ys]=find_centers(c3,cordins,rad2)
radiusu=56;
%%
% cordins=cordints(1,:);

   p1=c3(fix(cordins(1,2)-rad2):fix(cordins(1,2)+rad2),fix(cordins(1,1))-rad2:fix(cordins(1,1))+rad2);
   %
%    subplot(2,3,1)
   imagesc(p1)
   %
   [out,out4]=find_edge(p1);
   outmap=out4>10;
%    subplot(2,3,2)
   imagesc(outmap)
%    subplot(2,3,3)
   imagesc(out4)
%    subplot(2,3,4)
   [xs,ys]=size(outmap);
   jcul=[1:ys];
   amiry=fix((sum(outmap)*jcul')/sum(sum(outmap)));
   icul=[1:xs];
   amirx=fix((sum(outmap')*icul')/sum(sum(outmap)));
   newmap=find_new_map(xs,ys,amirx,amiry,radiusu);
   imagesc(newmap)
   jtest=(~newmap*500)+(newmap.*out4);
   imagesc(jtest)
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
%       pause(1)
   end
   
   kjji=sum(centersiu)./sum((centersiu)>0);
   xcent_b=kjji(1);
   ycent_b=kjji(2);
   newmap2=find_new_map(xs,ys,kjji(1),kjji(2),35);
   
   jtesti=jtest;
   
%    jtest=(newmap2.*jtest)+;
   jtest=((~newmap2*500)+(newmap2.*out4));
   imagesc(jtesti)
   imagesc(newmap2)
   totalmass=sum(sum(newmap2));
   centersiu2=0;
   for i=20:42
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
           3
       end  
      
   end
   kjji2=sum(centersiu2)./sum((centersiu2)>0);
   xcent_s2=sum((centersiu2(:,1).*centersiu2(:,4)))/sum(centersiu2(:,4));
   ycent_s2=sum((centersiu2(:,2).*centersiu2(:,4)))/sum(centersiu2(:,4));
   [A,B]=max(centersiu2(:,4))
   newmap3=find_new_map(xs,ys,centersiu2(B,1),centersiu2(B,2),30);
   
   imagesc(newmap.*(~newmap3)+(5*newmap3))
   imagesc(p1)
   imagesc(out4)
   hold on
   contour((newmap.*(~newmap3)+(5*newmap3)),[0,1],'b')
   contour((newmap.*(~newmap3)+(5*newmap3)),[0,5],'g')
    
