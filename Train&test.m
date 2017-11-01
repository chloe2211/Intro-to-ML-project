%% updating right now, please come back later
# cost function 
function checkCostFunction(lambda)
%CHECKCOSTFUNCTION Creates a collaborative filering problem 
% Set lambda
if ~exist('lambda', 'var') || isempty(lambda)
    lambda = 0;
end
%% Create small problem
X_t = rand(4, 3);
Theta_t = rand(5, 3);

% Zap out most entries
Y = X_t * Theta_t';
Y(rand(size(Y)) > 0.5) = 0;
R = zeros(size(Y));
R(Y ~= 0) = 1;

%% Run Gradient Checking
X = randn(size(X_t));
Theta = randn(size(Theta_t));
num_users = size(Y, 2);
num_movies = size(Y, 1);
num_features = size(Theta_t, 2);

numgrad = computeNumericalGradient( ...
                @(t) cofiCostFunc(t, Y, R, num_users, num_movies, ...
                                num_features, lambda), [X(:); Theta(:)]);

[cost, grad] = cofiCostFunc([X(:); Theta(:)],  Y, R, num_users, ...
                          num_movies, num_features, lambda);


diff = norm(numgrad-grad)/norm(numgrad+grad);

end


%% select Threshold
function [bestEpsilon bestF1] = selectThreshold(yval, pval)
 bestEpsilon = 0;
  bestF1 = 0;
  F1 = 0;

  stepsize = (max(pval) - min(pval)) / 1000;
  for epsilon = min(pval):stepsize:max(pval)
   cvPredictions = (pval < epsilon);
    tp = sum((cvPredictions == 1) & (yval == 1));
    fp = sum((cvPredictions == 1) & (yval == 0));
    fn = sum((cvPredictions == 0) & (yval == 1));

    prec = tp/(tp + fp);
    rec = tp/(tp + fn);

    F1 = 2*prec*rec/(prec + rec);

    if F1 > bestF1
      bestF1 = F1;
      bestEpsilon = epsilon;
    end
  end

end
