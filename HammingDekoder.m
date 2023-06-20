% Hamming Dekoder
% modtaget vektor = kodeord + fejl
% fejl vektor e med kun 1 fejl 
e=zeros(1,N);
e(1,randi(N))=1;
% y = c + e 
y=mod(c+e,2);

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

%s=y*H
%sammenlign med syndrom tabel for 1 fejl
s=mod(y*H,2);
index=polyval(s,2)+1;
c=mod(y+ST(index,:),2);
