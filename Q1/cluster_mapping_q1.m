function [cluster1_str,cluster2_str,cluster3_str] = cluster_mapping_q1(perm_vec)
% Mapping cluster assignmetn function for highest combination

if(isequal(perm_vec,[1 2 3]))
    cluster1_str = 'S1';
    cluster2_str = 'S2';
    cluster3_str = 'S3';
elseif(isequal(perm_vec,[1 3 2]))
    cluster1_str = 'S1';
    cluster2_str = 'S3';
    cluster3_str = 'S2';
elseif(isequal(perm_vec,[2 1 3]))
    cluster1_str = 'S2';
    cluster2_str = 'S1';
    cluster3_str = 'S3';
elseif(isequal(perm_vec,[2 3 1]))
    cluster1_str = 'S2';
    cluster2_str = 'S3';
    cluster3_str = 'S1';
elseif(isequal(perm_vec,[3 1 2]))
    cluster1_str = 'S3';
    cluster2_str = 'S1';
    cluster3_str = 'S2';
elseif(isequal(perm_vec,[3 2 1]))
    cluster1_str = 'S3';
    cluster2_str = 'S2';
    cluster3_str = 'S1';
end
    