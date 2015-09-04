for i = 1:6
    filename = strcat('part1_',num2str(i));
    I = imread(filename,'jpg');
    %Get the info of the image
    I_info = imfinfo(filename,'jpg');
   
    %Cropping out the borders
     I_cropped = I(25:I_info.Height-25,25:I_info.Width-25);

    
    if(i == 3)
        I_cropped = I ; %zero cropping for the fat man
    end
    
    if(i == 6) % more cropping for the last image
        I_cropped = I(40:I_info.Height-40,40:I_info.Width-40);
    end
    
    
    
 
    I2 = im2double(I_cropped);
    %Divide the cropped image into 3 parts
    height= floor(size(I2,1))/3;
    B = I2(1:height,:);
    G = I2(height+1:height*2,:);
    R = I2(height*2+1:height*3,:);
    
    %align G with B using Normalized Cross-Correlation
    disp(filename);
    disp('Aligning G with B');
    aligned_G = align(G,B);
    %align R with B using Normalized Cross-Correlation
    disp('Aligning R with B')
    aligned_R = align(R,B);
    colorized_img = cat(3,aligned_R,aligned_G,B);
    resultFileName = strcat('result',num2str(i),'.jpg');
    %figure
    %imshow(colorized_img);
    imwrite(colorized_img,resultFileName);
end
    
