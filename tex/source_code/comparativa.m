n=20;
h=0.1;
Tmax=10; 
t=0;
g=0.25;

XVi=rand(n,4);
XVi(:,[3:4])=XVi(:,[3:4])*6-2;

F=zeros(n,12);

XV_arbor=zeros(n,4);
XV_trelat1=zeros(n,4);
XV_trelat2=zeros(n,4);

max_arbor=zeros(101,1);
max_trelat1=zeros(101,1);
max_trelat2=zeros(101,1);

figure(1);
tamano_pantalla=get(0,'ScreenSize');
set(gcf, 'Position', [0 0 tamano_pantalla(3) tamano_pantalla(4)]);
subplot(2,2,1); 
quiver(XVi(:,1),XVi(:,2),XVi(:,3),XVi(:,4)); 
title('Posicion Inicial');
aux=1;

while t<=Tmax
    if t==0
        F(:,[1:2])=XVi(:,[3:4]);
        F(:,[5:6])=XVi(:,[3:4]);
        F(:,[9:10])=XVi(:,[3:4]);

        F(:,[3:4])=cs_arbor(XVi,n,g);
        F(:,[7:8])=cs_trelat1(XVi,n,g);
        F(:,[11:12])=cs_trelat2(XVi,n,g);

        XV_arbor=XVi+F(:,[1:4])*h;
        XV_trelat1=XVi+F(:,[5:8])*h;
        XV_trelat2=XVi+F(:,[9:12])*h;   
       
    else
        F(:,[1:2])=XV_arbor(:,[1:2]);
        F(:,[5:6])=XV_trelat1(:,[1:2]);
        F(:,[9:10])=XV_trelat2(:,[1:2]);
        F(:,[3:4])=cs_arbor(XV_arbor,n,g);
        F(:,[7:8])=cs_trelat1(XV_trelat1,n,g);
        F(:,[11:12])=cs_trelat2(XV_trelat2,n,g);

        XV_arbor=XV_arbor+F(:,[1:4])*h;
        XV_trelat1=XV_trelat1+F(:,[5:8])*h;
        XV_trelat2=XV_trelat2+F(:,[9:12])*h;
    end
    
    [max_arbor(aux),max_trelat1(aux),max_trelat2(aux)] = dibujar_max_dif(XV_arbor(:,[3,4]),XV_trelat1(:,[3,4]),XV_trelat2(:,[3,4]),n,t);
    aux=aux+1;
   
    subplot(2,2,2); title('Control Arbor');
    quiver(XV_arbor(:,1),XV_arbor(:,2),XV_arbor(:,3),XV_arbor(:,4));
    title('Control Arbor');
    subplot(2,2,3); 
    quiver(XV_trelat1(:,1),XV_trelat1(:,2),XV_trelat1(:,3),XV_trelat1(:,4));
    title('Control Trelat 1');
    subplot(2,2,4); 
    quiver(XV_trelat2(:,1),XV_trelat2(:,2),XV_trelat2(:,3),XV_trelat2(:,4));
    title('Control Trelat 2');

       
    t=t+h
    pause(0.1)

end
figure(2); hold on;
plot(max_arbor);
plot(max_trelat1);
plot(max_trelat2);
legend('max arbor','max trelat1','max trelat2');