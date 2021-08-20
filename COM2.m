clear all; close all; clc;

%% Read Input File

infile = 'Center of Mass Tracker.xlsx';
insheet = readcell(infile, 'Sheet', 2);
% COMmatrix = cell2mat(readcell(infile, 'Sheet', 2, 'Range', 'B2:E23'));


%% Define Variables

% Front
xfrontnose = cell2mat(insheet(2,2));
yfrontnose = cell2mat(insheet(2,3));
zfrontnose = cell2mat(insheet(2,4));
mfrontnose = cell2mat(insheet(2,5));

xmotorcap = cell2mat(insheet(3,2));
ymotorcap = cell2mat(insheet(3,3));
zmotorcap = cell2mat(insheet(3,4));
mmotorcap = cell2mat(insheet(3,5));

xthruster1 = cell2mat(insheet(4,2));
ythruster1 = cell2mat(insheet(4,3));
zthruster1 = cell2mat(insheet(4,4));

xthruster2 = cell2mat(insheet(5,2));
ythruster2 = cell2mat(insheet(5,3));
zthruster2 = cell2mat(insheet(5,4));

xfronthullmotor = cell2mat(insheet(6,2));
yfronthullmotor = cell2mat(insheet(6,3));
zfronthullmotor = cell2mat(insheet(6,4));
mfronthullmotor = cell2mat(insheet(6,5));

xfrontendcap = cell2mat(insheet(7,2));
yfrontendcap  = cell2mat(insheet(7,3));
zfrontendcap = cell2mat(insheet(7,4));
mfrontendcap = cell2mat(insheet(7,5));

% Mid
xacryllictube = cell2mat(insheet(8,2));
yacryllictube = cell2mat(insheet(8,3));
zacryllictube = cell2mat(insheet(8,4));
macryllictube = cell2mat(insheet(8,5));

xbattery1 = cell2mat(insheet(9,2));
ybattery1 = cell2mat(insheet(9,3));
zbattery1 = cell2mat(insheet(9,4));

xbattery2 = cell2mat(insheet(10,2));
ybattery2 = cell2mat(insheet(10,3));
zbattery2 = cell2mat(insheet(10,4));

xbattery3 = cell2mat(insheet(11,2));
ybattery3 = cell2mat(insheet(11,3));
zbattery3 = cell2mat(insheet(11,4));

xbattery4 = cell2mat(insheet(12,2));
ybattery4 = cell2mat(insheet(12,3));
zbattery4 = cell2mat(insheet(12,4));

xbatterymountalt1 = cell2mat(insheet(13,2));
ybatterymountalt1 = cell2mat(insheet(13,3));
zbatterymountalt1 = cell2mat(insheet(13,4));

xbatterymountalt2 = cell2mat(insheet(14,2));
ybatterymountalt2 = cell2mat(insheet(14,3));
zbatterymountalt2 = cell2mat(insheet(14,4));

mbatterymountalt = cell2mat(insheet(14,5));

xbatterymount = cell2mat(insheet(18,2));
ybatterymount = cell2mat(insheet(18,3));
zbatterymount = cell2mat(insheet(18,4));
mbatterymount = cell2mat(insheet(18,5));

xbedcenter = cell2mat(insheet(15,2));
ybedcenter = cell2mat(insheet(15,3));
zbedcenter = cell2mat(insheet(15,4));
mbedcenter = cell2mat(insheet(15,5));

xbedside1 = cell2mat(insheet(16,2));
ybedside1 = cell2mat(insheet(16,3));
zbedside1 = cell2mat(insheet(16,4));
mbedside1 = cell2mat(insheet(16,5));

xbedside2 = cell2mat(insheet(17,2));
ybedside2 = cell2mat(insheet(17,3));
zbedside2 = cell2mat(insheet(17,4));
mbedside2 = cell2mat(insheet(17,5));

%Back
xbacknose = cell2mat(insheet(19,2));
ybacknose = cell2mat(insheet(19,3));
zbacknose = cell2mat(insheet(19,4));
mbacknose = cell2mat(insheet(19,5));

