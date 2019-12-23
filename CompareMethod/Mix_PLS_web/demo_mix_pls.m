% demo MIX-PLS
clc;close all;clear
load spectra;
X = NIR;
Y = octane;

X_train = X(1:48,:);
X_test = X(49:60,:);
Y_train = Y(1:48,:);
Y_test = Y(49:60,:);

% Normalize data.
[X_train,psx]=mapminmax(X_train');X_train=X_train';
X_test=mapminmax('apply',X_test',psx)';
[Y_train,psy]=mapminmax(Y_train');Y_train=Y_train';
Y_test=mapminmax('apply',Y_test',psy)';

% The code does not work well when the dimensionality of data (i.e. number
% of variables is much larger than the number of samples).
% A trick to solve this is to create a data set with more samples than the
% number of inputs. In the case of spectra data set it was done by joining
% the training data in a way that it become bigger that the number of
% variables.
% The following trick does not change the information contained in training
% data
X_train = [X_train;X_train;X_train;...
    X_train;X_train;X_train;X_train;X_train;X_train];
X_test = [X_test];

Y_train = [Y_train;Y_train;Y_train;...
    Y_train;Y_train;Y_train;Y_train;Y_train;Y_train];
Y_test = [Y_test];

% Train Mix-PLS
n_int = 10; % maximum number of iterations
ne = 2; % number of experts
[par,Q_plot]=MIX_PLS_TRAIN(X_train,Y_train,ne,n_int);
% Test Mix-PLS
[Y_est_test,Gtest] = MIX_PLS_TEST(X_test,par);

% Plot results
figure(1);
plot(Q_plot(1:13),'-o','LineWidth',2)
xlabel('Iteration');
ylabel('Expectation');
title('Expectation/Likelihood of MIX-PLS algorithm')
grid on;
figure(2);
plot(Gtest,'-o','LineWidth',1.5)
xlabel('Gates output');
ylabel('sample');
title('Gates output on test data');
grid on;
figure(3);
plot([Y_test Y_est_test],'-o','LineWidth',1.5)
xlabel('Output');
ylabel('sample');
title('Predicted and Real output');
legend('Real','Predicted');
grid on;




