% Computational Finance CW1
% Question 2
load dataR.mat
dataR=flipud(dataR);
T=length(dataR(:,1));
T=T/2;% half time
dataRHalf=dataR(1:round(T),:);% first half
dataRRest=dataR(round(T)+1:end,:);% the rest 
% randStocks=randperm(30,3);
randStocks=[7 17 22];

R1=dataRHalf(:,randStocks);% select 3 stocks
R2=dataRRest(:,randStocks);
%%
% Q2(1)************************************************
% m and C of first half part
m1=mean(R1)';
C1=cov(R1);
% m and C of the rest part
m2=mean(R2)';
C2=cov(R2);
N=length(m1);% number of assets
%%
% Q2(2)************************************************
V0 = zeros(N, 1);
V1 = ones(1, N);
pHalf = Portfolio('mean', m1, 'covar', C1, ...
    'ae', V1, 'be', 1, 'lb', V0);
pRest = Portfolio('mean', m2, 'covar', C2, ...
    'ae', V1, 'be', 1, 'lb', V0);
figure(1),clf,
plotFrontier(pHalf); 
title('Efficient Frontier','FontSize',12);
%%
% Q2(3)************************************************
Simp=[1/3 1/3 1/3]';% 1/N portfolio
% the portfolio has max sharpe ratio
% MSRweight=estimateMaxSharpeRatio(pHalf);
% 
% PESimpRest=m2'*Simp;
% PVSimpRest=sqrt(Simp'*C2*Simp);
% PEMaxRest=m2'*MSRweight;
% PVMaxRest=sqrt(MSRweight'*C2*MSRweight);
% 
% PortReturn = [PESimpRest; PEMaxRest];
% PortRisk = [PVSimpRest; PVMaxRest];
% 
% RiskThreshold = 0.2;
% PortValue = [1000000;1000000];
% ValueAtRisk = portvrisk(PortReturn,PortRisk,...
% RiskThreshold,PortValue);
%%
% figure(2),clf,
% x=[1 2];
% bar(x,ValueAtRisk',0.3);
% title('Comparison of VaR','FontSize',12);
% xlabel('portfolio(max Sharpe)          simple 1/N',...
%     'FontSize',12,'FontWeight','bold');
% ylabel('Value at Risk','FontSize',12,'FontWeight','bold');
% grid on
%%
Npwgt=20;
pwgt=estimateFrontier(pHalf,Npwgt);
% training data
trainPortMeans=m1'*pwgt;
trainPortRisks=ones(1,Npwgt);
for i=1:Npwgt
    trainPortRisks(1,i)=sqrt(pwgt(:,i)'*C1*pwgt(:,i));
end
trainSimpMean=Simp'*m1;
trainSimpRisk=sqrt(Simp'*C1*Simp);
trainMeans=[trainPortMeans trainSimpMean];
trainRisks=[trainPortRisks trainSimpRisk];

% test data
testPortMeans=m2'*pwgt;
testPortRisks=ones(1,Npwgt);
for i=1:Npwgt
    testPortRisks(1,i)=sqrt(pwgt(:,i)'*C2*pwgt(:,i));
end
testSimpMean=Simp'*m2;
testSimpRisk=sqrt(Simp'*C2*Simp);
testMeans=[testPortMeans testSimpMean];
testRisks=[testPortRisks testSimpRisk];

% figure(3),clf,
% bar(trainMeans);
% title('Performance on training data(first half)','FontSize',13);
% ylabel('Expected Returen','FontSize',15,'FontWeight','bold');
% grid on
% 
% figure(4),clf,
% bar(testMeans);
% title('Performance on test data(rest)','FontSize',13);
% ylabel('Expected Returen','FontSize',15,'FontWeight','bold');
% grid on
%%
figure(2),clf,
plotFrontier(pHalf);
title('Efficient Frontier on training data','FontSize',15);
hold on
scatter(trainPortRisks, trainPortMeans,'r');
scatter(trainSimpRisk, trainSimpMean, 80, 'MarkerEdgeColor', ...
    'k', 'MarkerFaceColor', 'r', 'LineWidth', 2)
legend('efficient frontier','points on frontier','simple 1/N',...
    'Location','southeast');
grid on
hold off

figure(3),clf,
plotFrontier(pRest);
title('Efficient Frontier on test data','FontSize',15);
hold on
scatter(testPortRisks, testPortMeans,'r');
scatter(testSimpRisk, testSimpMean, 80, 'MarkerEdgeColor', ...
    'k', 'MarkerFaceColor', 'r', 'LineWidth', 2)
legend('efficient frontier','points on training frontier','simple 1/N',...
    'Location','southeast');
grid on
hold off
%%
trianSimpSharpeR=trainSimpMean/trainSimpRisk;
trianSimpSharpeR2=ones(1,Npwgt);
trainPortSharpeR=ones(1,Npwgt);
for i=1:Npwgt
    trainPortSharpeR(i)=trainPortMeans(i)/trainPortRisks(i);
    trianSimpSharpeR2(i)=trianSimpSharpeR;
end

testSimpSharpeR=testSimpMean/testSimpRisk;
testSimpSharpeR2=ones(1,Npwgt);
testPortSharpeR=ones(1,Npwgt);
for i=1:Npwgt
    testPortSharpeR(i)=testPortMeans(i)/testPortRisks(i);
    testSimpSharpeR2(i)=testSimpSharpeR;
end
xx4=linspace(1,Npwgt,Npwgt);

figure(4),clf,
plot(xx4,trainPortSharpeR,'b','LineWidth',2);
hold on
plot(xx4,trianSimpSharpeR2,'r','LineWidth',2);
title('Sharpe ratio of 20 points on frontier and simple 1/N(training)'...
    ,'FontSize',15)
ylabel('Sharpe ratio','FontSize',13,'FontWeight','bold')
legend('efficient frontier','simple 1/N','Location','west');
grid on
hold off

figure(5),clf,
plot(xx4,testPortSharpeR,'b','LineWidth',2);
hold on
plot(xx4,testSimpSharpeR2,'r','LineWidth',2);
title('Sharpe ratio of 20 points on frontier and simple 1/N(test)'...
    ,'FontSize',15)
ylabel('Sharpe ratio','FontSize',13,'FontWeight','bold')
legend('efficient frontier','simple 1/N','Location','northwest');
grid on
hold off















