clear
clc

k=4;

m=10;

features=2;

dataset=xlsread('S1.xlsx');

Reallabels=xlsread('S1labels.xlsx');

xmin=min(min(dataset));

xmax=max(max(dataset));

AVG=mean(dataset);

pop=rand(m,k*features);

increase=1;

newk=k+increase;

s=zeros(m,increase*features);

for i=1:m

    S(i,:)=rand*repmat(AVG,1,increase)+rand(1,increase*features)+randi([round(xmin) round(xmax)],1,increase*features);

end

newpop=[pop S];

