close all
clear all

X=csvread("BTCUSDT_math-in.csv");
% X=X(1:end-1,:);
% n=size(X,1);
% while(X(n,32)==20)
%     n=n-1;
% end
% X=X(1:n,:);
T=X(:,4);
X=X(:,1:end-1);


T1=T;
for(i=1:size(T1,1)-1)
    if(T1(i+1,1)>T1(i,1))
     T2(i,1)=1;
    else
        T2(i,1)=-1;
    end
end
% for(i=2:size(X,1))
%     for(j=1:size(X,2))
%         X1(i,j)=X(i,j)-X(i-1,j);
%     end
% end
% X1=X1(:,1:end-3);
% X1=X1(2:end,:);
% T2=T2(2:end);
X=X(1:end-1,:);

% for(i=2:size(X,1))
%     for(j=1:size(X,2))
%         X1(i,j)=X(i,j)-X(i-1,j);
%     end
% end
% 
% clear X
% X=X1;
% for(i=4:size(T2,1))
% if(T2(i-3,1)==0 && T2(i-2,1)==0 && T2(i-1,1)==0 && T2(i,1)==0 )
% Tn(i,5)=-16;
% end
% if(T2(i-3,1)==0 && T2(i-2,1)==0 && T2(i-1,1)==0 && T2(i,1)==1 )
% Tn(i,5)=16;
% end
% if(T2(i-3,1)==0 && T2(i-2,1)==0 && T2(i-1,1)==1 && T2(i,1)==0 )
% Tn(i,5)=-3;
% end
% if(T2(i-3,1)==0 && T2(i-2,1)==0 && T2(i-1,1)==1 && T2(i,1)==1 )
% Tn(i,5)=3;
% end
% if(T2(i-3,1)==0 && T2(i-2,1)==1 && T2(i-1,1)==0 && T2(i,1)==0 )
% Tn(i,5)=-5;
% end
% if(T2(i-3,1)==0 && T2(i-2,1)==1 && T2(i-1,1)==0 && T2(i,1)==1 )
% Tn(i,5)=5;
% end
% if(T2(i-3,1)==0 && T2(i-2,1)==1 && T2(i-1,1)==1 && T2(i,1)==0 )
% Tn(i,5)=-7;
% end
% if(T2(i-3,1)==0 && T2(i-2,1)==1 && T2(i-1,1)==1 && T2(i,1)==1 )
% Tn(i,5)=7;
% end
% if(T2(i-3,1)==1 && T2(i-2,1)==0 && T2(i-1,1)==0 && T2(i,1)==0 )
% Tn(i,5)=-9;
% end
% if(T2(i-3,1)==1 && T2(i-2,1)==0 && T2(i-1,1)==0 && T2(i,1)==1 )
% Tn(i,5)=9;
% end
% if(T2(i-3,1)==1 && T2(i-2,1)==0 && T2(i-1,1)==1 && T2(i,1)==0 )
% Tn(i,5)=-11;
% end
% if(T2(i-3,1)==1 && T2(i-2,1)==0 && T2(i-1,1)==1 && T2(i,1)==1 )
% Tn(i,5)=11;
% end
% if(T2(i-3,1)==1 && T2(i-2,1)==1 && T2(i-1,1)==0 && T2(i,1)==0 )
% Tn(i,5)=-13;
% end
% if(T2(i-3,1)==1 && T2(i-2,1)==1 && T2(i-1,1)==0 && T2(i,1)==1 )
% Tn(i,5)=13;
% end
% if(T2(i-3,1)==1 && T2(i-2,1)==1 && T2(i-1,1)==1 && T2(i,1)==0 )
% Tn(i,5)=-15;
% end
% if(T2(i-3,1)==1 && T2(i-2,1)==1 && T2(i-1,1)==1 && T2(i,1)==1 )
% Tn(i,5)=15;
% end
% 
% 
% end



