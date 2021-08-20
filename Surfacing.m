%% Constants
g = 9.81; %m^2/s
rhosaltwater = 1027; %kg/m^3
rhofreshwater = 997; %kg/m^3
NeutralVolumeSW = 0.002989378523; %m^3
NeutralVolumeFW = 0.002539995113; %m^3
FpushSW = 30.1176; %N
FpushFW = 24.8426; %N
FbSW = 180.5833; %N
FbFW = 175.3082; %N
AUVWeight = 150.4656; %N
Cd = 0.91; %unitless
A = 0.246; %m^2

D = 20; %distance - m

%% Initializing

Leakrates = [(5*10^-7):(5*10^-7):(2*10^-5)]; %m^3/s

MratesSW = Leakrates.*rhosaltwater; %kg/s
MratesFW = Leakrates.*rhofreshwater; %kg/s
%% Time to surface w/out Motors

%With no leak

TimeSW = sqrt((D*2)/(FpushSW/(AUVWeight/g)));
TimeFW = sqrt((D*2)/(FpushFW/(AUVWeight/g)));

%With leak

a = 0;
v = 0;
t = 0;
Dsum = 0;
Mrate = 0.03;
 while v >= 0 && Dsum < 20;
    t = t + 0.001;
    a = (FbFW - AUVWeight - Mrate*(t)*g - (1/2)*rhofreshwater*(v^2)*Cd*A)/(AUVWeight/g);
    v0 = v;
    v = a*(0.001) + v0;
    Dsum = Dsum + v*(0.001);
 end

tsurface = t;

Fy = FbFW - AUVWeight;

if Mrate > 0
    while Fy > 0
    t = t + 0.001;
    Fy = FbFW - AUVWeight - Mrate*(t)*g;
    end
end

tsink = t - tsurface;

fprintf('\n');

if tsink > 60 && tsink < 3600;
    tsink = tsink/60;
    fprintf('Time to sink: %f min \n\n',tsink)
elseif tsink > 3600
    tsink = tsink/3600;
    fprintf('Time to sink: %f hrs \n',tsink)
elseif tsink < 60;
    fprintf('Time to sink: %f sec \n\n',tsink)
end

fprintf('---------------------------------------- \n')
fprintf('Distance Traveled: %f\n\n',Dsum)
fprintf('Final Velocity right before surfacing: %f\n\n', v)
fprintf('Time to surface: %f\n',tsurface)
fprintf('-----------------------------------------\n')


    
    
    
