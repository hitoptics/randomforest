

function [fe1 fe2 fe3] = Mie_outer_contour_Esquare_spherical(rc,m,th,ph,r0,k)

% https://omlc.org/software/mie/maetzlermie/Maetzler2002.pdf
% Computation of nj+1 equally spaced values within (0,x) % of the mean-absolute-square internal
% electric field of a sphere of size parameter x,
% complex refractive index m=m'+im",
% where the averaging is done over teta and phi,
% with unit-amplitude incident field;
% Ref. Bohren and Huffman (1983) BEWI:TDD122,
% and my own notes on this topic;
% k0=2*pi./wavelength;
% x=k0.*radius;
% C. Matzler, May 2002
%https://omlc.org/software/mie/maetzlermie/Maetzler2002.pdf

nj=1;
xx=k*r0;
nmax=round(2+xx+4*xx^(1/3));
if xx<=0.5 nmax=1;end;
n=(1:nmax); 
nu =(n+0.5);
m1=real(m); m2=imag(m);

abcd=mie_abcd_recurr(m,xx);

an=abcd(1,:);bn=abcd(2,:);
size(an);
size(bn);
an2=abs(an).^2;
bn2=abs(bn).^2;

e0=1;

    x=rc.*k;  
   
    u=cos(th);
    pt=Mie_pt(u,nmax);

    p=pt(1,:);
    t=pt(2,:);
    

    en1=0;
    en2=cos(ph).*t(n).*(-1i).^(n+1).*1i.*exp(1i*x)./x;
    en3=-sin(ph).*p(n).*(-1i).^(n+1).*1i.*exp(1i*x)./x;


    
    em1=0;
    em2=cos(ph).*p(n).*(-1i).^(n+1).*exp(1i*x)./x;
    em3=-sin(ph).*t(n).*(-1i).^(n+1).*exp(1i*x)./x;
    
    a=e0.*(1i).^n.*(2.*n+1)./(n.*(n+1));
    e1=a.*(1i*an.*en1-bn.*em1);
    e2=a.*(1i*an.*en2-bn.*em2);
    e3=a.*(1i*an.*en3-bn.*em3);
   
    fe1=sum(e1(:));
    fe2=sum(e2(:));
    fe3=sum(e3(:));

    een=[fe1;fe2;fe3];
    
    size(een);
    