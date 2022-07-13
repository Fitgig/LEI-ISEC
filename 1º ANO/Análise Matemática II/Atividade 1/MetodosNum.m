% Atividade 1  
% Dinis Meireles de Sousa Falc�o, 2020130403
% David Seco Rodrigues, 2019130152
%
% MetodosNum -> Jun��o de todos os cinco m�todos num�ricos para a resolu��o de PVI
%     y = metodos_num(f,a,b,n,y0) -> M�todo num�rico para a resolu��o de um PVI
%     y' = f(t,y) , t=[a,b]; 
%     y(a)=y0 (Condi��o inicial) . 
%     
% INPUT:
%     f -> funcao do segundo membro da ED;
%     [a,b] -> extremos do intervalo da vari�vel independente t;
%     n -> n�mero de itera��es do m�todo;
%     y0 -> condi��o inicial.
%
% OUTPUT:
%     y -> vetor das aproxima��es discretas da solu��o exata;
%     y(:,1) = Euler(f,a,b,n,y0);   
%     y(:,2) = EulerM(f,a,b,n,y0);
%     y(:,3) = RK2(f,a,b,n,y0);    
%     y(:,4) = RK4(f,a,b,n,y0);
%     y(:,5) = ODE45(f,a,b,n,y0);
%         

function [t,y]= MetodosNum(f, a, b, n, y0)
h = (b-a)/n;
t = a:h:b; % Valores de "a" a "b" com compassos de "h" 
y = zeros(length(t),5); % Vetor de zeros onde se armazenam todos os valores de y


y(:,1) = NEuler(f,a,b,n,y0); %Mostrar Tudo
y(:,2) = EulerM(f,a,b,n,y0);
y(:,3) = RK2(f,a,b,n,y0);
y(:,4) = RK4(f,a,b,n,y0);
y(:,5) = ODE45(f,a,b,n,y0);
y(:,6) = RK3(f,a,b,n,y0);

plot(t,y(:,1),'--r') %Mostrar tudo
hold on
plot(t,y(:,2),'-b')
plot(t,y(:,3),'--c')
plot(t,y(:,4),'-k')
plot(t,y(:,5),'--g')
plot(t,y(:,6),'-m')

end
