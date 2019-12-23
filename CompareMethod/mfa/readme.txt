文献： 2010--(11)(葛志强)Maximum-likelihood mixture factor analysis model and its application for process monitoring
主函数：[LogL,mfa,Q] = mfa(X,d,C,iso,dia);
 输入：
    X     : data matrix (Dim x N data points)
    d     : latent dimensionality
    C     : number of mixtuer components
    iso   : use isotropic noise if 1
    eq    : use equal noise model for all components
    dia   : verbosity. 0=no output, 1=log-likelihood monitoring, 2=posterior plotting
 输出：
   LogL  : row vector of log-likelihoods after each EM iteration
   MoFA  : structure containing the Mixture of Factor Analyzers
         MoFA.W (D x d x C) : factor loading matrices
         MoFA.M (D x C)     : component means
         MoFA.Psi ( D x C ) : component noise variances
         MoFA.mix ( C x 1 ) : mixing weights
   Q     : C x N matrix of component posterior probabilities