%% Generate data for high-dimensional problems
clc,clear,close all
pro.fun=@(x,beta) 1./(1+exp(-x' * beta));
d = 200; n = 10000; r=1; % r denotes the radius
pro.TBeta =ones(d+1,1);  
pro.scenario =randsphere(n,d,r);
folder = fullfile('..\Sequential_LearningV2\HProb');
[~,~]  = mkdir(folder);
save(fullfile(folder,sprintf('P_%dD.mat',d)),'pro'); 

function X = randsphere(m,n,r)
 
% This function returns an m by n array, X, in which 
% each of the m rows has the n Cartesian coordinates 
% of a random point uniformly-distributed over the 
% interior of an n-dimensional hypersphere with 
% radius r and center at the origin.  The function 
% 'randn' is initially used to generate m sets of n 
% random variables with independent multivariate 
% normal distribution, with mean 0 and variance 1.
% Then the incomplete gamma function, 'gammainc', 
% is used to map these points radially to fit in the 
% hypersphere of finite radius r with a uniform % spatial distribution.
% Roger Stafford - 12/23/05
 
X = randn(m,n);
s2 = sum(X.^2,2);
X = X.*repmat(r*(gammainc(s2/2,n/2).^(1/n))./sqrt(s2),1,n);
end