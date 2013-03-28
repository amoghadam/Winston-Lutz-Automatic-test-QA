function [out,out4,out4_org]=find_edge_2(p1,p1_org)
% p1= binary map
% p1_org is the original pic
[opsdx,opsdy]=size(p1_org)
[psdx,psdy]=size(p1)
toler=12;
p56=p1;
q1=sum(p56);
% plot(q1)
% [xs,ys]=size(q1);
out1=p56;
out2=p1;
out2_org=p1_org;
for i=length(q1)-toler:-1:1+toler
    checksumur=sum(q1(i:i+toler))/(toler+1);
    checksumul=sum(q1(i-toler:i))/(toler+1);
    if q1(i)<=checksumur && q1(i)<=checksumul && q1(i)<(max(q1))*0.85
        out1(:,i:end)=0;
        out2(:,i:end)=0;
        out2_org(:,i:end)=0;
        break
    end
    if q1(i)==(max(q1))
        break
    end
end

% imagesc(out2)
q2=sum(out1);
% plot(q2)

        out=out1;
        out3=out2;
        out4_org=out2_org;
        out4=(out3<999).*out3;
% [xs,ys]=size(out1);
for i=1+toler:1:length(q2)-toler
    checksumur=sum(q2(i:i+toler))/(toler+1);
    checksumul=sum(q2(i-toler:i))/(toler+1);
    if q2(i)<=checksumur && q2(i)<=checksumul && q2(i)<(max(q2))*0.85
        out(:,1:i)=0;
        out3(:,1:i)=0;
        out4_org(:,1:i)=0;
        out4=(out3<999).*out3;
        break
    end
    if q2(i)==(max(q2))
        break
    end
end
% imagesc(out4)
