
clc,clear,close all
% X is one-dimensional and beta is also one-dimensional
beta=[0.5:0.025:0.7]';
% X is two-dimensional and the chart is 3-D
beta=[0.5,-0.4];
[x_1,x_2] = meshgrid(-5:.1:5);                                
Z = 1 ./(1+exp(-(x_1*beta(1)+x_2*beta(2))));
threshold=0.5+ x_1*0;
mesh(x_1,x_2,threshold)
hold on
mesh(x_1,x_2,Z)
p=(abs(threshold-Z)<0.001);
xp=x_1.*p;
yp=x_2.*p;
zp=Z.*p;
plot3(xp(p~=0),yp(p~=0),zp(p~=0),'r','LineWidth',4); 
z_0= 0.*p;
plot3(xp(p~=0),yp(p~=0),z_0(p),'r','LineWidth',2);   
text(-5,0,0,'Safe Scenarios','Color','red','FontSize',10)
colorbar
zlabel('Risk')
% A = magic(5);
% C = {'Time', 'Temp'; 12 98; 13 'x'; 14 97};
% filename = 'testdata.xlsx';
% writematrix(A,filename,'Sheet',2,'Range','E1:I5')
% writecell(C,filename,'Sheet','Temperatures','Range','B2');
%%-------------------------------------------------------------- 
% Plot: X is one-dimensional and the chart is 2-D
x=linspace(-5,5);
beta=[1,1.5,1];
F_x_beta= 1./(1+exp(-x * beta(1)));

figure
plot(x,1./(1+exp(-x * beta(1))),x,1./(1+exp(-x * 2)))
line([-5,5],[0.8,0.8],'linestyle','--', 'Color','r', 'LineWidth', 1);

text(-4,0.85,'Threshold','Color','red','FontSize',12)
line([0.6567,0.6567],[0,0.8], 'linestyle','--', 'Color','b', 'LineWidth', 0.5);
line([1.460,1.460],[0,0.8], 'linestyle','--', 'Color','b', 'LineWidth', 0.5);
hold on
fill([0.6567,0.6567,1.460,1.460],[0,0.05,0.05,0],'r')