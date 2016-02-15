% Computational Finance CW1
% Question 2

load dataR.mat
dataR=flipud(dataR);
L=length(dataR(:,1));
dataRHalf=dataR(1:round(L/2),:);
dataRRest=dataR(round(L/2)+1:end,:);
R=dataRHalf(:,[1 2 3]);
%%
% Q2(1)***********************************************************
m=mean(R)';
C=cov(R);

%%
% Q2(2)***********************************************************
NAssets=length(m);
V0 = zeros(NAssets, 1);
V1 = ones(1, NAssets);
p = Portfolio('mean', m, 'covar', C, ...
    'ae', V1, 'be', 1, 'lb', V0);
figure(6),clf,
plotFrontier(p);
title('Efficient Frontier','FontSize',12);

%%
% Q2(3)***********************************************************
portSimp=[1/3 1/3 1/3]';
PESimp=m'*portSimp;
PVSimp=sqrt(portSimp'*C*portSimp);
figure(7),clf,
plotFrontier(p);
title('Efficient Frontier','FontSize',12);
hold on
scatter(PVSimp, PESimp, 80, 'MarkerEdgeColor', ...
    'k', 'MarkerFaceColor', 'r', 'LineWidth', 2)
grid on
hold off





