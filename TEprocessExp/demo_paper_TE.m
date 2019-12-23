clc; clear all; close all;

load TEdata_sixOPT.mat

data_train = [data_train(:,1:6),data_train(:,9:11),data_train(:,13:14),data_train(:,16),...
    data_train(:,18:19), data_train(:,21:22), data_train(:,37:41)];
    

data_test = [data_test(:,1:6),data_test(:,9:11),data_test(:,13:14),data_test(:,16),...
    data_test(:,18:19), data_test(:,21:22), data_test(:,37:41)];
    

data_train = data_train';
data_test = data_test';

[train_data, ppp1] = preprocess(data_train);
[test_data, ppp2] = preprocess(data_test);

% NOutliers = 6; % 1% outliers -- 2; 3% -- 6; 5% -- 10; 7% -- 14
% X_outlier = train_data;
% outlier_position1 = unidrnd(200,[1,NOutliers]);     % outliers in operation condition 1
% outlier_position2 = unidrnd(200,[1,NOutliers])+200; % outliers in operation condition 2
% outlier_position3 = unidrnd(200,[1,NOutliers])+400; % outliers in operation condition 3
% outlier_position4 = unidrnd(200,[1,NOutliers])+600; % outliers in operation condition 4
% outlier_position5 = unidrnd(200,[1,NOutliers])+800; % outliers in operation condition 5
% outlier_position6 = unidrnd(200,[1,NOutliers])+1000; % outliers in operation condition 6
% outlier_position = [outlier_position1,outlier_position2,...
%     outlier_position3,outlier_position4,outlier_position5,outlier_position6];
% 
% outliersX = (rand(size(train_data,1), 6*NOutliers) - 1.5)*5;
% for j = 1:length(outlier_position)
%     X_outlier(:,outlier_position(j)) = outliersX(:,j);
% end
% 
% train_data = X_outlier;
%% 1. Mixture Factor Analysis Model
% ----------------------------------------------
%  Initialization 
MFAmodel.latent_dim = 6;
MFAmodel.num_of_mix_comp = 6;
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
newdataX = test_data(1:16,:);
KK = MFAmodel.num_of_mix_comp;
[hat_y_new] = mppcr_Ge(newdataX, mfa, KK);

%% Prediction error
%---------------------------------------
% RMSE: Root-Mean-Squared Error
newdataY = test_data(17:end,:);
nError_mix_ppcr = zeros(size(newdataY,2),1);
sst_mix_ppcr = zeros(size(newdataY,2),1);
sse_mix_ppcr = zeros(size(newdataY,2),1);
for i = 1 : size(newdataY,2)
    nError_mix_ppcr(i) = norm(hat_y_new(:,i) - newdataY(:,i))/sqrt(size(newdataY,2));
    sst_mix_ppcr(i) = norm(newdataY(:,i) - mean(newdataY,2))^2;
    sse_mix_ppcr(i) = norm(newdataY(:,i) - hat_y_new(:,i))^2;
end
RMSE_mix_ppcr = sqrt(sum(sse_mix_ppcr/size(newdataY,2)));
tot_sst_mix_ppcr = sum(sst_mix_ppcr);
tot_sse_mix_ppcr = sum(sse_mix_ppcr);
Rsquare_mix_ppcr =  1 - tot_sse_mix_ppcr/tot_sst_mix_ppcr;

%% 2. Robust mixture of PCR Learning
%---------------------------------------------
learningParameters = vbmcca.initLearningParameters(100, 10^(-6));

%% Initialise model with normal latents
oDataX = train_data(1:16,:); oDataY = train_data(17:end,:);
M = MFAmodel.num_of_mix_comp; % M -- cluster count
dX = size(oDataX,1); dY = size(oDataY,1); 
D = MFAmodel.latent_dim; % D -- Latent variable dimension. 1 <= D <= min(dX,dY)

nModel = vbmcca(M, dX, dY, D);
nModel.normalLatents = 0; % 0 -- student t; 1 -- gaussian

%% Robust model
tModel = vbmcca(M, dX, dY, D);

nModel = nModel.initWithKMeans(oDataX, oDataY);
tModel = tModel.initWithKMeans(oDataX, oDataY);

