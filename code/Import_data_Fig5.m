%% Import data from text file.
% Script for importing data from the following text file:
%

%% detect code path
code_path   = fileparts(mfilename('fullpath'));
csv_path    = sprintf('%s/../tidy_data', code_path);

%% Initialize variables.
filename = sprintf('%s/BAT_values_PET_pos_CA_v_TN.csv',csv_path);
delimiter = ',';
startRow = 2;

%% Read columns of data as strings:
% For more information, see the TEXTSCAN documentation.
formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Convert the contents of columns containing numeric strings to numbers.
% Replace non-numeric strings with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

for col=[1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36]
    % Converts strings in the input cell array to numbers. Replaced non-numeric
    % strings with NaN.
    rawData = dataArray{col};
    for row=1:size(rawData, 1);
        % Create a regular expression to detect and remove non-numeric prefixes and
        % suffixes.
        regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
        try
            result = regexp(rawData{row}, regexstr, 'names');
            numbers = result.numbers;
            
            % Detected commas in non-thousand locations.
            invalidThousandsSeparator = false;
            if any(numbers==',');
                thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
                if isempty(regexp(thousandsRegExp, ',', 'once'));
                    numbers = NaN;
                    invalidThousandsSeparator = true;
                end
            end
            % Convert numeric strings to numbers.
            if ~invalidThousandsSeparator;
                numbers = textscan(strrep(numbers, ',', ''), '%f');
                numericData(row, col) = numbers{1};
                raw{row, col} = numbers{1};
            end
        catch me
        end
    end
end

%% Split data into numeric and cell columns.
rawNumericColumns = raw(:, [1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36]);
rawCellColumns = raw(:, 2);


%% Allocate imported array to column variable names
Subject = cell2mat(rawNumericColumns(:, 1));
Sex = rawCellColumns(:, 1);
BMI = cell2mat(rawNumericColumns(:, 2));
NumVoxels = cell2mat(rawNumericColumns(:, 3));
TN_CT_Mean = cell2mat(rawNumericColumns(:, 4));
TN_CT_Stdv = cell2mat(rawNumericColumns(:, 5));
TN_CT_Max = cell2mat(rawNumericColumns(:, 6));
TN_CT_Min = cell2mat(rawNumericColumns(:, 7));
TN_PET_Mean = cell2mat(rawNumericColumns(:, 8));
TN_PET_Stdv = cell2mat(rawNumericColumns(:, 9));
TN_PET_Max = cell2mat(rawNumericColumns(:, 10));
TN_PET_Min = cell2mat(rawNumericColumns(:, 11));
TN_FSF_Mean = cell2mat(rawNumericColumns(:, 12));
TN_FSF_Stdv = cell2mat(rawNumericColumns(:, 13));
TN_FSF_Max = cell2mat(rawNumericColumns(:, 14));
TN_FSF_Min = cell2mat(rawNumericColumns(:, 15));
TN_R2s_Mean = cell2mat(rawNumericColumns(:, 16));
TN_R2s_Stdv = cell2mat(rawNumericColumns(:, 17));
TN_R2s_Max = cell2mat(rawNumericColumns(:, 18));
TN_R2s_Min = cell2mat(rawNumericColumns(:, 19));
CA_CT_Mean = cell2mat(rawNumericColumns(:, 20));
CA_CT_Stdv = cell2mat(rawNumericColumns(:, 21));
CA_CT_Max = cell2mat(rawNumericColumns(:, 22));
CA_CT_Min = cell2mat(rawNumericColumns(:, 23));
CA_PET_Mean = cell2mat(rawNumericColumns(:, 24));
CA_PET_Stdv = cell2mat(rawNumericColumns(:, 25));
CA_PET_Max = cell2mat(rawNumericColumns(:, 26));
CA_PET_Min = cell2mat(rawNumericColumns(:, 27));
CA_FSF_Mean = cell2mat(rawNumericColumns(:, 28));
CA_FSF_Stdv = cell2mat(rawNumericColumns(:, 29));
CA_FSF_Max = cell2mat(rawNumericColumns(:, 30));
CA_FSF_Min = cell2mat(rawNumericColumns(:, 31));
CA_R2s_Mean = cell2mat(rawNumericColumns(:, 32));
CA_R2s_Stdv = cell2mat(rawNumericColumns(:, 33));
CA_R2s_Max = cell2mat(rawNumericColumns(:, 34));
CA_R2s_Min = cell2mat(rawNumericColumns(:, 35));

%% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans raw col numericData rawData row regexstr result numbers invalidThousandsSeparator thousandsRegExp me rawNumericColumns rawCellColumns;

%% Import data from text file.
% Script for importing data from the following text file:
%

