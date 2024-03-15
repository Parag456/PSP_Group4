clc
clear all;
% Define the regions and their corresponding frequencies
hz50_regions = {'Hokkaido', 'Tohoku', 'Tokyo'};
hz60_regions = {'Chubu', 'Kansai', 'Chugoku', 'Shikoku', 'Kyushu'};

% Initialize variables to store combined generation data
combined_solar_50hz = zeros(8760, 1);
combined_wind_50hz = zeros(8760, 1);
combined_solar_60hz = zeros(8760, 1);
combined_wind_60hz = zeros(8760, 1);

% Loop through each region and combine generation data
for i = 1:length(hz50_regions)
    region = hz50_regions{i};
    filename = [region ' DEMAND.csv'];
    data = readmatrix(filename, 'Range', 'H3:I8762'); % Read data, starting from row 3
    combined_solar_50hz = combined_solar_50hz + data(:, 1); % Add solar data
    combined_wind_50hz = combined_wind_50hz + data(:, 2); % Add wind data
end

for i = 1:length(hz60_regions)
    region = hz60_regions{i};
    filename = [region ' DEMAND.csv'];
    data = readmatrix(filename, 'Range', 'H3:I8762'); % Read data, starting from row 3
    combined_solar_60hz = combined_solar_60hz + data(:, 1); % Add solar data
    combined_wind_60hz = combined_wind_60hz + data(:, 2); % Add wind data
end

% Define headers for the CSV file
headers = {'Solar_50Hz', 'Wind_50Hz', 'Solar_60Hz', 'Wind_60Hz'};

% Export combined data to a new CSV file
combined_data = [combined_solar_50hz, combined_wind_50hz, combined_solar_60hz, combined_wind_60hz];

% Combine headers with data
combined_data_with_headers = [headers; num2cell(combined_data)];

writecell(combined_data_with_headers, 'combined_generation_data.csv');
