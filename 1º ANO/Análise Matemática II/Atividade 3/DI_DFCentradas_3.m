%Atividade 3
%Dinis Meireles de Sousa Falc�o - 2020130403
%David Seco Rodrigues - 2019130152
%
% DI_DFCentradas_3 Deriva��o Num�rica - f�rmula das diferen�as centradas em 3 pontos
% Form�la das Diferen�as centradas em 3 pontos
% f'(xi)=(f(x(i+1))-f(x(i-1))/(2*h)
% INPUT:  f - fun��o
%         [a, b] - intervalo de deriva��o
%         h - passo da discretiza��o
%         y - imagens x vs y
% OUTPUT: [x, y] - malha de pontos
%         dydx - derivada de f

function [x,y,dydx]=DI_DFCentradas_3(f,a,b,h,y)
x=a:h:b;
n=length(x);
if nargin==4
    y=f(x);
end
dydx=zeros(1,n);
dydx(1)=(y(2)-y(1))/h;
for i=2:n-1
    dydx(i)=(y(i+1)-y(i-1))/(2*h);
end
dydx(n)=(y(n)-y(n-1))/h;