function dataExp = NumExp_with_Outliers(OPTIONS)
% Numerical Experiment on paper [1]



% [1] 2014--(¸ðÖ¾Ç¿)(SoftSensor)External Analysis-Based Regression Model for
%            Robust Soft Sensing of Multimode Chemical Processes

% OPTIONS.dataset = 'Outlier';
% OPTIONS.NOutliers = 20;


A = [1, 0.894, 0.058, 0.353, 0.813;
    0, 0.445, 0.932, 0.466, 0.419;
    0, 0.846, 0.525, 0.203, 0.672];
B = [0.110,1.909;
    0.307,0.879;
    1.159,-1.094;
    0.703,-0.139;
    0.374,0.296];

dataLength = 200;
X = zeros(dataLength,size(A,2));
Y = zeros(dataLength,size(B,2));
switch OPTIONS.dataset
    case 'NoOutlier'
        % No outliers
        %% build normal process condition
        %--------------------------------
        for i = 1 : dataLength
            s_tmp = rand(1,3);
            s(i,:) = s_tmp;
            v_tmp = 0.05.*randn(1,5);
            v(i,:) = v_tmp;
            w_tmp = 0.05.*randn(1,2);
            w(i,:) = w_tmp;
            X_tmp = s_tmp * A + v_tmp;
            X(i,:) = X_tmp;
            Y_tmp = X_tmp * B + w_tmp;
            Y(i,:) = Y_tmp;
        end
        dataExp.s = s;
        dataExp.v = v;
        dataExp.w = w;
       %% build other operation condition
        %--------------------------------
        X_op = zeros(4*dataLength,size(A,2));
        Y_op = zeros(4*dataLength,size(B,2));
        R = [6,8,3,2];
        for i = 1:4
%             R_tmp = unidrnd(11) - 1;
%             R(i) = R_tmp;
            R_tmp=R(i);
            X_op_tmp = [s(:,1) + R_tmp, s(:,2), s(:,3)] * A + v;
            Y_op_tmp = X_op_tmp * B + w;
            
            X_op((i-1)*200+1:(i*200), :) = X_op_tmp;
            Y_op((i-1)*200+1:(i*200), :) = Y_op_tmp;
        end
        
        dataExp.dataX = [X; X_op];
        dataExp.dataY = [Y; Y_op];
        dataExp.R = R;
    case 'Outlier'
        for i = 1 : dataLength
            s_tmp = rand(1,3);
            s(i,:) = s_tmp;
            v_tmp = 0.05.*randn(1,5);
            v(i,:) = v_tmp;
            w_tmp = 0.05.*randn(1,2);
            w(i,:) = w_tmp;
            X_tmp = s_tmp * A + v_tmp;
            X(i,:) = X_tmp;
            Y_tmp = X_tmp * B + w_tmp;
            Y(i,:) = Y_tmp;
        end
                
        X_op = zeros(4*dataLength, size(A,2));
        Y_op = zeros(4*dataLength, size(B,2));
        for i = 1:4
            R_tmp = unidrnd(11) - 1;
            R(i) = R_tmp;
            X_op_tmp = [s(:,1) + R_tmp, s(:,2), s(:,3)] * A + v;
            Y_op_tmp = X_op_tmp * B + w;
            
            X_op((i-1)*200+1:(i*200), :) = X_op_tmp;
            Y_op((i-1)*200+1:(i*200), :) = Y_op_tmp;
        end
        
        dataExp.dataX = [X; X_op];
        dataExp.dataY = [Y; Y_op];
        
        X_outlier = dataExp.dataX;
        outlier_position = unidrnd(size(dataExp.dataX,1),[1,OPTIONS.NOutliers]);
        outliersX = (rand(size(A,2), OPTIONS.NOutliers) - 1.5)*10;
        for j = 1:length(outlier_position)
            X_outlier(outlier_position(j),:) = outliersX(:,j)';
        end
        Y_outlier = X_outlier * B + repmat(w,5,1);
        
        dataExp.outlierX = X_outlier;
        dataExp.outlierY = Y_outlier;
        
end



