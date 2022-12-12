function [ newclusters,newcluster_num ] = MergingClusters( distance,Dataclustering,numofclusters,centroids,dataset,thr,thr2,thr3 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% newclusters=0;

mergedcenters.C1=[];

mergedcenters.C2=[];

mergedcenters.newcenter=[];

mergedcenters.Firstid=[];
            
mergedcenters.Secondid=[];

numofmerged=1;

distance(find(distance==0))=inf;

while numofmerged>0
    
    index=1;

    for i=1:numofclusters

    %     check=0;

        C1=centroids(i,:);

        check1=find([mergedcenters.Firstid]==i);

        check2=find([mergedcenters.Secondid]==i);

        if (numel(check1)==0)&&(numel(check2)==0)
            
            %% finding nearest center for each centroid

            temp=distance(i,:);

%             ind2=find(temp>0);

%             D=temp(ind2);

            [~,ind]=min(temp);

%             if ind>=i
% 
%                 ind=ind+1;
% 
%             end
            
            temp2=distance(ind,:);
            
%             non_zero=find(temp2>0);
%             
%             D2=temp2(non_zero);
            
            [~,ind2]=min(temp2);
            
%             if ind3>ind
%                 
%                 ind3=ind3+1;
%                 
%             end

            if (ind2~=i)
                
                distance(i,ind)=inf;

            end
%             
            if (ind2==i)
                
                C2=centroids(ind,:);

                check3=find([mergedcenters.Firstid]==ind);

                check4=find([mergedcenters.Secondid]==ind);

                if (numel(check1)>0)||(numel(check2)>0)

                    break;

                end
                
                Both_cluster_samples=[];
                
                First_cluster_samples=[];
                
                Second_cluster_samples=[];

                First_cluster_samples=dataset(find(Dataclustering==i),:);

                Second_cluster_samples=dataset(find(Dataclustering==ind),:);
                
                Both_cluster_samples=[First_cluster_samples;Second_cluster_samples];
                
                %% just cheking
                
%                 figure;
%                 
%                 plot(First_cluster_samples(:,1),First_cluster_samples(:,2),'o');
%                 
%                 hold on;
%                 
%                 plot(C1(1),C1(2),'k*','markersize',15);
%                 
%                 plot(Second_cluster_samples(:,1),Second_cluster_samples(:,2),'go');
                
%                 plot(C2(1),C2(2),'k*','markersize',15);
                
                Nc1=mean(First_cluster_samples);
                
                Nc2=mean(Second_cluster_samples);
                
                midC=(Nc1+Nc2)/2;
                
                labels=[1 2 3]';
                
                Cen=[Nc1;Nc2;midC];
               
                model=fitcknn(Cen,labels,'NumNeighbors',1);
                
                cls=model.predict(Both_cluster_samples);
                
%                 firstclus=Both_cluster_samples(find(cls==1),:);
%                 
%                 secondclus=Both_cluster_samples(find(cls==2),:);
                
                thirdclus=Both_cluster_samples(find(cls==3),:);
                
%                 figure;
%                 
%                 plot(firstclus(:,1),firstclus(:,2),'o');
%                 
%                 hold on
%                                
%                 plot(secondclus(:,1),secondclus(:,2),'ro');
%                                
%                 plot(thirdclus(:,1),thirdclus(:,2),'go');
                
                Rate=numel(find(cls==3))/numel(cls);
                
                if Rate<thr3
                    
                    distance(i,ind)=inf;
                    
                    distance(ind,i)=inf;
                    
                end
                %% end cheking

                d1=dist(Both_cluster_samples,C1');

                d2=dist(Both_cluster_samples,C2');

                difference=abs(d1-d2);

                closeness=difference./(d1+d2);

                Overlapped_samples=find(closeness<thr2);

                threshold=round(thr*size(Both_cluster_samples,1));

                if (numel(Overlapped_samples)>threshold)&&(Rate>thr3)

                    mergedcenters(index).C1=C1;

                    mergedcenters(index).C2=C2;

                    temp2=[C1;C2];

                    mergedcenters(index).newcenter=mean(temp2);

                    mergedcenters(index).Firstid=i;

                    mergedcenters(index).Secondid=ind;

                    numofmerged=index;

    %                 distance(:,i)=inf;
    % 
    %                 distance(:,ind)=inf;

                    index=index+1;

                end
            
            end

        end
        
    end
    
    if index>1
       
        [centroids,numofclusters]=Replacing_Merged_Clusters(mergedcenters,numofmerged,centroids,numofclusters);

        %% plot

        figure;

        plot(dataset(:,1),dataset(:,2),'o');

        hold on

        plot(centroids(:,1),centroids(:,2),'k*','linewidth',1.5,'markersize',10);

        %% plot

        distance=[];

        distance=dist(centroids,centroids');

        distance(distance==0)=inf;

        clear mergedcenters;

        mergedcenters.C1=[];

        mergedcenters.C2=[];

        mergedcenters.newcenter=[];

        mergedcenters.Firstid=[];

        mergedcenters.Secondid=[];

        %% new labeling

        Dataclustering=[];

        labels=[1:size(centroids,1)]';

        model=fitcknn(centroids,labels,'NumNeighbors',1);
        
        Dataclustering=model.predict(dataset);
    
    end
    
    if (index==1)
        
        numofmerged=0;
        
    end
    
    
end


newcluster_num=numofclusters;

newclusters=centroids;

end

