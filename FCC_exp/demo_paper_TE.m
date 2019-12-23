clc; clear; close all;
load mode3Test.mat
load modeTrain.mat

Q1 = [(Q11(102:2:end,6)-32)*5/9-530;(Q21(102:2:end,6)-32)*5/9-530]; % Furnace TEMP
Q2 = [(Q12(102:2:end,4)-32)*5/9+80;(Q22(102:2:end,4)-32)*5/9+80];  % TEMP of Reg. bed
Q3 = [(Q12(102:2:end,3)-32)*5/9+80;(Q22(102:2:end,3)-32)*5/9+80];   % TEMP at bottom of Reg.
Q4 = [(Q16(102:2:end,3)-32)*5/9-60;(Q26(102:2:end,3)-32)*5/9-60];   % TEMP of spent catalyst
Q5 = [(Q12(102:2:end,6)-32)*5/9-100;(Q22(102:2:end,6)-32)*5/9-100]; % TEMP of stack gas
Q6 = [Q13(102:2:end,2);Q23(102:2:end,2)];                           % TEMP diff. of fluidized bed
Q7 = [Q11(102:2:end,5)*6.894757;Q21(102:2:end,5)*6.894757];         % Reg. PRESS
Q8 = [Q11(102:2:end,3)*6.894757-10;Q21(102:2:end,3)*6.894757-10];   % Differential PRESS

Qyo2 = [Q13(102:2:end,4)+3.5;Q23(102:2:end,4)+3.5];                 % output1: Oxygen concentration
Qyco = [Q13(102:2:end,3)/200+1;Q23(102:2:end,3)/200+1];             % output2: CO concentration

Q1t = [(Q11Tra(102:2:end,6)-32)*5/9-530;(Q21Tra(102:2:end,6)-32)*5/9-530]; % Furnace TEMP
Q2t = [(Q12Tra(102:2:end,4)-32)*5/9+80;(Q22Tra(102:2:end,4)-32)*5/9+80];  % TEMP of Reg. bed
Q3t = [(Q12Tra(102:2:end,3)-32)*5/9+80;(Q22Tra(102:2:end,3)-32)*5/9+80];   % TEMP at bottom of Reg.
Q4t = [(Q16Tra(102:2:end,3)-32)*5/9-60;(Q26Tra(102:2:end,3)-32)*5/9-60];   % TEMP of spent catalyst
Q5t = [(Q12Tra(102:2:end,6)-32)*5/9-100;(Q22Tra(102:2:end,6)-32)*5/9-100]; % TEMP of stack gas
Q6t = [Q13Tra(102:2:end,2);Q23Tra(102:2:end,2)];                           % TEMP diff. of fluidized bed
Q7t = [Q11Tra(102:2:end,5)*6.894757;Q21Tra(102:2:end,5)*6.894757];         % Reg. PRESS
Q8t = [Q11Tra(102:2:end,3)*6.894757-10;Q21Tra(102:2:end,3)*6.894757-10];   % Differential PRESS

Qyo2t = [Q13Tra(102:2:end,4)+3.5;Q23Tra(102:2:end,4)+3.5];                 % output1: Oxygen concentration
Qycot = [Q13Tra(102:2:end,3)/200+1;Q23Tra(102:2:end,3)/200+1];             % output2: CO concentration

data_train = [Q1t Q2t Q3t Q4t Q5t Q6t Q7t Q8t Qyo2t Qycot];
data_train = data_train';
data_test = [Q1 Q2 Q3 Q4 Q5 Q6 Q7 Q8 Qyo2 Qyco];
data_test = data_test';


[train_data, ppp1] = mapstd(data_train,0,1);
[test_data, ppp2] = mapstd(data_test);

%% 1. Mixture Factor Analysis Model
% ----------------------------------------------
%  Initialization 
MFAmodel.latent_dim = 2;
MFAmodel.num_of_mix_comp = 2;
MFAmodel.iso = 1;
MFAmodel.eq = 1;
MFAmodel.verbosity = 0;
%------------------------------------------------
% Do Mixture of probabilistic pca with maximum likelihood estimation,
% togather with x and y
[LogL, mfa, Q] = mfa(train_data, MFAmodel.latent_dim, MFAmodel.num_of_mix_comp, ...
    MFAmodel.iso, MFAmodel.eq, MFAmodel.verbosity);

