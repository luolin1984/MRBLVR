clear all; clc; close all
% === FD dataset ===
load finalMode.mat
[YMultMode, ppp] = preprocess(finMode');
Xtest = YMultMode';
[N2, D2] = size(Xtest);

%% Mixture Factor Analysis Model
Data = Xtest';
MFAmodel.latent_dim = 3;
MFAmodel.num_of_mix_comp = 3;
MFAmodel.iso = 0;
MFAmodel.eq = 1;
MFAmodel.verbosity = 0;

[LogL, mfa, Q] = mfa(Data, MFAmodel.latent_dim, MFAmodel.num_of_mix_comp, ...
    MFAmodel.iso, MFAmodel.eq, MFAmodel.verbosity);

inputData = Xtest;
[Tsquare, SPE] = stat_mfa(inputData, MFAmodel, mfa);
figure(1)
plot(Tsquare)
figure(2)
plot(SPE)