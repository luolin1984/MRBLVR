% function [par,Q_plot]=MIX_PLS_TEST(x,par)
% x: input matrix (m x n)
%                 m: number of samples, n = number of variables
% par: parameters of trained MIX-PLS model

% It returns the output of MIX-PLS model defined by par, when using inputs
% x

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

function [youtMoE,pi]=MIX_PLS_TEST(x,par)
theta = par.theta;
v =par.v;
ne = par.ne;
[m,n]=size(x);
 for j=1:ne
        gate_out(:,j) = (x)*v{j};
        ypred(:,j) = (x)*theta{j};
 end    

 pi = exp(gate_out - repmat(logsumexp(gate_out),m,1));
 youtMoE = sum(ypred.*pi,2);

end
