clc;clear;
load res11-3.mat

nn = 15;
yn = 10;
figure(1)
subplot(4,1,1)
plot(Res_raw_Y(1,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(Res_raw_rbppcr(1,:),'ro--','LineWidth', 1.3, 'MarkerSize', 2);hold on
plot([200,200],[4,5],'k--');
annotation('textbox',[0.070,0.94,0.46,0.06],'BackgroundColor', 'g','LineStyle','-','LineWidth',1,...
     'String', 'Mode 1','HorizontalAlignment','center','VerticalAlignment','middle',...
     'FontName', 'times new Roman', 'FontSize', nn,'fontweight','b');  % [0.13,0.865,0.39,0.08] = [x_begin y_begin length height]
annotation('textbox',[0.526,0.94,0.455,0.06],'BackgroundColor', 'y','LineStyle','-','LineWidth',1,...
     'String', 'Mode 2','HorizontalAlignment','center','VerticalAlignment','middle',...
     'FontName', 'times new Roman', 'FontSize', nn,'fontweight','b');
ylabel('Oxygen content (VOL%)','fontsize',yn,'Fontname','times new Roman','fontweight','b');
xlabel('(a)','fontsize',13,'Fontname','times new Roman','fontweight','b');

subplot(4,1,2)
plot(Res_raw_Y(1,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(Res_raw_mppcr(1,:),'ro--','LineWidth', 1.3, 'MarkerSize', 2);hold on
plot([200,200],[4,5],'k--');
ylabel('Oxygen content (VOL%)','fontsize',yn,'Fontname','times new Roman','fontweight','b');
xlabel('(b)','fontsize',13,'Fontname','times new Roman','fontweight','b');
legend('Lab results','Predictions')

subplot(4,1,3)
plot(Res_raw_Y(1,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(Res_raw_gmm(1,:),'ro--','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot([200,200],[4,5],'k--');
ylabel('Oxygen content (VOL%)','fontsize',yn,'Fontname','times new Roman','fontweight','b');
xlabel('(c)','fontsize',13,'Fontname','times new Roman','fontweight','b');

subplot(4,1,4)
plot(Res_raw_Y(1,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(Res_raw_MixPLS(1,:),'ro--','LineWidth', 1.3, 'MarkerSize', 2);hold on
plot([200,200],[4,5],'k--');
ylabel('Oxygen content (VOL%)','fontsize',yn,'Fontname','times new Roman','fontweight','b');
xlabel('(d)','fontsize',13,'Fontname','times new Roman','fontweight','b');
tightfig;

figure(2)
subplot(4,1,1)
plot(Res_raw_Y(2,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(Res_raw_rbppcr(2,:),'ro--','LineWidth', 1.3, 'MarkerSize', 2);hold on
plot([200,200],[1,5.5],'k--');
annotation('textbox',[0.055,0.94,0.467,0.06],'BackgroundColor', 'g','LineStyle','-','LineWidth',1,...
     'String', 'Mode 1','HorizontalAlignment','center','VerticalAlignment','middle',...
     'FontName', 'times new Roman', 'FontSize', nn,'fontweight','b');  % [0.13,0.865,0.39,0.08] = [x_begin y_begin length height]
annotation('textbox',[0.519,0.94,0.465,0.06],'BackgroundColor', 'y','LineStyle','-','LineWidth',1,...
     'String', 'Mode 2','HorizontalAlignment','center','VerticalAlignment','middle',...
     'FontName', 'times new Roman', 'FontSize', nn,'fontweight','b');
ylabel('CO content (VOL%)','fontsize',yn,'Fontname','times new Roman','fontweight','b');
xlabel('(a)','fontsize',13,'Fontname','times new Roman','fontweight','b');

subplot(4,1,2)
plot(Res_raw_Y(2,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(Res_raw_mppcr(2,:),'ro--','LineWidth', 1.3, 'MarkerSize', 2);hold on
plot([200,200],[1,5.5],'k--');
ylabel('CO content (VOL%)','fontsize',yn,'Fontname','times new Roman','fontweight','b');
xlabel('(b)','fontsize',13,'Fontname','times new Roman','fontweight','b');
legend('Lab results','Predictions')

subplot(4,1,3)
plot(Res_raw_Y(2,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(Res_raw_gmm(2,:),'ro--','LineWidth', 1.3, 'MarkerSize', 2);hold on
plot([200,200],[1,5.5],'k--');
ylabel('CO content (VOL%)','fontsize',yn,'Fontname','times new Roman','fontweight','b');
xlabel('(c)','fontsize',13,'Fontname','times new Roman','fontweight','b');

subplot(4,1,4)
plot(Res_raw_Y(2,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(Res_raw_MixPLS(2,:),'ro--','LineWidth', 1.3, 'MarkerSize', 2);hold on
plot([200,200],[1,5.5],'k--');
ylabel('CO content (VOL%)','fontsize',yn,'Fontname','times new Roman','fontweight','b');
xlabel('(d)','fontsize',13,'Fontname','times new Roman','fontweight','b');
tightfig;