xbackhullmotor = cell2mat(insheet(20,2));
ybackhullmotor = cell2mat(insheet(20,3));
zbackhullmotor = cell2mat(insheet(20,4));
mbackhullmotor = cell2mat(insheet(20,5));

xthruster3 = cell2mat(insheet(21,2));
ythruster3 = cell2mat(insheet(21,3));
zthruster3 = cell2mat(insheet(21,4));

xthruster4 = cell2mat(insheet(22,2));
ythruster4 = cell2mat(insheet(22,3));
zthruster4 = cell2mat(insheet(22,4));

xbackendcap = cell2mat(insheet(23,2));
ybackendcap = cell2mat(insheet(23,3));
zbackendcap = cell2mat(insheet(23,4));
mbackendcap = cell2mat(insheet(23,5));

%m
mthruster = cell2mat(insheet(4,5));
mbattery = cell2mat(insheet(9,5));

%% COM Calculations

%Mass
mfront = mfrontnose + mmotorcap + 2*mthruster + mfronthullmotor + mfrontendcap;
mmid = macryllictube + 4*mbattery + 2*mbatterymountalt + mbatterymount + mbedcenter + mbedside1 + mbedside2;
mback = mbacknose + mbackhullmotor + 2*mthruster + mbackendcap;
mtotal = mfront + mmid + mback;

%COM
xfront = (mfrontnose*xfrontnose + mmotorcap*xmotorcap + mthruster*xthruster1 + mthruster*xthruster2 + mfronthullmotor*xfronthullmotor + mfrontendcap*xfrontendcap)/(mfront);
yfront = (mfrontnose*yfrontnose + mmotorcap*ymotorcap + mthruster*ythruster1 + mthruster*ythruster2 + mfronthullmotor*yfronthullmotor + mfrontendcap*yfrontendcap)/(mfront);
zfront = (mfrontnose*zfrontnose + mmotorcap*zmotorcap + mthruster*zthruster1 + mthruster*zthruster2 + mfronthullmotor*zfronthullmotor + mfrontendcap*zfrontendcap)/(mfront);

xmid = (macryllictube*xacryllictube + mbattery*(xbattery1 + xbattery2 + xbattery3 + xbattery4) + mbatterymountalt*(xbatterymountalt1 + xbatterymountalt2) + mbedcenter*xbedcenter + mbedside1*xbedside1 + mbedside2*xbedside2 + mbatterymount*xbatterymount)/(mmid);
ymid = (macryllictube*yacryllictube + mbattery*(ybattery1 + ybattery2 + ybattery3 + ybattery4) + mbatterymountalt*(ybatterymountalt1 + ybatterymountalt2) + mbedcenter*ybedcenter + mbedside1*ybedside1 + mbedside2*ybedside2 + mbatterymount*ybatterymount)/(mmid);
zmid = (macryllictube*zacryllictube + mbattery*(zbattery1 + zbattery2 + zbattery3 + zbattery4) + mbatterymountalt*(zbatterymountalt1 + zbatterymountalt2) + mbedcenter*zbedcenter + mbedside1*zbedside1 + mbedside2*zbedside2 + mbatterymount*zbatterymount)/(mmid);

xback = (mbacknose*xbacknose + mbackhullmotor*xbackhullmotor + mthruster*xthruster3 + mthruster*xthruster4 + mbackendcap*xbackendcap)/(mback);
yback = (mbacknose*ybacknose + mbackhullmotor*ybackhullmotor + mthruster*ythruster3 + mthruster*ythruster4 + mbackendcap*ybackendcap)/(mback);
zback = (mbacknose*zbacknose + mbackhullmotor*zbackhullmotor + mthruster*zthruster3 + mthruster*zthruster4 + mbackendcap*zbackendcap)/(mback);

%Total
xtotal = (mfront*xfront + mmid*xmid + mback*xback)/(mtotal);
ytotal = (mfront*yfront + mmid*ymid + mback*yback)/(mtotal);
ztotal = (mfront*zfront + mmid*zmid + mback+zback)/(mtotal);

%% Output

COMfront = [xfront, yfront, zfront]
COMmid = [xmid, ymid, zmid]
COMback = [xback, yback, zback]

COM =[xtotal, ytotal, ztotal]

