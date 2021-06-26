%Integracion por medio Simpson un tercio

function [int]=analisisInt(a,b,y);
  n=length(y); %largo del vector
  h=(b-a)/n;
  suma=y(a)+y(b);
  for z=1:n-1;
    if mod(z,2)==0;
      suma=suma+2*(y(z));
    else
      suma=suma+4*(y(z));
    endif
  endfor
  int=(suma*h)/3; %Respuesta de la integral
  
endfunction  