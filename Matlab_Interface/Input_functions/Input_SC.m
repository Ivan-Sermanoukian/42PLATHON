function [spacecraft] = Input_SC(folder,number_spacecraft)    

    for on_off = 1:1:str2double(number_spacecraft)     
        spacecraft(on_off,1) = "TRUE";
        spacecraft(on_off,2) = (on_off - 1);
        spacecraft(on_off,3) = "SC_Cubesat1U.txt";
    end
    
    source = strcat(pwd,filesep,"Templates",filesep,"SC_Cubesat1U.txt");
    destiny = strcat(folder);
    copyfile(source, destiny, 'f')
    
end