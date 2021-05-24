% 2021-05-24 MJG 
% playing with first data acquired by Zeiss iOCT 

% build path to .txt file
DDIR = 'F:\2021-05-20 Zeiss iOCT First Data\2021_5_20-21_28_57_bf39012e-964e-44bf-b4f2-4ef1275b085d\';
filename = 'Frame_0_1402.txt';
filename = [DDIR filename];

% get scan Params
scanParams = zGetScanParams(filename);

% dimensions of B-scan in [px]
dimXZ = [str2double(scanParams{2,2}) str2double(scanParams{3,2})];

% path to .raw data --- note, this is pretty dangerous to do... 
filename = strrep(filename, 'txt', 'raw');

% get raw data...
rawData = zGetRawData(filename, dimXZ);

% plot to see      
figure(1); clf;
imagesc(rawData);

% scale to [0,1] and plot
rawData = unorm(rawData);
figure(2); clf; imshow(rawData); 




