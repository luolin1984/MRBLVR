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

% Computes the degree of freedom of PLS model
% implemented from plsdof package of R
% the paper describing the method is 
% Nicole Kraemer, Masashi Sugiyama, "The Degrees of Freedom of Partial Least
% Squares Regression".
function DoF=pls_dof(t,Yhat,X,y)

for i=1:size(t,2)
    TT(:,i) = t(:,i)/sqrt(sum(t(:,i).^2));
end

K=X*X';
%KK<-diag(n)
m=size(TT,2);
n=length(Yhat);

KY=krylov(K,K*y,m);

lambda=eig(K);
trK=zeros(1,m);
for i=1:m
    %KK<-K%*%KK
    trK(i)=sum(lambda.^i);
    %tr.K[i]<-tr(KK)
end
BB=TT'*KY;
BB=triu(BB);%[row(BB)>col(BB)]=0
b=TT'*y;
%DoF=zeros(m,1);
DD=diag(ones(m,1));
for i=1:m
    [Binv(:,i),flag,relres,iter,resvec]=bicgstabl(BB,DD(:,i));
end
% %Binv<-backsolve(BB,diag(m))
% Binv = inv(BB);


tkt=zeros(1,m);
ykv=zeros(1,m);
KjT=zeros(m,n,m);
dummy=TT;
for i= 1:m
    dummy=K*dummy;
    KjT(i,:,:)=dummy;
end
traceTerm=zeros(1,m);
for i=1:m
    Binvi=Binv(1:i,1:i);
    ci=Binvi*b(1:i);
    Vi=TT(:,1:i)*Binvi';
    traceTerm(i)=sum(ci.*trK(1:i)');
    ri=y-Yhat(:,i);
    for j = 1:i
        %KjTj=KjT(j,:,:);
        KjTj=reshape(KjT(j,:,:),n,m);
        tkt(i)=tkt(i)+ci(j)*trace(TT(:,1:i)'*KjTj(:,1:i));
        ri=K*ri;
        ykv(i)=ykv(i)+ sum(ri.*Vi(:,j));
    end
end
DoF=traceTerm' + (1:m)' - (tkt)' + (ykv)';
%     DoF[DoF>DoF.max]=DoF.max
%     sigmahat=sqrt(pls.object$RSS[-1]/(n-DoF))
%         return(list(DoF=DoF,sigmahat=sigmahat))

% DoF(DoF<0)=10000;
end