%Polinomio interpolante

function [pol]=analisisPol(xx,yy);
  n=length(xx)/2; %largo del vector, pero solo la mitad dado que solo se necesitan los datos del primer semestre
  X=[];
  y=[];
  for a=1:n; %asignando informacion en los vectores hasta el mes que se decidio analizar.
    X(end+(1:numel(xx(a))))=xx(a);
    y(end+(1:numel(yy(a))))=yy(a);
  endfor
  
  n=length(X)-1;
  mat=zeros(n+1);
  mat(:,1)=y;
  for w=2:n+1 %encontrando valores de las diferencias divididas
    for j=w:n+1;
      mat(j,w)=[mat(j,w-1)-mat(j-1,w-1)]/[X(j)-X(j-w+1)];
    endfor
  endfor
  %para fines de visualizacion de la matriz de las diferencias divididas
  %display('La matriz es:');
  %display(mat);
  
  pkg load symbolic; %se carga symbolic
  syms x;
  pol=mat(1,1);
  p=1;
  for i=1:n; %Generando el polinomio con los valores encontrados en la matriz de las diferencias divididas
    p=p*(x-X(i));
    pol=pol+p*mat(i+1,i+1);
  endfor
  
  %GENERANDO GRAFICA CON LA INFORMACION SOLICITADA
  hold on; %Para mantener todas las configuraciones en una misma grafica
  ezplot(pol,[X(1) X(n+1)]); %generando grafica del polinomio interpolante
  plot(X,y,'r*'); %generando puntos de observacion
  grid on; %gradilla
  title('Polinomio interpolante mas los puntos observados del primer semestre de la temperatura anual:');
  xlabel('Tiempo (meses)');
  ylabel('Temperatura (C?)');
endfunction  