%% Projekt
% Produktkoder med koder og dekoder for Hamming koder
% Christian Schaumburg Jacobsen, Clara Mejlhede Lorenzen, Jana Jankovic

%Hamming enkoder 
%N er antal bit K er infromations bit 
% Hamming (N,K)
N=7;
K=4;

% H Paritets matrix
H=zeros(N,(N-K));   % N eller (2^(N-K))-1
j=N;
L=1;
for i=1:N           %((2^(N-K))-1 = N måske skal der kun står N

    if (i^i)==i || all(factor(i)==2)
        H(j,:)=flip(de2bi(i,(N-K)));
        j=j-1;
    else
        H(L,:)=flip(de2bi(i,(N-K)));
        L=L+1;
    end
end

% G generator matrix
G=[eye(K) H(1:K,:)];

%informations bits 
x= randi([0 1],1,K);

%encoder 
c=mod(x*G,2);
