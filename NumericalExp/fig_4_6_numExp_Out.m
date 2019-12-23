% figure(1)
% subplot(5,1,1)
% plot(dataExp.dataX(:,1),'b','LineWidth', 1.3, 'MarkerSize', 6)
% ylabel('$ \mathbf{x_{1}} $','interpreter','latex','fontsize',15,'fontweight','b');
% subplot(5,1,2)
% plot(dataExp.dataX(:,2),'b','LineWidth', 1.3, 'MarkerSize', 6)
% ylabel('$ \mathbf{x_{2}} $','interpreter','latex','fontsize',15,'fontweight','b');
% subplot(5,1,3)
% plot(dataExp.dataX(:,3),'b','LineWidth', 1.3, 'MarkerSize', 6)
% ylabel('$ \mathbf{x_{3}} $','interpreter','latex','fontsize',15,'fontweight','b');
% subplot(5,1,4)
% plot(dataExp.dataX(:,4),'b','LineWidth', 1.3, 'MarkerSize', 6)
% ylabel('$ \mathbf{x_{4}} $','interpreter','latex','fontsize',15,'fontweight','b');
% subplot(5,1,5)
% plot(dataExp.dataX(:,5),'b','LineWidth', 1.3, 'MarkerSize', 6)
% xlabel('# samples','fontsize',15,'Fontname','times new Roman','fontweight','b');
% ylabel('$ \mathbf{x_{5}} $','interpreter','latex','fontsize',15,'fontweight','b');
% % fn = 'D:\paper\论文7(投)--AIChE鲁棒混合BayesianPCR在软测量中的应用\AIChE\Pictures\Fig1a'; 
% % print(gcf, '-depsc2', fn)
% 
% figure(2)
% subplot(2,1,1)
% plot(dataExp.dataY(:,1),'b','LineWidth', 1.3, 'MarkerSize', 6)
% ylabel('$ \mathbf{y_{1}} $','interpreter','latex','fontsize',15,'fontweight','b');
% subplot(2,1,2)
% plot(dataExp.dataY(:,2),'b','LineWidth', 1.3, 'MarkerSize', 6)
% xlabel('# samples','fontsize',15,'Fontname','times new Roman','fontweight','b');
% ylabel('$ \mathbf{y_{2}} $','interpreter','latex','fontsize',15,'fontweight','b');
% 
% % fn = 'D:\paper\论文7(投)--AIChE鲁棒混合BayesianPCR在软测量中的应用\AIChE\Pictures\Fig1b'; 
% % print(gcf, '-depsc2', fn)
% 
%% plot new unobservations
figure(3)
plot(newdataY(1,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(hat_y_new(1,:),'ro--','LineWidth', 1.3, 'MarkerSize', 2); hold off
xlabel('# samples','fontsize',30,'Fontname','times new Roman','fontweight','b');
ylabel('$ \mathbf{y_{1}} $','interpreter','latex','fontsize',30,'fontweight','b');
[legend_h, object_h, plot_h, text_strings] =  legend('Reference','MPPCR','Location','SouthEast');
set(legend_h, 'fontsize',20,'fontweight','b')
set(plot_h, 'MarkerSize', 10)
% fn = 'D:\paper\论文7(投)--AIChE鲁棒混合BayesianPCR在软测量中的应用\AIChE\Pictures\Fig4a'; 
% print(gcf, '-depsc2', fn)

figure(4)
plot(newdataY(1,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(eYn(1,:),'k.-','LineWidth', 1.3, 'MarkerSize', 6); hold off
xlabel('# samples','fontsize',30,'Fontname','times new Roman','fontweight','b');
ylabel('$ \mathbf{y_{1}} $','interpreter','latex','fontsize',30,'fontweight','b');
[legend_h, object_h, plot_h, text_strings] =  legend('Reference','MRBPCR','Location','SouthEast');
set(legend_h, 'fontsize',20,'fontweight','b')
set(plot_h, 'MarkerSize', 10)
% fn = 'D:\paper\论文7(投)--AIChE鲁棒混合BayesianPCR在软测量中的应用\AIChE\Pictures\Fig4b'; 
% print(gcf, '-depsc2', fn)

figure(5)
plot(newdataY(1,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(GMMres.xstar(1,:),'x--','Color',[0, 191, 255]/255,'LineWidth', 1.3, 'MarkerSize', 2);hold off
xlabel('# samples','fontsize',30,'Fontname','times new Roman','fontweight','b');
ylabel('$ \mathbf{y_{1}} $','interpreter','latex','fontsize',30,'fontweight','b');
[legend_h, object_h, plot_h, text_strings] =  legend('Reference','GMR','Location','SouthEast');
set(legend_h, 'fontsize',20,'fontweight','b')
set(plot_h, 'MarkerSize', 10)
% fn = 'D:\paper\论文7(投)--AIChE鲁棒混合BayesianPCR在软测量中的应用\AIChE\Pictures\Fig4c'; 
% print(gcf, '-depsc2', fn)

figure(6)
plot(newdataY(1,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(Y_est_test1,'s:','MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',2,'LineWidth', 1.3);
xlabel('# samples','fontsize',30,'Fontname','times new Roman','fontweight','b');
ylabel('$ \mathbf{y_{1}} $','interpreter','latex','fontsize',30,'fontweight','b');
[legend_h, object_h, plot_h, text_strings] =  legend('Reference','Mix-PLS','Location','SouthEast');
set(legend_h, 'fontsize',20,'fontweight','b')
set(plot_h, 'MarkerSize', 7)
% fn = 'D:\paper\论文7(投)--AIChE鲁棒混合BayesianPCR在软测量中的应用\AIChE\Pictures\Fig4d'; 
% print(gcf, '-depsc2', fn)

figure(7)
plot(newdataY(2,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(hat_y_new(2,:),'ro--','LineWidth', 1.3, 'MarkerSize', 2); hold off
xlabel('# samples','fontsize',30,'Fontname','times new Roman','fontweight','b');
ylabel('$ \mathbf{y_{2}} $','interpreter','latex','fontsize',30,'fontweight','b');
[legend_h, object_h, plot_h, text_strings] =  legend('Reference','MPPCR','Location','SouthEast');
set(legend_h, 'fontsize',20,'fontweight','b')
set(plot_h, 'MarkerSize', 10)
% fn = 'D:\paper\论文7(投)--AIChE鲁棒混合BayesianPCR在软测量中的应用\AIChE\Pictures\Fig4e'; 
% print(gcf, '-depsc2', fn)

figure(8)
plot(newdataY(2,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(eYn(2,:),'k.-','LineWidth', 1.3, 'MarkerSize', 6); hold off
xlabel('# samples','fontsize',30,'Fontname','times new Roman','fontweight','b');
ylabel('$ \mathbf{y_{2}} $','interpreter','latex','fontsize',30,'fontweight','b');
[legend_h, object_h, plot_h, text_strings] =  legend('Reference','MRBPCR','Location','SouthEast');
set(legend_h, 'fontsize',20,'fontweight','b')
set(plot_h, 'MarkerSize', 10)
% fn = 'D:\paper\论文7(投)--AIChE鲁棒混合BayesianPCR在软测量中的应用\AIChE\Pictures\Fig4f'; 
% print(gcf, '-depsc2', fn)

figure(9)
plot(newdataY(2,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(GMMres.xstar(2,:),'x--','Color',[0, 191, 255]/255,'LineWidth', 1.3, 'MarkerSize', 2);hold off
xlabel('# samples','fontsize',30,'Fontname','times new Roman','fontweight','b');
ylabel('$ \mathbf{y_{2}} $','interpreter','latex','fontsize',30,'fontweight','b');
[legend_h, object_h, plot_h, text_strings] =  legend('Reference','GMR','Location','SouthEast');
set(legend_h, 'fontsize',20,'fontweight','b')
set(plot_h, 'MarkerSize', 10)
% fn = 'D:\paper\论文7(投)--AIChE鲁棒混合BayesianPCR在软测量中的应用\AIChE\Pictures\Fig4g'; 
% print(gcf, '-depsc2', fn)

figure(10)
plot(newdataY(2,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(Y_est_test2,'s:','MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',2,'LineWidth', 1.3);
xlabel('# samples','fontsize',30,'Fontname','times new Roman','fontweight','b');
ylabel('$ \mathbf{y_{2}} $','interpreter','latex','fontsize',30,'fontweight','b');
[legend_h, object_h, plot_h, text_strings] =  legend('Reference','Mix-PLS','Location','SouthEast');
set(legend_h, 'fontsize',20,'fontweight','b')
set(plot_h, 'MarkerSize', 7)
% fn = 'D:\paper\论文7(投)--AIChE鲁棒混合BayesianPCR在软测量中的应用\AIChE\Pictures\Fig4h'; 
% print(gcf, '-depsc2', fn)


% %% plot Q-Q
% figure(11)
% plot(newdataY(1,:),hat_y_new(1,:),'ro'); hold on
% lh1 = line([0 12],[0 12]);
% set(lh1,'LineWidth',1.75);
% xlabel('$ \mathbf{y_{1}} $','interpreter','latex','fontsize',30,'fontweight','b');
% ylabel('$ \mathbf{\hat{y}_{1}}$','interpreter','latex','fontsize',30,'fontweight','b');
% [legend_h, object_h, plot_h, text_strings] =  legend('MPPCR','Location','SouthEast');
% set(legend_h, 'fontsize',20,'fontweight','b')
% set(plot_h, 'MarkerSize', 10)
% % fn = 'D:\paper\论文7(投)--AIChE鲁棒混合BayesianPCR在软测量中的应用\AIChE\Pictures\Fig5a'; 
% % print(gcf, '-depsc2', fn)
% 
% figure(12)
% plot(newdataY(1,:),eYn(1,:),'k.'); hold on
% lh1 = line([0 12],[0 12]);
% set(lh1,'LineWidth',1.75);
% xlabel('$ \mathbf{y_{1}} $','interpreter','latex','fontsize',30,'fontweight','b');
% ylabel('$ \mathbf{\hat{y}_{1}}$','interpreter','latex','fontsize',30,'fontweight','b');
% [legend_h, object_h, plot_h, text_strings] =  legend('MRBPCR','Location','SouthEast');
% set(legend_h, 'fontsize',20,'fontweight','b')
% set(plot_h, 'MarkerSize', 20)
% % fn = 'D:\paper\论文7(投)--AIChE鲁棒混合BayesianPCR在软测量中的应用\AIChE\Pictures\Fig5b'; 
% % print(gcf, '-depsc2', fn)
% 
% figure(13)
% plot(newdataY(1,:),GMMres.xstar(1,:),'x','Color',[0, 191, 255]/255); hold on
% lh1 = line([0 12],[0 12]);
% set(lh1,'LineWidth',1.75);
% xlabel('$ \mathbf{y_{1}} $','interpreter','latex','fontsize',30,'fontweight','b');
% ylabel('$ \mathbf{\hat{y}_{1}}$','interpreter','latex','fontsize',30,'fontweight','b');
% [legend_h, object_h, plot_h, text_strings] =  legend('GMR','Location','SouthEast');
% set(legend_h, 'fontsize',20,'fontweight','b')
% set(plot_h, 'MarkerSize', 10)
% % fn = 'D:\paper\论文7(投)--AIChE鲁棒混合BayesianPCR在软测量中的应用\AIChE\Pictures\Fig5c'; 
% % print(gcf, '-depsc2', fn)
% 
% figure(14)
% plot(newdataY(1,:),Y_est_test1,'s','MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',2); hold on
% lh1 = line([0 12],[0 12]);
% set(lh1,'LineWidth',1.75);
% xlabel('$ \mathbf{y_{1}} $','interpreter','latex','fontsize',30,'fontweight','b');
% ylabel('$ \mathbf{\hat{y}_{1}}$','interpreter','latex','fontsize',30,'fontweight','b');
% [legend_h, object_h, plot_h, text_strings] =  legend('Mix-PLS','Location','SouthEast');
% set(legend_h, 'fontsize',20,'fontweight','b')
% set(plot_h, 'MarkerSize', 7)
% % fn = 'D:\paper\论文7(投)--AIChE鲁棒混合BayesianPCR在软测量中的应用\AIChE\Pictures\Fig5d'; 
% % print(gcf, '-depsc2', fn)
% 
% figure(15)
% plot(newdataY(2,:),hat_y_new(2,:),'ro'); hold on
% lh1 = line([-5 30],[-5 30]);
% set(lh1,'LineWidth',1.75);
% xlabel('$ \mathbf{y_{2}} $','interpreter','latex','fontsize',30,'fontweight','b');
% ylabel('$ \mathbf{\hat{y}_{2}}$','interpreter','latex','fontsize',30,'fontweight','b');
% [legend_h, object_h, plot_h, text_strings] =  legend('MPPCR','Location','SouthEast');
% set(legend_h, 'fontsize',20,'fontweight','b')
% set(plot_h, 'MarkerSize', 10)
% % fn = 'D:\paper\论文7(投)--AIChE鲁棒混合BayesianPCR在软测量中的应用\AIChE\Pictures\Fig5e'; 
% % print(gcf, '-depsc2', fn)
% 
% figure(16)
% plot(newdataY(2,:),eYn(2,:),'k.'); hold on
% lh1 = line([-5 30],[-5 30]);
% set(lh1,'LineWidth',1.75);
% xlabel('$ \mathbf{y_{2}} $','interpreter','latex','fontsize',30,'fontweight','b');
% ylabel('$ \mathbf{\hat{y}_{2}}$','interpreter','latex','fontsize',30,'fontweight','b');
% [legend_h, object_h, plot_h, text_strings] =  legend('MRBPCR','Location','SouthEast');
% set(legend_h, 'fontsize',20,'fontweight','b')
% set(plot_h, 'MarkerSize', 20)
% % fn = 'D:\paper\论文7(投)--AIChE鲁棒混合BayesianPCR在软测量中的应用\AIChE\Pictures\Fig5f'; 
% % print(gcf, '-depsc2', fn)
% 
% figure(17)
% plot(newdataY(2,:),GMMres.xstar(2,:),'cx'); hold on
% lh1 = line([-5 30],[-5 30]);
% set(lh1,'LineWidth',1.75);
% xlabel('$ \mathbf{y_{2}} $','interpreter','latex','fontsize',30,'fontweight','b');
% ylabel('$ \mathbf{\hat{y}_{2}}$','interpreter','latex','fontsize',30,'fontweight','b');
% [legend_h, object_h, plot_h, text_strings] =  legend('GMR','Location','SouthEast');
% set(legend_h, 'fontsize',20,'fontweight','b')
% set(plot_h, 'MarkerSize', 10)
% % fn = 'D:\paper\论文7(投)--AIChE鲁棒混合BayesianPCR在软测量中的应用\AIChE\Pictures\Fig5g'; 
% % print(gcf, '-depsc2', fn)
% 
% figure(18)
% plot(newdataY(2,:),Y_est_test2,'s','MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',2); hold on
% lh1 = line([-5 30],[-5 30]);
% set(lh1,'LineWidth',1.75);
% xlabel('$ \mathbf{y_{2}} $','interpreter','latex','fontsize',30,'fontweight','b');
% ylabel('$ \mathbf{\hat{y}_{2}}$','interpreter','latex','fontsize',30,'fontweight','b');
% [legend_h, object_h, plot_h, text_strings] =  legend('Mix-PLS','Location','SouthEast');
% set(legend_h, 'fontsize',20,'fontweight','b')
% set(plot_h, 'MarkerSize', 7)
% % fn = 'D:\paper\论文7(投)--AIChE鲁棒混合BayesianPCR在软测量中的应用\AIChE\Pictures\Fig5h'; 
% % print(gcf, '-depsc2', fn)