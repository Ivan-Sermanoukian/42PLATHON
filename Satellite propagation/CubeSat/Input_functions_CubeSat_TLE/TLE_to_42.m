function [sat_id] = TLE_to_42(folder)

% TLE Example

% ISS (ZARYA)
% 1 25544U 98067A   08264.51782528 -.00002182  00000-0 -11606-4 0  2927
% 2 25544  51.6416 247.4627 0006703 130.5360 325.0288 15.72125391563537

Option = 2;

if (Option == 1)
    url = 'https://www.celestrak.com/NORAD/elements/cubesat.txt';
    data_IRIDIUM_NEXT = webread(url);
    data = splitlines(data_IRIDIUM_NEXT);

elseif (Option == 2)
    FILENAME = 'SOMPdata2.txt';
    file_data = fileread(FILENAME);
    data = splitlines(file_data);
end
name = "SOMPdata2";
name_txt = strcat(name,".txt");
directory = strcat(folder,filesep,name_txt);
% directory = strcat(name_txt);
writecell(data,directory)

% sat_id = strings(1,(length(data)-1)/3);
% epoch(1) = data() 

for i = 1:1:((length(data))/3)
    sat_id(i) = deblank(string(data(3*i-2)));
end
end