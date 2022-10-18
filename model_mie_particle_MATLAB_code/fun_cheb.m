function fa=fun_cheb(swq,qw,del);

sa11=0;
sa12=0;
sa13=0;
sa14=0;
sa15=0;

sa21=0;
sa22=0;
sa23=0;
sa24=0;
sa25=0;

sa31=0;
sa32=0;
sa33=0;
sa34=0;
sa35=0;

sa41=0;
sa42=0;
sa43=0;
sa44=0;
sa45=0;

sa51=0;
sa52=0;
sa53=0;
sa54=0;
sa55=0;

ce=0;cf=0;cg=0;ch=0;ci=0;

for nx=1:1:qw;
Xq=(nx-1-floor((qw-1)/2))*del*1000;
X=Xq/((qw-1)/2*del*1000);
T1=X;
T2=2*X.^2-1;
T3=4*X.^3-3*X;
T4=8*X.^4 -8*X.^2+1;

sa11=qw;
sa12=sa12+T1;
sa13=sa13+T2;
sa14=sa14+T3;
sa15=sa15+T4;

sa21=sa21+T1;
sa22=sa22+T1.^2;
sa23=sa23+T1.*T2;
sa24=sa24+T1.*T3;
sa25=sa25+T1.*T4;

sa31=sa31+T2;
sa32=sa32+T1.*T2;
sa33=sa33+T2.^2;
sa34=sa34+T3.*T2;
sa35=sa35+T2.*T4;

sa41=sa41+T3;
sa42=sa42+T1.*T3;
sa43=sa43+T2.*T3;
sa44=sa44+T3.^2;
sa45=sa45+T3.*T4;

sa51=sa51+T4;
sa52=sa52+T1.*T4;
sa53=sa53+T2.*T4;
sa54=sa54+T3.*T4;
sa55=sa55+T4.^2;

ce=ce+swq(nx);
cf=cf+swq(nx).*T1;
cg=cg+swq(nx).*T2;
ch=ch+swq(nx).*T3;
ci=ci+swq(nx).*T4;

end;

A=[sa11 sa12 sa13 sa14 sa15;sa21 sa22 sa23 sa24 sa25;sa31 sa32 sa33 sa34 sa35;sa41 sa42 sa43 sa44 sa45;sa51 sa52 sa53 sa54 sa55];
b=[ce;cf;cg;ch;ci];
fa=pinv(A)*b;