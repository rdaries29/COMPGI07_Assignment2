%-------------------------------------------------------------------%
% Module: GI07 - Mathematical Methods for Machine Learning
% Assignment : Coursework 2
% Author : Russel Daries, Hugo Philion
% Student ID: 16079408, 14102040
% Question: 1
% Description: K-Means
% ------------------------------------------------------------------%

% clearing memory
clear all
close all
clc

%% 1.1.1 - Implement K-Means Algorithm

% Can be seen in function kMeans

%% 1.1.2 - Testing Algorithm

dataset = genData2;
k = 3;

cluster_1_cor = dataset(1:50,:);
cluster_2_cor = dataset(51:100,:);
cluster_3_cor = dataset(101:150,:);

% Plot of data with clustering
figure;
scatter(cluster_1_cor(:,1),cluster_1_cor(:,2),'filled')
hold on
scatter(cluster_2_cor(:,1),cluster_2_cor(:,2),'filled')
hold on
scatter(cluster_3_cor(:,1),cluster_3_cor(:,2),'filled')
% hold on
% scatter(centroids(:,1),centroids(:,2),'rs');
xlabel('x_1','FontSize',15)
ylabel('x_2','FontSize',15)
set(gcf, 'Color', 'w');
leg=legend('S1','S2','S3','Location','Best');
set(leg,'FontSize',15)
set(gca,'YMinorTick','on')
set(gca,'XMinorTick','on')
set(gca,'FontSize',15)
grid on;
grid minor;
axis tight;
print('q1_1_class_data_correct','-depsc')
close all;

[centroids, indicator_variable] = kMeans(dataset,k);

cluster_1 = dataset((indicator_variable(:,1)~=0),:);
cluster_2 = dataset((indicator_variable(:,2)~=0),:);
cluster_3 = dataset((indicator_variable(:,3)~=0),:);

% Plot of Original Data that is unclustered
figure;
scatter(dataset(:,1),dataset(:,2),'filled')
xlabel('x_1','FontSize',15)
ylabel('x_2','FontSize',15)
set(gcf, 'Color', 'w');
set(gca,'YMinorTick','on')
set(gca,'XMinorTick','on')
set(gca,'FontSize',15)
grid on;
grid minor;
axis tight;
print('q1_1_org_data','-depsc')
close all;

% Plot of data with clustering
figure;
scatter(cluster_1(:,1),cluster_1(:,2),'filled')
hold on
scatter(cluster_2(:,1),cluster_2(:,2),'filled')
hold on
scatter(cluster_3(:,1),cluster_3(:,2),'filled')
hold on
scatter(centroids(:,1),centroids(:,2),150,'ks','filled');
xlabel('x_1','FontSize',15)
ylabel('x_2','FontSize',15)
set(gcf, 'Color', 'w');
leg=legend('Cluster 1','Cluster 2','Cluster 3','Centroids','Location','Best');
set(gca,'YMinorTick','on')
set(gca,'XMinorTick','on')
set(gca,'FontSize',15)
grid on;
grid minor;
axis tight;
print('q1_1_class_data_unlabelled','-depsc')
close all;

% Resultant plot for err calculation

% [err_logic, err_counts] = simple_error(dataset,k,indicator_variable)
err_counts = simple_error(dataset,k,indicator_variable)

% % Resultant plot for occe calculation
% 
[occe_err, perm_vec_1] = occe_error(dataset,k,indicator_variable)
[cluster1_str,cluster2_str,cluster3_str] = cluster_mapping_q1(perm_vec_1)

cluster_1 = dataset((indicator_variable(:,perm_vec_1(1))~=0),:);
cluster_2 = dataset((indicator_variable(:,perm_vec_1(2))~=0),:);
cluster_3 = dataset((indicator_variable(:,perm_vec_1(3))~=0),:);

% Plot of data with clustering
figure;
scatter(cluster_1(:,1),cluster_1(:,2),'filled')
hold on
scatter(cluster_2(:,1),cluster_2(:,2),'filled')
hold on
scatter(cluster_3(:,1),cluster_3(:,2),'filled')
hold on
scatter(centroids(:,1),centroids(:,2),150,'ks','filled');
xlabel('x_1','FontSize',15)
ylabel('x_2','FontSize',15)
set(gcf, 'Color', 'w');
leg=legend(cluster1_str,cluster2_str,cluster3_str,'Centroids','Location','Best');
set(leg,'FontSize',15)
set(gca,'YMinorTick','on')
set(gca,'XMinorTick','on')
set(gca,'FontSize',15)
grid on;
grid minor;
axis tight;
print('q1_1_class_data_labelled','-depsc')
close all;

% Resultant plots for average and std deviation of occe for 100 trials
occe_err_100 = zeros(100,1);
k_m = 3;
for m=1:100
    dataset_m = dataset;
    [centroids_m, indicator_variable_m] = kMeans(dataset_m,k_m);
    occe_err_100(m) = occe_error(dataset_m,k_m,indicator_variable_m);
