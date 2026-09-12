%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% script for compering reference
% with binarized reconstructed files
% using Dice coefficient and Hausdorff distance
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% setting input

% reference mask created by reference.m
reference_mask = load(strcat(phantom,filesep,'phantom_3_256_v.mat')).Matrix;

% tables with Dice, Hausdorf and sum of voxels values
Dice_table = ["Matrix_size" "FOV" "CutOff" "Dice" ];
Hausdorf_table = ["Matrix_size" "FOV" "CutOff" "HH" "HD95"];
Sum_table = ["Matrix_size" "FOV" "CutOff" "Voxel_sum"];


raw_data_name = '260603';
arrangement = 'bot';
oxygen = 'Medium'; %Low or Medium depending on file

% binarysed file was created by ibGUI functions and PyMacroRecord macro
% binarysed file is defined by parameters used for its creation
file_name = 'pMatrix-%d_FOV-%d_CutOff-0%d_%s_%s.mat';

%% specyfing value of used parameters for compered files

% parameter: mastrix size
matrix_size_start = 32;
matrix_size_step = 16;
matrix_size_end = 64;

% parameter: field of view
FOV_start = 3.5;
FOV_step = 0.5;
FOV_end = 5;

% parameter: fillter cut off
cutoff_start = 0;
cutoff_step = 0.1;
cutoff_end = 1;

%% compering loop
for matrix_size = matrix_size_start:matrix_size_step:matrix_size_end
    for FOV = FOV_start:FOV_step:FOV_end
        for cutoff = cutoff_start:cutoff_step:cutoff_end
            % loading binarised file
            rec_mask = load(strcat(binarized, filesep, raw_data_name, filesep, arrangement, filesep, oxygen, filesep, sprintf(file_name,matrix_size,round(10*FOV),round(10*cutoff), arrangement, oxygen))).Mask;
            
            % resizing file to proper size and FOV
            rec_mask = resize_matrix(rec_mask,10*FOV);

            % calculation of the Dice coefficient
            dice_value = dice(rec_mask,reference_mask);

            % calculation of the Hausforff distance and 95 percentile
            [HH, HD95] = hausdorff_distance_3D(reference_mask, rec_mask);

            %calculating sum of all voxels in image
            voxel_sum = sum(rec_mask(:));
            
            % saving values
            Dice_table = [Dice_table; matrix_size, FOV, cutoff, dice_value];
            Hausdorf_table = [Hausdorf_table; matrix_size, FOV, cutoff, HH, HD95];
            Sum_table = [Sum_table; matrix_size, FOV, cutoff, voxel_sum];

        end
    end
end
