%CENTDIFF  
%	central difference method
%	[V]=centdiff(X,dtime)


function [V]=centdiff(X,dtime)

if size(X,1)>size(X,2) %data in column
  V(1,:)=(X(2,:)-X(1,:))./dtime;
  V(2:size(X,1)-1,:)=(X(3:size(X,1),:)-X(1:size(X,1)-2,:))./(2*dtime);
  V(size(X,1),:)=(X(size(X,1),:)-X(size(X,1)-1,:))./dtime;
elseif size(X,1)<size(X,2) %data in row
  V(:,1)=(X(:,2)-X(:,1))./dtime;
  V(:,2:size(X,2)-1)=(X(:,3:size(X,2))-X(:,1:size(X,2)-2))./(2*dtime);
  V(:,size(X,2))=(X(:,size(X,2))-X(:,size(X,2)-1))./dtime;
else
  error
end
