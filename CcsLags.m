clear;clc

l=[];
LL=[];
% f1=2;
% f2=3;
% DATA=csvread('/Users/yuanjing/Library/Mobile Documents/com~apple~CloudDocs/因果分析/data/windturbine1.csv',0,0);
% f1range=(1:3000);
% X=DATA(f1range,f1)';
% Y=DATA(f1range,f2)';

%% TE
% 读文件
% for i=0:21
%     if i < 10
%         Data=load(['/Users/yuanjing/Library/Mobile Documents/com~apple~CloudDocs/基于卷积图神经网络的状态辨识方法/ITScode_v2.1/functions/tennessee-eastman-profBraatz-master/','d0',num2str(i),'.dat']);
%     else
%         Data=load(['/Users/yuanjing/Library/Mobile Documents/com~apple~CloudDocs/基于卷积图神经网络的状态辨识方法/ITScode_v2.1/functions/tennessee-eastman-profBraatz-master/','d',num2str(i),'.dat']);
%     end
%         [M,N]=size(Data);
%         for i = 1:N
%             for j=1:N
%                 X=Data(:,i)
%                 Y=Data(:,j)
%                 for k=400:1:450
%                     X=X(k-399:k);
%                     Y=Y(k-399:k);
%                     for lag=5:-1:-2
%                         C=CCS(Y',X',lag,2,2);
% %     [C,r]=convergence(Y4',Y2',i,2,4);
%                         l=[l,C(2,1)];
%                     end
%                     LL=[LL;l];
%                     l=[];
%                 end
%             
%             end
%         end
%         
%     
% end
% 
% load d00.dat
% Y1=d00(20,1:end);
% Y2=d00(21,1:end);
% Y3=d00(22,1:end);
% Y4=d00(23,1:end);
%% 4GE
[Y1,Y2,Y3,Y4]=coupled_logistic_4(0.4,0.4,0.4,0.4,2000);
Data=[Y1;Y2;Y3;Y4];
% Data=[get_symbolic_ts(Y1',100);get_symbolic_ts(Y2',100);get_symbolic_ts(Y3',100);get_symbolic_ts(Y4',100)];
Data=Data';
[M,N]=size(Data);
Cell=cell(N,N)
tic;
bar=waitbar(0,"读取数据中...");
tao=[2,2,2,2];
MCAO=[2,2,2,2];

for i = 1:N
    for j=2:N
%         for t=1:1:N
%         for M=1:1:N
%         if i~=j
            X=Data(:,i);
            Y=Data(:,j);
            for k=1000:1:1001
                XX=X(k-200:k,:);
                YY=Y(k-200:k,:);
                for lag=0:-1:-1
                    C=CCS(YY,XX,lag,tao(i),MCAO(i));
    %     [C,r]=convergence(Y4',Y2',i,2,4);
                    l=[l,C(2,1)];
                end
                LL=[LL;l];
                l=[];
            end
            Cell{i,j}=LL;
            LL=[];
%         end
%         end
    end
    str=["计算中...",num2str(100*i/N),"%"];
    waitbar(i/N,bar,str);
end
toc;
% for j=1000:1:1010
%     X=Y1(j-999:j);
%     Y=Y4(j-999:j);
%     for i=5:-1:-2
%         C=CCS(Y',X',i,2,2);
% %     [C,r]=convergence(Y4',Y2',i,2,4);
%         l=[l,C(2,1)];
%     end
%     LL=[LL;l];
%     l=[];
% end
% % stem(1:100,l(1));