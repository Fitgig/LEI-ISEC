%Atividade 3
%Dinis Meireles de Sousa Falc�o - 2020130403
%David Seco Rodrigues - 2019130152
%
% DI_DFProgressivas_3 Deriva��o Num�rica - f�rmula das diferen�as progressivas em 3 pontos
% Form�la das Diferen�as progressivas em 3 pontos
% f'(xi)=(-3*f(x(i)) + 4*f(x(i+1)) - f(x(i+2))/(2*h)
% INPUT:  f - fun��o
%         [a, b] - intervalo de deriva��o
%         h - passo da discretiza��o
%         y - imagens x vs y
% OUTPUT: [x, y] - malha de pontos
%         dydx - derivada de f
%

function [x,y,dydx]=DI_DFProgressivas_3(f,a,b,h,y)
x=a:h:b;
n=length(x);
if nargin==4
    y=f(x);
end
dydx=zeros(1,n);
for i=1:n-2
    dydx(i)=( (-3)*y(i) + 4*y(i+1) - y(i+2) ) / (2*h);
end
dydx(n-1)=( y(n-3) - 4*y(n-2) + 3*y(n-1) )/(2*h);
dydx(n)=( y(n-2) - 4*y(n-1) + 3*y(n) )/(2*h);

