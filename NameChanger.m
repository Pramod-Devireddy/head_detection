% allfiles = dir('E:\background\False Images');

symbols = ['a':'z' 'A':'Z' '0':'9'];
MAX_ST_LENGTH = 6;

files = dir('E:\background\False Images');

for i = 1:length(files)-2
    % Get the file name (minus the extension)
    [~, f] = fileparts(files(i+2).name);
      % Convert to number
%     num = str2double(f);
    stLength = randi(MAX_ST_LENGTH);
    nums = randi(numel(symbols),[1 stLength]);
    st = symbols (nums);
    newname = strcat(st,'.jpg');
%       if ~isnan(nums)
          % If numeric, rename
          movefile(files(i+2).name, newname);
%       end
end