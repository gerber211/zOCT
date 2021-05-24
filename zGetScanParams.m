function scanParams = zGetScanParams(filename)
% ZGETSCANPARAMS Gets scan parameters from .txt saved by Zeiss iOCT; output
%                is a 14 x 2 cell array
%
% EXAMPLE USAGE
% filename = 'full\path\to\file\filename.txt';
% scanParams = zGetScanParams(filename)
% 
% HISTORY
% 2021-05-24 Initial version - MJG 

% get acq data
fid = fopen(filename);

% hardcoded; this isn't expected to change
numLines = 14;

% preallocate
scanParams = cell(numLines, 2);

% loop through each line 
for ii = 1:numLines
  
    % read a single line
    aline = fgetl(fid);
    
    % split the line by the : delimiter
    ab = strsplit(aline, ': ');
    
    % add data from this line to scanParams 
    scanParams{ii,1} = ab{1};
    scanParams{ii,2} = ab{2};

end

% close the file handle
fclose(fid);

end