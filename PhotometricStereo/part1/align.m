%Image Alignment using Normalized Cross-Correlation 
function aligned_img = align(temp,ref)
    res = normxcorr2(temp,ref);
    %Find the peak in the cross-correlation
    max_res = max(res(:)); 
    [y_peak,x_peak ] = find(res==max_res);
    %figure, surf(res), shading flat;
    %Find the displacement vector by subtracting the template size. (remove padding)
    shiftY = y_peak - size(temp,1) ;
    shiftX = x_peak - size(temp,2);
    disp('Displacement vector' );
    disp([shiftY,shiftX]);
    %shift the template image using the displacement vector
    aligned_img = circshift(temp,[shiftY,shiftX]);
end

















