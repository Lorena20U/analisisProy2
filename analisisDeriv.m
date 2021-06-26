%Derivacion
function [dx]=analisisDeriv(x,y);
  n=length(x); %largo del vector
  dx(1)=(y(2)-y(1))/(x(2)-x(1)); % el 1 y 2, indices del vector,... diferencia finita hacia adelante
  for i=2:n-1;
    dx(i)=(y(i+1)-y(i-1))/(x(i+1)-x(i-1)); %diferencia finita centrada
  endfor
  dx(n)=(y(n)-y(n-1))/(x(n)-x(n-1)); %diferencia finita hacia atras
endfunction  