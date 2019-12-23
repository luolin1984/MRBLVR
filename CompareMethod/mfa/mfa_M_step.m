function 	mfa = mfa_M_step(X,X2,Q,Lats,lat_covs,iso,eq)

D       = size(X,1);
[d,N,C] = size(Lats);
mfa.Lats = Lats;

for c=1:C; % M-step
        sumQ         = sum(Q(c,:));
        lats         = [Lats(:,:,c); ones(1,N)];
        Qlats        = repmat(Q(c,:),d+1,1) .* lats;
        XQlats       = X*Qlats';
        tmp          = lats*Qlats'; 
        tmp(1:d,1:d) = tmp(1:d,1:d) + sumQ * lat_covs(:,:,c);
        mfa.latent_covs(:,:,c) = tmp(1:d,1:d) + sumQ * lat_covs(:,:,c); % ����Eqs.(16)
        tmp          = mrdivide( XQlats, tmp);   
        mfa.tmp{c} = tmp;  % ����Eqs.(16)
 
        mfa.W(:,:,c)     = tmp(:,1:d);            
        mfa.M(:,c)       = tmp(:,d+1);

        mfa.Psi(:,c)     = (X2*Q(c,:)' - sum(  tmp.*XQlats,2)) / sumQ;
        mfa.Psi(:,c)     = max(mfa.Psi(:,c),1e-8);
        
        if iso; mfa.Psi(:,c) = mean(mfa.Psi(:,c));end
        mfa.mix(c,1)     = sumQ / N;
        
end 

if eq;  mfa.Psi = (mfa.Psi*mfa.mix)*ones(1,C); end