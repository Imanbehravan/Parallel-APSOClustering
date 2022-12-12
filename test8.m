SegmentedImage=zeros(size(Image,1),size(Image,2));

% SegmentedImage=imread('cameraman.tif');
% 
% imshow(SegmentedImage);

class=1;

ind=find(cls==class);

add=dataset(:,4:5);

Pixels=add(ind,:);

for i=1:size(Pixels,1);
    
    row=Pixels(i,1);
    
    column=Pixels(i,2);
    
    SegmentedImage(row,column)=255;
    
    
end

SegmentedImage=uint8(SegmentedImage);

figure;

imshow(SegmentedImage);

