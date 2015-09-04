%Write a script that processes stereo image pair to generate disparity map
%using basic block matching
function disparityMap = BlockMatch(ref , temp , win , groundTruth )

tic;

I1 = ref;
I1 = im2double(rgb2gray(I1)); 
disparityMap = zeros(size(I1));
I1 = padarray(I1,[win,win] , 'both');
[rows,cols] = size(I1);
I2 = temp;
I2 = im2double(rgb2gray(I2));
I2 = padarray(I2,[win,win] , 'both');

refWin = zeros(2*win + 1 , 2*win + 1);
matchWin = zeros(2*win + 1 , 2*win + 1);
col_match = 0;
min_ssd = 0;

for i = win+1:rows-win
    for j = win+1:cols-win % for each pixel in the reference image
        refWin(1:end , 1:end) = I1(i-win:i+win , j-win:j+win); % window in the reference image
        
       % if j - 100 > win+1
        %    startCheck = j - 100;
        %else
        %    startCheck = win+1;
        %end
        
        %if j + 100 < cols - win
        %    endCheck = j + 100;
        %else
        %    endCheck = cols-win;
        %end
         
        min_ssd = Inf;
        for k = win+1:cols-win % scanLine on the temp image
            matchWin(1:end, 1:end) = I2(i-win:i+win , k-win:k+win); %window in the temp image
            ssd = sum(sum((matchWin - refWin).^2)) ; %window matching
         if(ssd < min_ssd ) 
                min_ssd = ssd;
                col_match = k ;
         end
        end
       disparityMap(i-win,j-win) = abs(col_match - j ) ; % set disparity
    end
end

toc;
%imshow(disparityMap,[]), axis image, colormap('jet'), colorbar;
%caxis([0 70]);
%imwrite( uint8(disparityMap) , 'Results/disp.png');

disp = uint8(disparityMap);
error = groundTruth - disp ; 
sumSquaredError = sum(sum(error.^2));
mse = sumSquaredError / (size(disp,1) *  size(disp,2));
display(mse);
end


