%-------------------------------------------------------------------%
% Module: GI07 - Mathematical Methods for Machine Learning
% Assignment : Coursework 2
% Author : Russel Daries, Hugo Philion
% Student ID: 16079408, 14102040
% Question: 2
% Description: Principal Component Analysis
% ------------------------------------------------------------------%

% clearing memory
clear all
close all
clc

%% 2.1.1 PCA Algorithm

% Done in function pca_algrithm

%% 2.1.2 Implement K-Means Algorithm

% Done in function

%% 2.1.3 Implement on K-Means with PCA on Iris data

load('iris_dataset.mat');
dataset_iris = iris_data;
k_dimension_vec = 1:4;
k_iris = 3;
number_of_trials = 100;

% [centroids_iris, indicator_variable_iris, objective_result] = kMeans_Q2(dataset_iris,k_iris);

% Resultant plot for occe calculation

% occe_err_iris_org = occe_error(dataset_iris,k_iris,indicator_variable_iris);
occe_err_iris_org = zeros(number_of_trials,1);
occe_err_iris_pca = zeros(number_of_trials,size(k_dimension_vec,2));
objective_iris = zeros(number_of_trials,1);
objective_iris_pca = zeros(number_of_trials,size(k_dimension_vec,2));

% 100 Trials
for j=1:number_of_trials
    % Perform K-Means on Original Data
    [centroids_iris, indicator_variable_iris, objective_result] = kMeans_Q2(dataset_iris,k_iris);
    %objective
    objective_iris(j) = objective_result;
    %occe
    occe_err_iris_org(j) = occe_error(dataset_iris,k_iris,indicator_variable_iris);
    % Compute Objective Function
    for i=1:size(k_dimension_vec,2)
        % Perform PCA
        X_hat = pca_algorithm(dataset_iris,k_dimension_vec(i));
        % Perform K-Means on Reduced Data
        [centroids_iris_pca, indicator_variable_iris_pca, objective_result_pca] = kMeans_Q2(X_hat,k_iris);
        % Compute Objective Function
        objective_iris_pca(j,i) = objective_result_pca; 
        % Compute occe error
        occe_err_iris_pca(j,i) = occe_error(X_hat,k_iris,indicator_variable_iris_pca);
    end
end

occe_err_complete = [occe_err_iris_pca occe_err_iris_org];
objective_complete = [objective_iris_pca objective_iris];
objective_values_occe = zeros(3,1);

%% 2.1.3(a) Three Smallest occe's and value of computed objective

for n=1:5
    [rows,col] = size(occe_err_complete);
    [occe_values,occe_indx] = sort(occe_err_complete(:,n),'ascend');
    lowes_3_occe = occe_values(1:3)
    row_indx = occe_indx(1:3);
    col_indx = repmat(n,3,1);
    for m=1:3
        objective_values_occe(m) = objective_complete(row_indx(m),col_indx(m))
    end
    objective_values_occe = zeros(3,1);    
end

%% 2.1.3(b) Mean and standard deviation of occe's and the objectives

occe_mean_pca = mean(occe_err_iris_pca)
occe_mean_org = mean(occe_err_iris_org)
occe_std_pca = std(occe_err_iris_pca)
occe_std_org = std(occe_err_iris_org)

obj_func_pca_mean = mean(objective_iris_pca)
obj_func_org_mean = mean(objective_iris)
obj_func_pca_std = std(objective_iris_pca)
obj_func_org_std = std(objective_iris)

%User Error bars
figure;
errorbar(k_dimension_vec,occe_mean_pca,occe_std_pca)
hold on
errorbar(k_dimension_vec(end),occe_mean_org,occe_std_org)
xlabel('k','FontSize',15)
ylabel('occe','FontSize',15)
set(gcf, 'Color', 'w');
leg=legend('PCA','Untransformed','Location','Best');
set(leg,'FontSize',15)
set(gca,'YMinorTick','on')
set(gca,'XMinorTick','on')
set(gca,'FontSize',15)
grid on;
grid minor;
axis tight;
print('q2_1b_occe','-depsc')
close all;

figure;
errorbar(k_dimension_vec,obj_func_pca_mean,obj_func_pca_std)
hold on
errorbar(k_dimension_vec(end),obj_func_org_mean,obj_func_org_std)
xlabel('k','FontSize',15)
ylabel('objective function','FontSize',15)
set(gcf, 'Color', 'w');
leg=legend('PCA','Untransformed','Location','Best');
set(leg,'FontSize',15)
set(gca,'YMinorTick','on')
set(gca,'XMinorTick','on')
set(gca,'FontSize',15)
grid on;
grid minor;
axis tight;
print('q2_1b_obj','-depsc')
close all;

%% 2.1.3(c) Bar Chart Plots
occe_correct_values = zeros(100,5);
% occe_sorted_values = zeros(100,5);

rank_vec = 1:100;

