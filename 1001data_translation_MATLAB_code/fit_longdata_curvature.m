%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Matlab: 1001 data interpolation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;close all;
labels=zeros(1005,3);
data=zeros(1005,9);

labels= load('model_r_n_z.txt');
data=load('model_kyokuritsu.txt');

size(labels);
[h w]=size(data);

ssv5='kyokuritsu_9000.txt';
FID5=fopen(ssv5,'w');

del=0.01;

for i=1:1:h;  
 y(:)=data(i,:);
 za=labels(i,3);
 for jk=1:1:9;
 z(jk)=(za-5+(jk-1)*0.5);
 end;
 za=z;
 size(z);
 
 zc=round(z(1),3);
 s=zeros(1,1001);
 m=1+floor((zc-152.5)/0.01)
 for k=m:1:m+401;
     zp(k)=zc+(k-m-1)*del;
 end;
 t=zp;
 u=interp1(z,y,t,'spline');
 
for k=m:1:m+401;
    % s(k)=u(k-m+1);
      s(k)=u(k);
 end;

 for n=1:1:1001;
fprintf(FID5,'%16.8e ',s(n));
 end;
 fprintf(FID5,'\n');
end;
 
data=load('kyokuritsu_9000.txt');
writematrix(data,'myData.csv');
