%Atividade 3
%Dinis Meireles de Sousa Falc�o - 2020130403
%David Seco Rodrigues - 2019130152
%
% DI_DFDerivada2 Deriva��o Num�rica - f�rmula das diferen�as finitas em 3 pontos para a 2� derivada
% Form�la das Diferen�as finitas em 3 pontos para a 2� derivada
% f''(xi)=(f(x(i+1)) - 2*f(x(i)) - f(x(i-1))/(h^2)
% INPUT:  f - fun��o
%         [a, b] - intervalo de deriva��o
%         h - passo da discretiza��o
%         y - imagens x vs y
% OUTPUT: [x, y] - malha de pontos
%         dydx - derivada de f de 2�ordem
%

function [x,y,dydx]=DI_DFDerivada2(f,a,b,h,y)
x=a:h:b;
n=length(x);
if nargin==4
    y=f(x);
end
dydx=zeros(1,n);
dydx(1)=(y(3)-2*y(2)+y(1))/(h^2);
for i=2:n-1
    dydx(i)=(y(i+1)-2*y(i)+y(i-1))/(h^2);
end
dydx(n)=(y(n)-2*y(n-1)+y(n-2))/(h^2);

