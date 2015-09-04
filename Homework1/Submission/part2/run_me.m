% CSE 473/573 Programming Assignment 1, starter Matlab code
%% Credits: Arun Mallya and Svetlana Lazebnik

% path to the folder and subfolder
root_path = 'croppedyale/';
subjects = ['01';'02';'05';'07'];
subjects = cellstr(subjects);
prefix = 'yaleB';

save_flag = 1; % whether to save output images

for i = 1:size(subjects,1);
    subject_name = strcat(prefix,subjects(i)); 
    %% load images
    full_path = sprintf('%s%s/', root_path, char(subject_name));
    [ambient_image, imarray, light_dirs] = LoadFaceImages(full_path, char(subject_name), 64);
    image_size = size(ambient_image);
    
    %% preprocess the data: 

    %% subtract ambient_image from each image in imarray

    %% make sure no pixel is less than zero

    %% rescale values in imarray to be between 0 and 1

    %% <<< fill in your preprocessing code here (if any) >>>

    for i = 1:size(imarray,3)
        imarray(:,:,i) = imarray(:,:,i) - ambient_image; % subtract ambient image from each image
         for j = 1:size(imarray,1) %rows
            for k = 1:size(imarray,2) %cols
                if imarray(j,k,i) < 0 %check for negative values
                    imarray(j,k,i) = 0;
                end
                imarray(j,k,i) = imarray(j,k,i) / 255; %rescaling the intensities between 0 and 1
            end
        end
    end
    
        
    
    %% get albedo and surface normals (you need to fill in photometric_stereo)
    [albedo_image, surface_normals] = photometric_stereo(imarray, light_dirs);


    %% reconstruct height map (you need to fill in get_surface for different integration methods)
    height_map = get_surface(surface_normals, image_size);

    %% display albedo and surface
    display_output(albedo_image, height_map);

    %% plot surface normal
    %plot_surface_normals(surface_normals);

    %% save output (optional) -- note that negative values in the normal images will not save correctly!
    if save_flag
        imwrite(albedo_image, sprintf('%s_albedo.jpg', char(subject_name)), 'jpg');
        imwrite(surface_normals, sprintf('%s_normals_color.jpg', char(subject_name)), 'jpg');
        imwrite(surface_normals(:,:,1), sprintf('%s_normals_x.jpg', char(subject_name)), 'jpg');
        imwrite(surface_normals(:,:,2), sprintf('%s_normals_y.jpg', char(subject_name)), 'jpg');
        imwrite(surface_normals(:,:,3), sprintf('%s_normals_z.jpg', char(subject_name)), 'jpg');    
    end
end
