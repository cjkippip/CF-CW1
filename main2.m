% Computational Finance CW1
% Question 2
load dataR.mat
dataR=flipud(dataR);
T=length(dataR(:,1));
T=T/2;% half time
dataRHalf=dataR(1:round(T),:);% first half
dataRRest=dataR(round(T)+1:end,:);% the rest 
aa=round(9*rand)+1;
bb=round(9*rand)+11;
cc=round(9*rand)+21;
R1=dataRHalf(:,[aa bb cc]);% select 3 stocks
R2=dataRRest(:,[aa bb cc]);
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
figure(1),clf,
plotFrontier(pHalf); 
title('Efficient Frontier','FontSize',12);
%%
% Q2(3)************************************************
Simp=[1/3 1/3 1/3]';% 1/N portfolio
% the portfolio has max sharpe ratio
MSRweight=estimateMaxSharpeRatio(pHalf);

PESimpRest=m2'*Simp;
PVSimpRest=sqrt(Simp'*C2*Simp);
PEMaxRest=m2'*MSRweight;
PVMaxRest=sqrt(MSRweight'*C2*MSRweight);

PortReturn = [PESimpRest; PEMaxRest];
PortRisk = [PVSimpRest; PVMaxRest];

RiskThreshold = 0.2;
PortValue = [1000000;1000000];
ValueAtRisk = portvrisk(PortReturn,PortRisk,...
RiskThreshold,PortValue);
%%
figure(2),clf,
x=[1 2];
bar(x,ValueAtRisk',0.3);
title('Comparison of VaR','FontSize',12);
xlabel('portfolio(max Sharpe)          simple 1/N',...
    'FontSize',12,'FontWeight','bold');
ylabel('Value at Risk','FontSize',12,'FontWeight','bold');
grid on
%%
pwgt=estimateFrontier(pHalf);
trainPortMeans=m1'*pwgt;
testPortMeans=m2'*pwgt;
trainSimpMean=Simp'*m1;
testSimpMean=Simp'*m2;
trainMeans=[trainPortMeans trainSimpMean];
testMeans=[testPortMeans testSimpMean];

figure(3),clf,
bar(trainMeans);
title('Performance on training data(first half)','FontSize',13);
ylabel('Expected Returen','FontSize',15,'FontWeight','bold');
grid on

figure(4),clf,
bar(testMeans);
title('Performance on test data(rest)','FontSize',13);
ylabel('Expected Returen','FontSize',15,'FontWeight','bold');
grid on
%%
% portSimp=[1/3 1/3 1/3]';
% PESimpHalf=m1'*portSimp;
% PVSimpHalf=sqrt(portSimp'*C1*portSimp);
% 
% figure(3),clf,
% plotFrontier(pHalf);
% title('Efficient Frontier','FontSize',12);
% hold on
% scatter(PVSimpHalf, PESimpHalf, 80, 'MarkerEdgeColor', ...
%     'k', 'MarkerFaceColor', 'r', 'LineWidth', 2)
% grid on
% hold off
%%
% pRest = Portfolio('mean', m2, 'covar', C2, ...
%     'ae', V1, 'be', 1, 'lb', V0);
% PESimpRest=m2'*portSimp;
% PVSimpRest=sqrt(portSimp'*C2*portSimp);
% 
% figure(4),clf,
% plotFrontier(pRest);
% title('Efficient Frontier','FontSize',12);
% hold on
% scatter(PVSimpRest, PESimpRest, 80, 'MarkerEdgeColor', ...
%     'k', 'MarkerFaceColor', 'r', 'LineWidth', 2)
% grid on
% hold off
%%





















