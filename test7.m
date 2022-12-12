Image=imread('coins.png');

imshow(Image);

S=size(Image);

datapoints=zeros(S(1)*S(2),3);

index=1;

for i=1:S(1);
    
    for j=1:S(2)
        
      datapoints(index,1)=Image(i,j); 
      
      datapoints(index,2)=i;
      
      datapoints(index,3)=j;
      
      index=index+1;        
        
    end
    
    
    
end