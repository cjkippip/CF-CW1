function [PRisk, PRoR, PWts] = NaiveMV_CVX(ERet, ECov, NPts)
ERet = ERet(:); 
NAssets = length(ERet); 

cvx_begin quiet
variable MaxReturnWeights(NAssets)
minimize( -ERet'*MaxReturnWeights )
subject to
    MaxReturnWeights'*ones(NAssets,1) == 1;
    MaxReturnWeights >= 0;
cvx_end
MaxReturn = MaxReturnWeights' * ERet;

cvx_begin quiet
variable MinVarWeights(NAssets)
minimize( MinVarWeights'*ECov*MinVarWeights )
subject to
    MinVarWeights'*ones(NAssets,1) == 1;
    MinVarWeights >= 0;
cvx_end
MinVarReturn = MinVarWeights' * ERet; 
MinVarStd = sqrt(MinVarWeights' * ECov * MinVarWeights);
%%
if MaxReturn > MinVarReturn
    RTarget = linspace(MinVarReturn, MaxReturn, NPts);
    NumFrontPoints = NPts;
else
    RTarget = MaxReturn;
    NumFrontPoints = 1;
end
%%
PRoR = zeros(NumFrontPoints, 1);
PRisk = zeros(NumFrontPoints, 1);
PWts = zeros(NumFrontPoints, NAssets);
PRoR(1) = MinVarReturn;
PRisk(1) = MinVarStd;
PWts(1,:) = MinVarWeights(:)';
%%
VConstr = ERet';
for point = 2:NumFrontPoints
    
    cvx_begin quiet
    variable Weights(NAssets)
    minimize( Weights'*ECov*Weights )
    subject to
        Weights'*ones(NAssets,1) == 1;
        VConstr*Weights == RTarget(point);
        Weights >= 0;
    cvx_end
    
    PRoR(point) = dot(Weights, ERet);
    PRisk(point) = sqrt(Weights'*ECov*Weights);
    PWts(point, :) = Weights(:)';
end
