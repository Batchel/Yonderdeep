%% Yonder Deep Revised Buoyancy Calculations

clear all;
close all;
clc;

%% Read Input File
infile = 'Center of Mass Tracker.xlsx';
insheet = readcell(infile, 'Sheet', 3);

%% Constants

g = 9.81; %m/s^2
rhofreshwater = 997; %kg/m^3
rhosaltwater = 1027; %kg/m^3

%% AUV Weight and Volume
%weight measured in newtons
%volume measured in meters^3

%Front 
WfrontNoseCone = cell2mat(insheet(2,3)); %N 
WfrontHullMotor= cell2mat(insheet(6,3)); %N
Wmotor = 2*cell2mat(insheet(4,3));%N
WfrontEndCap = cell2mat(insheet(7,3));%N
Wmotorcap = cell2mat(insheet(3,3)); %N

Wfront = WfrontNoseCone + WfrontHullMotor + Wmotor + WfrontEndCap + Wmotorcap; %N

Vfrontnose = cell2mat(insheet(2,4)); %m^3
Vfronthullmotor = cell2mat(insheet(6,4)); %m^3

Vfront = Vfrontnose + Vfronthullmotor; %m^3

%Body
Wbodytube= cell2mat(insheet(8,3)); %N  
batterypack = 4*cell2mat(insheet(9,3)); %N
raspberrypi = 0; %negligible 
Welectronicsbed = cell2mat(insheet(15,3)); %N
Wbedside1 = cell2mat(insheet(16,3));%N
Wbedside2 = cell2mat(insheet(17,3));%N
Wbatterymount = cell2mat(insheet(18,3)); %N
Wbatterymountalt = cell2mat(insheet(13,3)); %N
Wrail = cell2mat(insheet(25,3)); %N
WacrylicCap = cell2mat(insheet(24,3));%N
Waudiointerface = cell2mat(insheet(27,3)); %N

Wbody = Wbodytube + batterypack + raspberrypi + Welectronicsbed + Wbedside1 + Wbedside2 + 2*Wbatterymountalt + Wbatterymount + 4*Wrail + 2*WacrylicCap + Waudiointerface; %N
 
%calculating volume of acryllic tube via cylinder volume
Length = 0.6096; %m
r = 0.08255; %m
Vbody = cell2mat(insheet(8,4)); %m^3

%Back
WbackNoseCone = cell2mat(insheet(19,3)); %N 
WbackHullMotor= cell2mat(insheet(20,3));%N
Wfin = cell2mat(insheet(26,3));%N
WbackEndCap = cell2mat(insheet(23,3));%N

Wback = WbackNoseCone + WbackHullMotor + 3*Wfin + WbackEndCap + Wmotor; %N

Vbacknosecone = cell2mat(insheet(19,4)); %m^3
Vbackhullmotor = cell2mat(insheet(20,4));
Vfin = cell2mat(insheet(26,4));

Vback = Vbacknosecone + Vbackhullmotor + 3*Vfin;

%Additional mounts

densitySLAresin = 1200; %kg/m^3

Vhydrophone = cell2mat(insheet(31,4)); %m^3
Vtemperaturesensor = cell2mat(insheet(32,4)); %m^3
Vpressuresensor = cell2mat(insheet(33,4)); %m^3

Whydrophone = Vhydrophone*g*densitySLAresin; %N
Wtemperaturesensor = Vtemperaturesensor*densitySLAresin*g; %N
Wpressuresensor = Vpressuresensor*densitySLAresin*g; %N

Wmounts = Whydrophone*4 + Wtemperaturesensor + Wpressuresensor; %N
Vmounts = Vhydrophone*4 + Vtemperaturesensor + Vpressuresensor; %m^3

%Buoyancy Test Values
%NOTE: this might mean that the individual Volume or Weight of a sub
%section will be incorrect

Mtest = 0; %kg
Vtest = 0; %m^3 - only for parts on outside of AUV

%Total
Vtotal = (Vfront + Vback + Vbody + Vmounts + Vtest);
Wtotal = Wfront + Wback + Wbody + Wmounts + (Mtest*g);
DensityAUV = ((Wtotal/g)/Vtotal);
Vsubmergedsalt = (DensityAUV*Vtotal)/(rhosaltwater);
Vsubmergedfresh = (DensityAUV*Vtotal)/(rhofreshwater);
Percentsubmergedsalt= Vsubmergedsalt/Vtotal
Percentsubmergedfresh = Vsubmergedfresh/Vtotal
check = DensityAUV/rhosaltwater

%TargetBuoyancy

TargetBuoy = 6.4293; %N
TargetW = rhofreshwater*g*Vtotal - TargetBuoy;
TargetDensityAuv = (TargetW/g)/(Vtotal);
TargetSubmerged = TargetDensityAuv/rhofreshwater

Vapprox = 0
D = 0
% while Vapprox <= Vbody*Percentsubmergedsalt
%         Vapprox = Length*((r^2)*acos((r-D)/r) - (r-D)*sqrt((2*r*D) - (D^2)));
%         D = D + 0.002;
% end    
%     disp(Vapprox)
%     disp(D)
%% Buoyancy

Bsalt = rhosaltwater*g*Vtotal
Bfresh = rhofreshwater*g*Vtotal

Fpushsalt = rhosaltwater*g*Vtotal - Wtotal %N
Fpushfresh = rhofreshwater*g*Vtotal - Wtotal %N

Fpushsaltlb = 0.2248089431*Fpushsalt %lb
Fpushfreshlb = 0.2248089431*Fpushfresh %lb


