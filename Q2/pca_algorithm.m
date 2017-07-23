function X_hat = pca_algorithm(X,k)
% Implementation of PCA algorithm
X = mean_norm_data(X);

[dim_row,dim_col] = size(X);

Sigma = (1/dim_row)* (X'*X);

[U,S,V] = svd(Sigma);

U_reduced = U(:,1:k);

phi_map = U_reduced;

X_hat = X*phi_map;
    