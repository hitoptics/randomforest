function bessey = bessely_home(nmax,x)

%https://omlc.org/software/mie/maetzlermie/Maetzler2002.pdf

c=sqrt(2/(pi*x));

z1=c*sin(x);
z2=-c*cos(x);
z3(1)=z2.*1/x-z1;
z1=z2;
z2=z3(1);  
for n=2:nmax; 

 nu =(n+0.5)-1;
z3(n)=z2.*2*nu/x-z1;
z1=z2;
z2=z3(n);
end;
bessey=z3;

   

