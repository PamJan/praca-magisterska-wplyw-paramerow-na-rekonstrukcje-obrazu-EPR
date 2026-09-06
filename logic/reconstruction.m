%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% script creating reconstructed files
% for defined by user values of parameters:
% matrix size, field of view, fillter cut off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

scenario_file = 'PulseRecon.scn';
protocole_file = 'protocole.par';
[pars, definition, ini_pars] = ProcessLoadScenario(strcat(protocole_path,filesep,scenario_file), strcat(protocole_path,filesep,protocole_file));

%% setting input

raw_data_name = '260603';
arrangement = 'bot';
oxygen = 'Medium'; %Low or Medium depending on file

% input file containing acuisited EPR signal 
acquisition_name = '48341image4D_36x36_1p5gcm_MediumOxy_bot.tdms';
inputfile = strcat(raw_data_path, filesep, raw_data_name, filesep, arrangement, filesep, acquisition_name);

% cavity profile for specyfic experiment used in reconstruction
pars.fft.profile_file = strcat(raw_data_path,filesep,raw_data_name,filesep,'cavity_profile.mat');

%% specyfing value of used parameters for reconstrucion

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

% reconstruction of all optimized parameters (133 reconstructions) will
% take couple of hours

%% reconstrucion loop
for matrix_size = matrix_size_start:matrix_size_step:matrix_size_end
    for FOV = FOV_start:FOV_step:FOV_end
        for cutoff = cutoff_start:cutoff_step:cutoff_end

            % setting parameters for recontruction
            pars.rec.Sub_points = matrix_size;
            pars.rec.Size = FOV;
            pars.rec.FilterCutOff = cutoff;
            file_name = strcat('Matrix-', string(matrix_size),'_FOV-', string(10*FOV_start),'_CutOff-0', string(10*cutoff),'_',arrangement,'_',oxygen);
            file_path = strcat(reconstructed, filesep, raw_data_name, filesep, arrangement, filesep, oxygen);
            
            % function from eprit that perform and save reconstruction
            ese_fbp_InvRec(inputfile, file_name, file_path, pars);
        end
    end
end




