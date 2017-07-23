function X = mean_norm_data(X)

X_mean = mean(X);
X_mean_rep = repmat(X_mean,size(X,1),1);

X = X - X_mean_rep;