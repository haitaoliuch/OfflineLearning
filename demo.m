
clc,clear,close all
warning off
N=400;       % No. of simulation budget
k= 'CS'; %= 'R3D2S3O' Uncertain
pro    = Problem(k);
pro.eta= 0.3;
rep =10; 
for r=1:rep
    Ubeta = pro.TBeta; % ambiguity set
    pro.HBeta = zeros(length(pro.TBeta),1);
    Fn=[]; % samples up to phase n
    archive=zeros(N,length(pro.TBeta)); 

for n=0:N-1 
%---Randomly sample the first scenario
    if n<10
       IndexScenario = randi(size(pro.scenario,1));
    else
        tic
        IndexScenario = Acquisition(Fn,pro,'KGD'); 
        Time(r,n+1) =toc; 
    end  
%---Measure (n+1)th scenario:
   if unifrnd(0,1) <= pro.fun([1,pro.scenario(IndexScenario,:)]',Ubeta) 
       Fn=[Fn;1,pro.scenario(IndexScenario,:),1];
   else
       Fn=[Fn;1,pro.scenario(IndexScenario,:),0];    
   end
%---Update the estimate of regression coefficient (beta) based on samples Fn
   pro.HBeta = MaxLikelihood(Fn,[],'eqweight');% glmfit(Fn(:,2:end-1),Fn(:,end),'binomial', 'link', 'logit');
   archive(n+1,1:length(pro.TBeta))=pro.HBeta;  
end  
   Rep.beta{r}     = archive;
   Rep.scenario{r} = Fn;
%---Measure similarity to true collection
   Rep.Sim(r,1) = SimMeasure(pro.TBeta,archive(end,:)', pro);
end
%---Compute mean and sample standard deviation in terms of similarity
Rep.SimMean  = mean(Rep.Sim);
Rep.SimStd   = std(Rep.Sim);  
Rep.Time = mean(Time);
folder= fullfile('..\Sequential_Learning\Result','KGD');
[~,~]      = mkdir(folder); % make new folder
save(fullfile(folder,sprintf('P_%s_E%s.mat',k,num2str(pro.eta))),'Rep', 'pro'); 