%% Initialize variables.
filename = sprintf('%s/BAT_values_PET_pos_CA_v_TN_LowBMI.csv',csv_path);
delimiter = ',';
startRow = 2;

%% Read columns of data as strings:
% For more information, see the TEXTSCAN documentation.
formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Convert the contents of columns containing numeric strings to numbers.
% Replace non-numeric strings with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

for col=[1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36]
    % Converts strings in the input cell array to numbers. Replaced non-numeric
    % strings with NaN.
    rawData = dataArray{col};
    for row=1:size(rawData, 1);
        % Create a regular expression to detect and remove non-numeric prefixes and
        % suffixes.
        regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
        try
            result = regexp(rawData{row}, regexstr, 'names');
            numbers = result.numbers;
            
            % Detected commas in non-thousand locations.
            invalidThousandsSeparator = false;
            if any(numbers==',');
                thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
                if isempty(regexp(thousandsRegExp, ',', 'once'));
                    numbers = NaN;
                    invalidThousandsSeparator = true;
                end
            end
            % Convert numeric strings to numbers.
            if ~invalidThousandsSeparator;
                numbers = textscan(strrep(numbers, ',', ''), '%f');
                numericData(row, col) = numbers{1};
                raw{row, col} = numbers{1};
            end
        catch me
        end
    end
end

%% Split data into numeric and cell columns.
rawNumericColumns = raw(:, [1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36]);
rawCellColumns = raw(:, 2);


%% Allocate imported array to column variable names
Subject_lowB = cell2mat(rawNumericColumns(:, 1));
Sex_lowB = rawCellColumns(:, 1);
BMI_lowB = cell2mat(rawNumericColumns(:, 2));
NumVoxels_lowB = cell2mat(rawNumericColumns(:, 3));
TN_CT_Mean_lowB = cell2mat(rawNumericColumns(:, 4));
TN_CT_Stdv_lowB = cell2mat(rawNumericColumns(:, 5));
TN_CT_Max_lowB = cell2mat(rawNumericColumns(:, 6));
TN_CT_Min_lowB = cell2mat(rawNumericColumns(:, 7));
TN_PET_Mean_lowB = cell2mat(rawNumericColumns(:, 8));
TN_PET_Stdv_lowB = cell2mat(rawNumericColumns(:, 9));
TN_PET_Max_lowB = cell2mat(rawNumericColumns(:, 10));
TN_PET_Min_lowB = cell2mat(rawNumericColumns(:, 11));
TN_FSF_Mean_lowB = cell2mat(rawNumericColumns(:, 12));
TN_FSF_Stdv_lowB = cell2mat(rawNumericColumns(:, 13));
TN_FSF_Max_lowB = cell2mat(rawNumericColumns(:, 14));
TN_FSF_Min_lowB = cell2mat(rawNumericColumns(:, 15));
TN_R2s_Mean_lowB = cell2mat(rawNumericColumns(:, 16));
TN_R2s_Stdv_lowB = cell2mat(rawNumericColumns(:, 17));
TN_R2s_Max_lowB = cell2mat(rawNumericColumns(:, 18));
TN_R2s_Min_lowB = cell2mat(rawNumericColumns(:, 19));
CA_CT_Mean_lowB = cell2mat(rawNumericColumns(:, 20));
CA_CT_Stdv_lowB = cell2mat(rawNumericColumns(:, 21));
CA_CT_Max_lowB = cell2mat(rawNumericColumns(:, 22));
CA_CT_Min_lowB = cell2mat(rawNumericColumns(:, 23));
CA_PET_Mean_lowB = cell2mat(rawNumericColumns(:, 24));
CA_PET_Stdv_lowB = cell2mat(rawNumericColumns(:, 25));
CA_PET_Max_lowB = cell2mat(rawNumericColumns(:, 26));
CA_PET_Min_lowB = cell2mat(rawNumericColumns(:, 27));
CA_FSF_Mean_lowB = cell2mat(rawNumericColumns(:, 28));
CA_FSF_Stdv_lowB = cell2mat(rawNumericColumns(:, 29));
CA_FSF_Max_lowB = cell2mat(rawNumericColumns(:, 30));
CA_FSF_Min_lowB = cell2mat(rawNumericColumns(:, 31));
CA_R2s_Mean_lowB = cell2mat(rawNumericColumns(:, 32));
CA_R2s_Stdv_lowB = cell2mat(rawNumericColumns(:, 33));
CA_R2s_Max_lowB = cell2mat(rawNumericColumns(:, 34));
CA_R2s_Min_lowB = cell2mat(rawNumericColumns(:, 35));

%% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans raw col numericData rawData row regexstr result numbers invalidThousandsSeparator thousandsRegExp me rawNumericColumns rawCellColumns;

