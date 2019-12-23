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

% adapted from pls.DoF R
% K=krylov(A,b,m)
function K=krylov(A,b,m)
K=zeros(length(b),m);
dummy=b;
for i=1:m
    K(:,i)=dummy;
    dummy=A*dummy;
end

end