function [ newcenters,numofnewclusters ] = Replacing_Merged_Clusters( mergedcenters,numofmerged,centroids,numofclusters )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

index=1;

for i=1:numofclusters
    
    check=find([mergedcenters.Firstid]==i);
    
    check2=find([mergedcenters.Secondid]==i);
    
    if (numel(check)==0)&&(numel(check2)==0)
        
        newcenters(index,:)=centroids(i,:);
        
        index=index+1;
        
    end 
    
end

for j=1:numofmerged
    
    newcenters(index,:)=mergedcenters(j).newcenter;
    
    index=index+1;
    
end


numofnewclusters=numofclusters-numofmerged;

end

