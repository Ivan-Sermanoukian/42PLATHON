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
mission_folder = "ISSdata"; 
folder = strcat(data_folder,filesep,mission_folder);

% Windows data path
if ispc
    display("Windows Path");
    linux = false;
    % Add simulation paths
    addpath(strcat(pwd,filesep,folder));
    addpath(genpath(strcat(pwd,filesep,'Output_results')));

% Linux data path
else
    display("Linux Path");
    linux = true;
    % Add simulation paths
    addpath(strcat(pwd,filesep,folder));
    addpath(genpath(strcat(pwd,filesep,'Output_results')));
    
end

%% Initial conditions

Nsc = 1;

%% Output data

% Simulation time [s]
sim_time = load(strcat(folder,filesep,'time.42'),'-ascii');
% Simulation time since J2000 [s]
sim_time_J2000 = load(strcat(folder,filesep,'DynTime.42'),'-ascii');

for Isc = 0:1:(Nsc-1)
    
    str = sprintf("u%02ld.42",Isc);
    u(:,:,Isc+1) = load(strcat(folder,filesep,str),'-ascii');
    str = sprintf("x%02ld.42",Isc);
    x(:,:,Isc+1) = load(strcat(folder,filesep,str),'-ascii');
%     str = sprintf("uf%02ld.42",Isc);
%     uf(:,:,Isc+1) = load(strcat(folder,filesep,str),'-ascii');
%     str = sprintf("xf%02ld.42",Isc);
%     xf(:,:,Isc+1) = load(strcat(folder,filesep,str),'-ascii');
%     str = sprintf("Constraint%02ld.42",Isc);
%     Constraint(:,:,Isc+1) = load(strcat(folder,filesep,str),'-ascii');
    
    str = sprintf("PosN%02ld.42",Isc);    
    PosN(:,:,Isc+1) = load(strcat(folder,filesep,str),'-ascii');
    str = sprintf("VelN%02ld.42",Isc);
    VelN(:,:,Isc+1) = load(strcat(folder,filesep,str),'-ascii');
    str = sprintf("PosW%02ld.42",Isc);
    PosW(:,:,Isc+1) = load(strcat(folder,filesep,str),'-ascii');
    str = sprintf("VelW%02ld.42",Isc);
    VelW(:,:,Isc+1) = load(strcat(folder,filesep,str),'-ascii');
    str = sprintf("PosR%02ld.42",Isc);
    PosR(:,:,Isc+1) = load(strcat(folder,filesep,str),'-ascii');
    str = sprintf("VelR%02ld.42",Isc);
    VelR(:,:,Isc+1) = load(strcat(folder,filesep,str),'-ascii');
    str = sprintf("qbn%02ld.42",Isc);
    qbn(:,:,Isc+1) = load(strcat(folder,filesep,str),'-ascii');
    str = sprintf("wbn%02ld.42",Isc);
    wbn(:,:,Isc+1) = load(strcat(folder,filesep,str),'-ascii');
    str = sprintf("Hvn%02ld.42",Isc);
    Hvn(:,:,Isc+1) = load(strcat(folder,filesep,str),'-ascii');
    str = sprintf("svn%02ld.42",Isc);
    svn(:,:,Isc+1) = load(strcat(folder,filesep,str),'-ascii');
    str = sprintf("svb%02ld.42",Isc);
    svb(:,:,Isc+1) = load(strcat(folder,filesep,str),'-ascii');
    str = sprintf("KE%02ld.42",Isc);
    KE(:,:,Isc+1) = load(strcat(folder,filesep,str),'-ascii');
    str = sprintf("RPY%02ld.42",Isc);
    RPY(:,:,Isc+1) = load(strcat(folder,filesep,str),'-ascii');
    str = sprintf("Hwhl%02ld.42",Isc);
    Hwhl(:,:,Isc+1) = load(strcat(folder,filesep,str),'-ascii');
    str = sprintf("MTB%02ld.42",Isc);
    MTB(:,:,Isc+1) = load(strcat(folder,filesep,str),'-ascii');
%     str = sprintf("ProjArea%02ld.42",Isc);
%     ProjArea(:,:,Isc+1) = load(strcat(folder,filesep,str),'-ascii');
    str = sprintf("Acc%02ld.42",Isc);
    Acc(:,:,Isc+1) = load(strcat(folder,filesep,str),'-ascii');
end

data42 = [PosN(1:(end-1),1)/1000,PosN(1:(end-1),2)/1000,PosN(1:(end-1),3)/1000]';
load("spice.mat");
dataSPICE = [dearth(1,:);dearth(2,:);dearth(3,:)];

diff = data42 - dataSPICE;

plot(sim_time(1:(end-1)),diff)
hold on

for i_step = 1:length(dearth(1,:))
    norm(i_step) = sqrt(diff(1,i_step).^2 + diff(2,i_step).^2 + diff(3,i_step).^2);
end
plot(sim_time(1:(end-1)),norm)

xlabel("Time [s]");
ylabel("Distance between bodies [km]");
legend("distance X","distance Y","distance Z","Total distance",'Location','northwest')















