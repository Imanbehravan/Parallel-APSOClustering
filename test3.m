clear
clc

numofclusters=10;

M=10;

numofselectedfeatures=2;

C1=2;

C2=2;

dataset=xlsread('S1.xlsx');

Reallabels=xlsread('S1labels.xlsx');

xmin=min(min(dataset));

xmax=max(max(dataset));

AVG=mean(dataset);

pop=rand(M,numofclusters*numofselectedfeatures);

[c1 c2 m population k]=changeparam(C1,C2,M,pop,AVG,numofclusters,numofselectedfeatures,xmin,xmax);