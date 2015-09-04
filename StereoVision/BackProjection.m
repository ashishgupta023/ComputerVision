
disp1 = imread('Results/headDispMap1_win4' , 'png');
groundTruth1 = imread('Data/disp1','png');

disp5 = imread('Results/headDispMap5_win4' , 'png');
groundTruth5 = imread('Data/disp5','png');



disp1_nan = double(disp1);
disp5_nan = double(disp5);

for i = 1:size(disp5,1)
    for j = 1:size(disp5,2)
            if(disp5(i,j) ~= disp1( i , j + disp5(i,j))    )
                disp5_nan(i,j) = NaN;
            end
    end
end


for i = 1:size(disp1,1)
    for j = 1:size(disp1,2)
        if j - disp1(i,j) > 0
            if(  disp1(i,j) ~= disp5( i , j - disp1(i,j))  )
                disp1_nan(i,j) = NaN;
            end
        end
    end
end

imshow(disp1_nan , [0,70]);


% Masking the NaN pixels by setting the NaN  values with groundTruth
for i = 1:size(disp1,1)
    for j = 1:size(disp1,2)
        if isnan(disp1_nan(i,j))
            disp1_nan(i,j) = groundTruth1(i,j);
        end
        if isnan(disp5_nan(i,j))
            disp5_nan(i,j) = groundTruth5(i,j);
        end
    end
end


error = groundTruth1 - uint8(disp1_nan) ; 
sumSquaredError = sum(sum(error.^2));
mse1_nan = sumSquaredError / (size(disp1,1) *  size(disp1,2));
display(mse1_nan)

error = groundTruth5 - uint8(disp5_nan) ; 
sumSquaredError = sum(sum(error.^2));
mse2_nan = sumSquaredError / (size(disp5,1) *  size(disp5,2));
display(mse2_nan)
