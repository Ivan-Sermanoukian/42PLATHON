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
mission_folder = "ISS_NASA_OEM"; 
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

div = 1000;

data42 = [PosN(:,1)/div,PosN(:,2)/div,PosN(:,3)/div]';

NASA_OEM = readmatrix('ISS1.txt');

X(1,:) = NASA_OEM(:,2);
X(2,:) = NASA_OEM(:,3);
X(3,:) = NASA_OEM(:,4);

V(1,:) = NASA_OEM(:,5);
V(2,:) = NASA_OEM(:,6);
V(3,:) = NASA_OEM(:,7);

data_NASA_OEM = X(:,1:length(PosN(:,1)));

difference = abs(data42 - data_NASA_OEM);
total_difference = sum(difference)

time_div = 60;

plot(sim_time/time_div,difference,sim_time/time_div,total_difference)

xlabel("Time [min]");
ylabel("Distance between bodies [km]");
legend("distance X","distance Y","distance Z","Total distance",'Location','northwest')















