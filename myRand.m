function randStocks=myRand(N)
randStocks=ones(1,N);
AA=linspace(1,30,30);
for i=1:N
    randStocks(i)=AA(cell(rand*(30-i)+1));
    
end


