load normMode1.mat
load normMode2.mat
load normMode3.mat
load normMode4.mat
load normMode5.mat
load normMode6.mat

data_train = [norm_Mode1_train; norm_Mode2_train; norm_Mode3_train;...
    norm_Mode4_train; norm_Mode5_train; norm_Mode6_train];
figure(1)
subplot(5,1,1)
plot(data_train(:,37));
ylabel('D comp.','fontsize',10,'Fontname','times new Roman','fontweight','b');
subplot(5,1,2)
plot(data_train(:,38));
ylabel('E comp.','fontsize',10,'Fontname','times new Roman','fontweight','b');
subplot(5,1,3)
plot(data_train(:,39));
ylabel('F comp.','fontsize',10,'Fontname','times new Roman','fontweight','b');
subplot(5,1,4)
plot(data_train(:,40));
ylabel('G comp.','fontsize',10,'Fontname','times new Roman','fontweight','b');
subplot(5,1,5)
plot(data_train(:,41));
xlabel('# samples','fontsize',10,'Fontname','times new Roman','fontweight','b');
ylabel('H comp.','fontsize',10,'Fontname','times new Roman','fontweight','b');

% fn = 'D:\paper\论文7(投)--AIChE鲁棒混合BayesianPCR在软测量中的应用\AIChE\Pictures\Fig6'; 
% print(gcf, '-depsc2', fn)

data_test = [norm_Mode1_test; norm_Mode2_test; norm_Mode3_test;...
    norm_Mode4_test; norm_Mode5_test; norm_Mode6_test];
figure(2)
subplot(5,1,1)
plot(data_test(:,37));
ylabel('D comp.','fontsize',10,'Fontname','times new Roman','fontweight','b');
subplot(5,1,2)
plot(data_test(:,38));
ylabel('E comp.','fontsize',10,'Fontname','times new Roman','fontweight','b');
subplot(5,1,3)
plot(data_test(:,39));
ylabel('F comp.','fontsize',10,'Fontname','times new Roman','fontweight','b');
subplot(5,1,4)
plot(data_test(:,40));
ylabel('G comp.','fontsize',10,'Fontname','times new Roman','fontweight','b');
subplot(5,1,5)
plot(data_test(:,41));
xlabel('# samples','fontsize',10,'Fontname','times new Roman','fontweight','b');
ylabel('H comp.','fontsize',10,'Fontname','times new Roman','fontweight','b');


