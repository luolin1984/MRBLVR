clc; clear all; close all;
load Gaussian_4C_3D.mat
%% plot original data
% figure(1)
% subplot(2,2,1)
% plot(X(:,1),X(:,2),'ko','LineWidth', 1.2, 'MarkerSize', 5)
% xlabel('$ \mathbf{x}_1 $','interpreter','latex','fontsize',15);
% ylabel('$ \mathbf{x}_2 $','interpreter','latex','fontsize',15);
% subplot(2,2,2)
% plot(X(:,1),X(:,3),'b.','LineWidth', 1.2, 'MarkerSize', 5)
% xlabel('$ \mathbf{x}_1 $','interpreter','latex','fontsize',15);
% ylabel('$ \mathbf{x}_3 $','interpreter','latex','fontsize',15);
% subplot(2,2,3)
% plot(X(:,2),X(:,3),'rx','LineWidth', 1.2, 'MarkerSize', 5)
% xlabel('$ \mathbf{x}_2 $','interpreter','latex','fontsize',15);
% ylabel('$ \mathbf{x}_3 $','interpreter','latex','fontsize',15);
%% Mixture Factor Analysis Model
Data = X';
MFAmodel.latent_dim = 2;
MFAmodel.num_of_mix_comp = 4;
MFAmodel.iso = 1;
MFAmodel.eq = 1;
MFAmodel.verbosity = 0;

[LogL, mfa, Q] = mfa(Data, MFAmodel.latent_dim, MFAmodel.num_of_mix_comp, ...
    MFAmodel.iso, MFAmodel.eq, MFAmodel.verbosity);
% LogL  : row vector of log-likelihoods after each EM iteration
% mfa  : structure containing the Mixture of Factor Analyzers
%   mfa.W (Dim x latent_dim x num_of_mix_comp) : factor loading matrices  (文献中的P)
%   mfa.M (Dim x num_of_mix_comp)     : component means          (文献中的\mu)
%   mfa.Psi ( Dim x num_of_mix_comp ) : component noise variances ()
%   mfa.mix ( num_of_mix_comp x 1 ) : mixing weights            ()
% Q     : num_of_mix_comp x N matrix of component posterior probabilities

inputData = X;
[Tsquare, SPE] = stat_mfa(inputData, MFAmodel, mfa);







