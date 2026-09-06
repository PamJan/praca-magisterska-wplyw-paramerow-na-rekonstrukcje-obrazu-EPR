path = ''; % path of the programe

logic_path = strcat(path, filesep, 'logic');
protocole_path = strcat(path, filesep, 'protocole');
raw_data_path = strcat(path, filesep, 'data', filesep, 'raw_data');
reconstructed = strcat(path, filesep, 'data', filesep, 'reconstructed');
binarized = strcat(path,filesep,'data',filesep,'binarized');
phantom = strcat(path,filesep,'phantom');

addpath(path)
% addpath() %path of Mesh_Mesh_voxelisation% (https://www.mathworks.com/matlabcentral/fileexchange/27390-mesh-voxelisation)