% H = [1 -1; -1 2]; 
% f = [-2; -6];
% A = [1 1; -1 2; 2 1];
% b = [2; 2; 3];
% lb = zeros(2,1);
% options = optimoptions('quadprog',...
%     'Algorithm','interior-point-convex','Display','off');
% [x,fval,exitflag,output,lambda] = ...
%    quadprog(H,f,A,b,[],[],lb,[],[],options);
%%
% v = sparse([1,-.25,0,0,0,0,0,-.25]);
% H = gallery('circul',v);
% f = -4:3;
% A = ones(1,8);
% b = -2;
% opts = optimoptions('quadprog',...
%     'Algorithm','interior-point-convex','Display','iter');
% [x,fval,eflag,output,lambda] = quadprog(H,f,A,b,[],[],[],[],[],opts);
%%
% T = 150; N = 50;
% R = randn(T, N);
% rho = 0.02;
% tau = 1;
% mu = rand(N,1);
% cvx_begin quiet
% variable w(N)
% minimize( norm(rho*ones(T,1)-R*w) + tau*norm(w,1) )
% subject to
%     w'*ones(N,1) == 1;
%     w'*mu == rho;
%     w >= 0;
% cvx_end
% figure(1), clf, bar(w); grid on
%%
% A = [1 1 1;
%      1 2 2;
%      1 3 3];
% B = [1 1 1;
%      2 2 2;
%      3 3 3];
% C = dot(A,B);
% D = A*B';
% E = A.*B;
%%
% A=[1 2 3;4 5 6;7 8 9];
% B=A(:,[1 2 3]);
%%
% C=[2 1.5;1.5 2];
% m=[0;0];
% A = chol(C);
% data=mvnrnd(m,C,10000);
% figure(21),clf
% plot(data(:,1),data(:,2),'x');
% 
% figure(22),clf
% data2=data*inv(A);
% plot(data2(:,1),data2(:,2),'x');
%%
% m=0;
% c=1000;
% data=linspace(-1,1,100000);
% 
% figure(23),clf,
% hist(data,100);
% 
% data2=data*c;
% figure(24),clf,
% hist(data2,10000);
%%
% load FundMarketCash 
% Returns = tick2ret(TestData);
% Riskless = mean(Returns(:,3));
% Sharpe = sharpe(Returns, Riskless);
%%
m1
C1













