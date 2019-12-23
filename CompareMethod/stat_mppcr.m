% function [Tsquare, SPE] = stat_mppcr(testData, mfa, rec_dim)
% testData -- testing data; (dim x N)
% ref -- number of mixture component
trainData = rand(5,100);
testData = rand(2,100);
Data = [trainData;testData];
MFAmodel.latent_dim = 2;
MFAmodel.num_of_mix_comp = 3;
MFAmodel.iso = 1;
MFAmodel.eq = 1;
MFAmodel.verbosity = 0;
[LogL, mfa, Q] = mfa(Data, MFAmodel.latent_dim, MFAmodel.num_of_mix_comp, ...
    MFAmodel.iso, MFAmodel.eq, MFAmodel.verbosity);
% --------

[col, row] = size(testData);
data = testData';

mu_x = mfa.M(1:col, :);
latent_dim = size(mfa.W,2);
KK = size(mu_x,2);

P_k = mfa.W(1:col,:,i); sigma_x = mfa.Psi(1:col,:);
Q_k = zeros(latent_dim, col, KK);
var_hat_t_k = zeros(latent_dim, latent_dim, KK);
hat_t_k = zeros(latent_dim, row, KK);
for i = 1:KK
    tmp_P_k = P_k(:,:,i);
    tmp_sigma = diag(mfa.Psi(:,i).^(1/2));  % \delta_x,k
    Q_k(:,:,i) = tmp_P_k' / (tmp_P_k*tmp_P_k'+tmp_sigma);  % under Eq.(8)
    var_hat_t_k(:,:,i) = Q_k(:,:,i) * (tmp_P_k*tmp_P_k'+tmp_sigma) * Q_k(:,:,i)';  % Eq.(16)
    
    tmp = inputData' - repmat(mu(:,i),1,nbData);
    hat_t_k(:,:,i) = Q_k(:,:,i) * tmp; % Eq.(15)
end











