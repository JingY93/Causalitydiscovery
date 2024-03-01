% ʹ��Cao������������ռ��ع�Ƕ��ά����ȷ����ǰ������Ҫ�������Ƕ��ά�������ʱ��
function [E1 E2 embed_dimension] = GetEmbedDimension_Cao(data,tao,mmax,flag)

%data : Ҫ�ع���ʱ������
%tao : ʱ���ӳ�
%mmax : ���Ƕ��ά��
%reference:Cao, L. (1997), ``Practical method for determining the minimum
%embedding dimension of a scalar time series'', Physcai D, 110, pp. 43-50. 

N=length(data);
for m=1:mmax
    M=N-m*tao;
    if M<1
        break;
    end
    Y=psr_deneme(data,m,tao,M);
    
    for n=1:M
        y0=ones(M,1)*Y(n,:);
        distance=max(abs(Y-y0),[],2);
        [neardis nearpos]=sort(distance);
        
        index=find(neardis==0);
        neardis(index)=[];
        nearpos(index)=[];
        
        newpoint=[Y(n,:) data(n+m*tao)];
        newneig=[Y(nearpos(2),:) data(nearpos(2)+m*tao)];
        R1=max(abs(newpoint-newneig),[],2);
        
        a(n)=R1/neardis(2);
        d(n)=abs(data(n+m*tao)-data(nearpos(2)+m*tao));
    end
    E(m)=sum(a)/M;
    Ey(m)=sum(d)/M;
end

embed_dimension=1;


E1=E(2:end)./E(1:end-1);
E2=Ey(2:end)./Ey(1:end-1);

for i=1:1:length(E1)-1
    if (E1(i+1)-E1(i))/E1(i)<0.1
        embed_dimension=i+1;
        break;
    end
end
if flag
    figure
    plot(1:length(E1),E1,'-bo','LineWidth',2,'MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',2);
    hold on
    plot(1:length(E2),E2,'-ro','LineWidth',2,'MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',2);
    grid on
    title('ʹ��Cao����ȷ����СǶ��ά��');
    xlabel('Ƕ��ά��');
    ylabel('E1&E2');
    legend('E1','E2');
end


% ��ȡ�ع���ռ�
function Y=psr_deneme(data,m,tao,npoint)
%x : ԭʼʱ������
%m : Ƕ��ά��
%tao : ʱ��
%npoint : ��������N=M-��m-1��*tao
%Y : M x m matrix

N=length(data);
if nargin == 4
    M=npoint;
else
    M=N-(m-1)*tao;
end

Y=zeros(M,m); 

for i=1:m
    Y(:,i)=data((1:M)+(i-1)*tao)';
end



