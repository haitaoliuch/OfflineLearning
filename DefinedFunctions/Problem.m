function pro = Problem(options)

%---Define the logistic regression function
pro.fun=@(x,beta) 1./(1+exp(-x' * beta));
switch options
    case '2D1S'
        pro.TBeta =[1;1;1];  
        step=0.1; 
        [ x_2,x_1]=ndgrid(-1:step:1,-1:step:1);
        pro.scenario =[ x_1(:) x_2(:) ]; % collection of scenarios
        offset =0;
        pro.lb =pro.TBeta-offset;
        pro.ub =pro.TBeta+offset;
    case '2D2S'
        pro.TBeta =[1;1;1];  
        step=0.2; 
        [x_2,x_1]=ndgrid(-1:step:1,-1:step:1);
        pro.scenario =[ x_1(:) x_2(:)]; % collection of scenarios 
        offset =0;
        pro.lb =pro.TBeta-offset;
        pro.ub =pro.TBeta+offset;
    case '3D1S'
        pro.TBeta =[1;1;1;1];  
        step=0.1; 
        [x_3, x_2,x_1]=ndgrid(-1:step:1,-1:step:1,-1:step:1);
        pro.scenario =[ x_1(:) x_2(:) x_3(:)]; % collection of scenarios
        offset =0;
        pro.lb =pro.TBeta-offset;
        pro.ub =pro.TBeta+offset;
    case '3D2S'
        pro.TBeta =[1;1;1;1];  
        step=0.2; 
        [x_3, x_2,x_1]=ndgrid(-1:step:1,-1:step:1,-1:step:1);
        pro.scenario =[ x_1(:) x_2(:) x_3(:)]; % collection of scenarios 
        offset =0;
        pro.lb =pro.TBeta-offset;
        pro.ub =pro.TBeta+offset;
    case 'R2D1S'
        pro.TBeta =[1;1;1];  
        step=0.1; 
        [x_2,x_1]=ndgrid(-1:step:1,-1:step:1);
        pro.scenario =[ x_1(:) x_2(:)]; % collection of scenarios 
        offset =0.3;
        pro.lb =pro.TBeta-offset;
        pro.ub =pro.TBeta+offset;
        
    case 'R2D2S'
        pro.TBeta =[1;1;1];  
        step=0.2; 
        [x_2,x_1]=ndgrid(-1:step:1,-1:step:1);
        pro.scenario =[ x_1(:) x_2(:)]; % collection of scenarios 
        offset =0.2;
        pro.lb =pro.TBeta-offset;
        pro.ub =pro.TBeta+offset;
    case 'R3D1S'
        pro.TBeta =[1;1;1;1];  
        step=0.1; 
        [x_3, x_2,x_1]=ndgrid(-1:step:1,-1:step:1,-1:step:1);
        pro.scenario =[ x_1(:) x_2(:) x_3(:)]; % collection of scenarios
        offset =0.3;
        pro.lb =pro.TBeta-offset;
        pro.ub =pro.TBeta+offset;
    case 'R3D1S2O'
        offset =0.2;
        pro.TBeta =[1;1;1;1];  
        step=0.1; 
        [x_3, x_2,x_1]=ndgrid(-1:step:1,-1:step:1,-1:step:1);
        pro.scenario =[ x_1(:) x_2(:) x_3(:)]; % collection of scenarios 
        pro.lb =pro.TBeta-offset;
        pro.ub =pro.TBeta+offset;    
    case 'R3D2S'
        pro.TBeta =[1;1;1;1];  
        step=0.2; 
        [x_3, x_2,x_1]=ndgrid(-1:step:1,-1:step:1,-1:step:1);
        pro.scenario =[ x_1(:) x_2(:) x_3(:)]; 
        offset =0.2;
        pro.lb =pro.TBeta-offset;
        pro.ub =pro.TBeta+offset;
    case 'R3D2S3O'
        offset =0.3;
        pro.TBeta =[1;1;1;1];  
        step=0.2; 
        [x_3, x_2,x_1]=ndgrid(-1:step:1,-1:step:1,-1:step:1);
        pro.scenario =[ x_1(:) x_2(:) x_3(:)];  
        pro.lb =pro.TBeta-offset;
        pro.ub =pro.TBeta+offset;         
    case 'CS'
         % import data
        data = xlsread('banking.xlsx');
        pro.Y=data(:,end); % Target variable
        pro.scenario=zscore(data(:,1:end-1));% Normalized Predictors
        %compute cost and gradient
        pro.TBeta = MaxLikelihood([ones(length(pro.scenario),1) data],[],'eqweight');
    case '30D'
        d = 30; n = 10000; r=1;
        pro.TBeta =ones(d+1,1);  
        pro.scenario =randsphere(n,d,r);  
    case '40D'
        d = 40; n = 10000; r=1;
        pro.TBeta =ones(d+1,1);  
        pro.scenario =randsphere(n,d,r);  
    case '50D'
        d = 50; n = 10000; r=1;
        pro.TBeta =ones(d+1,1);  
        pro.scenario =randsphere(n,d,r); 
end
pro.domain = [1,1; -1*ones(length(pro.TBeta)-1,1),1*ones(length(pro.TBeta)-1,1)];






