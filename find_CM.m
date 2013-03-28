function [xcm,ycm]=find_CM(outmap)
[xs,ys]=size(outmap);
   jcul=[1:ys];
   ycm=fix((sum(outmap)*jcul')/sum(sum(outmap)));
   icul=[1:xs];
   xcm=fix((sum(outmap')*icul')/sum(sum(outmap)));