%%  Predict new unobserved values
%--------------------------------
newdataX = test_data(1:8,:);
KK = MFAmodel.num_of_mix_comp;
[Res_mppcr] = mppcr_Ge(newdataX, mfa, KK);

%% Prediction error
%---------------------------------------
% RMSE: Root-Mean-Squared Error
newdataY = test_data(9:end,:);
nError_mix_ppcr = zeros(size(newdataY,2),1);
sst_mix_ppcr = zeros(size(newdataY,2),1);
sse_mix_ppcr = zeros(size(newdataY,2),1);
for i = 1 : size(newdataY,2)
    nError_mix_ppcr(i) = norm(Res_mppcr(:,i) - newdataY(:,i))/sqrt(size(newdataY,2));
    sst_mix_ppcr(i) = norm(newdataY(:,i) - mean(newdataY,2))^2;
    sse_mix_ppcr(i) = norm(newdataY(:,i) - Res_mppcr(:,i))^2;
end
RMSE_mix_ppcr = sqrt(sum(sse_mix_ppcr/size(newdataY,2)));
tot_sst_mix_ppcr = sum(sst_mix_ppcr);
tot_sse_mix_ppcr = sum(sse_mix_ppcr);
Rsquare_mix_ppcr =  1 - tot_sse_mix_ppcr/tot_sst_mix_ppcr;

%% 2. Robust mixture of PCR Learning
%---------------------------------------------
learningParameters = MRBLVR.initLearningParameters(500, 10^(-9));

%% Initialise model with normal latents
oDataX = train_data(1:8,:); oDataY = train_data(9:end,:);
M = MFAmodel.num_of_mix_comp; % M -- cluster count
dX = size(oDataX,1); dY = size(oDataY,1); 
D = MFAmodel.latent_dim; % D -- Latent variable dimension. 1 <= D <= min(dX,dY)

nModel = MRBLVR(M, dX, dY, D);
nModel.normalLatents = 0; % 0 -- student t; 1 -- gaussian

%% Robust model
tModel = MRBLVR(M, dX, dY, D);

nModel = nModel.initWithKMeans(oDataX, oDataY);
tModel = tModel.initWithKMeans(oDataX, oDataY);

% [nModel, nEnergies] = nModel.learn(oDataX, oDataY, learningParameters); 
% [tModel, tEnergies] = tModel.learn(oDataX, oDataY, learningParameters); 

% Predict new unobserved values
%-------------------------------------------------
[Res_rbppcr, covYn] = nModel.inferConditionalYMean(newdataX);
%% Prediction error
%---------------------------------------
% RMSE: Root-Mean-Squared Error
nError_mix_rob_ppcr = zeros(size(newdataY,2),1);
sst_mix_rob_ppcr = zeros(size(newdataY,2),1);
sse_mix_rob_ppcr = zeros(size(newdataY,2),1);
for i = 1 : size(newdataY,2)
    nError_mix_rob_ppcr(i) = norm(Res_rbppcr(:,i) - newdataY(:,i))/sqrt(size(newdataY,2));
    sst_mix_rob_ppcr(i) = norm(newdataY(:,i) - mean(newdataY,2))^2;
    sse_mix_rob_ppcr(i) = norm(newdataY(:,i) - Res_rbppcr(:,i))^2;
end
RMSE_mix_rob_ppcr = sqrt(sum(sse_mix_rob_ppcr/size(newdataY,2)));
tot_sst_mix_rob_ppcr = sum(sst_mix_rob_ppcr);
tot_sse_mix_rob_ppcr = sum(sse_mix_rob_ppcr);
Rsquare_mix_rob_ppcr =  1- tot_sse_mix_rob_ppcr/tot_sst_mix_rob_ppcr;

%% 3. GMR
Xtrain = train_data';

options = statset('MaxIter' ,200); % max iteration = 500
obj = gmdistribution.fit(Xtrain, KK, 'Regularize', 1e-6, 'Options', options);

