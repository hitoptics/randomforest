%----***** Mie scattering  ************--
%
%
%------------------------------------------
function mk=fun_Ey_exact_spherical(rj,n_p,z,ii);
global HFE HFZE sav
tic
lamda=0.532*1e-3;
nme=1.3337;
m=n_p/nme;
k=2*pi/lamda*nme;
k0=2*pi/lamda;
h=lamda;
lamdak=lamda/nme;

delx=0.0022;
del=delx;

E0=1;
njx0=2592/2;    
njy0=1944/2;   


njx=floor(njx0/2);
njy=floor(njy0/2);


aq=10;



r0=rj;


parfor iy=1:1:njy;
       
   
CXa=zeros(1,njx);
    for ix=1:1:njx;
    xcc=(ix-1)*delx;ycc=(iy-1)*delx;
   [XX,YY]=meshgrid(xcc,ycc);;
      
   rc=sqrt(XX.^2+YY.^2+z.^2);
   th=acos(z./rc);

   if XX==0 ph=0;
       else ph=atan(YY./XX);end;
   x=rc.*k;
   u=cos(th);
  
    
  
  [aaa aab aac]= Mie_outer_contour_Esquare_spherical(rc,m,th,ph,r0,k);   
  
   XXc=sin(th).*cos(ph).*conj(aaa)+cos(th).*cos(ph).*conj(aab)-sin(ph).*conj(aac);
   CXa(ix)=XXc;
end;

Xa(iy,:)=CXa;
end;

pha=angle(Xa);

fprintf('pass\n');

X=zeros(njy0,njx0);
a=fliplr(Xa);
b=a(:,1:njx-1);
c=horzcat(b,Xa);
d=flipud(c);
e=d(1:njy-1,:);
X=vertcat(e,c);
mwa=X;

[M N]=size(X);


X=double(X);

[M N]=size(X);

K=2*max(M,N);

% Zeros-padding to get KxK image
Z1=zeros(K,floor((K-N)/2));
Z2=zeros(floor((K-M)/2),N);
Z3=zeros(K-M-floor((K-M)/2),N);
Z4=zeros(K,K-N-floor((K-N)/2));

Xp=[Z1,[Z2;X;Z3],Z4];
fprintf('M %d N %d',M,N);

[hq,wq]=size(Xp);

U1=double(Xp);
L0=del*K;
fprintf('L0=%f\n',L0);
zmin=L0^2/K/h;

HF=fftshift(fft2(U1));

HFE=HF;

save('HFE');


r0=0.00001;


parfor iy=1:1:njy;
 
CXa=zeros(1,njx);
    for ix=1:1:njx;
    xcc=(ix-1)*delx;ycc=(iy-1)*delx;
   [XX,YY]=meshgrid(xcc,ycc);;
      
   rc=sqrt(XX.^2+YY.^2+z.^2);
   th=acos(z./rc);

   if XX==0 ph=0;
       else ph=atan(YY./XX);end;
   x=rc.*k;
   u=cos(th);
  
   [aaa aab aac]= Mie_outer_contour_Esquare_spherical(rc,m,th,ph,r0,k);   
   
   XXc=sin(th).*cos(ph).*conj(aaa)+cos(th).*cos(ph).*conj(aab)-sin(ph).*conj(aac);
   CXa(ix)=XXc;
end;

Xa(iy,:)=CXa;
end;



pha=angle(Xa);

fprintf('pass\n');
X=zeros(njy0,njx0);
a=fliplr(Xa);
b=a(:,1:njx-1);
c=horzcat(b,Xa);
d=flipud(c);
e=d(1:njy-1,:);
X=vertcat(e,c);
mwa=X;
[M N]=size(X);

X=zeros(njy0,njx0);
a=fliplr(Xa);
b=a(:,1:njx-1);
c=horzcat(b,Xa);
d=flipud(c);
e=d(1:njy-1,:);
X=vertcat(e,c);
mwa=X;

[M N]=size(X);



X=double(X);

[M N]=size(X);

K=2*max(M,N);

% Zeros-padding to get KxK image
Z1=zeros(K,floor((K-N)/2));
Z2=zeros(floor((K-M)/2),N);
Z3=zeros(K-M-floor((K-M)/2),N);
Z4=zeros(K,K-N-floor((K-N)/2));

Xp=[Z1,[Z2;X;Z3],Z4];
fprintf('M %d N %d',M,N);

[hq,wq]=size(Xp);

U0=double(Xp);
L0=del*K;
fprintf('L0=%f\n',L0);
zmin=L0^2/K/h;

HFZ=fftshift(fft2(U0));

HFZE=HFZ;

save('HFZE');


mk=r0;
toc