end

occe_err_100_avg = mean(occe_err_100)
occe_err_100_std = std(occe_err_100)

figure;
plot(occe_err_100,'r*')
hold on
plot(occe_err_100_avg*ones(length(occe_err_100),1),'b--')
xlabel('Trials','FontSize',15)
ylabel('occe','FontSize',15)
set(gcf, 'Color', 'w');
leg=legend('occe_{trials}','occe_{avg}','Location','Best');
set(leg,'FontSize',15)
set(gca,'YMinorTick','on')
set(gca,'XMinorTick','on')
set(gca,'FontSize',15)
grid on;
grid minor;
axis tight;
print('q1_2_occe_100_trials','-depsc')
close all;

% Resultant plots for average and std deviation of occe for 250 trials
occe_err_250 = zeros(250,1);
k_n = 3;

for n=1:250
    dataset_n = dataset;
    [centroids_n, indicator_variable_n] = kMeans(dataset_n,k_n);
    occe_err_250(n) = occe_error(dataset_n,k_n,indicator_variable_n);
end

occe_err_250_avg = mean(occe_err_250)
occe_err_250_std = std(occe_err_250)

figure;
plot(occe_err_250,'r*')
hold on
plot(occe_err_250_avg*ones(length(occe_err_250),1),'b--')
xlabel('Trials','FontSize',15)
ylabel('occe','FontSize',15)
set(gcf, 'Color', 'w');
leg=legend('occe_{trials}','occe_{avg}','Location','Best');
set(leg,'FontSize',15)
set(gca,'YMinorTick','on')
set(gca,'XMinorTick','on')
set(gca,'FontSize',15)
grid on;
grid minor;
axis tight;
print('q1_2_occe_250_trials','-depsc')
close all;


%% 1.1.3 - Testing on Iris Dataset

k_iris = 3;

% Read in Iris Data from file

load('iris_dataset.mat');
dataset_iris = iris_data;

% Perform k-means on Iris data

[centroids_iris, indicator_variable_iris] = kMeans(dataset_iris,k_iris);

cluster_1 = dataset_iris((indicator_variable_iris(:,1)~=0),:);
cluster_2 = dataset_iris((indicator_variable_iris(:,2)~=0),:);
cluster_3 = dataset_iris((indicator_variable_iris(:,3)~=0),:);

% Resultant plot for err calculation

err_iris = simple_error(dataset_iris,k_iris,indicator_variable_iris);

% Resultant plot for occe calculation

occe_err_iris = occe_error(dataset_iris,k_iris,indicator_variable_iris);

% Resultant plots for average and std deviation of occe for 100 trials
occe_err_100_iris = zeros(100,1);
k_k=3;
for k=1:100    
    [centroids_k, indicator_variable_k] = kMeans(dataset_iris,k_k);
    occe_err_100_iris(k) = occe_error(dataset_iris,k_k,indicator_variable_k);
end

occe_err_100_iris_avg = mean(occe_err_100_iris)
occe_err_100_iris_std = std(occe_err_100_iris)    

figure;
plot(occe_err_100_iris,'r*')
hold on
plot(occe_err_100_iris_avg*ones(length(occe_err_100_iris),1),'b--')
xlabel('Trials','FontSize',15)
ylabel('occe','FontSize',15)
set(gcf, 'Color', 'w');
leg=legend('occe_{trials}','occe_{avg}','Location','Best');
set(leg,'FontSize',15)
set(gca,'YMinorTick','on')
set(gca,'XMinorTick','on')
set(gca,'FontSize',15)
grid on;
grid minor;
axis tight;
print('q1_2_occe_iris_100_trials','-depsc')
close all;

% Resultant plots for average and std deviation of occe for 250 trials

occe_err_250_iris = zeros(250,1);
k_l=3;
for l=1:250    
    [centroids_l, indicator_variable_l] = kMeans(dataset_iris,k_l);
    occe_err_250_iris(l) = occe_error(dataset_iris,k_l,indicator_variable_l);
end

occe_err_250_iris_avg = mean(occe_err_250_iris)
occe_err_250_iris_std = std(occe_err_250_iris) 

figure;
plot(occe_err_250_iris,'r*')
hold on
plot(occe_err_250_iris_avg*ones(length(occe_err_250_iris),1),'b--')
xlabel('Trials','FontSize',15)
ylabel('occe','FontSize',15)
set(gcf, 'Color', 'w');
leg=legend('occe_{trials}','occe_{avg}','Location','Best');
set(leg,'FontSize',15)
set(gca,'YMinorTick','on')
set(gca,'XMinorTick','on')
set(gca,'FontSize',15)
grid on;
grid minor;
axis tight;
print('q1_2_occe_iris_250_trials','-depsc')
close all;
