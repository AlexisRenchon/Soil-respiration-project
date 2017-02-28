% Alexis Script, load EucFACE soil respiration data in a tall array
% Created 28/02/2017

% Load a big datasets, stored in a Tall Array
% Datastores enable you to work with large data sets in small chunks that individually fit in memory,
% instead of loading the entire data set into memory at once.

ds = datastore('\\ad.uws.edu.au\dfshare\HomesHWK$\90929058\My Documents\GitHub\Soil Respiration Project\Input EucFACE\Rsoil_env_AR.csv');
ds.MissingValue = -9999; % Specify that -9999 is NaN
ds.SelectedVariableNames = {'Rsoil','Tsoil'}; % following lines of code will just read these 2 variables

% Initiate
Size_d = 0;
R_vs_T = figure; hold on;
while hasdata(ds) % Read the data by chunk of 20 000 row while there is still data
    Data = read(ds);
    Size_d = Size_d + length(Data.Tsoil);
    scatter(Data.Tsoil,Data.Rsoil,'k');
end
reset(ds); % Reset to the first row of data
clearvars Size_d R_vs_T Data; % Clear those variables