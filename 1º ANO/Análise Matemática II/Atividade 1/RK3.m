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
function y=RK3(f,a,b,n,y0)
h=(b-a)/n;
t=a:h:b;
y=zeros(1,n+1);
y(1)=y0;   
for i= 1:n
    k1 = h*f(t(i),y(i));         
    k2 = h*f(t(i)+h*0.5,y(i)+h*k1*0.5);
    k3 = h*f(t(i)+h, y(i)-h*k1 +2*k2*h);
    y(i+1) =y(i)+h*(1/6)*(k1 +4*k2+k3);
end


