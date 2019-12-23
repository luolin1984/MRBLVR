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

function s=logsumexp(x)
y=max(x,[],2);
s=y+log(sum(exp(x-repmat(y,1,size(x,2))),2));
end
% y=max(x,[],2);
% s=y+log(sum(exp(x-y)));