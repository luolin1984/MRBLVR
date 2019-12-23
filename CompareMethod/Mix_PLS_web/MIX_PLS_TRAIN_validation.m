function [par,Q_plot,ee]=MIX_PLS_TRAIN_validation(x,y,x_val,y_val,ne,n_int)
% function [par,Q_plot]=MIX_PLS_TRAIN(x,y,n_int,ne,flag)
% x: input matrix (m x n)
%                 m: number of samples, n = number of variables
% y: output vector
% n_int: number of iterations of ME.
% ne: number of experts

% It returns a struct par containing several parameters of MIX-PLS
% learning.
% par contains all PLS parameters of gates and experts. As well it containg
% the num

% For use with MATLAB
% Copyright (C) 2014 -- Francisco Souza <alexandre.andry@gmail.com> or <fasouza@isr.uc.pt>
% MIX-PLS comes with ABSOLUTELY NO WARRANTY;
% In case of publication of any application of this method,
% please, cite the original work:
% [FSRA2014]:
% Francisco A.A. Souza, Rui Araújo, Mixture of partial least squares
% experts and application in prediction settings with multiple operating
% modes, Chemometrics and Intelligent Laboratory Systems, Volume 130,
% 15 January 2014, Pages 192-202.
% DOI: http://dx.doi.org/10.1016/j.chemolab.2013.11.006.
% www.isr.uc.pt/~fasouza

% Whenever as possible, the equations described in the MATLAB file will be
% followed by the respective equation in the paper [FSRA2014].

if(nargin==2)
    ne=2;
    n_int = 500;
end

% initialization of the parameters MIX-PLS algorithm.
% experts parameters are designed by theta.
% gates parameters are designed by v.

[m,n]=size(x); % get the number of variables and samples
theta = cell(ne,1); % set theta to cell, where each cell contains
% the parameters of the experts.
v = cell(ne,1);     % similar to above.

% initialization
for i=1:ne
    theta{i}=(rand(n, 1)*0.2)-0.1;
    if(i==1)
        v{1}=zeros(n,1);
    else
        v{i}=(rand(n, 1)*0.2)-0.1;
    end
end
% variance of experts v
gv = 500*ones(1,ne);

% initialize variables
ypred = zeros(m,ne);
prob = zeros(m,ne);
gate_out = zeros(m,ne);
pi = zeros(m,ne);
e = zeros(m,ne);
resp = zeros(m,ne);
% Q_plot = zeros(n_int,1);
nLatv=0;
par.theta = theta;
par.v = v;
par.ne=ne;
eTotal = Inf;

