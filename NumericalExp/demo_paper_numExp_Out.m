clc; clear all; close all;
%% comparison between Mixture PPCR model and Robust Mixture PPCR model
%
%
%
%
load numExp_noOut.mat

NOutliers = 14;  % 5% outliers -- 10; 1% -- 2; 3% -- 6; 7% -- 14
X_outlier = dataExp.dataX;
Y_outlier = dataExp.dataY;
outlier_position1 = unidrnd(200,[1,NOutliers]);     % outliers in normal condition
outlier_position2 = unidrnd(200,[1,NOutliers])+200; % outliers in operation condition 1
outlier_position3 = unidrnd(200,[1,NOutliers])+400; % outliers in operation condition 2
outlier_position4 = unidrnd(200,[1,NOutliers])+600; % outliers in operation condition 3
outlier_position5 = unidrnd(200,[1,NOutliers])+800; % outliers in operation condition 4
outlier_position = [outlier_position1,outlier_position2,...
    outlier_position3,outlier_position4,outlier_position5];
outliersX = (rand(size(dataExp.dataX,2), 5*NOutliers) - 1.5)*10;
outliersY = (rand(size(dataExp.dataY,2), 5*NOutliers) - 1.5)*10;
for j = 1:length(outlier_position)
    X_outlier(outlier_position(j),:) = outliersX(:,j)';
    Y_outlier(outlier_position(j),:) = outliersY(:,j)';
end
%% plot data with outliers
% graph_numExp_with_outlier;

DatawithOutlier = [X_outlier, Y_outlier];
DatawithOutlier = DatawithOutlier';
%% 1. Mixture Factor Analysis Model
% ----------------------------------------------
%  Initialization 
MFAmodel.latent_dim = 2;
MFAmodel.num_of_mix_comp = 5;
MFAmodel.iso = 1;
MFAmodel.eq = 1;
MFAmodel.verbosity = 0;
%------------------------------------------------
% Do Mixture of probabilistic pca with maximum likelihood estimation,
% togather with x and y
[LogL, mfa, Q] = mfa(DatawithOutlier, MFAmodel.latent_dim, MFAmodel.num_of_mix_comp, ...
    MFAmodel.iso, MFAmodel.eq, MFAmodel.verbosity);

%%  Predict new unobserved values
%--------------------------------
newdataX = Data(1:5,:); newdataY = Data(6:end,:);
KK = MFAmodel.num_of_mix_comp;
[hat_y_new, Tsquare_mppcr] = mppcr_Ge(newdataX, mfa, KK);

SPE_mppcr = zeros(size(newdataY,2),1);
for ii = 1 : size(newdataY,2)
    SPE_mppcr(ii) = (hat_y_new(:,ii) - newdataY(:,ii))'*(hat_y_new(:,ii) - newdataY(:,ii));
end

% figure(1)
% plot(Tsquare_mppcr)
% figure(2)
% plot(SPE_mppcr)

%% Prediction error
%---------------------------------------
% RMSE: Root-Mean-Squared Error
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
Rsquare_mix_ppcr =  1- tot_sse_mix_ppcr/tot_sst_mix_ppcr;

%% 2. Robust mixture of CCA Learning
%---------------------------------------------
learningParameters = vbmcca.initLearningParameters(150, 10^(-6));

%% Initialise model with normal latents
oDataX = DatawithOutlier(1:5,:); oDataY = DatawithOutlier(6:end,:);%oDataX = dataExp.outlierX'; oDataY = dataExp.outlierY';
M = MFAmodel.num_of_mix_comp; % M -- cluster count
dX = size(oDataX,1); dY = size(oDataY,1); 
D = MFAmodel.latent_dim; % D -- Latent variable dimension. 1 <= D <= min(dX,dY)

nModel = vbmcca(M,dX,dY,D);
nModel.normalLatents = 0;