%% Import data from text file.
% Script for importing data from the following text file:
%

%% Initialize variables.
filename = sprintf('%s/BAT_values_PET_pos_CA_v_TN_HighBMI.csv',csv_path);
delimiter = ',';
startRow = 2;

%% Read columns of data as strings:
% For more information, see the TEXTSCAN documentation.
formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Convert the contents of columns containing numeric strings to numbers.
% Replace non-numeric strings with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

for col=[1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36]
    % Converts strings in the input cell array to numbers. Replaced non-numeric
    % strings with NaN.
    rawData = dataArray{col};
    for row=1:size(rawData, 1);
        % Create a regular expression to detect and remove non-numeric prefixes and
        % suffixes.
        regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
        try
            result = regexp(rawData{row}, regexstr, 'names');
            numbers = result.numbers;
            
            % Detected commas in non-thousand locations.
            invalidThousandsSeparator = false;
            if any(numbers==',');
                thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
                if isempty(regexp(thousandsRegExp, ',', 'once'));
                    numbers = NaN;
                    invalidThousandsSeparator = true;
                end
            end
            % Convert numeric strings to numbers.
            if ~invalidThousandsSeparator;
                numbers = textscan(strrep(numbers, ',', ''), '%f');
                numericData(row, col) = numbers{1};
                raw{row, col} = numbers{1};
            end
        catch me
        end
    end
end

%% Split data into numeric and cell columns.
rawNumericColumns = raw(:, [1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36]);
rawCellColumns = raw(:, 2);


%% Allocate imported array to column variable names
Subject_highB = cell2mat(rawNumericColumns(:, 1));
Sex_highB = rawCellColumns(:, 1);
BMI_highB = cell2mat(rawNumericColumns(:, 2));
NumVoxels_highB = cell2mat(rawNumericColumns(:, 3));
TN_CT_Mean_highB = cell2mat(rawNumericColumns(:, 4));
TN_CT_Stdv_highB = cell2mat(rawNumericColumns(:, 5));
TN_CT_Max_highB = cell2mat(rawNumericColumns(:, 6));
TN_CT_Min_highB = cell2mat(rawNumericColumns(:, 7));
TN_PET_Mean_highB = cell2mat(rawNumericColumns(:, 8));
TN_PET_Stdv_highB = cell2mat(rawNumericColumns(:, 9));
TN_PET_Max_highB = cell2mat(rawNumericColumns(:, 10));
TN_PET_Min_highB = cell2mat(rawNumericColumns(:, 11));
TN_FSF_Mean_highB = cell2mat(rawNumericColumns(:, 12));
TN_FSF_Stdv_highB = cell2mat(rawNumericColumns(:, 13));
TN_FSF_Max_highB = cell2mat(rawNumericColumns(:, 14));
TN_FSF_Min_highB = cell2mat(rawNumericColumns(:, 15));
TN_R2s_Mean_highB = cell2mat(rawNumericColumns(:, 16));
TN_R2s_Stdv_highB = cell2mat(rawNumericColumns(:, 17));
TN_R2s_Max_highB = cell2mat(rawNumericColumns(:, 18));
TN_R2s_Min_highB = cell2mat(rawNumericColumns(:, 19));
CA_CT_Mean_highB = cell2mat(rawNumericColumns(:, 20));
CA_CT_Stdv_highB = cell2mat(rawNumericColumns(:, 21));
CA_CT_Max_highB = cell2mat(rawNumericColumns(:, 22));
CA_CT_Min_highB = cell2mat(rawNumericColumns(:, 23));
CA_PET_Mean_highB = cell2mat(rawNumericColumns(:, 24));
CA_PET_Stdv_highB = cell2mat(rawNumericColumns(:, 25));
CA_PET_Max_highB = cell2mat(rawNumericColumns(:, 26));
CA_PET_Min_highB = cell2mat(rawNumericColumns(:, 27));
CA_FSF_Mean_highB = cell2mat(rawNumericColumns(:, 28));
CA_FSF_Stdv_highB = cell2mat(rawNumericColumns(:, 29));
CA_FSF_Max_highB = cell2mat(rawNumericColumns(:, 30));
CA_FSF_Min_highB = cell2mat(rawNumericColumns(:, 31));
CA_R2s_Mean_highB = cell2mat(rawNumericColumns(:, 32));
CA_R2s_Stdv_highB = cell2mat(rawNumericColumns(:, 33));
CA_R2s_Max_highB = cell2mat(rawNumericColumns(:, 34));
CA_R2s_Min_highB = cell2mat(rawNumericColumns(:, 35));

%% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans raw col numericData rawData row regexstr result numbers invalidThousandsSeparator thousandsRegExp me rawNumericColumns rawCellColumns;

