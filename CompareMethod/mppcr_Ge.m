function [hat_y_new,Tsquare] = mppcr_Ge(newdataX, mfa, KK)
%
% INPUT:
%  newdataX : Dim x N
%  mfa      : Dimension Reduction model by MLMFA
%  K        : Number of mixture components
% OUTPUT:
%  hat_y_new : prediction of output
% 

% Get P_k and C_k
P_k = mfa.W(1:size(newdataX,1),:,:);
C_k = mfa.W(size(newdataX,1)+1:end,:,:); % Dim_y x latent_dim x K

% Get \hat{t}_{k,new} and \hat{y}_{k,new} in Eq.(31) and Eq.(32)
mu_x = mfa.M(1:size(newdataX,1),:);
sigma_x = mfa.Psi(1:size(newdataX,1),:);
for i = 1:KK
    tmp_P_k = P_k(:,:,i); % (Dim_{x} x red_dim x K)
    tmp_sigma = diag(sigma_x(:,i).^(1/2));  % \delta_x,k
    Q_k(:,:,i) = tmp_P_k' / (tmp_P_k*tmp_P_k'+tmp_sigma);  % left part in the right Eq.(31), which is equal to Eq.(8) in
                                                          %2010--(11)Maximum-likelihood mixture factor analysis model and its application for process monitoring
    var_hat_t_k(:,:,i) = Q_k(:,:,i) * (tmp_P_k*tmp_P_k'+tmp_sigma) * Q_k(:,:,i)';  % Eq.(16)
    
    tmp = newdataX - repmat(mu_x(:,i),1,size(newdataX,2));
    hat_t_k(:,:,i) = Q_k(:,:,i) * tmp; % Eq.(31)(Dim_{x} x N_{new} x K)
    
    tmp_C_k = C_k(:,:,i);
    hat_y_k(:,:,i) = tmp_C_k * hat_t_k(:,:,i);  % Eq.(32)
    hat_y_k_ttmp(:,:,i) = hat_y_k(:,:,i) + repmat(mfa.M(size(newdataX,1)+1:end,i),1,size(newdataX,2));
    
    hat_y_new_tmp(:,:,i) = mfa.mix(i) .* hat_y_k_ttmp(:,:,i);
end
hat_y_new = sum(hat_y_new_tmp,3);

tmp_data = newdataX';
[nbData, Dim] = size(tmp_data);

hat_e_k = zeros(nbData,Dim,KK);
Tsquare_k = zeros(nbData,KK);
for i = 1:KK
    tmp_hat_t_k = hat_t_k(:,:,i);
    tmp_var_hat_t_k = var_hat_t_k(:,:,i);
    tmp_mu = mu_x(:,i);
    tmp_W = P_k(:,:,i);
    for j = 1:nbData
        tmp_P_hat_t = tmp_W * tmp_hat_t_k(:,j);
        hat_e_k(j,:,i) = tmp_data(j,:) - tmp_mu' - tmp_P_hat_t';
        Tsquare_k(j,i) = tmp_hat_t_k(:,j)' * tmp_var_hat_t_k * tmp_hat_t_k(:,j);
    end
end

Tsquare = sum(Tsquare_k,2);


    









