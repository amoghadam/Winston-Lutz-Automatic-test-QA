BLACK=0;
% WHITE=65530;  %16bit
WHITE=256;  %8bit
DPI=300; %scan resolution
BIG=65;  %ridus of big circle
SML=30;  %ridus of small circle
N=10;
[filename,pathname] = uigetfile({'*.tif','*.jpg'});
if isequal(filename,0) || isempty(filename)
	return
end
b2=imread(char([pathname,filename]));  %enter the file name here
b5=imcrop(b2);
% figure
% subplot(1,2,1)
% imshow(a)
b6=imrotate(imadjust(256-b5),90);
[amxsu,amysu]=size(b6);
amini=min(min(b6));
b7=[(double(amini)*ones(50,amysu));b6;(double(amini)*ones(50,amysu))];
[amxsu,amysu]=size(b7);
a=[(double(amini)*ones(amxsu,50)),b7,(double(amini)*ones(amxsu,50))];
% a=(imadjust(256-a));
% subplot(1,2,2)
imshow(a);
% figure
%%
cordins=zeros(10,2);
ilen=1;
button=1;
while button~=3
[x,y,button] = ginput(1);
cordins(ilen,1)=x;
cordins(ilen,2)=y;
ilen=ilen+1;
end
if length(cordins)>10
    cordins(10,:)=[];
end
%%
tolerance=60;
rad2=fix(1.4*65);
rad1=5;
atol=sum(sum(((a(fix(cordins(1,2)-rad1):fix(cordins(1,2)+rad1),fix(cordins(1,1))-rad1:fix(cordins(1,1))+rad1)))))/(2*2*rad1*rad1);
imagesc(a(fix(cordins(1,2)-rad2):fix(cordins(1,2)+rad2),fix(cordins(1,1))-rad2:fix(cordins(1,1))+rad2))
a=((double(a)>100).*double(a));

b=(a>=(a(fix(cordins(1,2)),fix(cordins(1,1)))-tolerance));
figure
imagesc(b(fix(cordins(1,2)-rad2):fix(cordins(1,2)+rad2),fix(cordins(1,1))-rad2:fix(cordins(1,1))+rad2))
BWb = bwmorph(b,'clean',3);
BW = bwmorph(BWb,'bridge',3);
figure
imagesc(BW(fix(cordins(1,2)-rad2):fix(cordins(1,2)+rad2),fix(cordins(1,1))-rad2:fix(cordins(1,1))+rad2))

BW2 = bwmorph(BW,'close',3);
figure
imagesc(BW2(fix(cordins(1,2)-rad2):fix(cordins(1,2)+rad2),fix(cordins(1,1))-rad2:fix(cordins(1,1))+rad2))

c=double(BW2).*double(a);
imagesc(c(fix(cordins(1,2)-rad2):fix(cordins(1,2)+rad2),fix(cordins(1,1))-rad2:fix(cordins(1,1))+rad2))
am1=c>atol-2;
imagesc(am1(fix(cordins(1,2)-rad2):fix(cordins(1,2)+rad2),fix(cordins(1,1))-rad2:fix(cordins(1,1))+rad2))
AW = bwmorph(am1,'bridge',3);
figure
imagesc(AW(fix(cordins(1,2)-rad2):fix(cordins(1,2)+rad2),fix(cordins(1,1))-rad2:fix(cordins(1,1))+rad2))

AW2 = bwmorph(AW,'close',3);
figure
imagesc(AW2(fix(cordins(1,2)-rad2):fix(cordins(1,2)+rad2),fix(cordins(1,1))-rad2:fix(cordins(1,1))+rad2))
imagesc(AW2)




