function [t_dos,t_cont,t_cent,t_org]=WL_test_v3_sq(Scan_file_name)
%%
% [filename2,pathname] = uigetfile({'*.tif','*.jpg'},'MultiSelect','on');
% filename=cellstr( filename2);
% if isequal(filename,0) || isempty(filename)
% 	return
% end
% 
% [fxs,fys]=size(cellstr(filename));
% 
% % axes(handles.axes1);
% Scan_file_name=char([pathname,char(filename)]);
%%


i=1;
BLACK=0;
% WHITE=65530;  %16bit
WHITE=256;  %8bit
DPI=300; %scan resolution
BIG=65;  %ridus of big circle
SML=30;  %ridus of small circle
SSQ=2*BIG;
N=10;
handles.DPI=DPI;


b2=imread(Scan_file_name);  %enter the file name here
% klopa=imshow(b2);
fighandelu=figure;
b5=imcrop(b2);
% figure
% subplot(1,2,1)
% imshow(a)
b6=imrotate(imadjust(256-b5),90);
[amxsu,amysu]=size(b6);
amini=min(min(b6));
b61=b6(1,:);
b62=b6(2,:);
b63=b6(3,:);
b621=b6(end,:);
b622=b6(end-1,:);
b623=b6(end-2,:);
for i=1:BIG
    if mod(i,6)==1
        b6=[b61;b6;b621];
    elseif mod(i,6)==2
        b6=[b622;b6;b62];
    elseif mod(i,6)==3
        b6=[b63;b6;b623];
    elseif mod(i,6)==4
        b6=[b621;b6;b61];
    elseif mod(i,6)==5
        b6=[b62;b6;b622];
    elseif mod(i,6)==0
        b6=[b623;b6;b63];
    end
end
b7=b6;
[amxsu,amysu]=size(b7);

b71=b7(:,1);
b72=b7(:,2);
b73=b7(:,3);
b721=b7(:,end);
b722=b7(:,end-1);
b723=b7(:,end-2);
for i=1:BIG
    if mod(i,6)==1
        b7=[b71,b7,b721];
    elseif mod(i,6)==2
        b7=[b722,b7,b72];
    elseif mod(i,6)==3
        b7=[b73,b7,b723];
    elseif mod(i,6)==4
        b7=[b721,b7,b71];
    elseif mod(i,6)==5
        b7=[b72,b7,b722];
    elseif mod(i,6)==0
        b7=[b723,b7,b73];
    end
end
a=b7;
% a=(imadjust(256-a));
% subplot(1,2,1)
imshow(a);

%%
original_p=a;
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
delete(fighandelu)

amirhg=helpdlg('finding the circles, please wait');

%% slicing & cleaning up
siliced_outu=slice_it(a,cordins,SSQ);


%%
for i=1:10
    a=siliced_outu(:,:,i);
    rad1=fix(SML/6);
    fucking_ass_hole=double((a(fix((SSQ)-rad1):fix((SSQ)+rad1),fix((SSQ))-rad1:fix((SSQ))+rad1)));
    [Fxs,Fys]=size(fucking_ass_hole);
    atol(i,2)=std(reshape(fucking_ass_hole,1,Fxs*Fys));
    atol(i,1)=sum(sum(fucking_ass_hole))/(Fxs*Fys);
%     figure
%     imagesc(a>(atol(i,1)-(2*atol(i,2))))
end
%% finding big circles
%% creating step1 map
for i=1:10
    a=siliced_outu(:,:,i);
    bmap=(a>atol(i,1)-(1*atol(i,2)));
    BW = bwmorph(bmap,'clean',7);
    BW1 = bwmorph(BW,'bridge',7);
    BW2 = bwmorph(BW1,'close',7);
    a2(:,:,i)=BW2;
%     figure
%     imagesc(BW2)
end
% imagesc(BW2.*double(a))
%%
for i=1:10
    orginal_p2=double(siliced_outu(:,:,i));
