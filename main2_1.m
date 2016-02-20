% Computational Finance CW1
% Question 2
load dataR.mat
dataR=flipud(dataR);
T=length(dataR(:,1));
T=T/2;% half time
dataRHalf=dataR(1:round(T),:);% first half
dataRRest=dataR(round(T)+1:end,:);% the rest 

ValueAtRisk=ones(10,2);
for i=1:10
    R1=dataRHalf(:,[i i+1 i+2]);% select 3 stocks
    R2=dataRRest(:,[i i+1 i+2]);
    % m and C of first half part
    m1=mean(R1)';
    C1=cov(R1);
    % m and C of the rest part
    m2=mean(R2)';
    C2=cov(R2);
    N=length(m1);% number of assets
    
    V0 = zeros(N, 1);
    V1 = ones(1, N);
    pHalf = Portfolio('mean', m1, 'covar', C1, ...
        'ae', V1, 'be', 1, 'lb', V0);
%     figure(1),clf,
%     plotFrontier(pHalf);
%     title('Efficient Frontier','FontSize',12);

    portSimp=[1/3 1/3 1/3]';% 1/N portfolio
    weights=estimateMaxSharpeRatio(pHalf);% the portfolio has max sharpe ratio

    PESimpRest=m2'*portSimp;
    PVSimpRest=sqrt(portSimp'*C2*portSimp);
    PEMaxRest=m2'*weights;
    PVMaxRest=sqrt(weights'*C2*weights);

    PortReturn = [PESimpRest; PEMaxRest];
    PortRisk = [PVSimpRest; PVMaxRest];
    RiskThreshold = 0.2;
    PortValue = [1000000;1000000];
    ValueAtRisk(i,:) = portvrisk(PortReturn,PortRisk,...
    RiskThreshold,PortValue);
end
xx=linspace(1,10,10);
figure(5),clf,
bar(xx,ValueAtRisk);
grid on
figure(6),clf,
plot(xx,ValueAtRisk(:,1),'b',xx,ValueAtRisk(:,2),'r','LineWidth',2);
legend('portfolio(max Sharpe)','simple 1/N');
grid on


