for(i=4:size(T2,1))
    Tn(i,1)=T2(i-3,1);
    Tn(i,2)=T2(i-2,1)*2;
    Tn(i,3)=T2(i-1,1)*3;
    Tn(i,4)=T2(i,1)*4;
    
end
% X=X(1:end-1,:);
% clear T2
% T2=Tn;

X=X(4:end,:);
Tn=Tn(4:end,:);

for(i=5:size(X,1))
p=0;
n=0;
for(k=1:4)
for(j=1:size(X,2))
    n=n+1;
    X2(i,n)=X(i-p,j);
end
p=p+1;
end
end
% X2=X2(4:end,:);
% T2=T2(4:end,:);
% 
% load select
% p=0;
% for(i=1:size(X2,1))
%     for(j=1:size(Select,1))
%         if(i==Select(j,1))
%             p=p+1;
%             X3(:,p)=X2(:,i);
%         end
%     end
% end
% X4=X3(1:end-500,:);
% T3=T2(1:end-500);

% clear X
% X=X3;
clear X
X=X2;
X=X(5:end,:);
Tn=Tn(5:end,:);

% X3=X(1:end-1000,:);
% T=Tn(1:end-1000,:);

X3=X;
T=Tn;



t=T';


x=X3';


% [xn,xs] = mapminmax(x);% Normalization of inputs
% [tn,ts] = mapminmax(t); % Normalization of outputs


trainFcn = 'trainlm';  % Levenberg-Marquardt backpropagation.
hiddenLayer1Size = 3;
% hiddenLayer2Size = 4;


net = fitnet([hiddenLayer1Size],  trainFcn);
net.divideFcn = 'dividerand';  % Divide data randomly
net.divideMode = 'sample';  % Divide up every sample
net.numLayers=2;
% net.biasConnect(3)=1;
% net.biasConnect(2)=1;
% net.biasConnect(1)=1;
% net.layerConnect(2,1);
% net.layerConnect(3,2);

net.layers{1}.transferFcn = 'logsig';
net.layers{2}.transferFcn = 'tansig';
% net.layers{3}.transferFcn = 'tansig';
net = configure(net, x, t);
I = size(x,1);
N = size(x,2);
O = size(t,1);
rng(0);
IW = 0.001 * randn(hiddenLayer1Size,I);
LW = 0.001 * randn(O,hiddenLayer1Size);
b1 = 0.001 * randn(hiddenLayer1Size,1);
b2 = 0.001 * randn(O,1);

% net.IW{1,1}
% net.LW{2,1}
% net.b{1}
% net.b{2}
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
net.trainParam.max_fail=60;
net.trainParam.epochs=200000;
net.trainParam.min_grad=0;
net.trainParam.lr=0.0000000001;
% net.trainParam.mu=0.000001;
% net.trainParam.mu_max=1e20;
% net.trainParam.mu_dec=0.00001;
% net.trainParam.goal=0.125;
% net.trainParam.lr_inc=0.00001;
% net.trainParam.lr_dec=0.00001;
% net.trainParam.mc=0.000001;
net.performFcn = 'mse';  % Mean Squared Error

  
%        net.layerWeights{1,1}.initFcn=(-1/sqrt(170))+(normrnd(1,1000))*((1/sqrt(170))-(-1/sqrt(170)));

% net.b{1};
% net.performParam.normalization='percent';
[net,tr] = train(net,x,t);

clear X3
clear T2
X3=X(end-1000:end,:);
T2=Tn(end-1000:end,:);
p=net(X3');

% T2=T2';
p=p';
win=0;
los=0;
for(i=1:size(p,1))
    if(p(i,4)>0.2  )
        if(T2(i,4)==1 )
            win=win+1
        end
        if(T2(i,4)==-1)
            los=los+1
        end
    end
    if(p(i,4)<-0.2 )
        if(T2(i,4)==-1 )
            win=win+1
        end
        if(T2(i,4)==1)
            los=los+1
        end
    end    

end




