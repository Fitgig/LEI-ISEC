%Atividade 3
%Dinis Meireles de Sousa Falc�o - 2020130403
%David Seco Rodrigues - 2019130152
%
%DI_RTrapezios Calculo Integra��o Num�rica atrav�s da Regra dos Trap�zios
%   t = DI_RTrapezios(f,a,b,n)
%   t = h*(f(a)+f(b)+t)/2;
%
%INPUT:
%   f - fun��o real de vari�vel real x
%   [a, b] - extremos do intervalo da vari�vel independente x
%   n - n�mero de subintervalos ou itera��es da regra
%OUTPUT: 
%   t - Resultado da �rea do Integral
%   t = h*(f(a)+f(b)+t)/2 , i=2,...,n-1
%

function t = DI_RTrapezios(f,a,b,n)

h = (b-a)/n;
t = 0;
x=a;

for i=1:n-1
	x=x+h;
	t = t+2*f(x);
end

t = h*(f(a)+f(b)+t)/2;
