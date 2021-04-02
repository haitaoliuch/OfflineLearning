
function IndexScenario = AcquisitionH(~,problem,options)
%% This is for synthetic problem with high-dimensional design space. In order to 
%% run this function, you should change the demo.m accordingly.
%---Select (n+1)th scenario: (i)  Estimate true beta by perturbation ...
%                            (ii) Select scenarios and update estimated beta
%                            (iii)Compute similarity measure
%---Define the logistic regression function

switch options
%% --- Randomly sample scenario
    case 'RandomR'       
        m = length(problem.HBeta);
        IndexScenario=rand(m,1)*2-1;
    case 'HIG'
        m = length(problem.HBeta);
        index = randi(m); r=rand(1)*2-1;
        IndexScenario = ones(m,1);
        IndexScenario(rand(m,1)>0.5)=-1;
        IndexScenario(index) =r;  
end
end


