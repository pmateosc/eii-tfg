function [max0,max_arbor,max_trelat1,max_trelat2] = dibujar_max_dif(V0,V_arbor,V_trelat1,V_trelat2,n)
media0=sum(V0)./n;
media_arbor=sum(V_arbor)./n;
media_trelat1=sum(V_trelat1)./n;
media_trelat2=sum(V_trelat2)./n;

dif0=V0-ones(n,2).*media0;
dif_arbor=V_arbor-ones(n,2).*media_arbor;
dif_trelat1=V_trelat1-ones(n,2).*media_trelat1;
dif_trelat2=V_trelat2-ones(n,2).*media_trelat2;

mod_dif0=sqrt(sum(dif0.*dif0,2));
mod_dif_arbor=sqrt(sum(dif_arbor.*dif_arbor,2));
mod_dif_trelat1=sqrt(sum(dif_trelat1.*dif_trelat1,2));
mod_dif_trelat2=sqrt(sum(dif_trelat2.*dif_trelat2,2));

max0=max(mod_dif0);
max_arbor=max(mod_dif_arbor);
max_trelat1=max(mod_dif_trelat1);
max_trelat2=max(mod_dif_trelat2);

end

