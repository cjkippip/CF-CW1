% Computational Finance CW1
% Question 1
m=[0.10;0.20;0.15];
C=[0.005,-0.01,0.004;...
   -0.01,0.04,-0.002;...
   0.004,-0.002,0.023];
NAssets = length(m);
V0 = zeros(NAssets, 1);
V1 = ones(1, NAssets);
%%
% Q1(a)************************************************
pointN=1000;
port1=ones(pointN,3);
for i=1:pointN
    x=rand(1,3);y=sum(x);z=x/y;
    port1(i,:)=z;
end
PV=ones(pointN,1);
PE=port1*m;
for i=1:pointN  
    PV(i)=sqrt(port1(i,:)*C*port1(i,:)'); 
end

[PRisk, PRoR, PWts] = NaiveMV(m, C, pointN);
figure(1),clf,
plot(PRisk,PRoR,'LineWidth',2)
title('Mean Variance Porfolio','FontSize',15)
xlabel('V(risk)','FontSize',13,'FontWeight','bold')
ylabel('E(return)','FontSize',13,'FontWeight','bold')
hold on
scatter(PV,PE,'r');
grid on
hold off
%%
figure(2),clf,
scatter3(port1(:,1),port1(:,2),port1(:,3),'r');
hold on
plot3([1,0],[0,0],[0,1],'m','LineWidth',2);
plot3([1,0],[0,1],[0,0],'m','LineWidth',2);
plot3([0,0],[1,0],[0,1],'m','LineWidth',2);
plot3(PWts(:,1),PWts(:,2),PWts(:,3),'b','LineWidth',3);
grid on
hold off
%%
% Q1(b)************************************************
m1=[0.20;0.15];
m2=[0.10;0.15];
m3=[0.10;0.20];
C1=[0.04,-0.002;...
    -0.002,0.023];
C2=[0.005,0.004;...
    0.004,0.023];
C3=[0.005,-0.01;...
    -0.01,0.04];

pointN2=50;
wgt1=ones(pointN2,2);
for i=1:pointN2
    x=rand(1,2);y=sum(x);z=x/y;
    wgt1(i,:)=z;
end

wgt2=ones(pointN2,2);
for i=1:pointN2
    x=rand(1,2);y=sum(x);z=x/y;
    wgt2(i,:)=z;
end

wgt3=ones(pointN2,2);
for i=1:pointN2
    x=rand(1,2);y=sum(x);z=x/y;
    wgt3(i,:)=z;
end

PV1=ones(pointN2,1);
PE1=wgt1*m1;
for i=1:pointN2  
    PV1(i)=sqrt(wgt1(i,:)*C1*wgt1(i,:)'); 
end
PV2=ones(pointN2,1);
PE2=wgt2*m2;
for i=1:pointN2  
    PV2(i)=sqrt(wgt2(i,:)*C2*wgt2(i,:)'); 
end
PV3=ones(pointN2,1);
PE3=wgt3*m3;
for i=1:pointN2  
    PV3(i)=sqrt(wgt3(i,:)*C3*wgt3(i,:)'); 
end


p = Portfolio('mean', m, 'covar', C, ...
'ae', V1, 'be', 1, 'lb', V0);
p1 = Portfolio('mean', m1, 'covar', C1, ...
'ae', V1(1,1:2), 'be', 1, 'lb', V0(1:2,1));
p2 = Portfolio('mean', m2, 'covar', C2, ...
'ae', V1(1,1:2), 'be', 1, 'lb', V0(1:2,1));
p3 = Portfolio('mean', m3, 'covar', C3, ...
'ae', V1(1,1:2), 'be', 1, 'lb', V0(1:2,1));
figure(3),clf,

subplot(221)
plotFrontier(p);
title('Efficient Frontier(3-asset)','FontSize',12);
hold on
scatter(PV,PE,'r');
axis([0.02 0.2 0.1 0.2]);

subplot(222)
plotFrontier(p1);
title('Efficient Frontier(2-asset 1st)','FontSize',12);
hold on
scatter(PV1,PE1,'m');
axis([0.02 0.2 0.1 0.2]);

subplot(223)
plotFrontier(p2);
title('Efficient Frontier(2-asset 2nd)','FontSize',12);
hold on
scatter(PV2,PE2,'m');
axis([0.02 0.2 0.1 0.2]);

subplot(224)
plotFrontier(p3);
title('Efficient Frontier(2-asset 3rd)','FontSize',12);
hold on
scatter(PV3,PE3,'c');
axis([0.02 0.2 0.1 0.2]);
%%
figure(4),clf,
plotFrontier(p);
hold on
plotFrontier(p1);
plotFrontier(p2);
plotFrontier(p3);
legend('3-asset','no 1st','no 2nd','no 3rd',...
    'Location','northwest')
scatter(PV,PE,'r');
scatter(PV1,PE1,'b+');
scatter(PV2,PE2,'m+');
scatter(PV3,PE3,'c+');
grid on
hold off

%%
% Q1(c)************************************************

%%
% Q1(d)************************************************
T = 150; N = 50;
R = randn(T, N);
mu = rand(N,1);
%%
tau = 1;
rho = 0.02;
cvx_begin quiet
variable w(N)
minimize( norm(rho*ones(T,1)-R*w) + tau*norm(w,1) )
subject to
    w'*ones(N,1) == 1;
    w'*mu == rho;
    w >= 0;
cvx_end
figure(5), clf, bar(w); 
grid on
%%
[PRisk2, PRoR2, PWts2] = NaiveMV_CVX(m, C, 100);
figure(6),clf,
plot(PRisk2,PRoR2,'LineWidth',2)
title('Mean Variance Porfolio','FontSize',15)
xlabel('V(risk)','FontSize',13,'FontWeight','bold')
ylabel('E(return)','FontSize',13,'FontWeight','bold')
grid on






