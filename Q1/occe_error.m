function [occe_err, perm_vec] = occe_error(dataset,k,indicator_variable)
% Function for implementation of occe calculation
l = size(dataset,1);

permutation_matrix = perms(1:k);

S1 = dataset(1:round(size(dataset,1)/k),:);
S2 = dataset((round(size(dataset,1)/k)+1):(round(size(dataset,1)/k)*2),:);
S3 = dataset(((round(size(dataset,1)/k)*2)+1):end,:);

err_numerator = zeros(size(permutation_matrix,1),1);
occe_err_temp = zeros(size(permutation_matrix,1),1);

for i=1:size(permutation_matrix,1)

    % Data clusters
    cluster_1 = dataset((indicator_variable(:,permutation_matrix(i,1))~=0),:);
    cluster_2 = dataset((indicator_variable(:,permutation_matrix(i,2))~=0),:);
    cluster_3 = dataset((indicator_variable(:,permutation_matrix(i,3))~=0),:);

    % Checking data members of each cluster
    Lia_c1 = ismember(cluster_1,S1,'rows');
    Lia_c2 = ismember(cluster_2,S2,'rows');
    Lia_c3 = ismember(cluster_3,S3,'rows');

    err_numerator(i) = sum(ones(size(Lia_c1,1),1)-Lia_c1)+sum(ones(size(Lia_c2,1),1)-Lia_c2)+sum(ones(size(Lia_c3,1),1)-Lia_c3);

    occe_err_temp(i) = err_numerator(i)/l;

end

[err_val_min,perm_indx] = min(occe_err_temp);

perm_vec = permutation_matrix(perm_indx,:);
occe_err = min(err_val_min);
