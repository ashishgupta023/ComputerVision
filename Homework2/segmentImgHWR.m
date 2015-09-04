function idx = segmentImgHWR(I, k)
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
    F=makeLMfilters;
    [~,~,num_filters] = size(F);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %                                                                     %
        %                            YOUR CODE HERE                           %
        %                                                                     %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        X_rows = size(I,1);
        X_cols = size(I,2);
        
        %Dont take the absolute values
         for i=1:num_filters
            responses(:,:,i)=conv2(I,F(:,:,i),'same');
         end
        
         %Half Wave rectification
        for m = 1:X_rows
            for n = 1:X_cols
               for i = 1 :num_filters
                   if(  responses(m,n,i)  > 0)
                        responses_pos(m,n,i) = responses(m,n,i);
                   else
                        responses_pos(m,n,i) = 0;
                   end
                end
            end
        end
        
        for m = 1:X_rows
            for n = 1:X_cols
               for i = 1 :num_filters
                   if(  responses(m,n,i)  < 0)
                        responses_neg(m,n,i) = abs(responses(m,n,i));
                   else
                        responses_neg(m,n,i) = 0;
                   end
                end
            end
        end
        
        %Summarizing the neighbourhood
        h = fspecial('gaussian' , 10, 5); % Gaussian filter
         for i=1:num_filters
            responses_final(:,:,i)=conv2(responses_pos(:,:,i),h,'same');
         end
          for i=1:num_filters
            responses_final(:,:,num_filters + i)=conv2(responses_neg(:,:,i),h,'same');
         end
         
        %display(X_rows);
        %display(X_cols);
          
        
        X= zeros(X_rows*X_cols , num_filters * 2);
        pixel_count = 1;
        for m=1:X_rows
            for n=1:X_cols
                for j=1:num_filters
                    X(pixel_count,j) = responses_final(m,n,j);    
                end

                pixel_count = pixel_count+1;
            end
        end
      
        
        
     
        IDX = KMeansClustering(X,k);
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
