%
load mode3Test.mat
load modeTrain.mat

Qtrain1 = [Q11(102:2:end,2);Q21(102:2:end,2)];

Qtest5 = [(Q11(102:2:end,6)-32)*5/9-530;(Q21(102:2:end,6)-32)*5/9-530];
Qtest8 = [(Q12(102:2:end,4)-32)*5/9+80;(Q22(102:2:end,4)-32)*5/9+80];
Qtest7 = [(Q12(102:2:end,3)-32)*5/9+80;(Q22(102:2:end,3)-32)*5/9+80];
Qtest6_1 = [(Q16(102:2:end,3)-32)*5/9-60;(Q26(102:2:end,3)-32)*5/9-60];
Qtest10 = [(Q12(102:2:end,6)-32)*5/9-100;(Q22(102:2:end,6)-32)*5/9-100];
Qtest11 = [Q13(102:2:end,2);Q23(102:2:end,2)];
Qtest4 = [Q11(102:2:end,5)*6.894757;Q21(102:2:end,5)*6.894757];
Qtest2 = [Q11(102:2:end,3)*6.894757-10;Q21(102:2:end,3)*6.894757-10];

Qtest13 = [Q13(102:2:end,4)+3.5;Q23(102:2:end,4)+3.5];
Qtest12 = [Q13(102:2:end,3)/200+1;Q23(102:2:end,3)/200+1];

Qtrain5 = [(Q11Tra(102:2:end,6)-32)*5/9-530;(Q21Tra(102:2:end,6)-32)*5/9-530];
Qtrain8 = [(Q12Tra(102:2:end,4)-32)*5/9+80;(Q22Tra(102:2:end,4)-32)*5/9+80];
Qtrain7 = [(Q12Tra(102:2:end,3)-32)*5/9+80;(Q22Tra(102:2:end,3)-32)*5/9+80];
Qtrain6_1 = [(Q16Tra(102:2:end,3)-32)*5/9-60;(Q26Tra(102:2:end,3)-32)*5/9-60];
Qtrain10 = [(Q12Tra(102:2:end,6)-32)*5/9-100;(Q22Tra(102:2:end,6)-32)*5/9-100];
Qtrain11 = [Q13Tra(102:2:end,2);Q23Tra(102:2:end,2)];
Qtrain4 = [Q11Tra(102:2:end,5)*6.894757;Q21Tra(102:2:end,5)*6.894757];
Qtrain2 = [Q11Tra(102:2:end,3)*6.894757-10;Q21Tra(102:2:end,3)*6.894757-10];

Qtrain13 = [Q13Tra(102:2:end,4)+3.5;Q23Tra(102:2:end,4)+3.5];
Qtrain12 = [Q13Tra(102:2:end,3)/200+1;Q23Tra(102:2:end,3)/200+1];