%% Robust model
% tModel = vbmcca(M, dX, dY, D);
% 
% nModel = nModel.initWithKMeans(oDataX, oDataY);
% tModel = tModel.initWithKMeans(oDataX, oDataY);
% 
% [nModel, nEnergies] = nModel.learn(oDataX, oDataY, learningParameters); 
% [tModel, tEnergies] = tModel.learn(oDataX, oDataY, learningParameters); 
% 
% % Predict new unobserved values
% %-------------------------------------------------
% [eYn, covYn] = nModel.inferConditionalYMean(newdataX);
% %% Prediction error
% %---------------------------------------
% % RMSE: Root-Mean-Squared Error
% nError_mix_rob_ppcr = zeros(size(newdataY,2),1);
% sst_mix_rob_ppcr = zeros(size(newdataY,2),1);
% sse_mix_rob_ppcr = zeros(size(newdataY,2),1);
% for i = 1 : size(newdataY,2)
%     nError_mix_rob_ppcr(i) = norm(eYn(:,i) - newdataY(:,i))/sqrt(size(newdataY,2));
%     sst_mix_rob_ppcr(i) = norm(newdataY(:,i) - mean(newdataY,2))^2;
%     sse_mix_rob_ppcr(i) = norm(newdataY(:,i) - eYn(:,i))^2;
% end
% RMSE_mix_rob_ppcr = sqrt(sum(sse_mix_rob_ppcr/size(newdataY,2)));
% tot_sst_mix_rob_ppcr = sum(sst_mix_rob_ppcr);
% tot_sse_mix_rob_ppcr = sum(sse_mix_rob_ppcr);
% Rsquare_mix_rob_ppcr =  1- tot_sse_mix_rob_ppcr/tot_sst_mix_rob_ppcr;

% %% 3. GMR
% Xtrain = DatawithOutlier';
% 
% options = statset('MaxIter' ,200); % max iteration = 500
% obj = gmdistribution.fit(Xtrain, KK, 'Regularize', 1e-3, 'Options', options);
% 
% GMMres.GMMnCompts = obj.NComponents;
% for n = 1 : GMMres.GMMnCompts
%     GMMres.res{n,1} = obj.PComponents(n); % prior
%     GMMres.res{n,2} = obj.mu(n,:); % mean
%     GMMres.res{n,3} = obj.Sigma(:,:,n); % Sigma
%     
%     GMMres.GMMPCompts(1,n) = GMMres.res{n,1};
%     GMMres.GMMmu(:,n) = GMMres.res{n,2};
%     GMMres.GMMSigma(:,:,n) = GMMres.res{n,3};
% end
% 
% testX = newdataX;
% [GMMres.xstar(1:size(oDataY,1),:), GMMres.Sigma_xstar, GMMres.Pxi, GMMres.beta] = GaussMR(GMMres.GMMPCompts, GMMres.GMMmu, ...
%     GMMres.GMMSigma, testX, [1:size(newdataX,1)], [1:size(oDataY,1)]);
% 
% nError_mix_gmm = zeros(size(newdataY,2),1);
% sst_mix_gmm = zeros(size(newdataY,2),1);
% sse_mix_gmm = zeros(size(newdataY,2),1);
% for i = 1 : size(newdataY,2)
%     nError_mix_gmm(i) = norm(GMMres.xstar(:,i) - newdataY(:,i))/sqrt(size(newdataY,2));
%     sst_mix_gmm(i) = norm(newdataY(:,i) - mean(newdataY,2))^2;
%     sse_mix_gmm(i) = norm(newdataY(:,i) - GMMres.xstar(:,i))^2;
% end
% RMSE_mix_gmm = sqrt(sum(sse_mix_gmm/size(newdataY,2)));
% tot_sst_mix_gmm = sum(sst_mix_gmm);
% tot_sse_mix_gmm = sum(sse_mix_gmm);
% Rsquare_mix_gmm =  1- tot_sse_mix_gmm/tot_sst_mix_gmm;
% 
%% 4. Mix-PLS
n_int = 10; % maximum number of iterations
ne = 5; % number of experts
[par1, Q_plot1]=MIX_PLS_TRAIN(oDataX', oDataY(1,:)', ne, n_int);
[par2, Q_plot2]=MIX_PLS_TRAIN(oDataX', oDataY(2,:)', ne, n_int);
% Test Mix-PLS
[Y_est_test1,Gtest1] = MIX_PLS_TEST(oDataX', par1);
[Y_est_test2,Gtest2] = MIX_PLS_TEST(oDataX', par2);

Y_est_test = [Y_est_test1,Y_est_test2];
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
% 
% %% plot analysis graph
% % fig_4_6_numExp_Out;







