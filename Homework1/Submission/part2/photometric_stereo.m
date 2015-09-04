function [albedo_image, surface_normals] = photometric_stereo(imarray, light_dirs)
% imarray: h x w x Nimages array of Nimages no. of images
% light_dirs: Nimages x 3 array of light source directions
% albedo_image: h x w image
% surface_normals: h x w x 3 array of unit surface normals
%% <<< fill in your code below >>>
surface_normals = zeros(size(imarray(:,:,1))) ;
surface_normals(:,:,3) = 0;

Ix_y = zeros([size(imarray,3),1]); %64X1
%light_dirs Source vectors 64X3
albedo_image = zeros(size(imarray(:,:,1)));
    for i = 1:size(imarray,1)
        for j = 1:size(imarray,2);
            for k = 1:size(imarray,3)
                Ix_y(k,1) = imarray(i,j,k); % Stacking up the pixel intensity for each point on all 64 images
            end
            surface = light_dirs\Ix_y ; %surface(i,j) 3X1 Solving the equation light_dirs*surface(i,j) = I
            surface_normals(i,j,1) = surface(1,1)/norm(surface); %Unit Surface Normals 
            surface_normals(i,j,2) = surface(2,1)/norm(surface);
            surface_normals(i,j,3) = surface(3,1)/norm(surface);
            albedo_image(i,j) = norm(surface); %albedo is the magintude of surface(i,j)
        end
    end 


