% Atividade 1  
% Dinis Meireles de Sousa Falc�o, 2020130403
% David Seco Rodrigues, 2019130152
%
% MENUMNPVI  Menu de M�todos Num�ricos para um PVI
%   y = MenuMNPVI(f,a,b,n,y0)
%   y'= f(t,y) com t=[a, b] e y(a)=y0 condi��o inicial  
%
% INPUT:
%   f - fun��o do 2.� membro da Equa��o Diferencial
%   [a, b] - extremos do intervalo da vari�vel independente t
%   n - n�mero de subintervalos ou itera��es do m�todo
%   y0 - condi��o inicial t=a -> y=y0
% OUTPUT: 
%   y - vector das solu��es aproxima��es
% 

function y=MenuMNPVI(f,a,b,n,y0)
y=[];
menuMNPVI = 1;
while menuMNPVI~=9
    clc
    disp('--------------------------------------------------')
    disp('           M�todos Num�ricos para PVI             ')
    disp('--------------------------------------------------')
    menuMNPVI=menu('M�todos Num�ricos para PVI', ...
                   'M�todo de Euler',...
                   'M�todo de Euler Melhorado',...
                   'M�todo RK2',...
                   'M�todo RK4',...
                   'M�todo RK3',...
                   'M�todo ODE45',...
                   'Todos',...
                   'Sa�r');
    switch menuMNPVI
        case 1
              y=NEuler(f,a,b,n,y0);
        case 2  
              y=EulerM(f,a,b,n,y0);                
        case 3
              y=RK2(f,a,b,n,y0);
        case 4
              y=RK4(f,a,b,n,y0);
        case 5
              y=RK3(f,a,b,n,y0);
        case 6
              y=ODE45(f,a,b,n,y0);  
        case 7
             y = MetodosNum(f,a,b,n,y0);
             hold off
            legend('Euler','EulerM','RK2','RK4','ODE45','RK3','Exata'); %Legenda
            grid on;
            shg; 
    end
    disp('-----------Solu��o aproximada do PVI---------')
    disp(y)
    input('Prima numa tecla para continuar �')
end
            