%     figure
%      imagesc(orginal_p2)
    p1=double(a2(:,:,i));
    [out,out4,out4_org]=find_edge_2(p1,orginal_p2);
    a3(:,:,i)=out4_org;
    a4(:,:,i)=out4;
    a5(:,:,i)=out;
%     figure
%     imagesc(a3(:,:,i))
end
    

%% Finding center of mass
Bsqx=152/2;
Bsqy=162/2;
for i=1:10
    [xcm,ycm]=find_CM(a3(:,:,5));
    [asdfds,xs,ys]=newcleaner_sq2(a3(:,:,i),xcm,ycm,Bsqx,Bsqy,12);
    a6(:,:,i)=asdfds;
    CMS(i,1)=xs;
    CMS(i,2)=ys;
%     figure
%     imagesc(asdfds)
end
%% optimize the big circle
for i=1:10
    [asdfds2,f_x,f_y]=optimize_SQ_2(a6(:,:,i),CMS(i,1),CMS(i,2),Bsqx,Bsqy);
    CMS2(i,1)=f_x;
    CMS2(i,2)=f_y;
    a7(:,:,i)=asdfds2;
%     figure
%     imagesc(a6(:,:,i))
%     hold on
%     contour(a7(:,:,i),[0,1],'b')
end
%% find small circle

%%
for i=1:10
    [xsu,ysu]=size(a6(:,:,i));
    newmap1=find_new_map(xsu,ysu,CMS2(i,1),CMS2(i,2),BIG-7);
    a8(:,:,i)=(newmap1.*a6(:,:,i));
%     figure
%     imagesc(a8(:,:,i));
    params(i,1)=sum(sum(a8(:,:,i)))/sum(sum(newmap1));
    params(i,2)=max(max(a8(:,:,i)));
    a9(:,:,i)=(a8(:,:,i)<params(i,1)).*(a8(:,:,i)>0);
%     figure
%     imagesc(a9(:,:,i))
end

%%
for i=1:10
    [xcm,ycm]=find_CM(a9(:,:,5));
    [asdfds,xs,ys]=newcleaner(a9(:,:,i),xcm,ycm,SML,5);
    a10(:,:,i)=bwmorph(asdfds,'close',1);
    CMSS(i,1)=xs;
    CMSS(i,2)=ys;
%     figure
%      subplot(1,2,1)
%     imagesc(a9(:,:,i))
%     subplot(1,2,2)
%     imagesc(asdfds)
end
%% optimize small circles
for i=1:10
    [asdfds2,f_x,f_y]=optimize_circle_3(a8(:,:,i),CMSS(i,1),CMSS(i,2),SML,5);
    CMSS2(i,1)=f_x;
    CMSS2(i,2)=f_y;
    a11(:,:,i)=asdfds2;
%     figure
%     imagesc(a6(:,:,i))
%     hold on
%     contour(a11(:,:,i),[0,1],'b')
end

%%
% for i=1:10
%     figure
%     imagesc(siliced_outu(:,:,i))
%     hold on
%     contour(a11(:,:,i),[0,1],'b')
%     contour(a7(:,:,i),[0,1],'k')
%     
% end
%%

t_org=siliced_outu;
t_dos=t_org;
t_cont=(a7.*(~a11)+(5*a11));
for imi=1:10
t_cent(1,1,imi)=CMS2(imi,1);
   t_cent(1,2,imi)=CMS2(imi,2);
   t_cent(1,3,imi)=CMSS2(imi,1);
   t_cent(1,4,imi)=CMSS2(imi,2);
   t_cent(1,6,imi)=xsu;
   t_cent(1,7,imi)=ysu;
   t_cent(1,8,imi)=BIG;
   t_cent(1,5,imi)=sqrt((CMS2(imi,1)-CMSS2(imi,1))^2+(CMS2(imi,2)-CMSS2(imi,2))^2)*25.4/DPI;
end
delete(amirhg)
    
    

