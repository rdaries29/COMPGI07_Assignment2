function y_signed = signed_output(y_pred)

% Assign output based on probability input
if y_pred>0
    y_signed = 1;
elseif y_pred <=0
    y_signed = -1;
end




