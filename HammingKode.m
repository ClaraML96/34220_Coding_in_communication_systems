%% Projekt
% Produktkoder med koder og dekoder for Hamming koder
% Christian Schaumburg Jakobsen, Clara Mejlhede Lorenzen, Jana Jankovic

%Hamming enkoder 
%N er antal bit K er infromations bit 
% Hamming (N,K)
m=3; %7=127 bit
N=2^m-1;
K=N-m;

%%informations bits 
x=zeros(K);
for i =1:K 
    x(i,:)= randi([0 1],1,K); %informations vektor 
end   


% H Paritetscheck matrix
H=zeros(N,m);     % N eller (2^(N-K))-1 % m eller (N-K)
j=N;
L=1;
for i=1:N           %((2^(N-K))-1 = N måske skal der kun står N
    if (i^i)==i || all(factor(i)==2)
        H(j,:)=flip(de2bi(i,m));
        j=j-1;
    else
        H(L,:)=flip(de2bi(i,m));
        L=L+1;
    end
end

% G generator matrix
G=[eye(K) H(1:K,:)]; %[egenmatrix paritetscheck]

%enkoder 
% c = xG
%c=mod(x*G,2); %kodeord
%% Produktkode
P=zeros(N);
%række
for i=1:K 
    c=mod(x(i,:)*G,2);
    P(i,:)=mod(x(i,:)*G,2);
end
%søjle
P=P';
for i=1:N
    P(i,:)=mod(P(i,1:K)*G,2);
end
P=P';
%tjek x og P(4x4)
%x == P(1:K,1:K)
