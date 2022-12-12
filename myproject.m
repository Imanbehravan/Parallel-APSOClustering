clc;
clear;
close all

%numofclusters=8;

realclusternumber=20;

numofselectedfeatures=2;

lengthoftree=10;

numofPSOs=3;

% threshold=0.2; % number of overlapped samples
% 
% threshold2=0.4; % distance of two close clusters from centers
% 
% threshold3=0.2;

FuncIter=150;

MainPSOiter=600;

npop=5;

dataset=xlsread('a1.xlsx');

Reallabels=xlsread('a1labels.xlsx');

% wholedataset=xlsread('poker');

% wholedataset=load('Mydataset11.mat');

% dataset=wholedataset(:,1:end-1);

% dataset=xlsread('centers.xlsx');

% Image=imread('3063.jpg');
% 
% imshow(Image);

% Image2=medfilt2(Image);

% dataset=Image2Data(Image);

% Reallabels=xlsread('aggregationlabels.xlsx');

numofrepres=round(0.1*size(dataset,1));

% Realcenters=xlsread('Realcenters.xlsx');

% [~,numoffeatures]=size(dataset);
%         for  i=1:numoffeatures
% 
% 
%             data=dataset(:,i);
% 
%             div(i)=std(data);
% 
%         end
%         
%         
%         
%  div=div';
%         
%  [diversity featurenumber]=sort(div,'descend');
%         
%  [selectedfeatures newdataset]=RemovingFeatures(dataset,numofselectedfeatures);

% newdataset=dataset(:,1);

newdataset=dataset;
        
 AVG=mean(newdataset);
 
xmin=min(min(newdataset));

xmax=max(max(newdataset));
  
%% defining parameters 

% param.numofclusters=[];

numofclusters=[];

% param.inspectedK=[];

inspectedK=[];


% param.c1=[];
% 
% param.c2=[];
% 
%  param.m=[]; % number of beginning population for each tree
% 

popsize=npop;

% param.pop=[];

pop=[];
     
% param.cost=[];

cost=[];
    
% param.bestpos=[];

bestpos=[];
    
    
 
%     param.c1=2;
%  
%     param.c2=2;
% 

%% initializing each tree 

S=size(newdataset);



%% 
tic;

parfor i=1:numofPSOs
    
    disp(' ');

    disp(['----------------------tree number: ' num2str(i) '--------------------']);

    disp(' ');
    
    index=1;

    bestresult=[];
    
    result=[];
    
    result.position=[];
    
    result.cost=[];
    
    result.centroids=[];
    
%     param.numofclusters=round(unifrnd(2,sqrt(S(1))));

    numofclusters=round(unifrnd(2,sqrt(S(1))));

%     nvar=param.numofclusters*numofselectedfeatures;
    nvar=numofclusters*numofselectedfeatures;

%     population=zeros(param.m,nvar);
    
      population=zeros(popsize,nvar);


%     for j=1:param.m

    for j=1:popsize


%         p=randi([1,size(newdataset,1)],1,param.numofclusters);

        p=randi([1,size(newdataset,1)],1,numofclusters);

        
%         chosensamples=ChoosingUniquesamples(p,size(newdataset,1),param.numofclusters);

        chosensamples=ChoosingUniquesamples(p,size(newdataset,1),numofclusters);

        
        index=1;
        
%         for h=1:param.numofclusters
        for h=1:numofclusters

        
%         population(j,:)=rand*repmat(AVG,1,param.numofclusters)+rand(1,param.numofclusters*numofselectedfeatures)+randi([round(xmin) round(xmax)],1,nvar);
           
          population(j,index:index+numofselectedfeatures-1)=newdataset(chosensamples(h),:);
            
          index=index+numofselectedfeatures;
        
        end
        
    end

    pop=population;
    
    disp(' ');

    disp(['-------------PSO number: ' num2str(1) '--------------']);

    disp(' ');
    
%     result(1)=PSOfunc(numofselectedfeatures,param.numofclusters,newdataset,FuncIter,param.m,param.pop,xmin,xmax);

