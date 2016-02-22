% Computational Finance CW1
% Question 3
load dataR.mat
dataR=flipud(dataR);
T=length(dataR(:,1));
T=T/2;
% dataR_Half=100*dataR(1:round(T),:);
% dataR_Rest=100*dataR(round(T)+1:end,:);
dataR_Half=100*dataR(1:round(T),:);
dataR_Rest=100*dataR(round(T)+1:end,:);

N=length(dataR_Half(1,:));

m=mean(dataR_Half)';
C=cov(dataR_Half);

dataR_FTSE=flipud(dataR_FTSE);
dataR_FTSE_Half=100*dataR_FTSE(1:round(T),:);
dataR_FTSE_Rest=100*dataR_FTSE(round(T)+1:end,:);

%%
% Q3(a)************************************************
flag=0;
wgts=eye(30,30);
greedyWgts=zeros(30,6);
for i=1:6
    score=norm(dataR_FTSE_Half-dataR_Half*wgts(:,1));
    wgt=wgts(:,1);
    indx=1;
    for j=1:N-flag
        score1=norm(dataR_FTSE_Half-dataR_Half*wgts(:,j));
        weight1=wgts(:,j);
        if score1<score
            score=score1;
            wgt=weight1;
            indx=j;
        end
    end
    wgts(:,indx)=[];
    greedyWgts(:,i)=wgt;
    flag=flag+1;
end

%%
% Q3(b)************************************************
Division=100;
tRange=linspace(0,5,Division);
numNoZero=ones(Division,1);
weights=ones(N,Division);
for i=1:Division
    tau=tRange(i);
    cvx_begin quiet
    variable w(N)
    minimize( norm(dataR_FTSE_Half-dataR_Half*w) + tau*norm(w,1) )
    cvx_end
    
    [WIndx]=find(abs(w) > 1e-5);
    numNoZero(i,1)=length(WIndx);
    weights(:,i)=w;
end  
%%
load main3data.mat
%%
figure(1),clf,
plot(tRange,numNoZero,'r','LineWidth',2);
grid on
% [WIndx]=find(abs(weights(:,33)) > 1e-5);
% num=length(WIndx);
% disp(num);
%%
tau=1.5;
cvx_begin quiet
variable w(N)
minimize( norm(dataR_FTSE_Half-dataR_Half*w) + tau*norm(w,1) )
cvx_end
[WIndx]=find(abs(w) > 1e-5);

figure(2), clf, bar(w); 
grid on










