clc; clear all; close all;
load TE_res_7out.mat

figure(1)
subplot(5,1,1)
plot(newdataY(1,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(hat_y_new(1,:),'ro--','LineWidth', 1.3, 'MarkerSize', 2); hold off
ylabel('D comp.','fontsize',13,'Fontname','times new Roman','fontweight','b');
[legend_h, object_h, plot_h, text_strings] =  legend('Reference','MPPCR');
set(legend_h, 'Position', [.8,.7,.1,.2], 'fontsize',10,'fontweight','b')
set(plot_h, 'MarkerSize', 10)

subplot(5,1,2)
plot(newdataY(2,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(hat_y_new(2,:),'ro--','LineWidth', 1.3, 'MarkerSize', 2); hold off
ylabel('E comp.','fontsize',13,'Fontname','times new Roman','fontweight','b');

subplot(5,1,3)
plot(newdataY(3,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(hat_y_new(3,:),'ro--','LineWidth', 1.3, 'MarkerSize', 2); hold off
ylabel('F comp.','fontsize',13,'Fontname','times new Roman','fontweight','b');

subplot(5,1,4)
plot(newdataY(4,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(hat_y_new(4,:),'ro--','LineWidth', 1.3, 'MarkerSize', 2); hold off
ylabel('G comp.','fontsize',13,'Fontname','times new Roman','fontweight','b');

subplot(5,1,5)
plot(newdataY(5,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(hat_y_new(5,:),'ro--','LineWidth', 1.3, 'MarkerSize', 2); hold off
ylabel('H comp.','fontsize',13,'Fontname','times new Roman','fontweight','b');
xlabel('# samples','fontsize',13,'Fontname','times new Roman','fontweight','b');
% fn = 'D:\paper\论文7(投)--AIChE鲁棒混合BayesianPCR在软测量中的应用\AIChE\Pictures\Fig7a'; 
% print(gcf, '-depsc2', fn)

figure(2)
subplot(5,1,1)
plot(newdataY(1,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(eYn(1,:),'k.-','LineWidth', 1.3, 'MarkerSize', 6); hold off
ylabel('D comp.','fontsize',13,'Fontname','times new Roman','fontweight','b');
[legend_h, object_h, plot_h, text_strings] =  legend('Reference','MRBPCR');
set(legend_h, 'Position', [.8,.7,.1,.2], 'fontsize',10,'fontweight','b')
set(plot_h, 'MarkerSize', 10)

subplot(5,1,2)
plot(newdataY(2,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(eYn(2,:),'k.-','LineWidth', 1.3, 'MarkerSize', 6); hold off
ylabel('E comp.','fontsize',13,'Fontname','times new Roman','fontweight','b');

subplot(5,1,3)
plot(newdataY(3,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(eYn(3,:),'k.-','LineWidth', 1.3, 'MarkerSize', 6); hold off
ylabel('F comp.','fontsize',13,'Fontname','times new Roman','fontweight','b');

subplot(5,1,4)
plot(newdataY(4,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(eYn(4,:),'k.-','LineWidth', 1.3, 'MarkerSize', 6); hold off
ylabel('G comp.','fontsize',13,'Fontname','times new Roman','fontweight','b');

subplot(5,1,5)
plot(newdataY(5,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(eYn(5,:),'k.-','LineWidth', 1.3, 'MarkerSize', 6); hold off
ylabel('H comp.','fontsize',13,'Fontname','times new Roman','fontweight','b');
xlabel('# samples','fontsize',13,'Fontname','times new Roman','fontweight','b');
% fn = 'D:\paper\论文7(投)--AIChE鲁棒混合BayesianPCR在软测量中的应用\AIChE\Pictures\Fig7b'; 
% print(gcf, '-depsc2', fn)

figure(3)
subplot(5,1,1)
plot(newdataY(1,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(GMMres.xstar(1,:),'x--','Color',[0, 191, 255]/255,'LineWidth', 1.3, 'MarkerSize', 2); hold off
ylabel('D comp.','fontsize',13,'Fontname','times new Roman','fontweight','b');
[legend_h, object_h, plot_h, text_strings] =  legend('Reference','GMR');
set(legend_h, 'Position', [.8,.7,.1,.2], 'fontsize',10,'fontweight','b')
set(plot_h, 'MarkerSize', 10)

subplot(5,1,2)
plot(newdataY(2,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(GMMres.xstar(2,:),'x--','Color',[0, 191, 255]/255,'LineWidth', 1.3, 'MarkerSize', 2); hold off
ylabel('E comp.','fontsize',13,'Fontname','times new Roman','fontweight','b');

subplot(5,1,3)
plot(newdataY(3,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(GMMres.xstar(3,:),'x--','Color',[0, 191, 255]/255,'LineWidth', 1.3, 'MarkerSize', 2); hold off
ylabel('F comp.','fontsize',13,'Fontname','times new Roman','fontweight','b');

subplot(5,1,4)
plot(newdataY(4,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(GMMres.xstar(4,:),'x--','Color',[0, 191, 255]/255,'LineWidth', 1.3, 'MarkerSize', 2); hold off
ylabel('G comp.','fontsize',13,'Fontname','times new Roman','fontweight','b');

subplot(5,1,5)
plot(newdataY(5,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(GMMres.xstar(5,:),'x--','Color',[0, 191, 255]/255,'LineWidth', 1.3, 'MarkerSize', 2); hold off
ylabel('H comp.','fontsize',13,'Fontname','times new Roman','fontweight','b');
xlabel('# samples','fontsize',13,'Fontname','times new Roman','fontweight','b');
% fn = 'D:\paper\论文7(投)--AIChE鲁棒混合BayesianPCR在软测量中的应用\AIChE\Pictures\Fig7c'; 
% print(gcf, '-depsc2', fn)

figure(4)
subplot(5,1,1)
plot(newdataY(1,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(Y_est_test1,'s:','MarkerEdgeColor','g','MarkerFaceColor','g','MarkerSize',2,'LineWidth', 1.3); hold off
ylabel('D comp.','fontsize',13,'Fontname','times new Roman','fontweight','b');
[legend_h, object_h, plot_h, text_strings] =  legend('Reference','Mix-PLS');
set(legend_h, 'Position', [.8,.7,.1,.2], 'fontsize',10,'fontweight','b')
set(plot_h, 'MarkerSize', 10)

subplot(5,1,2)
plot(newdataY(2,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(Y_est_test2,'s:','MarkerEdgeColor','g','MarkerFaceColor','g','MarkerSize',2,'LineWidth', 1.3); hold off
ylabel('E comp.','fontsize',13,'Fontname','times new Roman','fontweight','b');

subplot(5,1,3)
plot(newdataY(3,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(Y_est_test3,'s:','MarkerEdgeColor','g','MarkerFaceColor','g','MarkerSize',2,'LineWidth', 1.3); hold off
ylabel('F comp.','fontsize',13,'Fontname','times new Roman','fontweight','b');

subplot(5,1,4)
plot(newdataY(4,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(Y_est_test4,'s:','MarkerEdgeColor','g','MarkerFaceColor','g','MarkerSize',2,'LineWidth', 1.3); hold off
ylabel('G comp.','fontsize',13,'Fontname','times new Roman','fontweight','b');

subplot(5,1,5)
plot(newdataY(5,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(Y_est_test5,'s:','MarkerEdgeColor','g','MarkerFaceColor','g','MarkerSize',2,'LineWidth', 1.3); hold off
ylabel('H comp.','fontsize',13,'Fontname','times new Roman','fontweight','b');
xlabel('# samples','fontsize',13,'Fontname','times new Roman','fontweight','b');
% fn = 'D:\paper\论文7(投)--AIChE鲁棒混合BayesianPCR在软测量中的应用\AIChE\Pictures\Fig7d'; 
% print(gcf, '-depsc2', fn)