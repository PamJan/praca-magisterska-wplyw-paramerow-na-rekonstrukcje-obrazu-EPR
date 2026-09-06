function matrix_c = resize_matrix(matrix, FOV)    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function for resizing logical binarised 
% 3D matrix with specific FOV
% to the specific resolution of voxel:
% 35/256 - voxel size of reference
%
% Inputs:
% matrix = 3D logical  binarized matrix from image reconstruction
% FOV = field of view used for reconstruction of matrix
%
% Output:
% matrix_c = resized 3D matrix with resolution and size of the reference
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % physical resolution of the voxels
    voxel_reference = 35 / 256; 
    voxel_matrix = FOV / size(matrix,1);
    
    scale = voxel_matrix / voxel_reference;
    
    % reseizing to coressponding scale (the same resolution for reference and matrix)
    matrix_rs = imresize3(matrix, scale, 'nearest');
    
    % finading center of the matrix
    c = floor(size(matrix_rs)/2) + 1;
    
    % finding how much to crop (to the size of reference 256x256x256)  
    start = c - floor([256 256 256]/2);
    stop  = start + [256 256 256] - 1;
    
    % croping the resized matrix
    matrix_c = matrix_rs(start(1):stop(1), start(2):stop(2), start(3):stop(3));
    
end
