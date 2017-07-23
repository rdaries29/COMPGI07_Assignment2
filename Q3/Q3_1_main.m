close all;
clear all;

clc

load('train.txt')
load('test.txt')

% Epoch indices
epoch_start = 1;
epoch_stop = 10;

% Kernel Degrees
kernel_degree_max = 2;
kernel_degree_min=2;

% Digit ranges
min_dig=0;
max_dig=9;

% Kernel Type
type = 'poly';

%Initialisation for first for loop

for i=min_dig+1:max_dig+1
    
    alpha{i}=0;

    X_train{i}=train(1,2:end);
end


%for1 kernel_degree
for k_deg=kernel_degree_min:kernel_degree_max
    %for2 digits
    for epo_current= epoch_start:epoch_stop
        %for3 epochs
        for digit=min_dig+1:max_dig+1 
            %for4 training samples
            for train_sample=2432:7291
                % Prediction
                current_sample = train(train_sample,2:end);
                y_prediction = kernel_map(alpha{digit},X_train{digit},current_sample,k_deg,type);
%                 y_prediction = kernel_map(alpha{},X_train{},X_train{},k_deg,type)

                % Signed output
                y_signed = signed_output(y_prediction);
                %comparison
                y_true=train(train_sample,1);
                    if y_true==digit-1
                        y_comp=1;
                    else
                        y_comp=-1;
                    end
          
                    if y_signed ~= y_comp
                        %trigger update
                        
                        %Perform paramater update awhen mistake made
                        %Update alpha
                        alpha{digit} = [alpha{digit} y_comp];

                        %Update X's
                        X_train{digit} = [X_train{digit};  train(train_sample,2:end)];
                
                        %Update Parameters
                      %alpha, X_train  = update_parameters(alpha{digit,train_sample},y_true,X_train{digit,train_sample},X_train{digit,train_sample+1})
                    end
             
            end

            
        
        end
    end
    
end
count_correct=0;
prediction_vec = zeros(10,1);
length_validation = 2431;
length_train = 4860;

for i=1:2431
    pred_sample=train(i,2:end);
    y_true_actual = train(i,1);
    for digit_j=1:10
        prediction_vec(digit_j) = kernel_map(alpha{digit_j},X_train{digit_j},pred_sample,k_deg,type);
    end

    [value, index] = max(prediction_vec);
    y_pred_actual = index -1;
    if(y_true_actual == y_pred_actual)
        count_correct = count_correct+1;
    end
    %training_accuracy = count_correct/7291

end    


training_accuracy_final = count_correct/length_validation 












