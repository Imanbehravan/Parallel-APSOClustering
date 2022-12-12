clc;
clear;
close all


npop=5;

numofclusters=8;

numofselectedfeatures=2;

FuncIter=10;

dataset=xlsread('S1.xlsx');

Reallabels=xlsread('S1labels.xlsx');

[~,numoffeatures]=size(dataset);
        for  i=1:numoffeatures


            data=dataset(:,i);

            div(i)=std(data);

        end


 div=div';
        
 [diversity featurenumber]=sort(div,'descend');
        
 [selectedfeatures newdataset]=RemovingFeatures(dataset,numofselectedfeatures);
        
  AVG=mean(newdataset);
  
xmin=min(min(newdataset));
xmax=max(max(newdataset));
  
nvar=numofclusters*numofselectedfeatures;

population=zeros(npop,nvar);

c1=2;
c2=2;

for i=1:npop
    
    population(i,:)=rand*repmat(AVG,1,numofclusters)+rand(1,numofclusters*numofselectedfeatures)+randi([round(xmin) round(xmax)],1,nvar);

    
end

result=PSOfunc(numofselectedfeatures,numofclusters,newdataset,FuncIter,npop,c1,c2,population )

