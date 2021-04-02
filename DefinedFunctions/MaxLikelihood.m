function [th] = MaxLikelihood(Fn,InitialBeta, option)
%  x=xlsread('marks.xlsx');
 ytrain = Fn(:,end); % Target variable 
 xtrain = Fn(:,1:end-1);
 % xtrain=zscore(x(:,1:end-1));% Normalized Predictors
%   iter=1000; % No. of iterations for weight updation
  if isempty(InitialBeta)
      th=zeros(size(xtrain,2),1); % Initial weights
  else
      th =InitialBeta;
  end
  
  alpha=0.1; % Learning parameter
  
  %Cost Summary of this function goes here

if isequal(option,'reweight')
    PerQuantity = gamrnd(1,2,length(ytrain),1); 
else
    PerQuantity = ones(length(ytrain),1);
end
    for j=1:1000
        h=1./(1+exp(-xtrain*th));
%        h=sigmoid(xtrain*th);
        th=th+(alpha/length(xtrain))*xtrain'*((ytrain-h).*PerQuantity);
    end
end

% function g = sigmoid( z )
% %SIGMOID Summary of this function goes here
% %   Detailed explanation goes here
% g=1./(1+exp(-z));
% 
% end
 
 