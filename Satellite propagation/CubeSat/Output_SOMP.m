%-------------------------------------------------------------------------%
% Output_main: Analysis of 42's output data
%-------------------------------------------------------------------------%

%{
  Date: 14/04/2021
  Author: Iván Sermanoukian Molina
  Title: Study on orbital propagators: Constellation analysis with NASA 42 
         and Matlab/Simulink
  Director: David González Diez
%}

% Clear workspace, command window and close windows
clc
clear all
close all

% LaTeX configuration
set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');

%% Operating System selection

% Choose simulation folder
data_folder    = "data";
mission_folder_1 = "SOMP_CubeSat"; 
mission_folder_2 = "SOMP2_CubeSat"; 
mission_folder_3 = "SOMP3_CubeSat"; 
folder_1 = strcat(data_folder,filesep,mission_folder_1);
folder_2 = strcat(data_folder,filesep,mission_folder_2);
folder_3 = strcat(data_folder,filesep,mission_folder_3);

folder_pool = [folder_1];

for f = 1:1:length(folder_pool)

    folder = folder_pool(f);
    
    % Windows data path
    if ispc
        display("Windows Path");
        linux = false;
        % Add simulation paths
        addpath(strcat(pwd,filesep,folder));

    % Linux data path
    else
        display("Linux Path");
        linux = true;
        % Add simulation paths
        addpath(strcat(pwd,filesep,folder));

    end

    % Initial conditions

    Nsc = 1;

    %  Output data

    % Simulation time [s]
    sim_time(:,f) = load(strcat(folder,filesep,'time.42'),'-ascii');
    % Simulation time since J2000 [s]
    sim_time_J2000(:,f) = load(strcat(folder,filesep,'DynTime.42'),'-ascii');

    for Isc = 0:1:(Nsc-1)

        str = sprintf("u%02ld.42",Isc);
        u(:,:,Isc+1,f) = load(strcat(folder,filesep,str),'-ascii');
        str = sprintf("x%02ld.42",Isc);
        x(:,:,Isc+1,f) = load(strcat(folder,filesep,str),'-ascii');
    %     str = sprintf("uf%02ld.42",Isc);
    %     uf(:,:,Isc+1,f) = load(strcat(folder,filesep,str),'-ascii');
    %     str = sprintf("xf%02ld.42",Isc);
    %     xf(:,:,Isc+1,f) = load(strcat(folder,filesep,str),'-ascii');
    %     str = sprintf("Constraint%02ld.42",Isc);
    %     Constraint(:,:,Isc+1,f) = load(strcat(folder,filesep,str),'-ascii');

        str = sprintf("PosN%02ld.42",Isc);    
        PosN(:,:,Isc+1,f) = load(strcat(folder,filesep,str),'-ascii');
        str = sprintf("VelN%02ld.42",Isc);
        VelN(:,:,Isc+1,f) = load(strcat(folder,filesep,str),'-ascii');
        str = sprintf("PosW%02ld.42",Isc);
        PosW(:,:,Isc+1,f) = load(strcat(folder,filesep,str),'-ascii');
        str = sprintf("VelW%02ld.42",Isc);
        VelW(:,:,Isc+1,f) = load(strcat(folder,filesep,str),'-ascii');
        str = sprintf("PosR%02ld.42",Isc);
        PosR(:,:,Isc+1,f) = load(strcat(folder,filesep,str),'-ascii');
        str = sprintf("VelR%02ld.42",Isc);
        VelR(:,:,Isc+1,f) = load(strcat(folder,filesep,str),'-ascii');
        str = sprintf("qbn%02ld.42",Isc);
        qbn(:,:,Isc+1,f) = load(strcat(folder,filesep,str),'-ascii');
        str = sprintf("wbn%02ld.42",Isc);
        wbn(:,:,Isc+1,f) = load(strcat(folder,filesep,str),'-ascii');
        str = sprintf("Hvn%02ld.42",Isc);
        Hvn(:,:,Isc+1,f) = load(strcat(folder,filesep,str),'-ascii');
        str = sprintf("svn%02ld.42",Isc);
        svn(:,:,Isc+1,f) = load(strcat(folder,filesep,str),'-ascii');
        str = sprintf("svb%02ld.42",Isc);
        svb(:,:,Isc+1,f) = load(strcat(folder,filesep,str),'-ascii');
        str = sprintf("KE%02ld.42",Isc);
        KE(:,:,Isc+1,f) = load(strcat(folder,filesep,str),'-ascii');
        str = sprintf("RPY%02ld.42",Isc);
        RPY(:,:,Isc+1,f) = load(strcat(folder,filesep,str),'-ascii');
        str = sprintf("Hwhl%02ld.42",Isc);
        Hwhl(:,:,Isc+1,f) = load(strcat(folder,filesep,str),'-ascii');
        str = sprintf("MTB%02ld.42",Isc);
        MTB(:,:,Isc+1,f) = load(strcat(folder,filesep,str),'-ascii');
    %     str = sprintf("ProjArea%02ld.42",Isc);
    %     ProjArea(:,:,Isc+1,f) = load(strcat(folder,filesep,str),'-ascii');
        str = sprintf("Acc%02ld.42",Isc);
        Acc(:,:,Isc+1,f) = load(strcat(folder,filesep,str),'-ascii');
    end

end

% Study 1

position_TLE = PosN(39725,:);

position_TLE_3 = [-6621674	1772467	488916.500000000];

diff_1 = position_TLE - position_TLE_3;
diff_mod_1 = sqrt(diff_1(1).^2+diff_1(2).^2+diff_1(3).^2);

div = 1000;
plot3(PosN(39000:end,1)/div,PosN(39000:end,2)/div,PosN(39000:end,3)/div);
hold on
plot3(position_TLE(1)/div, position_TLE(2)/div, position_TLE(3)/div,'x','color','k');
plot3(position_TLE_3(1)/div, position_TLE_3(2)/div, position_TLE_3(3)/div,'x','color','r');
legend("Propagated orbit","Propagated Case 2","TLE Case 2");
% axis equal;
xlabel("ECI X [km]");
ylabel("ECI Y [km]");
zlabel("ECI Z [km]");
hold off;

% Study 2

position_TLE_2 = [-6620620	1781461	469926.100000000];
position_TLE_2_end = [-6621762	1771685	490566.100000000];

diff_2 = PosN(1,:) - position_TLE_2;
diff_mod_2 = sqrt(diff_2(1).^2+diff_2(2).^2+diff_2(3).^2);

diff_3 = position_TLE_2_end - position_TLE_3;
diff_mod_3 = sqrt(diff_3(1).^2+diff_3(2).^2+diff_3(3).^2);




