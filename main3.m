% Computational Finance CW1
% Question 3
load dataR.mat
dataR=flipud(dataR);
T=length(dataR(:,1));
T=T/2;
N=length(dataR(1,:));
dataR_Half=100*dataR(1:round(T),:);
dataR_Rest=100*dataR(round(T)+1:end,:);
m=mean(dataR_Half)';
C=cov(dataR_Half);

dataR_FTSE=flipud(dataR_FTSE);
dataR_FTSE_Half=100*dataR_FTSE(1:round(T),:);
dataR_FTSE_Rest=100*dataR_FTSE(round(T)+1:end,:);

%%
% Q3(a)************************************************


%%
% Q3(b)************************************************
numNoZero=ones(100,1);
for i=1:100
    % rho = 0.0013;
    tau=(i-1)/10;
    cvx_begin quiet
    variable w(N)
    minimize( norm(dataR_FTSE_Half-dataR_Half*w) + tau*norm(w,1) )
%     subject to
%        w'*ones(N,1) == 1;
%        w'*m == rho;
%        w >= 0;
    cvx_end
    
    [WIndx]=find(abs(w) > 1e-5);
    numNoZero(i,1)=length(WIndx);
end  

%%
tau=1.6;
cvx_begin quiet
variable w(N)
minimize( norm(dataR_FTSE_Half-dataR_Half*w) + tau*norm(w,1) )
cvx_end
[WIndx]=find(abs(w) > 1e-5);
num=length(WIndx);

figure(9), clf, bar(w); 
grid on
disp(num);



