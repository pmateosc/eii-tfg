n=20;
h=0.1;
Tmax=60;
g=0.25;
N_iterations = 500;
consensus_times = ones(N_iterations,5).*Tmax;
final_diff = zeros(N_iterations,5);
consensus_diff = 0.01;

for n_ex = 1:N_iterations
    t=0;
    disp(n_ex)
    consensus_times(n_ex,1)=n_ex;
    final_diff(n_ex,1)=n_ex;
    XVi=rand(n,4);
    XVi(:,[3:4])=XVi(:,[3:4])*6-2;
    
    F=zeros(n,16);
    
    XV0=zeros(n,4);
    XV_arbor=zeros(n,4);
    XV_trelat1=zeros(n,4);
    XV_trelat2=zeros(n,4);
    
    max0=zeros(101,1);
    max_arbor=zeros(101,1);
    max_trelat1=zeros(101,1);
    max_trelat2=zeros(101,1);

    aux=1;
    
    while t<=Tmax
        if t==0
            F(:,[1:2])=XVi(:,[3:4]);
            F(:,[5:6])=XVi(:,[3:4]);
            F(:,[9:10])=XVi(:,[3:4]);
            F(:,[13:14])=XVi(:,[3:4]);
            
            F(:,[3:4])=cs0(XVi,n,g);
            F(:,[7:8])=cs_arbor(XVi,n,g);
            F(:,[11:12])=cs_trelat1(XVi,n,g);
            F(:,[15:16])=cs_trelat2(XVi,n,g);
            
            XV0=XVi+F(:,[1:4])*h;
            XV_arbor=XVi+F(:,[5:8])*h;
            XV_trelat1=XVi+F(:,[9:12])*h;
            XV_trelat2=XVi+F(:,[13:16])*h;   
           
        else
            F(:,[1:2])=XV0(:,[3:4]);
            F(:,[5:6])=XV_arbor(:,[3:4]);
            F(:,[9:10])=XV_trelat1(:,[3:4]);
            F(:,[13:14])=XV_trelat2(:,[3:4]);
            
            F(:,[3:4])=cs0(XV0,n,g);
            F(:,[7:8])=cs_arbor(XV_arbor,n,g);
            F(:,[11:12])=cs_trelat1(XV_trelat1,n,g);
            F(:,[15:16])=cs_trelat2(XV_trelat2,n,g);
    
            XV0=XV0+F(:,[1:4])*h;
            XV_arbor=XV_arbor+F(:,[5:8])*h;
            XV_trelat1=XV_trelat1+F(:,[9:12])*h;
            XV_trelat2=XV_trelat2+F(:,[13:16])*h;
        end
        
        [max0(aux),max_arbor(aux),max_trelat1(aux),max_trelat2(aux)] = dibujar_max_dif(XV0(:,[3:4]),XV_arbor(:,[3,4]),XV_trelat1(:,[3,4]),XV_trelat2(:,[3,4]),n);
        
        if (max0(aux) <= consensus_diff) && (consensus_times(n_ex,2)==Tmax)
            consensus_times(n_ex,2)=t;
        end
        if max_arbor(aux) <= consensus_diff && (consensus_times(n_ex,3)==Tmax)
            consensus_times(n_ex,3)=t;
        end
        if max_trelat1(aux) <= consensus_diff && (consensus_times(n_ex,4)==Tmax)
            consensus_times(n_ex,4)=t;
        end
        if max_trelat2(aux) <= consensus_diff && (consensus_times(n_ex,5)==Tmax)
            consensus_times(n_ex,5)=t;
        end
        aux=aux+1;
        t=t+h;
    end
    aux = aux-1;
    final_diff(n_ex,2) = max0(aux);
    final_diff(n_ex,3) = max_arbor(aux);
    final_diff(n_ex,4) = max_trelat1(aux);
    final_diff(n_ex,5) = max_trelat2(aux);
    
end
figure(1); hold on;
plot(final_diff(:,2));
plot(final_diff(:,3));
plot(final_diff(:,4));
plot(final_diff(:,5));
title('Diferencia final');
legend('sin control','arbor','trelat1','trelat2');

save("tiempos_consenso.mat")

