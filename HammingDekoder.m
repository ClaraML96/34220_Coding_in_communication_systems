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

%tilføj fejl til Produktkode transmission
for i=1:N
    e=zeros(1,N);
    e(1,randi(N))=1;
    P(i,:)=mod(P(i,:)+e,2);
end
    
%% Produktkode decode
temp=zeros(N,K);
%række
for i=1:N
    y=P(i,:);
    s=mod(y*H,2);
    index=polyval(s,2)+1;
    c=mod(y+ST(index,:),2);
    temp(i,1:K)=c(1,1:K);
end
%søjle
x2=zeros(K);
temp=temp';
for i=1:K
    y=temp(i,:);
    s=mod(y*H,2);
    index=polyval(s,2)+1;
    c=mod(y+ST(index,:),2);
    x2(i,:)=c(1,1:K);
end
x2=x2';
%tjek
x == x2
