%SISTEMAS DE CONTROL FIS324
%Juan Pablo Crespo Vargas
%Programa para analizar el sonido 

%inicialización
clc
close all
clear all
t=3;                     %tiempo de grabación 
Fs=8000;                 %Frecuencia de muestreo
ch=1;                    %canales de grabación
YW=zeros(t*Fs,1);        %limpia el vector
%grabaación
fprintf(' \n Iniciando grabación, pulse una tecla para continuar \n ')
pause
YW=wavrecord(t*Fs,Fs,ch);
NBits=8;
filexxx='file1.wav';
wavwrite(YW,Fs,NBits,filexxx);
fprintf(' \n Se grafica la grabación, pulse tecla para continuar \n ')
pause
sound(YW,Fs);
figure(1)
X=0:1/Fs:t-1/Fs;
plot(X,YW)
grid
title('Grabación en función del tiempo')
xlabel('Tiempo [segundos] ')
ylabel('Amplitud [voltios]')
fprintf(' \n Iniciando la FFT de la grabación, pulse tecla para continuar \n ')
pause
%transformando la onda para analisis de Fourier
Y=fft(YW);
Y(1)=[]; %al hallar fourier, el primer elemento no corresponde a YW, se borra
n=t*Fs;                    
power=abs(Y(1:floor(n/2))).^2;  
nyquist = 1/2;
freq=(1:n/2)/(n/2)*nyquist;     
fprintf(' \n Grafica de Periodogramas, pulse tecla para continuar \n ')
pause
figure(2)
plot(freq,power)                
ylabel('Potencia');
xlabel('Frecuencia');
title('Periodograma Pow vs. Frec' );
grid

period = 1./freq;
figure(3)
plot(period,power,'r.');
axis([0 500 0 max(power)*2]);
ylabel('Potencia');
xlabel('Periodo');
title('Periodograma Pow vs. Periódo');
grid
hold on;
%Encuentra armónicos

fprintf(' \n Encontrar armónicos, pulse tecla para continuar \n ')
pause
index=find(power==max(power));
PeriodoPrincipal=num2str(period(index));
frecStr=num2str(Fs/period(index));
plot(period(index),power(index),'b.','MarkerSize', 16);
text(period(index)+2,power(index),['Periodo=',PeriodoPrincipal,' [',frecStr,' Hz]']);
hold off;
 
Z=power;
periodos(1)=period(index);
frecuencias(1)=Fs/period(index);
for k=1:4 %halla el numero de armonicos despues del 1ero que queramos
for i=1:length(Z);
    if(Z(i)>=(0.50*max(Z)))%Elimina frecuencias mayores 70% del max
        B(i)=0;
    else
        B(i)=Z(i);
    end
end
index=find(B==max(B));
periodos(k+1)=period(index(1));
frecuencias(k+1)=Fs/period(index(1));
Z=B;
clear index;
clear B;
end

fprintf(' \n Los 5 periodos y frecuencias caracteristicas \n ')
periodos
frecuencias 

fprintf(' \n *************************** \n Presione una tecla para construir el sonograma  \n ')
pause 

clc
close all

%Declara tamaño de trama 
figure(1)
spectrogram(YW,256,80,256,Fs,'yaxis')
title('Periodograma 2D en color')
xlabel('Tiempo')
ylabel('Frecuencia(hz)')
view(-77,72)
shading interp
colorbar 

figure(2)
spectrogram(YW,256,80,256,Fs,'yaxis')
title('Periodograma 2D en escala de grises')
view(-77,72)
xlabel('Tiempo')
ylabel('Frecuencia(hz)')
shading interp
colormap bone

figure(3)
spectrogram(YW,256,80,256,Fs,'yaxis')
title('Periodograma 3D, de la trama entera')
view(-77,72)
xlabel('Tiempo')
ylabel('Frecuencia(hz)')
shading interp
colorbar 

%Parte de la aplicación
% Calculo de todo el indice musical
octavas=[0:1:10];
notas=[1:1:12]; 
for p=1:10
    for k=1:12
       NOTAS(p,k)=440*exp( ((octavas(p)-4)+((notas(k))/(12)) )*(log(2)));
    end
end


%verificamos la frecuencia grabada corresponde a una nota con el error del
%15%

for p=1:10
    for k=1:12
        if (frecuencias(1)>=(floor(0.95*NOTAS(p,k))))
            if (frecuencias(1)<=floor((1.05*NOTAS(p,k))))
                indice=[p ; k]
                break;
            end
        end
    end
end
fprintf(' \n Se identifica a la nota del primer armónico, pulse una tecla para continuar \n')
pause
notas=[{'do'},{'do#'},{'Re'},{'Re#'},{'Mi'},{'Fa'},{'Fa#'},{'Sol'},{'Sol#'},{'La'},{'La#'},{'Si'}];
puntero1=indice(1,1);
puntero2=indice(2,1);
fprintf(' \n Octava: ')
octavas(puntero1)
fprintf(' \n Nota')
notas(puntero1)


