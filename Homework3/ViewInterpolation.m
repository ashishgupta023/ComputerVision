% parameters
interp = 0.5;   % interpolation factor of 0.5 should give a virtual view exactly at the center of line connecting both the cameras. can vary from 0 (left view) to 1 (right view)

% read in images and disparity maps
i1 = imread('Data\view1.png');           % left view
i2 = imread('Data\view5.png');           % right view
d1 = double(imread('Data\disp1.png'));   % left disparity map, 0-255
d2 = double(imread('Data\disp5.png'));   % right disparity map, 0-255

% tag bad depth values with NaNs
d1(d1==0) = NaN;
d2(d2==0) = NaN;

%Using view1 and and disp1 - Shifting pixels with half the disparity value
view3 = zeros(size(i1));

for i = 1:size(i1,1)
    for j = 1:size(i1,2)
        if j - floor(d1(i,j)*interp) > 0
            view3(i,j-floor(d1(i,j)*interp), :) = i1(i ,j  , :);
        end
    end
end

%Using view5 and disp5 - Filling holes by shifting pixels with half the
%disparity
for i = 1:size(i2,1)
    for j = 1:size(i2,2)
            if j + floor(d2(i,j)*interp) < size(i2,2)
                if view3(i,j + floor(d2(i,j)*interp)) == 0
                    view3(i,j + floor(d2(i,j)*interp) , :) = i2(i,j, :);
                end
            end
    end
end
imwrite(uint8(view3) , 'Results/view3.png');
view3(view3 == 0) = NaN;

%masking NaN with the original image
i3 = double(imread('Data\view3.png'));      % center view
for i = 1:size(view3,1)
    for j = 1:size(view3,2)
         if isnan(view3(i,j,1))
            view3(i,j ,1) = i3(i,j , 1);
         end
         if isnan(view3(i,j,2))
            view3(i,j ,2) = i3(i,j , 2);
         end
         if isnan(view3(i,j,3))
            view3(i,j ,3) = i3(i,j , 3);
        end
    end
end

sumSquaredError = 0 ;
for i = 1:size(view3,1)
    for j = 1:size(view3,2)
            sumSquaredError = sumSquaredError + (i3(i,j,1) - view3(i,j,1))^2;
            sumSquaredError = sumSquaredError + (i3(i,j,2) - view3(i,j,2))^2;
            sumSquaredError = sumSquaredError + (i3(i,j,3) - view3(i,j,3))^2;
    end
end

MSE = sumSquaredError/ (size(i3,1)*size(i3,2))
%207.8091
