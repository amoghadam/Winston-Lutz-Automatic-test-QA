function [org,b] = drawcircle(x,y,a,COLOR,SIZE)
n=0;
R=SIZE;
THK=3;
for i=y-R-THK:y+R+THK
    for j=x-R:x+R
        if uint16(sqrt((i-y)^2+(j-x)^2))>=R && uint16(sqrt((i-y)^2+(j-x)^2))<R+THK
            n=n+1;
            org(n)=a(uint16(i),uint16(j));
            a(uint16(i),uint16(j))=COLOR;
        end
    end
end
b=a;
imshow(a);
