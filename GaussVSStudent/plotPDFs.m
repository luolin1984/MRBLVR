function plotPDFs(data)
Xbar = mean(data);
sigma = std(data);
gauss = @(X) gaussProb(X, Xbar, sigma.^2);
model = studentFit(data);
sT = @(X)exp(studentLogprob(model, X));
hold on;
x = (-5:0.01:10)';
h(1) = plot(x,gauss(x),'k:','LineWidth',2.5);
h(2) = plot(x,sT(x),'r-','LineWidth',2.5);
axis([-5,10,0,0.5]);
set(gca,'YTick',0:0.1:0.5);
legendStr = {'gaussian', 'student T'};
legend(h, legendStr{:})