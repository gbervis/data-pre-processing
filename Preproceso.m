%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% Cargando los datos %%%%%%%%%%%%%%%%%%%%%%%%%%%%
load('arcene.mat')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% Visualizando los datos %%%%%%%%%%%%%%%%%%%%%%%%%
t = 1:size(datos,2);
figure, hold on
for i=1:size(datos,1)
    if(salida1(i) == 1)
        plot(t,datos(i,:),'r','LineWidth',1);
    else
        plot(t,datos(i,:),'b','LineWidth',1);
    end
end    

%Separando los datos en positivos y negativos %%%%%%%%%%%%%%%%%%

%Datos positivos
datosP = datos.*salida1;
%Se eliminan los muestras con 0 (negativas)
ind1 = find(sum(datosP,2)==0) ;
datosP(ind1,:) = [];

%Datos negativos
datosN = datos.*(1-salida1);
%Se eliminan los muestras con 0 (positivas)
ind2 = find(sum(datosN,2)==0) ;
datosN(ind2,:) = [];

%Observando los 20 valores (de 60 a 80)
%De la 5ta a al 8va muestra
t = 60:80;
n = 5:8;
plot(t,datosN(n,t),'color','blue')
hold on
plot(t,datosP(n,t),'color','red')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Detectando valores no numéricos %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sum(sum(isnan(datos)'))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%Estadísticos generales con todos los datos%%%%%%%%%%%%%%

nsignals = 1:100;
avg = mean(datos,2);
mina = min(avg);
maxa = max(avg);
meana = mean(avg);
stda = std(avg);
%Graficar estadísticos usando la media
plot(nsignals,avg)
hold on
plot(nsignals,meana*ones(length(nsignals))+stda,'color',[0.9100    0.4100    0.1700])
plot(nsignals,meana*ones(length(nsignals))-stda,'color',[0.9100    0.4100    0.1700])
plot(nsignals,meana*ones(length(nsignals)),'r--')
xlabel('No. de muestra')
ylabel('Promedio de cada muestra')
ylim([45,105])
for i=1:100
    if salida1(i)==1,
        plot(i,avg(i),'r.','MarkerSize',20)
    else
        plot(i,avg(i),'b.','MarkerSize',20)
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Detectando valores outliers %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sum(sum(isoutlier(datos,'mean','ThresholdFactor',10)))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Reducción de dimensión %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Determinando el número de dimensiones
intrinsic_dim(datos, 'EigValue')

%Graficando los nuevos valores (guardados en Ndatos)
Ndatos = compute_mapping(datos,'PCA',10);
t = 1:8;
figure, hold on
for i = 1:size(Ndatos,1)
    if(salida1(i) == 1)
        plot(t,Ndatos(i,:),'r','LineWidth',3);
    elseif(salida1(i) == 0)
        plot(t,Ndatos(i,:),'b','LineWidth',3);
    end
end
xlim([0.5,10.5])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Transformación de los datos %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Z = normalize(Ndatos);
%Gráfica de los datos normalizados
figure, hold on
for i = 1:size(Z,1)
    if(salida1(i) == 1)
        plot(t,Z(i,:),'r','LineWidth',3);
    elseif(salida1(i) == 0)
        plot(t,Z(i,:),'b','LineWidth',3);
    end
end


