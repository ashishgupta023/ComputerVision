function idx = segmentImg(I, k)
% function idx = segmentImage(img)
% Returns the logical image containing the segment ids obtained from 
%   segmenting the input image
%
% INPUTS
% I - The input image contining textured foreground objects to be segmented
%     out.
% k - The number of segments to compute (also the k-means parameter).
%
% OUTPUTS
% idx - The logical image (same dimensions as the input image) contining 
%       the segment ids after segmentation. The maximum value of idx is k.
%          

    % 1. Create your bank of filters using the given alogrithm; 
    % 2. Compute the filter responses by convolving your input image with  
    %     each of the num_filters in the bank of filters F.
    %     responses(:,:,i)=conv2(I,F(:,:,i),'same')
    %     NOTE: we suggest to use 'same' instead of 'full' or 'valid'.
    % 3. Remember to take the absolute value of the filter responses (no
    %     negative values should be used).
    % 4. Construct a matrix X of the points to be clustered, where 
    %     the rows of X = the total number of pixels in I (rows*cols); and
    %     the columns of X = num_filters;
    %     i.e. each pixel is transformed into a num_filters-dimensional
    %     vector.
    % 5. Run kmeans to cluster the pixel features into k clusters,
    %     returning a vector IDX of labels.
    % 6. Reshape IDX into an image with same dimensionality as I and return
    %     the reshaped index image.
    %  
    
    I_rgb = I;
    I = double(rgb2gray(I)); 
    %I=(:,:,1);
    F=makeLMfilters; % bank of filters
    [~,~,num_filters] = size(F);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %                                                                     %
        %                            YOUR CODE HERE                           %
        %                                                                     %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        X_rows = size(I,1);
        X_cols = size(I,2);
     
        %computing filter responses with absolute values
        for i=1:num_filters
            responses(:,:,i)=abs(conv2(I,F(:,:,i),'same'));
        end
        
        
        %display(X_rows);
        %display(X_cols);
          
        %constructing the points to be clustered
        X= zeros(X_rows*X_cols , num_filters);
        pixel_count = 1;
        for m=1:X_rows
            for n=1:X_cols
                for j=1:size(X,2)
                    X(pixel_count,j) = responses(m,n,j);    
                end
                pixel_count = pixel_count+1;
            end
        end
       %augmenting the normalized rgb value for each pixel in the feature vector
       pixel_count = 1;
        for m = 1:X_rows
            for n = 1:X_cols
                for o =1:3
                X(pixel_count , num_filters + o ) = double(I_rgb(m,n,o)/255);
                end
                pixel_count = pixel_count+1;
            end
        end
        %run k means
        IDX = KMeansClustering(X,k);
        %Reshape
        idx = zeros(X_rows,X_cols);
        pixel_counter = 1;
        for m=1:X_rows
            for n=1:X_cols
                idx(m,n) = IDX(pixel_counter);
                pixel_counter = pixel_counter + 1;
            end
        end
        
        
                
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %                                                                     %
        %                            END YOUR CODE                            %
        %                                                                     %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
