clear all
close all
while (1>0)
A = exist('ETHUSDT_math-in.csv');
B = exist('BTCUSDT_math-in.csv');
C = exist('BNBUSDT_math-in.csv');
if(A==2 && B==2 && C==2)
pause(5);

X_ETH=csvread("ETHUSDT_math-in.csv");
X_BTC=csvread("BTCUSDT_math-in.csv");
X_BNB=csvread("BNBUSDT_math-in.csv");

[Xt_ETH,L_C_ETH]=Xt_generator(X_ETH);
[Xt_BTC,L_C_BTC]=Xt_generator(X_BTC);
[Xt_BNB,L_C_BNB]=Xt_generator(X_BNB);

load net_ETH_H1
ans_ETH=net(Xt_ETH');
clear net
load net_BTC_H1
ans_BTC=net(Xt_BTC');
clear net
load net_BNB_H1
ans_BNB=net(Xt_BNB');
% -------fil array defult
Answer(1,1)="ETH";
Answer(1,2)="None";
Answer(1,3)=ans_ETH(4,end);
Answer(1,4)=L_C_ETH; 
Answer(1,5)="BTC";
Answer(1,6)="None";
Answer(1,7)=ans_BTC(4,end);
Answer(1,8)=L_C_BTC; 
Answer(1,9)="BNB";
Answer(1,10)="None";
Answer(1,11)=ans_BNB(4,end);
Answer(1,12)=L_C_BNB; 

% -----------ETH answer check
if(ans_ETH(4,end)>0.18)
Answer(1,1)="ETH";
Answer(1,2)="BUY";
Answer(1,3)=ans_ETH(4,end);
Answer(1,4)=X_ETH(end,4); 
end
if(ans_ETH(4,end)<-0.18)

Answer(1,1)="ETH";
Answer(1,2)="SELL";
Answer(1,3)=ans_ETH(4,end);
Answer(1,4)=L_C_ETH; 
end
% -----------BTC answer check
if(ans_BTC(4,end)>0.18)
Answer(1,5)="BTC";
Answer(1,6)="BUY";
Answer(1,7)=ans_BTC(4,end);
Answer(1,8)=L_C_BTC; 
end
if(ans_BTC(4,end)<-0.18)
Answer(1,5)="BTC";
Answer(1,6)="SELL";
Answer(1,7)=ans_BTC(4,end);
Answer(1,8)=X_BTC(end,4); 
end
% -----------BNB answer check
if(ans_BNB(4,end)>0.14)
Answer(1,9)="BNB";
Answer(1,10)="BUY";
Answer(1,11)=ans_BNB(4,end);
Answer(1,12)=L_C_BNB; 
end
if(ans_BNB(4,end)<-0.14)
Answer(1,9)="BNB";
Answer(1,10)="SELL";
Answer(1,11)=ans_BNB(4,end);
Answer(1,12)=X_BNB(end,4); 
end



%write('Answer.csv',char(Answer));
fileID = fopen('Answer.txt','w');
fprintf(fileID,'%s\n',Answer);
fclose(fileID);
delete('ETHUSDT_math-in.csv');
delete('BTCUSDT_math-in.csv');
delete('BNBUSDT_math-in.csv');


end
pause(1);
end