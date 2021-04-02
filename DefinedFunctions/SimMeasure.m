 function mu = SimMeasure(beta, betaHat,problem)
% beta is the true parameter, and betaHat is the estimate obtained by MLE
% Similarity measure is defined as the the size of the intersection divided ...
% by the size of the union of the sample sets with equal weights
% clc,clear,close all
%% ---- Method 2 starts: vectorization to speed up checking feasibility 
%---Define the logistic regression function

% f=@(x,beta) 1./(1+exp(-x' * beta));

X = [ones(size(problem.scenario,1),1) problem.scenario];
Ytrue = problem.fun(X',beta);
Ypred = problem.fun(X',betaHat);

insect = sum(Ytrue <= problem.eta & Ypred <= problem.eta);
exceed = sum(Ytrue > problem.eta  & Ypred >  problem.eta);

% Compute the similarity measure
if (size(problem.scenario,1)-exceed )~=0
    mu= insect/(size(problem.scenario,1)-exceed);
else
    mu=0;
end
%% --- Method 1: starts: use linear programming to check feasibility and compute similarity
%  eta=problem.eta;
% % beta=[-1,1,1]';
% % betaHat=[0,1,1]';
% % domain = [1,1; -1*ones(length(beta)-1,1),1*ones(length(beta)-1,1)];
% domain =problem.domain;
% 
% % step=0.1;
% % [x_2,x_1]=ndgrid(-1:step:1,-1:step:1);
% % scenario=[ x_1(:) x_2(:) ]; % collection of scenarios
% A_domain = [diag(ones(length(beta)-1,1));-diag(ones(length(beta)-1,1))];
% b_domain = [domain(2:end,2);domain(2:end,2)];
% ATrue=beta(2:end)';
% bTrue=-(beta(1)+log(1/eta-1));   
% 
% AHat = betaHat(2:end)';
% bHat = -(betaHat(1)+log(1/eta-1));
% %---True region
% ATrue=[ATrue;A_domain];
% bTrue=[bTrue;b_domain];
% %---Estimated region 
% AEstimate=[AHat;A_domain];
% bEstimate=[bHat;b_domain];
% 
% %---Check feasibility
% x = optimvar('x',length(beta)-1,1);
% ConTrue = ATrue *x <= bTrue;
% ConEstimate= AEstimate *x <= bEstimate;
% 
% if isequal(option,'appro') && size(problem.scenario,1)> 300
%     index = randperm(size(problem.scenario,1),300);
%     scenario= problem.scenario(index,:);
% else % isequal(option,'test')
%     scenario = problem.scenario;
% end
% 
% insect=0; miss=0;%  exceed=0;
% for i=1:size(scenario,1)
%     pt.x = scenario(i,:)';
%     infeas=[infeasibility(ConTrue,pt),infeasibility(ConEstimate,pt)];
%     if (sum(infeas(:,1)))==0 && (sum(infeas(:,2)))==0 % feasible
%         insect=insect+1;
%     elseif (sum(infeas(:,1)))> 0 && (sum(infeas(:,2)))>0 % infeasible
%         miss=miss +1;      
%     end 
% end
% 
% % Compute the similarity measure
% if (size(scenario,1)-miss)~=0
%     mu= insect/(size(scenario,1)-miss);
% else
%     mu=0;
% end
% %———Method 1 ending
return
