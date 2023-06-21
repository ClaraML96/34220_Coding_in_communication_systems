% Hamming Dekoder
%syndrom
%s= eH
fejl= zeros(1,N);
ST=zeros(N+1,N); %syndrom tabel 1 fejl
for i=1:N
      fejl(i)=1;
      syndrom=mod(fejl*H,2);
      s1=polyval(syndrom,2)+1;
      ST(s1,:)=fejl;
      fejl(i)=0;
end  
%%
% % modtaget vektor = kodeord + fejl
% % fejl vektor e med kun 1 fejl 
% e=zeros(1,N);
% e(1,randi(N))=1;
% % y = c + e 
% y=mod(c+e,2);
% 
% %s=y*H
% %samlign med syndrom tabel for 1 fejl
% s=mod(y*H,2);
% index=polyval(s,2)+1;
% c=mod(y+ST(index,:),2);
% %x=c(1,1:K)

% %tilføj fejl til Produktkode transmission
% for i=1:N
%     e=zeros(1,N);
%     e(1,randi(N))=1;
%     P(i,:)=mod(P(i,:)+e,2);
% end
%% tilføj støj til Produkt code
% e= zeros(N);
p=0.005; %p<0.005
e=rand(N,N)<p;
y=mod(P+e,2);


%% Produktkode decode
temp=zeros(N,K);
%rækkea
for i=1:N
%     y=P(i,:); %uden støj
%     s=mod(y*H,2);
    s=mod(y(i,:)*H,2);
    index=polyval(s,2)+1;
    c=mod(y(i,:)+ST(index,:),2);
    temp(i,1:K)=c(1,1:K); % skift til temp(i,:)
end
%søjle
x2=zeros(K);
temp=temp';
for i=1:K
    s=mod(temp(i,:)*H,2);
    index=polyval(s,2)+1;
    c=mod(temp(i,:)+ST(index,:),2);
    x2(i,:)=c(1,1:K);
end
x2=x2';
%tjek
dec=all(all(x == x2))
%% Produktkode decode iterations 
temp=zeros(N,N);
count=0;
while (all(all(P == y)))==0 && count<3 %% køre max 3 gange %x==y(1:K,1:K)
    %række
    for i=1:N
    %     y=P(i,:); %uden støj
    %     s=mod(y*H,2);
        s=mod(y(i,:)*H,2);
        index=polyval(s,2)+1;
        c=mod(y(i,:)+ST(index,:),2);
        temp(i,:)=c(1,:);
    end
    %søjle
    x2=zeros(N);
    temp=temp';
    for i=1:N
        s=mod(temp(i,:)*H,2);
        index=polyval(s,2)+1;
        c=mod(temp(i,:)+ST(index,:),2);
        x2(i,:)=c(1,:);
    end
    x2=x2';
    y=x2;
    %tjek
    %all(all(x == x2(1:K,1:K)))
    count=count+1;
end
it=(all(all(P == y)))
x = y(1:K,1:K);
