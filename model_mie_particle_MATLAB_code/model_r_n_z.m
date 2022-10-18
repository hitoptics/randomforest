%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    Creating training data 
%             using Mie scattering 
%       
%
%     MATLAB parallel computing
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;close all;
global SP FID II CHEB9 ZAC sav ICO zurashi

%%%% Stored file  set your folder xxx
sav='C:\Users\xxx';

%%%% parameters
ssv3=[sav,'\model_r_n_z.txt'];

%%%%  curvature value at 9 points
ssv4=[sav,'\model_kyokuritsu.txt'];

FID5=fopen(ssv3,'w');
FID6=fopen(ssv4,'w');

tic;
timerVal=tic;

%%%% zurashi=0 means Δz=0.
zurashi=0;

for m=1:1:3;
tic
n_p=1.58+(m-1)*0.01;

for k=1:1:6;

r0=0.027+(k-1)*0.001;    

for jj=1:1:501;

z=157.5+(jj-1)*0.01;

ZAC=z;

x0=[r0,n_p,z];

kyoku=fun_small_zer_mic_for_r(x0);

fprintf(FID5,'%10.6f %10.6f %10.6f\n',r0,n_p,z+zurashi);
for k=1:1:9;
fprintf(FID6,'%16.8e ',kyoku(k));
end;
fprintf(FID6,'\n');
toc;
end;
end;
end;

toc(timerVal);
elapsedTime=toc(timerVal);


