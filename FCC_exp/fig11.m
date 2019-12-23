clc;clear;
load res11.mat

nn = 12;
figure(1)
plot(Res_raw_Y(1,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(Res_raw_mppcr(1,:),'ro--','LineWidth', 1.3, 'MarkerSize', 2);hold on
plot([200,200],[4,5],'k--');
annotation('textbox',[0.13,0.9,0.4,0.06],'BackgroundColor', 'g','LineStyle','-','LineWidth',1,...
     'String', 'Mode 1','HorizontalAlignment','center','VerticalAlignment','middle',...
     'FontName', 'times new Roman', 'FontSize', nn,'fontweight','b');  % [0.13,0.865,0.39,0.08] = [x_begin y_begin length height]
annotation('textbox',[0.517,0.9,0.388,0.06],'BackgroundColor', 'y','LineStyle','-','LineWidth',1,...
     'String', 'Mode 2','HorizontalAlignment','center','VerticalAlignment','middle',...
     'FontName', 'times new Roman', 'FontSize', nn,'fontweight','b');
ylabel('Oxygen concentration (VOL%)','fontsize',13,'Fontname','times new Roman','fontweight','b');

figure(2)
plot(Res_raw_Y(1,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(Res_raw_rbppcr(1,:),'ro--','LineWidth', 1.3, 'MarkerSize', 2);hold on
plot([200,200],[4,5],'k--');
annotation('textbox',[0.13,0.9,0.4,0.06],'BackgroundColor', 'g','LineStyle','-','LineWidth',1,...
     'String', 'Mode 1','HorizontalAlignment','center','VerticalAlignment','middle',...
     'FontName', 'times new Roman', 'FontSize', nn,'fontweight','b');  % [0.13,0.865,0.39,0.08] = [x_begin y_begin length height]
annotation('textbox',[0.517,0.9,0.388,0.06],'BackgroundColor', 'y','LineStyle','-','LineWidth',1,...
     'String', 'Mode 2','HorizontalAlignment','center','VerticalAlignment','middle',...
     'FontName', 'times new Roman', 'FontSize', nn,'fontweight','b');
ylabel('Oxygen concentration (VOL%)','fontsize',13,'Fontname','times new Roman','fontweight','b');

figure(3)
plot(Res_raw_Y(1,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(Res_raw_gmm(1,:),'ro--','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot([200,200],[4,5],'k--');
annotation('textbox',[0.13,0.9,0.4,0.06],'BackgroundColor', 'g','LineStyle','-','LineWidth',1,...
     'String', 'Mode 1','HorizontalAlignment','center','VerticalAlignment','middle',...
     'FontName', 'times new Roman', 'FontSize', nn,'fontweight','b');  % [0.13,0.865,0.39,0.08] = [x_begin y_begin length height]
annotation('textbox',[0.517,0.9,0.388,0.06],'BackgroundColor', 'y','LineStyle','-','LineWidth',1,...
     'String', 'Mode 2','HorizontalAlignment','center','VerticalAlignment','middle',...
     'FontName', 'times new Roman', 'FontSize', nn,'fontweight','b');
ylabel('Oxygen concentration (VOL%)','fontsize',13,'Fontname','times new Roman','fontweight','b');

figure(4)
plot(Res_raw_Y(1,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(Res_raw_MixPLS(1,:),'ro--','LineWidth', 1.3, 'MarkerSize', 2);hold on
plot([200,200],[4,5],'k--');
annotation('textbox',[0.13,0.9,0.4,0.06],'BackgroundColor', 'g','LineStyle','-','LineWidth',1,...
     'String', 'Mode 1','HorizontalAlignment','center','VerticalAlignment','middle',...
     'FontName', 'times new Roman', 'FontSize', nn,'fontweight','b');  % [0.13,0.865,0.39,0.08] = [x_begin y_begin length height]
annotation('textbox',[0.517,0.9,0.388,0.06],'BackgroundColor', 'y','LineStyle','-','LineWidth',1,...
     'String', 'Mode 2','HorizontalAlignment','center','VerticalAlignment','middle',...
     'FontName', 'times new Roman', 'FontSize', nn,'fontweight','b');
ylabel('Oxygen concentration (VOL%)','fontsize',13,'Fontname','times new Roman','fontweight','b');


figure(5)
plot(Res_raw_Y(2,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(Res_raw_mppcr(2,:),'ro--','LineWidth', 1.3, 'MarkerSize', 2);hold on
plot([200,200],[1,5.5],'k--');
annotation('textbox',[0.13,0.9,0.4,0.06],'BackgroundColor', 'g','LineStyle','-','LineWidth',1,...
     'String', 'Mode 1','HorizontalAlignment','center','VerticalAlignment','middle',...
     'FontName', 'times new Roman', 'FontSize', nn,'fontweight','b');  % [0.13,0.865,0.39,0.08] = [x_begin y_begin length height]
annotation('textbox',[0.517,0.9,0.388,0.06],'BackgroundColor', 'y','LineStyle','-','LineWidth',1,...
     'String', 'Mode 2','HorizontalAlignment','center','VerticalAlignment','middle',...
     'FontName', 'times new Roman', 'FontSize', nn,'fontweight','b');
ylabel('CO concentration (VOL%)','fontsize',13,'Fontname','times new Roman','fontweight','b');


figure(6)
plot(Res_raw_Y(2,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(Res_raw_rbppcr(2,:),'ro--','LineWidth', 1.3, 'MarkerSize', 2);hold on
plot([200,200],[1,5.5],'k--');
annotation('textbox',[0.13,0.9,0.4,0.06],'BackgroundColor', 'g','LineStyle','-','LineWidth',1,...
     'String', 'Mode 1','HorizontalAlignment','center','VerticalAlignment','middle',...
     'FontName', 'times new Roman', 'FontSize', nn,'fontweight','b');  % [0.13,0.865,0.39,0.08] = [x_begin y_begin length height]
annotation('textbox',[0.517,0.9,0.388,0.06],'BackgroundColor', 'y','LineStyle','-','LineWidth',1,...
     'String', 'Mode 2','HorizontalAlignment','center','VerticalAlignment','middle',...
     'FontName', 'times new Roman', 'FontSize', nn,'fontweight','b');
ylabel('CO concentration (VOL%)','fontsize',13,'Fontname','times new Roman','fontweight','b');


figure(7)
plot(Res_raw_Y(2,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(Res_raw_gmm(2,:),'ro--','LineWidth', 1.3, 'MarkerSize', 2);hold on
plot([200,200],[1,5.5],'k--');
annotation('textbox',[0.13,0.9,0.4,0.06],'BackgroundColor', 'g','LineStyle','-','LineWidth',1,...
     'String', 'Mode 1','HorizontalAlignment','center','VerticalAlignment','middle',...
     'FontName', 'times new Roman', 'FontSize', nn,'fontweight','b');  % [0.13,0.865,0.39,0.08] = [x_begin y_begin length height]
annotation('textbox',[0.517,0.9,0.388,0.06],'BackgroundColor', 'y','LineStyle','-','LineWidth',1,...
     'String', 'Mode 2','HorizontalAlignment','center','VerticalAlignment','middle',...
     'FontName', 'times new Roman', 'FontSize', nn,'fontweight','b');
ylabel('CO concentration (VOL%)','fontsize',13,'Fontname','times new Roman','fontweight','b');

figure(8)
plot(Res_raw_Y(2,:),'b*-','LineWidth', 1.3, 'MarkerSize', 2); hold on
plot(Res_raw_MixPLS(2,:),'ro--','LineWidth', 1.3, 'MarkerSize', 2);hold on
plot([200,200],[1,5.5],'k--');
annotation('textbox',[0.13,0.9,0.4,0.06],'BackgroundColor', 'g','LineStyle','-','LineWidth',1,...
     'String', 'Mode 1','HorizontalAlignment','center','VerticalAlignment','middle',...
     'FontName', 'times new Roman', 'FontSize', nn,'fontweight','b');  % [0.13,0.865,0.39,0.08] = [x_begin y_begin length height]
annotation('textbox',[0.517,0.9,0.388,0.06],'BackgroundColor', 'y','LineStyle','-','LineWidth',1,...
     'String', 'Mode 2','HorizontalAlignment','center','VerticalAlignment','middle',...
     'FontName', 'times new Roman', 'FontSize', nn,'fontweight','b');
ylabel('CO concentration (VOL%)','fontsize',13,'Fontname','times new Roman','fontweight','b');





