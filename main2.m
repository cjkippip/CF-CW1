% Computational Finance CW1
% Question 2
load dataR.mat
dataR=flipud(dataR);
T=length(dataR(:,1));
T=T/2;% half time
dataRHalf=dataR(1:round(T),:);% first half
dataRRest=dataR(round(T)+1:end,:);% the rest 
R1=dataRHalf(:,[1 2 3]);% select 3 stocks
R2=dataRRest(:,[1 2 3]);
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
portSimp=[1/3 1/3 1/3]';% 1/N portfolio
weights=estimateMaxSharpeRatio(pHalf);% the portfolio has max sharpe ratio

PESimpRest=m2'*portSimp;
PVSimpRest=sqrt(portSimp'*C2*portSimp);
PEMaxRest=m2'*weights;
PVMaxRest=sqrt(weights'*C2*weights);

PortReturn = [PESimpRest; PEMaxRest];
PortRisk = [PVSimpRest; PVMaxRest];

RiskThreshold = 0.10;
PortValue = [1000000;1000000];
ValueAtRisk = portvrisk(PortReturn,PortRisk,...
RiskThreshold,PortValue);
%%
% portSimp=[1/3 1/3 1/3]';
% PESimpHalf=m1'*portSimp;
% PVSimpHalf=sqrt(portSimp'*C1*portSimp);
% 
% figure(2),clf,
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
% figure(3),clf,
% plotFrontier(pRest);
% title('Efficient Frontier','FontSize',12);
% hold on
% scatter(PVSimpRest, PESimpRest, 80, 'MarkerEdgeColor', ...
%     'k', 'MarkerFaceColor', 'r', 'LineWidth', 2)
% grid on
% hold off
%%























