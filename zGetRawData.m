function rawData = zGetRawData(filename, dimXZ)
% ZGETRAWDATA Gets raw data from .raw saved by Zeiss iOCT; output is a
% dimXZ(2) x dimXZ(1) matrix of uint8 pixel intensities
%
% INPUT dimXZ is a 1 x 2 matrix of pixel dimensions of the B-scan
% This can come from:
%   scanParams = zGetScanParams(filename);
%   dimXZ = [str2double(scanParams{2,2}) str2double(scanParams{3,2})];
%
% EXAMPLE USAGE
% filename = 'full\path\to\file\filename.raw';
% rawData = zGetRawData(filename, dimXZ)
% 
% HISTORY
% 2021-05-24 Initial version - MJG 

% Get file reference
fid = fopen(filename);

% Read in data
rawData = fread(fid, prod(dimXZ)*4, 'uint8'); 

% close file reference
fclose(fid);

% reshape into matrix
rawData = reshape(rawData, dimXZ);
      
% need to rotate/flip image 
rawData = flip(rawData);
rawData = rot90(rawData,3);

end

