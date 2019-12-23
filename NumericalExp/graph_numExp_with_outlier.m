%% plot data characteristics under different operation conditions
% % input data
figure(1)
subplot(5,1,1)
plot(X_outlier(:,1));

subplot(5,1,2)
plot(X_outlier(:,2));

subplot(5,1,3)
plot(X_outlier(:,3));

subplot(5,1,4)
plot(X_outlier(:,4));

subplot(5,1,5)
plot(X_outlier(:,5));
% % output data
figure(2)
subplot(2,1,1)
plot(Y_outlier(:,1));

subplot(2,1,2)
plot(Y_outlier(:,2));