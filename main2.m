% Computational Finance CW1
% Question 2
load dataR.mat
dataR=flipud(dataR);
T=length(dataR(:,1));
T=T/2;
dataRHalf=dataR(1:round(T),:);
dataRRest=dataR(round(T)+1:end,:);
R=dataRHalf(:,[1 2 3]);
%%
% Q2(1)************************************************
m=mean(R)';
C=cov(R);

%%
% Q2(2)************************************************
NAssets=length(m);
V0 = zeros(NAssets, 1);
V1 = ones(1, NAssets);
p = Portfolio('mean', m, 'covar', C, ...
    'ae', V1, 'be', 1, 'lb', V0);
figure(1),clf,
plotFrontier(p);
title('Efficient Frontier','FontSize',12);

%%
% Q2(3)************************************************
portSimp=[1/3 1/3 1/3]';
PESimp=m'*portSimp;
PVSimp=sqrt(portSimp'*C*portSimp);
figure(2),clf,
plotFrontier(p);
title('Efficient Frontier','FontSize',12);
hold on
scatter(PVSimp, PESimp, 80, 'MarkerEdgeColor', ...
    'k', 'MarkerFaceColor', 'r', 'LineWidth', 2)
grid on
hold off





