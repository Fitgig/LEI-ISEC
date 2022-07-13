% Atividade 1  
% Dinis Meireles de Sousa Falc�o, 2020130403
% David Seco Rodrigues, 2019130152

% NEULER  M�todo de Euler para ED/PVI:
%   y = NEuler(f,a,b,n,y0) -> M�todo num�rico para a resolu��o de um PVI;
%   y'= f(t,y) , t=[a,b];  
%   y(a)=y0 (Condi��o inicial) .  
%
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

function y = NEuler(f,a,b,n,y0)
h=(b-a)/n;
t=zeros(1,n+1); 
y=zeros(1,n+1); 
t(1)=a;
y(1)=y0;
    for i=1:n  
    y(i+1)=y(i)+h*f(t(i),y(i));
    t(i+1)=a+h*i;
    end
  

end


