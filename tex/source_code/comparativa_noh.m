n=20;
h=0.1;
g=0.70;
N_iterations = 100;
consensus_times = nan(N_iterations,5);
final_diff = ones(N_iterations,5);
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
    
    max0=nan;
    max_arbor=nan;
    max_trelat1=nan;
    max_trelat2=nan;

    aux=1;
    
    while any(final_diff(n_ex,2:5)>consensus_diff)
        if aux==1
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
        
        [max0,max_arbor,max_trelat1,max_trelat2] = dibujar_max_dif(XV0(:,[3:4]),XV_arbor(:,[3,4]),XV_trelat1(:,[3,4]),XV_trelat2(:,[3,4]),n);
        
        if (max0 <= consensus_diff) && isnan(consensus_times(n_ex,2))
            consensus_times(n_ex,2)=t;
        end
        if max_arbor <= consensus_diff && isnan(consensus_times(n_ex,3))
            consensus_times(n_ex,3)=t;
        end
        if max_trelat1 <= consensus_diff && isnan(consensus_times(n_ex,4))
            consensus_times(n_ex,4)=t;
        end
        if max_trelat2 <= consensus_diff && isnan(consensus_times(n_ex,5))
            consensus_times(n_ex,5)=t;
        end
        
        final_diff(n_ex,2) = max0;
        final_diff(n_ex,3) = max_arbor;
        final_diff(n_ex,4) = max_trelat1;
        final_diff(n_ex,5) = max_trelat2;
        t=t+h;
        aux=aux+1;
    end
    
end

xaxis_str = {'CS'; 'CCR'; 'Trelat 1'; 'Trelat 2'};
xaxis = [1:4];
tiempos_medios = mean(consensus_times(:,2:5));
tiempos_max = max(consensus_times(:,2:5));
tiempos_min = min(consensus_times(:,2:5));

% fig = figure(1);hold on;
% bar(xaxis,tiempos_medios);
% er = errorbar(xaxis,tiempos_medios, tiempos_min, tiempos_max);
% er.Color = [0 0 0];
% er.LineStyle = 'none';
% xticklabels(xaxis_str);
% title('Diferencia final');
% %legend('sin control','arbor','trelat1','trelat2');
% fig.WindowState = 'maximized';
% hold off

save("tiempos_consenso_b07.mat")

