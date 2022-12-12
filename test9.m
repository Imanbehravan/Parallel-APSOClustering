SegmentedImage=zeros(size(Image,1),size(Image,2));

% imshow(SegmentedImage);

numofclusters=max(labels);

graysc=randi([0,255],1,numofclusters);

for p=1:numofclusters
    
    
        class=p;

        ind=find(cls==class);

        add=dataset(:,4:5);

        Pixels=add(ind,:);

        for i=1:size(Pixels,1);

            row=Pixels(i,1);

            column=Pixels(i,2);

            SegmentedImage(row,column)=graysc(p);


        end

        SegmentedImage=uint8(SegmentedImage);

        % figure;

        imshow(SegmentedImage);

    
end