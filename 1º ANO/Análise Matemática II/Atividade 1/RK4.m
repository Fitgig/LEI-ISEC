% Atividade 1  
% Dinis Meireles de Sousa Falc�o, 2020130403
% David Seco Rodrigues, 2019130152
%
% RK4 -> M�todo de Runge-Kutta de ordem 4
%   y = RK4(f,a,b,n,y0) -> M�todo num�rico para a resolu��o de um PVI;
%   y'= f(t,y) , t=[a, b];
%   y(a)=y0 (Condi��o inicial) .
% INPUT:
%   f -> fun��o do segundo membro de uma ED;
%   [a,b] -> extremos do intervalo de uma vari�vel independente t;
%   n -> n�mero de itera��es do m�todo;
%   t = a -> y = y0(condi��o inicial).
%
% OUTPUT: 
%   y -> vetor das aproxima��es discretas da solu��o exacta;
%   y(i+1) = y(i)+h*f(t(i),y(i)) , i =0,1,...,n-1 . 
%
function y = RK4(f, a, b, n, y0)
h = (b-a)/n;
t(1) = a;
y(1) = y0;
for i=1:n % Ciclo "for" que percorre todos os valores de i - de 1 at� n - com compassos de 1 a 1.
    t(i+1) = t(i) + h;
    K1 = h * f(t(i),y(i));
    K2 = h * f(t(i) + (h/2),y(i) + (1/2) * K1);
    K3 = h * f(t(i) + (h/2),y(i) + (1/2) * K2);
    K4 = h * f(t(i) + h,y(i) + K3);
    y(i+1) = y(i) + ((1/6) * (K1 + (2*K2) + (2*K3) + K4));
end 


