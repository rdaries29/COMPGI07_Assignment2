function y_pred = kernel_map(alphas,x_previous,x_t,power,type)

% Polynomials Basis
if type == 'poly'
    x_correlate = x_previous*x_t';
    for dim=1:power
        x_correlate = x_correlate.*x_correlate;
    end
    y_pred = alphas* x_correlate;
    
% Gaussian Basis
elseif type == 'gaussian'
    % gaussian kernel
    
% Default Basis
else
    
end
   
    
end