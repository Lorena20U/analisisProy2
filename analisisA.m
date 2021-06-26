%Proyecto #2 ---Lorena Perez
%cargando informacion
  
function p2=analisisA();
  %cargando informacion
  data=fopen('Data.txt'); %la informacion del excel se guardo en documento txt para poder leer los datos
  t=fscanf(data,'%f',[2,12]); %se guarda informacion
  fclose(data);
  t=t';
  
  
  temp=[]; %vector que almacena la temperatura (C�)
  y=[]; %vector que almacena la precipitacion pluvial (mm)
  x=[]; %vector que almacena tiempo (meses)
  n=length(t);
  for k=1:n; %almacenando los datos de t, dentro de los vectores 'x', 'temp' e 'y' para mayor facilidad...
    x(end+(1:numel(k)))=k; 
  endfor
  n=n*2;
  for i=1:n;
    if i<=(n/2);
      temp(end+(1:numel(t(i))))=t(i);
    else
      y(end+(1:numel(t(i))))=t(i);
    endif
  endfor
  
  
  
  %----------------------------------------------------------------
  %ANALIZANDO INFORMACION
  %REDIRECCIONANDO A LOS SCRIPTS POR SEPARADO PARA ANALIZAR CON MAYOR FACILIDAD POSIBLES ERRORES EN EL CODIGO.
  
  %Razon de cambio de la precipitacion pluvial respecto al tiempo...
  %La razon de cambio se encuentra por medio de la primera derivada
  %Solucion PUNTO A-B: Derivando con diferencias finitas
  n=length(x); %largo del vector
  dxP=analisisDeriv(x,y); %dxP almacena la derivada de los vectores 'x' e 'y'.
  
  %Solucion PUNTO C: Precipitacion pluvial a lo largo del anio
  %Integrando por medio de la Regla de Simpson 1/3 compuesto
  a=1;  b=12; %limites que se evaluaran en la integral
  panual=analisisInt(a,b,y); %integral
  
  %Solucion PUNTO D-E: Razon de cambio de la temperatura respecto al tiempo.
  dxT=analisisDeriv(x,temp);
  
  %Soluncion PUNTO F: Temperatura promedio anual
  at=1;  bt=12; %limites de la integral
  tprom=analisisInt(at,bt,temp); %se encuentra el valor de la integral
  tprom=tprom/(bt-at); %el promedio es la integral de la funcion a evaluar por 1/(a-b)
  
  %Solucion PUNTO G: Polinomio interpolante
  pol=analisisPol(x,temp); %busqueda del polinomio interpolante
  
  
  
  
  %----------------------------------------------------------------
  %GENERANDO RESPUESTAS
  %Punto A
  printf('\n\nPunto A: Generando tabla sobre las razones de cambio de la prec. pluvial respecto al tiempo.\n');
  printf('Tiempo (meses)\tPrec. pluvial (mm)\tRazon de cambio\n');
  mayP=dxP(1);
  for l=1:n;
    printf('%4.0f\t\t %4.5f\t\t %4.5f\n',x(l),y(l),dxP(l));
    if dxP(l)>mayP;
      mayP=dxP(l);
      indP=l;
    endif
  endfor
  
  %Punto B
  printf('\nPunto B: Mes que mayor razon de cambio presenta por el cual deberia lanzarse la campania.\n');
  printf('Mes #%i: %4.5f\n',indP,mayP);
  
  %Punto C
  printf('\nPunto C: Precipitacion pluvial a lo largo del anio en Guatemala.\n');
  printf('Precipitacion anual: %4.5f\n',panual);
  
  %Punto D
  printf('\nPunto D: Generando tabla sobre las razones de cambio de la temperatura respecto al tiempo.\n');
  printf('Tiempo (meses)\tTemperatura (C�)\tRazon de cambio\n');
  mayT=dxT(1);
  for l=1:n;
    printf('%4.0f\t\t %4.5f\t\t %4.5f\n',x(l),temp(l),dxT(l));
    if dxT(l)>mayT;
      mayT=dxT(l);
      indT=l;
    endif
  endfor
  
  %Punto E
  printf('\nPunto E: Mes que mayor razon de cambio presenta por el cual deberia comenzar los preparativos.\n');
  printf('Mes #%i: %4.5f\n',indT,mayT);
  
  %Punto F
  printf('\nPunto F: Temperatura promedio anual para Guatemala\n');
  printf('Temperatura promedio: %4.5f\n',tprom);
  
  %Punto G
  printf('\nPunto G: Polinomio interpolante.\n');
  printf('Eleccion: Primer semestre de la temperatura anual: \n');
  display(pol);
  
  %Punto H
  printf('\nPunto H: Grafica con los puntos observados del 1er. semestre incluyendo el polinomio interpolante en la grafica.\nVer grafica.\n\n');
  
endfunction