for nn=1:5
    
    [rows_obj,col_obj] = size(objective_complete);
    [obj_values,obj_indx] = sort(objective_complete(:,nn),'ascend');
    obj_values_sorted = obj_values;
    occe_correct_values(:,nn) = occe_err_complete(obj_indx,nn);
    occe_sorted_values = sortrows([objective_complete(:,nn) occe_err_complete(:,nn)],1);
    
    formatSpec = 'q2_1b_bar_%d';
    A1 = nn;
    str = sprintf(formatSpec,A1);
    
    figure;
    bar(occe_sorted_values(:,2))
    xlabel('','FontSize',15)
    ylabel('','FontSize',15)
    set(gcf, 'Color', 'w');
    set(gca,'YMinorTick','on')
    grid on;
    axis tight;
    print(str,'-depsc')
    close all;
end

%% 2.1.4 Visualisation

% Resultant output plots
k_vis=3;
X_hat_2 = pca_algorithm(dataset_iris,2);
% Perform K-Means on Reduced Data
[centroids_iris_pca_2, indicator_variable_iris_pca_2, objective_result_pca_2] = kMeans_Q2(X_hat_2,k_vis);

[occe_err_cluster,perm_vec_2] = occe_error(X_hat_2,k_vis,indicator_variable_iris_pca_2);

% Mapping Clusters

[cluster1_str,cluster2_str,cluster3_str] = cluster_mapping_iris(perm_vec_2);

cluster_1 = X_hat_2((indicator_variable_iris_pca_2(:,perm_vec_2(1))~=0),:);
cluster_2 = X_hat_2((indicator_variable_iris_pca_2(:,perm_vec_2(2))~=0),:);
cluster_3 = X_hat_2((indicator_variable_iris_pca_2(:,perm_vec_2(3))~=0),:);

% Plot of data with clustering in 2D
figure;
scatter(cluster_1(:,1),cluster_1(:,2),'b*')
hold on
scatter(cluster_2(:,1),cluster_2(:,2),'go','filled')
hold on
scatter(cluster_3(:,1),cluster_3(:,2),'k+')
hold on
scatter(centroids_iris_pca_2(:,1),centroids_iris_pca_2(:,2),150,'rs','filled');
hl1=xlabel('${\hat{x}}_1$','FontSize',15)
set(hl1, 'Interpreter', 'latex');
hl2= ylabel('${\hat{x}}_2$','FontSize',15)
set(hl2, 'Interpreter', 'latex');
set(gcf, 'Color', 'w');
leg=legend(cluster1_str,cluster2_str,cluster3_str,'Centroids','Location','Best');
set(leg,'FontSize',15)
set(gca,'YMinorTick','on')
set(gca,'XMinorTick','on')
set(gca,'FontSize',15)
grid on;
grid minor;
axis tight;
print('q2_4_2d','-depsc')
close all;

X_hat_3 = pca_algorithm(dataset_iris,3);
% Perform K-Means on Reduced Data
[centroids_iris_pca_3, indicator_variable_iris_pca_3, objective_result_pca_3] = kMeans_Q2(X_hat_3,k_vis);

[occe_err_cluster,perm_vec_3] = occe_error(X_hat_3,k_vis,indicator_variable_iris_pca_3);
[cluster1_str,cluster2_str,cluster3_str] = cluster_mapping_iris(perm_vec_3);

cluster_1 = X_hat_3((indicator_variable_iris_pca_3(:,perm_vec_3(1))~=0),:);
cluster_2 = X_hat_3((indicator_variable_iris_pca_3(:,perm_vec_3(2))~=0),:);
cluster_3 = X_hat_3((indicator_variable_iris_pca_3(:,perm_vec_3(3))~=0),:);

% Plot of data with clustering in 3D
figure;
scatter3(cluster_1(:,1),cluster_1(:,2),cluster_1(:,3),'b*')
hold on
scatter3(cluster_2(:,1),cluster_2(:,2),cluster_2(:,3),'go','filled')
hold on
scatter3(cluster_3(:,1),cluster_3(:,2),cluster_3(:,3),'k+')
hold on
scatter3(centroids_iris_pca_3(:,1),centroids_iris_pca_3(:,2),centroids_iris_pca_3(:,3),150,'rs','filled');
hl1=xlabel('${\hat{x}}_1$','FontSize',15)
set(hl1, 'Interpreter', 'latex');
hl2= ylabel('${\hat{x}}_2$','FontSize',15)
set(hl2, 'Interpreter', 'latex');
hl3 = zlabel('${\hat{x}}_3$','FontSize',15)
set(hl3, 'Interpreter', 'latex');
set(gcf, 'Color', 'w');
leg=legend(cluster1_str,cluster2_str,cluster3_str,'Centroids','Location','Best');
set(leg,'FontSize',15)
set(gca,'YMinorTick','on')
set(gca,'XMinorTick','on')
set(gca,'FontSize',15)
grid minor;
grid on;
axis tight;
print('q2_4_3d','-depsc')
close all;