nn = 12;
figure(1)
subplot(3,3,1)
plot(1:size(Qtrain1,1), Qtest5, 'MarkerFaceColor','b','LineWidth', 1.3, 'MarkerSize', 2);
% hold on
% plot(1:size(Qtrain1,1), Qtrain5, 'MarkerFaceColor','g','LineWidth', 1.3, 'MarkerSize', 2);
xlabel('# samples','fontsize',nn,'Fontname','times new Roman','fontweight','b');
ylabel('Furnace TEMP (\circC)','fontsize',nn,'Fontname','times new Roman','fontweight','b')    % x_1 320度-360度，最高不可超过360
subplot(3,3,2)
plot(1:size(Qtrain1,1), Qtest8, 'MarkerFaceColor','b','LineWidth', 1.3, 'MarkerSize', 2); 
% hold on
% plot(1:size(Qtrain1,1), Qtrain8, 'MarkerFaceColor','g','LineWidth', 1.3, 'MarkerSize', 2);
ylabel('TEMP of Reg. bed (\circC)','fontsize',nn,'Fontname','times new Roman','fontweight','b') % x_2 整个再生管温度760-800，催化剂质量好就800度，不好就760度
xlabel('# samples','fontsize',nn,'Fontname','times new Roman','fontweight','b');
subplot(3,3,3)
plot(1:size(Qtrain1,1), Qtest7, 'MarkerFaceColor','b','LineWidth', 1.3, 'MarkerSize', 2); 
% hold on
% plot(1:size(Qtrain1,1), Qtrain7, 'MarkerFaceColor','g','LineWidth', 1.3, 'MarkerSize', 2);
ylabel('TEMP at bottom of Reg. (\circC)','fontsize',nn,'Fontname','times new Roman','fontweight','b')  % x_3 再生温度越高，催化剂焦炭烧料越多，催化剂再生效果越好，活性就越高
xlabel('# samples','fontsize',nn,'Fontname','times new Roman','fontweight','b');
subplot(3,3,4)
plot(1:size(Qtrain1,1), Qtest6_1, 'MarkerFaceColor','b','LineWidth', 1.3, 'MarkerSize', 2);
% hold on
% plot(1:size(Qtrain1,1), Qtrain6_1, 'MarkerFaceColor','g','LineWidth', 1.3, 'MarkerSize', 2);
ylabel('TEMP of spent catalyst (\circC)','fontsize',nn,'Fontname','times new Roman','fontweight','b')  % x_4 比反应温度(380度左右)低一些，能低30-40度
xlabel('# samples','fontsize',nn,'Fontname','times new Roman','fontweight','b');
subplot(3,3,5)
plot(1:size(Qtrain1,1), Qtest10, 'MarkerFaceColor','b','LineWidth', 1.3, 'MarkerSize', 2); 
% hold on
% plot(1:size(Qtrain1,1), Qtrain10, 'MarkerFaceColor','g','LineWidth', 1.3, 'MarkerSize', 2);
ylabel('TEMP of stack gas (\circC)','fontsize',nn,'Fontname','times new Roman','fontweight','b')   % x_6 如果水冷直接降到100度，
xlabel('# samples','fontsize',nn,'Fontname','times new Roman','fontweight','b');
subplot(3,3,6)
plot(1:size(Qtrain1,1), Qtest11, 'MarkerFaceColor','b','LineWidth', 1.3, 'MarkerSize', 2); 
% hold on
% plot(1:size(Qtrain1,1), Qtrain11, 'MarkerFaceColor','g','LineWidth', 1.3, 'MarkerSize', 2);
ylabel('TEMP diff. of fluidized bed (\circC)','fontsize',nn,'Fontname','times new Roman','fontweight','b') % x_7 差10度左右
xlabel('# samples','fontsize',nn,'Fontname','times new Roman','fontweight','b');
subplot(3,3,7)
plot(1:size(Qtrain1,1), Qtest4, 'MarkerFaceColor','b','LineWidth', 1.3, 'MarkerSize', 2);
% hold on
% plot(1:size(Qtrain1,1), Qtrain4, 'MarkerFaceColor','g','LineWidth', 1.3, 'MarkerSize', 2);
ylabel('Reg. PRESS (kPa)','fontsize',nn,'Fontname','times new Roman','fontweight','b')  % x_8
xlabel('# samples','fontsize',nn,'Fontname','times new Roman','fontweight','b');
subplot(3,3,8)
plot(1:size(Qtrain1,1), Qtest2, 'MarkerFaceColor','b','LineWidth', 1.3, 'MarkerSize', 2);
% hold on
% plot(1:size(Qtrain1,1), Qtrain2, 'MarkerFaceColor','g','LineWidth', 1.3, 'MarkerSize', 2);
ylabel('Differential PRESS (kPa)','fontsize',nn,'Fontname','times new Roman','fontweight','b') % x_9 50 kP左右，30-100不等
xlabel('# samples','fontsize',nn,'Fontname','times new Roman','fontweight','b');
tightfig;

figure(2)
subplot(2,1,1)
plot(1:size(Qtrain1,1), Qtest13, 'MarkerFaceColor','b','LineWidth', 1.3, 'MarkerSize', 2); 
hold on
plot(1:size(Qtrain1,1), Qtrain13, 'MarkerFaceColor','g','LineWidth', 1.3, 'MarkerSize', 2);
hold on
plot([200,200],[4,5],'k--');
annotation('textbox',[0.13,0.9,0.4,0.06],'BackgroundColor', 'g','LineStyle','-','LineWidth',1,...
     'String', 'Mode 1','HorizontalAlignment','center','VerticalAlignment','middle',...
     'FontName', 'times new Roman', 'FontSize', nn,'fontweight','b');  % [0.13,0.865,0.39,0.08] = [x_begin y_begin length height]
annotation('textbox',[0.517,0.9,0.388,0.06],'BackgroundColor', 'y','LineStyle','-','LineWidth',1,...
     'String', 'Mode 2','HorizontalAlignment','center','VerticalAlignment','middle',...
     'FontName', 'times new Roman', 'FontSize', nn,'fontweight','b');
ylabel('Oxygen concentration (VOL%)','fontsize',nn,'Fontname','times new Roman','fontweight','b');
xlabel('# samples','fontsize',nn,'Fontname','times new Roman','fontweight','b');
subplot(2,1,2)
plot(1:size(Qtrain1,1), Qtest12, 'MarkerFaceColor','b','LineWidth', 1.3, 'MarkerSize', 2);
hold on
plot(1:size(Qtrain1,1), Qtrain12, 'MarkerFaceColor','g','LineWidth', 1.3, 'MarkerSize', 2);
hold on
plot([200,200],[1,6],'k--');
annotation('textbox',[0.13,0.425,0.4,0.06],'BackgroundColor', 'g','LineStyle','-','LineWidth',1,...
     'String', 'Mode 1','HorizontalAlignment','center','VerticalAlignment','middle',...
     'FontName', 'times new Roman', 'FontSize', nn,'fontweight','b');  % [0.13,0.865,0.39,0.08] = [x_begin y_begin length height]
annotation('textbox',[0.517,0.425,0.388,0.06],'BackgroundColor', 'y','LineStyle','-','LineWidth',1, ...
    'String', 'Mode 2','HorizontalAlignment','center','VerticalAlignment','middle',...
    'FontName', 'times new Roman', 'FontSize', nn,'fontweight','b');
ylabel('CO concentration (VOL%)','fontsize',nn,'Fontname','times new Roman','fontweight','b')
xlabel('# samples','fontsize',nn,'Fontname','times new Roman','fontweight','b');

