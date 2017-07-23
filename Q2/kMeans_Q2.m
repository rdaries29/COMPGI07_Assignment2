function [centroids, indicator_variable,objective_result] = kMeans_Q2(X,k)
% Function to implement K-Mean Algorithm with call to objective function

% Initialize centroid positions on k of data points selected randomly
indicator_variable = zeros(size(X,1),k);
rand_indices = randsample(size(X,1),k);
prev_centroids = zeros(k,size(X,2));
centroids = X(rand_indices,:);
max_iterations = 1000;
iteration_count = 0;

while(iteration_count<max_iterations) % Max iteration counter
    iteration_count = iteration_count+1;
    while(prev_centroids~=centroids) % Check thatk-means has converged
        % Assignment Step 1
        for i=1:size(X,1) % For-loop for all data set points x_i
            min_dist = Inf; 
            for j=1:k % For-loop for all centroidss
                min_dist_current = (sum((X(i,:) - centroids(j,:)) .^ 2));
                if (min_dist_current<min_dist) % Check min distance currently

                    indicator_variable(i,:) = 0; % Reassign entire row to zero
                    indicator_variable(i,j) = 1; % Assign closest data point to 1 for cluster
                    min_dist = min_dist_current; % Update minimum distance for data point

                else

                end
            end
        end
        %Centroid Update Step 2
        prev_centroids = centroids;
        for n=1:k
            denominator = sum(indicator_variable(:,n)); % Calculate denomiator
            numerator = zeros(1,size(X,2)); % Initialise variable to row of zeros
            for m=1:size(X,1)
                numerator = numerator + (indicator_variable(m,n)*X(m,:)); % Calculate numerator
            end 
            centroids(n,:) = numerator/denominator; %Update kth centroid position
        end
        
    end
end

objective_result = objective_function(X,centroids,indicator_variable);

        
