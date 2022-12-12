clear
close all
clc

dataset=xlsread('dim032.xlsx');

Reallabels=xlsread('dim032labels.xlsx');

numofselectedfeatures=32;

% Realcenters=xlsread('Realcenters.xlsx');

[~,numoffeatures]=size(dataset);
        for  i=1:numoffeatures


            data=dataset(:,i);

            div(i)=std(data);

        end


 div=div';
        
 [diversity featurenumber]=sort(div,'descend');
        
 [selectedfeatures newdataset]=RemovingFeatures(dataset,numofselectedfeatures);

c=load('r.mat');

centroids=c.R.centroids;

labels=[1:size(centroids,1)]';

model=fitcknn(centroids,labels,'NumNeighbors',1);

Dataclustering=model.predict(newdataset);
