%% --Notice: before running please change the policy name
  %--for RandomRh-dimensional problems
clc,clear,close all
warning off
N = 500;       % No. of simulation budget
k = 30;  % dimension
folder = fullfile('..\Sequential_Learning\HProb');
load(fullfile(folder,sprintf('P_%dD.mat',k))); 
pro.eta= 0.3;
R =20; 
for r=1:R
    pro.HBeta = zeros(length(pro.TBeta),1);
    Fn=[]; % samples up to phase n
    archive=zeros(N,length(pro.TBeta)); 
    for n=0:N-1 
        Scenario = AcquisitionM1(Fn,pro,'RandomR'); 
       if unifrnd(0,1) <= pro.fun(Scenario,pro.TBeta) 
           Fn=[Fn;Scenario',1];
       else
           Fn=[Fn;Scenario',0];    
       end
    %---Update the estimate of regression coefficient (beta) based on samples Fn
       pro.HBeta = MaxLikelihood(Fn,[],'eqweight');
       archive(n+1,1:length(pro.TBeta))=pro.HBeta;   
    end
   Rep.beta{r}     = archive;
%---Measure similarity to true collection
   Rep.Sim(r,1) = SimMeasure(pro.TBeta,archive(end,:)', pro);
end
%---Compute mean and sample standard deviation in terms of similarity
Rep.SimMean  = mean(Rep.Sim); 
folder= fullfile('..\Sequential_Learning\Result','RandomR');
[~,~]      = mkdir(folder); % make new folder
save(fullfile(folder,sprintf('P_%dD_E%s_N%d_R%d.mat',k,num2str(pro.eta),N,R)),'Rep', 'pro'); 
