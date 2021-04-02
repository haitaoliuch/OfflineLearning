
function IndexScenario = Acquisition(Fn,problem,options)
%---Select (n+1)th scenario: (i)  Estimate true beta by perturbation ...
%                            (ii) Select scenarios and update estimated beta
%                            (iii)Compute similarity measure
%---Define the logistic regression function
f=problem.fun;
betaHat = problem.HBeta; 
switch options


    case 'IG'
        if size(problem.scenario,1)>10000
            index = randi(size(problem.scenario,1),10000,1);
            scenario= problem.scenario(index,:);
        else
            scenario= problem.scenario;
            index = 1:1 :size(problem.scenario,1);
        end
        KGquantity= zeros(size(scenario,1),1);
    parfor i=1:size(scenario,1)
        sample1  = [Fn;1,scenario(i,:),1];
        betaHat1 = MaxLikelihood(sample1,problem.HBeta,'EqWeight');
        sample0  = [Fn;1,scenario(i,:),0];
        betaHat0 = MaxLikelihood(sample0,problem.HBeta,'EqWeight');  
        X = [Fn(:,1:end-1);1,scenario(i,:)];
        p1 = problem.fun(X',betaHat1);
        p0 = problem.fun(X',betaHat0);
        W1 = diag(p1.*(1-p1));
        W0 = diag(p0.*(1-p0));
        KGquantity(i,1) = problem.fun([1,scenario(i,:)]',problem.HBeta)*(det(inv(X'*W1*X))) +...
            (1-problem.fun([1,scenario(i,:)]',problem.HBeta))*det(inv(X'*W0*X));
    end
        [~,IndexScenario]=min(KGquantity);
        IndexScenario=index(IndexScenario);
        
%% ---A-optimality sampling: minimize the trace of the inverse Fisher information
    case 'A-optimality' 
    scenario = problem.scenario;
    KGquantity = zeros(size(scenario,1),1);
    parfor i=1:size(scenario,1)
        X = [Fn(:,1:end-1);1,scenario(i,:)];
        p = f(X',problem.HBeta);
        W = diag(p.*(1-p));
        KGquantity(i,1) = trace(inv(X'*W*X));
    end
    [~,IndexScenario]=min(KGquantity);

%% --- D-optimality minimizes the determinant of the inverse Fisher information
    case 'D-optimality' 
    scenario = problem.scenario;
    KGquantity = zeros(size(scenario,1),1);
    parfor i=1:size(scenario,1)
        X = [Fn(:,1:end-1);1,scenario(i,:)];
        p = f(X',problem.HBeta);
        W = diag(p.*(1-p));
        KGquantity(i,1) = det(inv(X'*W*X));
    end
    [~,IndexScenario]=min(KGquantity);

%% -- adaptive D-optimality design
    case 'ADD'
        KGquantity = zeros(size(problem.scenario,1),1);
        parfor i=1:size(problem.scenario,1)
            x = [1,problem.scenario(i,:)];
            p = problem.fun(x',problem.HBeta);
            X = Fn(:,1:end-1);
            P = problem.fun(X',problem.HBeta);
            W = diag(P.*(1-P));
            u = x'*p*(1-p)*x;
            KGquantity(i,1) = trace(u/(X'*W*X));
        end
        [~,IndexScenario]=min(KGquantity);
%% --- Randomly sample scenario
    case 'Random'       
    IndexScenario = randi(size(problem.scenario,1));
    
%% Uncertainty sampling: measure the scenario about which is the least certain 
% certain to label. FOR BINARY CASE, it simply queries the instance whose
% posterior probability of being postive is nearest 0.5.  
    case 'Uncertain'
    KGquantity = zeros(size(problem.scenario,1),1);
    parfor i=1:size(problem.scenario,1)
        KGquantity(i,1) = abs(f([1,problem.scenario(i,:)]',betaHat)-0.5);
    end
    [~,IndexScenario]=min(KGquantity);   
%% Expected Gradient Length: query the instance that would impart the greatest ...
% change to the current model if we knew its label. ...
% https://www.biostat.wisc.edu/~craven/papers/settles.emnlp08.pdf    
    case 'EGL'
    KGquantity = zeros(size(problem.scenario,1),1);
    for i=1:size(problem.scenario,1)
        x = [1,problem.scenario(i,:)]';
        KGquantity(i,1)=f(x,betaHat)*norm((1-f(x,betaHat))*x) +...
            (1-f(x,betaHat))*norm((0-f(x,betaHat))*x);
    end
    [~,IndexScenario]=max(KGquantity);   % maximum impact 
end
end


