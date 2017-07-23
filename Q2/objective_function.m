function objective_result = objective_function(X,centroids,indicator_variable)
% Function to calculate the objective function
cluster_1 = X((indicator_variable(:,1)~=0),:);
cluster_2 = X((indicator_variable(:,2)~=0),:);
cluster_3 = X((indicator_variable(:,3)~=0),:);

temp = 0;

for i=1:size(centroids,1)
%     temp = temp + sum((X((indicator_variable(:,i)~=0),:) - repmat(centroids(i,:),size(X((indicator_variable(:,i)~=0),:),1),1)) .^ 2);
    temp = temp + (norm(X((indicator_variable(:,i)~=0),:) - repmat(centroids(i,:),size(X((indicator_variable(:,i)~=0),:),1),1)))^2;
%       temp= temp+pdist2(X((indicator_variable(:,i)~=0),:),repmat(centroids(i,:),size(X((indicator_variable(:,i)~=0),:),1),1),'squaredeuclidean');  
end

objective_result = temp;