c2=(~double(BW2)*1000);
imagesc(c2(fix(cordins(1,2)-rad2):fix(cordins(1,2)+rad2),fix(cordins(1,1))-rad2:fix(cordins(1,1))+rad2))
c3=c+c2;
imagesc(c3(fix(cordins(1,2)-rad2):fix(cordins(1,2)+rad2),fix(cordins(1,1))-rad2:fix(cordins(1,1))+rad2))
[x,y]=min(c3);
imagesc(c3)
cordints=cordins;
% for iop=1:length(cordins)
%     cordinus=cordins(iop,:);
% [x_b,y_b,x_s,y_s,xs,ys]=find_centers(c3,cordinus,rad2);
[t_dos,t_cont,t_cent]=find_centers(c3,cordins,rad2,DPI);
mean=mean(t_cent(:,5,:))
% newmap=find_new_map(xs,ys,x_b,y_b,56);
% newmap3=find_new_map(xs,ys,x_s,y_s,30);
% imagesc(c(fix(cordins(iop,2)-rad2):fix(cordins(iop,2)+rad2),fix(cordins(iop,1))-rad2:fix(cordins(iop,1))+rad2))
% hold on
%    contour((newmap.*(~newmap3)+(5*newmap3)),[0,1],'b')
%    contour((newmap.*(~newmap3)+(5*newmap3)),[0,5],'g')
%    drawnow
%    amicent(iop,1)=x_b;
%    amicent(iop,2)=y_b;
%    amicent(iop,3)=x_s;
%    amicent(iop,1)=y_s;
%    pause (1)
% end

% d=(c>min(min(c+c2))+10);
% imagesc(d(fix(cordins(1,2)-rad2):fix(cordins(1,2)+rad2),fix(cordins(1,1))-rad2:fix(cordins(1,1))+rad2))
% 
% 
% fprintf('select region that includes first 5 circles \n');
% b1=imcrop(a);
% fprintf('select region that includes rest 5 circles \n');
% b2=imcrop(a);
% [br1, bc1]=size(b1);
% [br2, bc2]=size(b2);
% if bc1<=bc2
%     bc=bc2;
% else
%     bc=bc1;
% end
% if br1<=br2
%     br=br2;
% else
%     br=br1;
% end
% b=uint8(zeros(2*br,bc));
% b(1:br1,1:bc1)=b1;
% b(2*br-br2+1:2*br,1:bc2)=b2;
% imshow(b)
% 
% cb=zeros(10,2,1);
% for n=1:N
%     answer='N';
%     p=0;    
%     while (answer=='N' || answer=='n')
%         if p==0
%             fprintf('select the center for big circle %d \n', n);
%             p=p+1;
%         else
%             b=recov(x,y,org,b,BIG);
%         end
%         [x,y]=ginput(1);
%         [org,b]=drawcircle(x,y,b,WHITE,BIG);
%         answer=input('confirm circle? Y/N [Y]','s');
%         if isempty(answer)
%             answer='Y';
%         end
%     end
%     cb(n,:)=[x,y];
% end
% 
% cs=zeros(10,2,1);
% for n=1:N
%     answer='N';
%     p=0;    
%     while (answer=='N' || answer=='n')
%         if p==0
%             fprintf('select the center for small circle %d \n', n);
%             p=p+1;
%         else
%             b=recov(x,y,org,b,SML);
%         end
%         [x,y]=ginput(1);
%         [org,b]=drawcircle(x,y,b,BLACK,SML);
%         answer=input('confirm circle? Y/N [Y]','s');
%         if isempty(answer)
%             answer='Y';
%         end
%     end
%     cs(n,:)=[x,y];
% end
% 
% disp=zeros(1,10);
% for n=1:N
%     disp(n)=sqrt((cb(n,1)-cs(n,1))^2+(cb(n,2)-cs(n,2))^2)*25.4/DPI;
% end
% 
% % b(2*br+1:2*br+40,:)=65530;  % add extra space to display results  16bit
% b(2*br+1:2*br+40,:)=256;  % add extra space to display results  8bit
% imshow(b);
% text(10, 2*br+20, 'Displacement(mm):', 'fontsize', 11);
% text(250, 2*br+22, num2str(disp,' %5.3f,'), 'fontsize', 11);
% text(1080, 2*br+20, 'Average(mm):', 'fontsize', 11);
% text(1250, 2*br+22, num2str(mean(disp),'%5.3f'), 'fontsize', 11);
% 
% if mean(disp)<0.75
%     fprintf('Congratulations, your test passed! \n')
%     fprintf('Please save current image as .fig file (menu file\save), \n')
%     fprintf('and then print in landscape orientation \n')
% else
%     fprintf('Sorry, seems you have to do it again. \n')
% end