
%Write a script that processes stereo image pair to generate disparity map
%using dynamic programming

ref = imread('Data\view1.png');           % left view
temp = imread('Data\view5.png'); 
tic;
I1 = ref;
I1 = im2double(rgb2gray(I1)); 
[rows,cols] = size(I1);
I2 = temp;
I2 = im2double(rgb2gray(I2));
%I1_edges = edge(I1,'canny') ;
%I2_edges = edge(I2,'canny')  ;

DispMap1 = zeros(size(I1));
DispMap5 = zeros(size(I1));  

for k = 1:size(I1,1) % for each scanline i.e. each row
    
    
    A = zeros(cols , cols); % for scanline comparison to find longest common subsequence
    A(:,:) = NaN;
    A(1,1) = 0;
    
    % Initialization
    for j = 2:size(I1,2) 
        ColorL = I1(k,j);
        ColorR = I2(k,j);
        A(1 ,j) = A(1,j-1) + Difference( ColorR , ColorL );
    end

    for j = 2:size(I1,2)
         ColorL = I1(k,j);
         ColorR = I2(k,j);
         A(j,1) = A(j-1,1) + Difference( ColorR , ColorL );
    end  

    %populating the matrix to find optimal path
    for i = 2 : cols
        for j= 2 : cols
            Minimum = minValue( A(i-1,j-1) , A(i-1,j) , A(i,j-1) );
            ColorL = I1(k,j);
            ColorR = I2(k,i);
            A(i,j) = Minimum + Difference( ColorR , ColorL );
        end
    end
    
    %finding the optimal path in the populated matrix
    i = cols;
    j = cols;
    while( i > 1 && j > 1)
            DispMap5(k,i) = j - i;
            DispMap1(k,j) = i - j;
            up = A(i-1,j);
            left = A(i,j-1);
            upLeft = A(i-1,j-1);
            min = minValue(up, left, upLeft);
            if min == upLeft
                i = i-1;
                j= j-1;
            end
            if min == up;
                i = i-1;
            end
            if min == left
                j = j-1;
            end
    end
    
end


imshow(DispMap5,[]), axis image, colormap('jet'), colorbar;
caxis([0 70]);
imwrite(uint8(DispMap5) ,'Results/dynProgdispMap5.png' );
imwrite(uint8(-DispMap1) ,'Results/dynProgdispMap1.png' );


