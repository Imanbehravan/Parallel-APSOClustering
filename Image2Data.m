function [ datapoints ] = Image2Data( Image )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    S=size(Image);

    datapoints=zeros(S(1)*S(2),5);

    index=1;

    for i=1:S(1);

        for j=1:S(2)

          datapoints(index,1)=Image(i,j,1); 

          datapoints(index,2)=Image(i,j,2); 

          datapoints(index,3)=Image(i,j,3);
          
          datapoints(index,4)=i; 
          
          datapoints(index,5)=j; 

          index=index+1;        

        end



    end

end