%     R=PSOfunc(numofselectedfeatures,param.numofclusters,newdataset,FuncIter,param.m,param.pop,numofrepres,xmin,xmax);

    R=PSOfunc(numofselectedfeatures,numofclusters,newdataset,FuncIter,popsize,pop,numofrepres,xmin,xmax);

    
    result=R;
    
%     param.inspectedK=R.inspectedK;

    inspectedK=R.inspectedK;


    
%      PSOleaf(1).c1=param.c1;
%             
%      PSOleaf(1).c2=param.c2;
            
%      PSOleaf(1).m=param.m;

     PSOleaf(1).m=popsize;
            
     PSOleaf(1).pop=pop;
            
%      PSOleaf(1).k=param.numofclusters;

     PSOleaf(1).k=numofclusters;
     
     PSOleaf(1).inspectedK=result.inspectedK;
            
     PSOleaf(1).silind=result(1).cost;

%      param.cost=result(1).cost;

     cost=result(1).cost;
     
%      param.bestpos=result(1).position;

    bestpos=result(1).position;
    
    bestresult=result(1);
    
        for l=2:lengthoftree

%             [newc1,newc2,newm,newpop,newk]=changeparam(param.c1,param.c2,param.m,param.pop,AVG,param.numofclusters,numofselectedfeatures,xmin,xmax);
            
%             [newpop,newk]=changeK2(param.numofclusters,param.pop,AVG,param.m,numofselectedfeatures,xmin,xmax);
            
            [newpop,newk]=changeK2(numofclusters,pop,AVG,popsize,numofselectedfeatures,xmin,xmax);

            
            disp(' ');

            disp(['-------------PSO number: ' num2str(l) '--------------']);

            disp(' ');

%             result(l)=PSOfunc(numofselectedfeatures,newk,newdataset,FuncIter,param.m,newpop,xmin,xmax);
            
            result(l)= PSOfunc(numofselectedfeatures,newk,newdataset,FuncIter,popsize,newpop,numofrepres,xmin,xmax);

%             PSOleaf(l).c1=newc1;
%             
%             PSOleaf(l).c2=newc2;
            
%             PSOleaf(l).m=param.m;

            PSOleaf(l).m=popsize;
            
            PSOleaf(l).pop=newpop;
            
            PSOleaf(l).k=newk;
            
            PSOleaf(l).inspectedK=result(l).inspectedK;
            
            PSOleaf(l).silind=result(l).cost;

            if result(l).cost<bestresult.cost

%                 param.c1=newc1;
% 
%                 param.c2=newc2;

%                 param.numofclusters=newk;

                numofclusters=newk;


%                 param.m=newm;

%                 param.pop=newpop;

                pop=newpop;
                
%                 param.cost=result(l).cost;

                cost=result(l).cost;
                
%                 param.inspectedK=result(l).inspectedK;

                inspectedK=result(l).inspectedK;
                
%                 param.bestpos=result(l).position;

                bestpos=result(l).position;

                bestresult=result(l);


            end

%             newc1=[];
%             newc2=[];
%             newm=[];
            newpop=[];
            newk=[];
            
            

        end
        
        finalresult(i)=bestresult;
        
        finalparam(i).numofclusters=numofclusters;
        
        finalparam(i).inspectedK=inspectedK;
        
        finalparam(i).m=popsize;
        
        finalparam(i).pop=pop;
        
        finalparam(i).cost=cost;
        
        finalparam(i).bestpos=bestpos;
        
%         figure;
%         
%         plot([PSOleaf.silind],'--o','markersize',5,'markerfacecolor','r','markeredgecolor','r','linewidth',1.5);
%         
%         name=['treePSO ' , num2str(i)];
%         
%         title(name);
%         
%         ylabel('Silhouette');
%         
%         xlabel('leaf');
%         
%         save(name,'PSOleaf');
        
        PSOleaf=[];

end

d=[finalresult.cost];

[~,index]=min(d);

selectedparam=finalparam(index);

