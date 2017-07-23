function [cluster1_str,cluster2_str,cluster3_str] = cluster_mapping_iris(perm_vec)

if(isequal(perm_vec,[1 2 3]))
    cluster1_str = 'setosa';
    cluster2_str = 'versicolor';
    cluster3_str = 'virginica';
elseif(isequal(perm_vec,[1 3 2]))
    cluster1_str = 'setosa';
    cluster2_str = 'virginica';
    cluster3_str = 'versicolor';
elseif(isequal(perm_vec,[2 1 3]))
    cluster1_str = 'versicolor';
    cluster2_str = 'setosa';
    cluster3_str = 'versicolor';
elseif(isequal(perm_vec,[2 3 1]))
    cluster1_str = 'versicolor';
    cluster2_str = 'virginica';
    cluster3_str = 'setosa';
elseif(isequal(perm_vec,[3 1 2]))
    cluster1_str = 'virginica';
    cluster2_str = 'setosa';
    cluster3_str = 'versicolor';
elseif(isequal(perm_vec,[3 2 1]))
    cluster1_str = 'virginica';
    cluster2_str = 'versicolor';
    cluster3_str = 'setosa';
end
    