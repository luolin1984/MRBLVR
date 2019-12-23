%% Illustrate the robustness of the student and laplace distributions compared to the Gaussian.
%
%%


n = 50;
setSeed(8);
data = randn(n,1);
outliers = [7.7; 8; 8.35; 8.7; 9];
nn = length(outliers);
nbins = 8;

figure;
plotHist(data,nbins,n);
% plotPDFs(data);
Xbar1 = mean(data);
sigma1 = std(data);
gauss = @(X) gaussProb(X, Xbar1, sigma1.^2);
model1 = studentFit(data);
sT = @(X)exp(studentLogprob(model1, X));
hold on;
x1 = (-5:0.01:10)';
y11 = gauss(x1); 
y21 = sT(x1); 
h(1) = plot(x1,y11,'k:','LineWidth',2.5);
h(2) = plot(x1,y21,'r-','LineWidth',2.5);
a1 = x1(find(y11==max(y11)));
a2 = x1(find(y21==max(y21)));
gg(1)=line([a1, a1], [0, 0.5]);
gg(2)=line([a2, a2], [0, 0.5]);
set(gg, 'color', 'g', 'LineWidth', 1.5, 'LineStyle', '-.')

axis([-5,10,0,0.5]);
set(gca,'YTick',0:0.1:0.5);
legendStr = {'Gaussian', 'Student t'};
legend(h, legendStr{:})
printPmtkFigure('robustDemoNoOutliers')
%%
figure;
plotHist(data, nbins, n+nn);
plotHist(outliers, nn, n+nn);
% plotPDFs([data ; outliers]);

Xbar = mean([data ; outliers]);
sigma = std([data ; outliers]);
gauss = @(X) gaussProb(X, Xbar, sigma.^2);
model = studentFit([data ; outliers]);
sT = @(X)exp(studentLogprob(model, X));
hold on;
x = (-5:0.01:10)';
y1 = gauss(x); 
y2 = sT(x); 
h(1) = plot(x,y1,'k:','LineWidth',2.5);
h(2) = plot(x,y2,'r-','LineWidth',2.5);
a1 = x(find(y1==max(y1)));
a2 = x(find(y2==max(y2)));
gg(1)=line([a1, a1], [0, 0.5]);
gg(2)=line([a2, a2], [0, 0.5]);
set(gg, 'color', 'g', 'LineWidth', 1.5, 'LineStyle', '-.')

axis([-5,10,0,0.5]);
set(gca,'YTick',0:0.1:0.5);
legendStr = {'Gaussian', 'Student t'};
legend(h, legendStr{:})

printPmtkFigure('robustDemoOutliers')







