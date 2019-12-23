function [Tsquare, SPE] = stat_mfa(inputData, MFAmodel, mfa)
% inputData = X; % (N x dim)
% paper:
%   2010--(11)(¸ðÖ¾Ç¿)Maximum-likelihood mixture factor analysis model and its application for process monitoring
mu = mfa.M;   % (dim x num_of_mix_comp)

latent_dim = MFAmodel.latent_dim;

KK = size(mu,2);
[nbData, Dim] = size(inputData);

Q_k = zeros(latent_dim, Dim, KK);
var_hat_t_k = zeros(latent_dim, latent_dim, KK);
hat_t_k = zeros(latent_dim,nbData,KK);
for i = 1:KK
    tmp_P_k = mfa.W(:,:,i);
    tmp_sigma = diag(mfa.Psi(:,i).^(1/2));  % \delta_x,k
    Q_k(:,:,i) = tmp_P_k' / (tmp_P_k*tmp_P_k'+tmp_sigma);  % under Eq.(8)
    var_hat_t_k(:,:,i) = Q_k(:,:,i) * (tmp_P_k*tmp_P_k'+tmp_sigma) * Q_k(:,:,i)';  % Eq.(16)
    
    tmp = inputData' - repmat(mu(:,i),1,nbData);
    hat_t_k(:,:,i) = Q_k(:,:,i) * tmp; % Eq.(15)
end

hat_e_k = zeros(nbData,Dim,KK);
Tsquare_k = zeros(nbData,KK);
SPE_k = zeros(nbData,KK);
for i = 1:KK
    tmp_hat_t_k = hat_t_k(:,:,i);
    tmp_var_hat_t_k = var_hat_t_k(:,:,i);
    tmp_mu = mu(:,i);
    tmp_W = mfa.W(:,:,i);
    tmp_sigma = diag(mfa.Psi(:,i).^(1/2));
    for j = 1:nbData
        tmp_P_hat_t = tmp_W * tmp_hat_t_k(:,j);
        hat_e_k(j,:,i) = inputData(j,:) - tmp_mu' - tmp_P_hat_t';
        Tsquare_k(j,i) = tmp_hat_t_k(:,j)' * tmp_var_hat_t_k * tmp_hat_t_k(:,j);
        SPE_k(j,i) = hat_e_k(j,:,i)*tmp_sigma*hat_e_k(j,:,i)';
    end
end

Tsquare = sum(Tsquare_k,2);
SPE = sum(SPE_k,2);













