% Atividade 01  
% Dinis Meireles de Sousa Falc�o, 2020130403
% David Seco Rodrigues, 2019130152
%
% ODE45 M�todo de ODE45 para PVI:
%     y = mn_ode(f, a, b, n, y0)->M�todo num�rico para a resolu��o de um
%   PVI;
%     y' = f(t,y) , t=[a,b];
%     y(a)=y0 (Condi��o inicial).
%   
% INPUT:
%     f -> fun��o do segundo membro da ED;
%     [a,b] -> extremos do intervalo da vari�vel independente t;
%     n -> n�mero de itera��es do m�todo;
%     y0 -> condi��o inicial.
%
% OUTPUT:
%     y -> vetor das aproxima��es discretas da solu��o exata;
%     [t,y] = ode45(f,t,y0).
%

function y = ODE45(f,a,b,n,y0)
h = (b-a)/n;
t = a:h:b; 
y=zeros(1,n+1); 
[t,y] = ode45(f,t,y0);
end
