%----***** Mie scattering  ************--
%
%
%------------------------------------------


function coe=fun_small_zer_mic_for_r(x);

global HFE HFZE FID  II CHEB9 DZ COE F3 ZAC sav SP ICOU zurashi 

rj=x(1);
n_p=x(2);
z=x(3);

zc=z-1;

hc=9;

 for jk=1:1:9;
 zpa(jk)=(z-5+(jk-1)*0.5);
 end;

lamda=0.532*1e-3;
delta=0.0022;
nme=1.3337;
m=n_p/nme;
k=2*pi/lamda*nme;
k0=2*pi/lamda;
h=lamda;
lamdak=lamda/nme;

delx=delta;
del=delx;

mk=fun_Ey_exact_spherical(rj,n_p,z);

HF=HFE;
HFZ=HFZE;


[hq wq]=size(HF)
K=hq;

%%%%%%%%%%%%以下を追加%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
L0=del*(wq-1);
dx=del;

k0=2*pi/h*nme;
h=lamda./nme;%%12/6追加
k=2*pi/h;%%同上
% ii=1:1:67;
fex=K/L0;fey=fex;% sampling of frequency plane
fx=[-fex/2:fex/K:fex/2-fex/K];
fy=[-fey/2:fey/K:fey/2-fey/K];

[FX,FY]=meshgrid(fx,fy);
E=exp(-i*k*zurashi*sqrt(1-(h*FX).^2-(h*FY).^2)); % Angular spectrum transfer function
HF=HF.*E;
HFZ=HFZ.*E;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

k=2*pi/lamda*nme;

k0=k;


%%%%%%%figure(1992),imagesc((abs(HF)));
L0x=delta*wq;L0y=delta*hq;

fex=wq/L0x;fey=hq/L0y;%

for ij=1:1:hc;

da=zpa(ij)+zurashi;

h=lamda./nme;
fx=[-fex/2:fex/wq:fex/2-fex/wq];
fy=[-fey/2:fey/hq:fey/2-fey/hq];


[FX,FY]=meshgrid(fx,fy);

E=exp(i*k*da*sqrt(1-(h*FX).^2-(h*FY).^2)); % Angular spectrum transfer function

    [Hrr]=ifft2(HF.*E);
    [Hrr0]=ifft2(HFZ.*E);


   phw=-(angle(Hrr)-angle(Hrr0));

    ta=100;

 [haa waa]=size(Hrr)

 hmax=max(max(abs(Hrr)));
 
 
phw=phw(floor(haa/2)-ta:1:floor(haa/2)+ta,floor(waa/2)-ta:1:floor(waa/2)+ta);    
Hrr=Hrr(floor(haa/2)-ta:1:floor(haa/2)+ta,floor(waa/2)-ta:1:floor(waa/2)+ta);  
HR=Hrr/hmax;

WrappedPhase=phw;
mex Miguel_2D_unwrapper.cpp

WrappedPhase = single(WrappedPhase);
UnwrappedPhase = Miguel_2D_unwrapper(WrappedPhase);
phwa=double(UnwrappedPhase);

phwa=(abs(HR)<=0.05).*0+(abs(HR)>0.05).*phwa;

        
phwas = medfilt2(phwa);

 [haa waa]=size(phwas);
 
medphase=phwas;
 [haa waa]=size(medphase);

qle=floor(-da*1000);


if ij==hc+1 ta=6;
   else ta=20;end;

phwas=medphase;
phwaa=phwas(floor(haa/2)-ta:1:floor(haa/2)+ta,floor(waa/2)-ta:1:floor(waa/2)+ta);
n=floor(haa/2)-ta:1:floor(haa/2)+ta;m=floor(waa/2)-ta:1:floor(waa/2)+ta;
ln=length(n);
lm=length(m);

x=(-ta+(n-1))*del;
y=(-ta+(m-1))*del;

[xx,yy]=meshgrid(x,y);

xmax=floor(ta)*delx;
Mb=1/xmax;
 n=1:1:ln;
 m=1:1:lm;
[xs ys]=meshgrid((-ta+(n-1))*del.*Mb,(-ta+(m-1))*del.*Mb);
UV=zeros(1,2*ta+1);
rca=sqrt(xs.^2+ys.^2);

 V=phwaa(m,n);  

 [haa waa]=size(V);

eyedata=zeros(haa,waa);

kn=2*pi/(lamdak*Mb);
za=-da.*Mb;
za=-(z-zc)*Mb
z_phase(n,m)=kn.*sqrt(xs.^2+ys.^2+za.^2);
sq=phwaa(n,m)./Mb;

wfa(n,m)=phwaa(n,m)/Mb;

asr=floor(ij);
hold on;


phwc=V/Mb;

for kk=2:1:2;
 
 if kk==2 xn=xs(ta+1,:);phc=phwc(ta+1,:);end;
 

[hph wph]=size(phwc);

fa=fun_cheb(phc,wph,del);

nxa=1:0.01:wph;


Xq=(nxa-1-floor((wph-1)/2))*del*1000;
X=Xq/((wph-1)/2*del*1000);

T1=X;
T2=2*X.^2-1;
T3=4*X.^3-3*X;
T4=8*X.^4 -8*X.^2+1;
coeph=fa(1)+fa(2).*T1+fa(3).*T2+fa(4).*T3+fa(5).*T4;


if kk==2 asr=floor(ij);end; 

fprintf('z %8.4f f(1) %8.4f f(2) %8.4f f(3) %8.4f f(4) %8.4f f(5) %8.4f\n',da,fa(1),fa(2),fa(3),fa(4),fa(5));

end;

coe(ij)=fa(3);

fprintf('r= %f n_p=%f z= %f  coe= %e\n',rj,n_p,da,coe(ij));
end;









 

 