% selectedparam.pop(selectedparam.m+1,:)=selectedparam.bestpos;
% 
% selectedparam.m=selectedparam.m+1;

[newpop, newbestpos, k]=removingzeroclusters(selectedparam.pop,selectedparam.bestpos,numofselectedfeatures,newdataset);

disp(' ');

disp('--------------------Main PSO-------------------');

% mainPSOout=PSOfunc2(numofselectedfeatures,selectedparam.numofclusters,newdataset,MainPSOiter,selectedparam.m,selectedparam.pop,numofrepres,xmin,xmax);

 mainPSOout=PSOfunc2(numofselectedfeatures,k,newdataset,MainPSOiter,selectedparam.m,newpop,numofrepres,xmin,xmax);

toc;

save('result.mat','mainPSOout');

Centroids=mainPSOout.centroids;

figure

plot(newdataset(:,1),newdataset(:,2),'o');

hold on 

for j=1:k
    
    plot(Centroids(j,1),Centroids(j,2),'k*','markersize',10,'linewidth',1.5);
    
    hold on
    
end
% 
% labels=[1:size(Centroids,1)]';
% 
% model=fitcknn(Centroids,labels,'NumNeighbors',1);
% 
% cls=model.predict(newdataset);
% 
% % SegmentedImage=zeros(size(Image,1),size(Image,2));
% 
% % imshow(SegmentedImage);
% 
% numofclusters=max(labels);

% graysc=randi([0,255],1,numofclusters);

% for p=1:numofclusters
%     
%     
%         class=p;
% 
%         ind=find(cls==class);
% 
%         add=dataset(:,4:5);
% 
%         Pixels=add(ind,:);
% 
%         for i=1:size(Pixels,1);
% 
%             row=Pixels(i,1);
% 
%             column=Pixels(i,2);
% 
%             SegmentedImage(row,column)=graysc(p);
% 
% 
%         end
% 
%         SegmentedImage=uint8(SegmentedImage);
% 
%         % figure;
% 
%         imshow(SegmentedImage);
% 
%     
% end

% silhouette=evalclusters(newdataset,cls,'Silhouette')
% 
 %% calculating rand index
% 
disp(' ');
disp('--------calculating the rand index-------');
disp(' ');

g=load('result.mat');
     
centroids=g.mainPSOout.centroids;
  
labels=[1:size(centroids,1)]';
  
% Dataclustering=knnclassify(newdataset,centroids,labels);

model=fitcknn(centroids,labels,'NumNeighbors',1);

Dataclustering=model.predict(newdataset);
% 
Rindex=randindex(Dataclustering,Reallabels)
% 
% %% analyzing 
% 
for i=1: max(labels)
    
    numofsamples(i)=numel(find(Dataclustering==i));
    
end

numof_nonzero_clusters=numel(find(numofsamples>0))
% 
% for j=1:realclusternumber
%     
%     realnumofSam(j)=numel(find(Reallabels==j));
%     
% end
% 
% distance=zeros(k);
% 
% for i=1:k
%     
%     for j=1:k
%         
%         distance(i,j)=dist(centroids(i,:),centroids(j,:)');
%         
%     end
%     
%     
% end
% 
NMI=nmi(Reallabels,Dataclustering)
% 
% [newclusters,cluster_num]=MergingClusters( distance,Dataclustering,numof_nonzero_clusters,centroids,newdataset,threshold,threshold2,threshold3 )
% 
% newlabels=[1:size(newclusters,1)]';
% 
% model=fitcknn(newclusters,newlabels,'NumNeighbors',1);
% 
% cls=model.predict(newdataset);
% 
% New_Rindex=randindex(cls,Reallabels)
% 
% new_NMI=nmi(Reallabels,cls)
% 
% for i=1: cluster_num
%     
%     numofsamples2(i)=numel(find(cls==i));
%     
% end
% 
% cost=fitness6(numofselectedfeatures,cluster_num,newdataset,newclusters);
% 
% newCost=1/(cost.CriterionValues)