GMMres.GMMnCompts = obj.NComponents;
for n = 1 : GMMres.GMMnCompts
    GMMres.res{n,1} = obj.PComponents(n); % prior
    GMMres.res{n,2} = obj.mu(n,:); % mean
    GMMres.res{n,3} = obj.Sigma(:,:,n); % Sigma
    
    GMMres.GMMPCompts(1,n) = GMMres.res{n,1};
    GMMres.GMMmu(:,n) = GMMres.res{n,2};
    GMMres.GMMSigma(:,:,n) = GMMres.res{n,3};
end

testX = newdataX;
[GMMres.xstar(1:size(oDataY,1),:), GMMres.Sigma_xstar, GMMres.Pxi, GMMres.beta] = GaussMR(GMMres.GMMPCompts, GMMres.GMMmu, ...
    GMMres.GMMSigma, testX, [1:size(newdataX,1)], [1:size(oDataY,1)]);
Res_GMM = GMMres.xstar;

nError_mix_gmm = zeros(size(newdataY,2),1);
sst_mix_gmm = zeros(size(newdataY,2),1);
sse_mix_gmm = zeros(size(newdataY,2),1);
for i = 1 : size(newdataY,2)
    nError_mix_gmm(i) = norm(Res_GMM(:,i) - newdataY(:,i))/sqrt(size(newdataY,2));
    sst_mix_gmm(i) = norm(newdataY(:,i) - mean(newdataY,2))^2;
    sse_mix_gmm(i) = norm(newdataY(:,i) - Res_GMM(:,i))^2;
end
RMSE_mix_gmm = sqrt(sum(sse_mix_gmm/size(newdataY,2)));
tot_sst_mix_gmm = sum(sst_mix_gmm);
tot_sse_mix_gmm = sum(sse_mix_gmm);
Rsquare_mix_gmm =  1- tot_sse_mix_gmm/tot_sst_mix_gmm;

%% 4. Mix-PLS
n_int = 10; % maximum number of iterations
ne = MFAmodel.num_of_mix_comp; % number of experts
[par1, Q_plot1]=MIX_PLS_TRAIN(oDataX', oDataY(1,:)', ne, n_int);
[par2, Q_plot2]=MIX_PLS_TRAIN(oDataX', oDataY(2,:)', ne, n_int);
% Test Mix-PLS
[Y_est_test1,Gtest1] = MIX_PLS_TEST(oDataX', par1);
[Y_est_test2,Gtest2] = MIX_PLS_TEST(oDataX', par2);

Y_est_test = [Y_est_test1,Y_est_test2];
Res_MixPLS = Y_est_test';
nError_mix_pls = zeros(size(newdataY,2),1);
sst_mix_pls = zeros(size(newdataY,2),1);
sse_mix_pls = zeros(size(newdataY,2),1);
for i = 1 : size(newdataY,2)
    nError_mix_pls(i) = norm(Res_MixPLS(:,i) - newdataY(:,i))/sqrt(size(newdataY,2));
    sst_mix_pls(i) = norm(newdataY(:,i) - mean(newdataY,2))^2;
    sse_mix_pls(i) = norm(newdataY(:,i) - Res_MixPLS(:,i))^2;
end
RMSE_mix_pls = sqrt(sum(sse_mix_pls/size(newdataY,2)));
tot_sst_mix_pls = sum(sst_mix_pls);
tot_sse_mix_pls = sum(sse_mix_pls);
Rsquare_mix_pls =  1- tot_sse_mix_pls/tot_sst_mix_pls;

Res_raw_mppcr = poststd(Res_mppcr, ppp2.xmean(9:10,:), ppp2.xstd(9:10,:));
Res_raw_gmm = poststd(Res_GMM, ppp2.xmean(9:10,:), ppp2.xstd(9:10,:));
Res_raw_rbppcr = poststd(Res_rbppcr, ppp2.xmean(9:10,:), ppp2.xstd(9:10,:));
Res_raw_MixPLS = poststd(Res_MixPLS, ppp2.xmean(9:10,:), ppp2.xstd(9:10,:));

Res_raw_Y = poststd(newdataY,ppp2.xmean(9:10,:), ppp2.xstd(9:10,:));
