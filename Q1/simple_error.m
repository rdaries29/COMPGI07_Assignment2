function [err_counts] = simple_error(dataset,k,indicator_variable)
% Function to implement simple errors
% function [err_logic, err_counts] = simple_error(dataset,k,indicator_variable)

% Data clusters
cluster_1 = dataset((indicator_variable(:,1)~=0),:);
cluster_2 = dataset((indicator_variable(:,2)~=0),:);
cluster_3 = dataset((indicator_variable(:,3)~=0),:);

S1 = dataset(1:round(size(dataset,1)/k),:);
S2 = dataset((round(size(dataset,1)/k)+1):(round(size(dataset,1)/k)*2),:);
S3 = dataset(((round(size(dataset,1)/k)*2)+1):end,:);

% Checking data members of each cluster
Lia_c1 = ismember(cluster_1,S1,'rows');
Lia_c2 = ismember(cluster_2,S2,'rows');
Lia_c3 = ismember(cluster_3,S3,'rows');

err_numerator = sum(ones(size(Lia_c1,1),1)-Lia_c1)+sum(ones(size(Lia_c2,1),1)-Lia_c2)+sum(ones(size(Lia_c3,1),1)-Lia_c3);

l = size(dataset,1);

err_counts = err_numerator/l;

% Logic Calculation

% S1_vec = zeros(size(dataset,1),1);
% vec_1 = ones(50,1);
% S1_vec = [vec_1; S1_vec(51:150)];
% 
% S2_vec = zeros(size(dataset,1),1);
% vec_1 = ones(50,1);
% S2_vec = [S2_vec(1:50);vec_1; S2_vec(101:150)];
% 
% S3_vec = zeros(size(dataset,1),1);
% vec_1 = ones(50,1);
% S3_vec = [S3_vec(1:100);vec_1];
% 
% S = [S1_vec S2_vec S3_vec];
% 
% err_numerator_logic = 0;
% 
% for i=1:k
%     err_numerator_logic = err_numerator_logic + sum(xor(indicator_variable(:,i),S(:,i)));
% end
% 
% 
% err_logic = err_numerator_logic/l;
