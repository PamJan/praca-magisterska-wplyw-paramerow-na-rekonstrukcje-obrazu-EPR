%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   script for converting input_stl
%   into logical matrix phantom_file.Matrix
%   with defined size
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% input stl file
input_stl = 'reference_3_v.stl';

% function from Mesh_voxelisation liblary used to read stl file
[stlFV, stlInfo] = READ_stl(strcat(phantom,filesep,input_stl));

% size of the reference matrix
size = 256;

[Matrix, X, Y, Z] = VOXELISE(size, size, size, stlFV, 'xyz');

Matrix = logical(Matrix);

%% erasing 8 squares in conrers

Matrix(1:12,     1:12,     1:12)     = 0;
Matrix(245:256,  1:12,     1:12)     = 0;
Matrix(1:12,     245:256,  1:12)     = 0;
Matrix(245:256,  245:256, 1:12)      = 0;

Matrix(1:12,     1:12,     245:256)  = 0;
Matrix(245:256,  1:12,     245:256)  = 0;
Matrix(1:12,     245:256,  245:256)  = 0;
Matrix(245:256,  245:256, 245:256)   = 0;

%% rotation to the same orientation as reconstructed files
Matrix = permute(Matrix, [1 3 2]);
Matrix = flip(Matrix, 3);

phantom_file = 'phantom_3_';
save(strcat(phantom, filesep, phantom_file, num2str(size),'_v.mat'),'Matrix');


