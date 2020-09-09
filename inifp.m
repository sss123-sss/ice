function inifp
% Calculation of the initial freezing point based on compostion
close all; clear; clc

% Mass fraction of vanilla ice cream
% Data souce: https://fdc.nal.usda.gov/fdc-app.html#/food-details/167575/nutrients
% FDC ID: 167575. NDB Number:19095
water = .61;
protein = .035;
fat = .11;
sugar = .212;
fiber = .024; % adjusted, in order to make the total 100
ash = .009;
% Calculate ash molecular weight, minerals, unit (mg)
% Mass per 100 g product
Ca = 128; 
Fe = .09;
Mg = 14;
P = 105;
K = 199;
Na = 80;
Zn = .69;
Cu = .023;
Mn = .008;
Se = 1.8/1e3;
F = 15.4/1e3;
% Molecular weight of each mineral
MCa = 40.078;
MFe = 55.845;
MMg = 24.305;
MP = 30.9738;
MK = 39.0983;
MNa = 22.9898;
MZn = 65.38;
MCu = 63.546;
MMn = 54.938;
MSe = 78.96;
MF = 18.998;
% Assign a matrix for calculation
Minerals(1, :) = [Ca, Fe, Mg, P, K, Na, Zn, Cu, Mn, Se, F];
Minerals(2, :) = [MCa, MFe, MMg, MP, MK, MNa, MZn, MCu, MMn, MSe, MF];
nMineral = sum(Minerals(1,:)/Minerals(2,:));
Minerals(3,:) = Minerals(1, :)/nMineral.*Minerals(2, :);
MAsh = sum(Minerals(3,:))/1000; % Transfer the unit from mg to g, the calculated ash molecular weight

% Molecular weight of other components
MWater = 18;
MProtein = 50000;
MFat = 50000;
MSugar = 342; % sucrose
MFiber = 50000; 
% According to $\lambda/R_g[1/T_{A0} - 1/T_A] = \ln X_A$ (Heldman, 2008, Handbook)
% Where T_{A0} is the original freezing point of water, 273 K
X_A = (water/MWater)*(water/MWater + protein/MProtein + fat/MFat + ...
    + sugar/MSugar + fiber/MFiber + ash/MAsh)^(-1);
% Use the freezing point depression formula
T_A0 = 273; % K, freezing point of pure water
lambda_f = 333.5; % kJ*kg^(-1), latent heat of water fusion
R_g = 8.314; % kJ*K^(-1)*kmol^(-1)
T_f = (1/T_A0 - R_g*log(X_A)/(MWater*lambda_f))^(-1); % Unit, K
T_f = T_f - T_A0; % Initial freezing point, degC
disp(T_f)