for i=1:n_int
    %% E STEP
    
    % Compute responsabilities for each expert.
    % In [FSRA2014] it is given by Eq. 20.
    % begin ==============================================================
    for j=1:ne
        ypred(:,j) = x*theta{j};
        prob(:,j) = normpdf(y,ypred(:,j),sqrt(gv(j)));
    end
    
    for j=1:ne
        gate_out(:,j) = x*v{j};
    end
    
    pi = exp(gate_out - repmat(logsumexp(gate_out),1,ne));
    for l=1:m
        for j=1:ne
            resp(l,j) = (pi(l,j)*prob(l,j)+eps)/(prob(l,:)*pi(l,:)'+eps);
        end
    end
    % end ==============================================================
    
    % Compute likelihood function or expectation function
    % In [FSRA2014] it is given by Eq. 19.
    % begin ==============================================================
    Q  =0;
    for l=1:m
        for j=1:ne % compute weights
            Q = Q + resp(l,j)*(log(pi(l,j)+eps) + log(prob(l,j)+eps));
        end
    end
    Q_plot(i) = Q;
    fprintf('>>>>>>> Iteration: %d >>>>>>> Expectation: %04f\n',i,Q_plot(i))
    % end ==============================================================
    
    
    %% M STEP
    
    % EXPERTS ===================================================
    % Update the experts parameters theta.
    % In [FSRA2014] it is given by Section 4.2.
    for j=1:ne
        % diagonal matrix containing the resposibilities.
        w = diag(resp(:,j));
        % running PLS algorithm with Eq. 23 and 24 of [FSRA2014]
        [bb,p,q,W,t,u,inner] = ...
            mvplsnipals(sqrt(w)*x,sqrt(w)*y,400);
        
        if(size(t,2)==0),theta{j} = bb(1,:)';
        else
            % [FSRA2014] it is given by equation 28.
            for NL=1:size(t,2)
                par.theta{j} = bb(NL,:)'; % theta of expert j with NL latent variables
                RSS = sum(((MIX_PLS_TEST(x_val,par) - y_val).^2)); % residual sum of squares.
                criterion(NL) = RSS;
            end
            % Select the number of latent variables that minimizes the BIC
            % criterion
            [~,idx]=min(criterion);
            nLat(j)=idx;
            % update the model by setting the correct number of latent
            % variables.
            theta{j}=bb(idx,:)';
        end
        % save in struct par
        par.p{j}=p; par.q{j}=q; par.W{j}=W; par.t{j}=t;
        par.u{j}=u; par.inner{j}=inner;
        par.theta{j}=theta{j};
    end
    
    % GATES ===================================================
    % Update the parameters of gate v
    % In [FSRA2014] it is given by Section 4.2.
    for j=2:ne
        % compute the outputs of gates
        % In [FSRA2014] it is given by Section 29.
        % begin ==============================================================
        for k=1:ne
            gate_out(:,k) = x*v{k};
        end
        Mpi = exp(gate_out - repmat(logsumexp(gate_out),1,ne));
        % end ==============================================================
        
        Rp = diag(Mpi(:,j).*(1-Mpi(:,j))); % compute R_p
        %zp=x*v{j} + pinv(Rp,1e-6)*((resp(:,j)-Mpi(:,j)));
        %zp=x*v{j} + Rp \ ((resp(:,j)-Mpi(:,j)));
        zp=x*v{j} + diag(1./(Mpi(:,j).*(1-Mpi(:,j)))+0.01)*(resp(:,j)-Mpi(:,j));
        [bb,p1,q1,w1,t1,u1,inner1] = ...
            mvplsnipals(sqrt(Rp)*x,sqrt(Rp)*zp,400);
        
        if(size(t1,2)==0), v{j} = bb(1,:)';
        else
            for NL=1:size(t1,2)
                par.v{j}=bb(NL,:)';
                RSS = sum(((MIX_PLS_TEST(x_val,par) - y_val).^2)); % residual sum of squares.
                criterion(NL) = RSS;
            end
            % Select the number of latent variables that minimizes the BIC
            % criterion
            [~,idx]=min(criterion);
            nLatv(j)=idx;
            v{j} = bb(idx,:)';
        end
        % save
        par.p1{j}=p1; par.q1{j}=q1; par.w1{j}=w1; par.t1{j}=t1;
        par.u1{j}=u1; par.inner1{j}=inner1;
        par.v{j}=v{j};
    end
    
    % compute the variance of each model with the parameter theta.
    % we know that the value of gv can be get while selecting the values of
    % latent variables in the EXPERTS. However, following old codes we let
    % it here.
    % However, it will be optimized in future
    for j=1:ne % compute the error of each model
        ypred(:,j) = x*theta{j};
        e(:,j) = (ypred(:,j) - y).^2;
    end
    
    for j=1:ne
        E(j) = sum(resp(:,j).*e(:,j));
        gv(j)=((E(j)+eps)/sum(resp(:,j))+eps);
        par.sumResp(j) = sum(resp(:,j));
    end
    par.Eup = E;
    
    Erro(i)=sum(gv);
    
    
    ee(i) = sum(((MIX_PLS_TEST(x_val,par) - y_val).^2));
    eVal(i)=1/length(y_val)*sum(((MIX_PLS_TEST(x_val,par) - y_val).^2));
    eTrain(i)=1/length(y)*sum(((MIX_PLS_TEST(x,par) - y).^2));
    
    figure(1)
    plot(1:i,[eTrain' eVal'], '-o', 'LineWidth',2, 'YDataSource','eTrain');
    drawnow;
    legend('Train','Validation')
    grid on;

    if(i> 1 && (ee(i) < eTotal))
        eTotal = ee(i);
        ePar  = par;
        iplus = 0;
    end
    
    if (i>10 && (ee(i)>eTotal))
        iplus = iplus + 1;
    end
    
    % Make a convergence test.
    %if(i>10 && convergenceTest(Q_plot(i),Q_plot(i-1)))
    if(i>10 && iplus== 6)
        par = ePar;
        %         figure(1)
%         grid on
%         plot(ee)
%         
        break;
    end
    
end


par.Int = i;
% save parameters of each expert
par.lv=nLat;
par.lv1= nLatv;
par.v{1}=v{1};
par.gv = gv;
par.Erro=Erro;
par.ne = ne;

end

function [converged] = convergenceTest(fval, previous_fval, threshold, warn)
% Check if an objective function has converged
%
% We have converged if the slope of the function falls below 'threshold',
% i.e., |f(t) - f(t-1)| / avg < threshold,
% where avg = (|f(t)| + |f(t-1)|)/2
% 'threshold' defaults to 1e-4.
% This stopping criterion is from Numerical Recipes in C p423
% This file is from pmtk3.googlecode.com


if nargin < 3, threshold = 1e-3; end
if nargin < 4, warn = false; end

converged = 0;
delta_fval = abs(fval - previous_fval);
avg_fval = (abs(fval) + abs(previous_fval) + eps)/2;
if (delta_fval / avg_fval) < threshold,
    converged = 1;
end

if warn && (fval-previous_fval) < -2*eps %fval < previous_fval
    warning('convergenceTest:fvalDecrease', 'objective decreased!');
end

% converged = 0;
end

