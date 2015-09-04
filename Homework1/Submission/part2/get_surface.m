function  height_map = get_surface(surface_normals, image_size)
% surface_normals: h x w x 3 array of unit surface normals
% image_size: [h, w] of output height map/image
% height_map: height map of object of dimensions [h, w]
%% <<< fill in your code below >>> 

height_map1 = zeros(image_size); %for the first integral
height_map2 = zeros(image_size);% for second integral
height_map = zeros(image_size);%averaged integral

p = zeros(image_size);
q = zeros(image_size);
%Calculating p and q(values for the partial derivatives of the surface)
for j = 1:image_size(1)
    for k = 1:image_size(2)
        p(j,k) = surface_normals(j,k,1)/surface_normals(j,k,3);
        q(j,k) = surface_normals(j,k,2)/surface_normals(j,k,3);
    end
end

%First Integral - fill the left most column and then fill all rows
%Top left corner of the height map is zero
%For each pixel in the left column of the height map
for i = 2:size(height_map,1)
    height_map1(i,1) = height_map1(i-1,1) + q(i,1);
end

%For each row
for m = 1:size(height_map,1)
    for n = 2:size(height_map,2) % For each element in the row
        height_map1(m,n) = height_map1(m,n-1) + p(m,n);
    end
end

%Second Integral - Fill the top row and then fill all the columns
%Top left corner of the height map is zero
%For each pixel in the top row of the height map
for i = 2:size(height_map,2)
    height_map2(1,i) = height_map2(1,i-1) + p(1,i);
end

%For each column
for m = 1:size(height_map,2)
    for n = 2:size(height_map,1) % For each element in the column
        height_map2(n,m) = height_map2(n-1,m) + q(n,m);
    end
end

% Averaging the calculated integrals
height_map = (height_map1 + height_map2)/2;