% [nModel, nEnergies] = nModel.learn(oDataX, oDataY, learningParameters); 
% [tModel, tEnergies] = tModel.learn(oDataX, oDataY, learningParameters); 

% Predict new unobserved values
%-------------------------------------------------
[eYn, covYn] = nModel.inferConditionalYMean(newdataX);
%% Prediction error
%---------------------------------------
% RMSE: Root-Mean-Squared Error
nError_mix_rob_ppcr = zeros(size(newdataY,2),1);
sst_mix_rob_ppcr = zeros(size(newdataY,2),1);
sse_mix_rob_ppcr = zeros(size(newdataY,2),1);
for i = 1 : size(newdataY,2)
    nError_mix_rob_ppcr(i) = norm(eYn(:,i) - newdataY(:,i))/sqrt(size(newdataY,2));
    sst_mix_rob_ppcr(i) = norm(newdataY(:,i) - mean(newdataY,2))^2;
    sse_mix_rob_ppcr(i) = norm(newdataY(:,i) - eYn(:,i))^2;
end
RMSE_mix_rob_ppcr = sqrt(sum(sse_mix_rob_ppcr/size(newdataY,2)));
tot_sst_mix_rob_ppcr = sum(sst_mix_rob_ppcr);
tot_sse_mix_rob_ppcr = sum(sse_mix_rob_ppcr);
Rsquare_mix_rob_ppcr =  1- tot_sse_mix_rob_ppcr/tot_sst_mix_rob_ppcr;

%% 3. GMR
Xtrain = train_data';

options = statset('MaxIter' ,200); % max iteration = 500
obj = gmdistribution.fit(Xtrain, KK, 'Regularize', 1e-3, 'Options', options);

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

nError_mix_gmm = zeros(size(newdataY,2),1);
sst_mix_gmm = zeros(size(newdataY,2),1);
sse_mix_gmm = zeros(size(newdataY,2),1);
for i = 1 : size(newdataY,2)
    nError_mix_gmm(i) = norm(GMMres.xstar(:,i) - newdataY(:,i))/sqrt(size(newdataY,2));
    sst_mix_gmm(i) = norm(newdataY(:,i) - mean(newdataY,2))^2;
    sse_mix_gmm(i) = norm(newdataY(:,i) - GMMres.xstar(:,i))^2;
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
[par3, Q_plot3]=MIX_PLS_TRAIN(oDataX', oDataY(3,:)', ne, n_int);
[par4, Q_plot4]=MIX_PLS_TRAIN(oDataX', oDataY(4,:)', ne, n_int);
[par5, Q_plot5]=MIX_PLS_TRAIN(oDataX', oDataY(5,:)', ne, n_int);
% Test Mix-PLS
[Y_est_test1,Gtest1] = MIX_PLS_TEST(oDataX', par1);
[Y_est_test2,Gtest2] = MIX_PLS_TEST(oDataX', par2);
[Y_est_test3,Gtest3] = MIX_PLS_TEST(oDataX', par3);
[Y_est_test4,Gtest4] = MIX_PLS_TEST(oDataX', par4);
[Y_est_test5,Gtest5] = MIX_PLS_TEST(oDataX', par5);

Y_est_test = [Y_est_test1,Y_est_test2,Y_est_test3,Y_est_test4,Y_est_test5];
Y_est_test = Y_est_test';
nError_mix_pls = zeros(size(newdataY,2),1);
sst_mix_pls = zeros(size(newdataY,2),1);
sse_mix_pls = zeros(size(newdataY,2),1);
for i = 1 : size(newdataY,2)
    nError_mix_pls(i) = norm(Y_est_test(:,i) - newdataY(:,i))/sqrt(size(newdataY,2));
    sst_mix_pls(i) = norm(newdataY(:,i) - mean(newdataY,2))^2;
    sse_mix_pls(i) = norm(newdataY(:,i) - Y_est_test(:,i))^2;
end
RMSE_mix_pls = sqrt(sum(sse_mix_pls/size(newdataY,2)));
tot_sst_mix_pls = sum(sst_mix_pls);
tot_sse_mix_pls = sum(sse_mix_pls);
Rsquare_mix_pls =  1- tot_sse_mix_pls/tot_sst_mix_pls;

% graph_TE
