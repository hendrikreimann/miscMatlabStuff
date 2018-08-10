%CENTDIFF  
%	central difference method
%	[V]=centdiff(X,dtime)


function [V] = centdiff(data, timeStep)

if size(data,1)>size(data,2) %data in column
    V(1,:)=(data(2,:)-data(1,:))./timeStep;
    V(2:size(data,1)-1,:)=(data(3:size(data,1),:)-data(1:size(data,1)-2,:))./(2*timeStep);
    V(size(data,1),:)=(data(size(data,1),:)-data(size(data,1)-1,:))./timeStep;
elseif size(data,1)<size(data,2) %data in row
    V(:,1)=(data(:,2)-data(:,1))./timeStep;
    V(:,2:size(data,2)-1)=(data(:,3:size(data,2))-data(:,1:size(data,2)-2))./(2*timeStep);
    V(:,size(data,2))=(data(:,size(data,2))-data(:,size(data,2)-1))./timeStep;
else
    error
end
