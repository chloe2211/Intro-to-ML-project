random_indices = randperm(100000);
% randomly permute the indices 1 to 100000, then we will use these random ordering or indices to perform a ten fold cross validation 
R_actual = zeros(943,1682)
w = zeros(943,1682)
% Matrix that stores the predicted values
R_predicted = zeros(size(R_actual,1), size(R_actual,2),3); 
% matrix that stores avg errors
avg_err = zeros(10,3)
% 10 folds, 3 values of k
k = [10,50,100]


%Training & Testing Data as 10 fold cross validation

for  j = 1:10
  for i = 1:(j-1)*10000
    R_actual(user_id(random_indices(i)), movie_id(random_indices(i))) = rating(random_indices(i));
    w(user_id(random_indices(i)), movie_id(random_indices(i)))=1
  
end
  
  %jth block will be full of zeros
  
  for i = (j*10000 + 1): 100000
      R_actual(user_id(random_indices(i)), movie_id(random_indices(i))) = rating(random_indices(i))
      w(user_id(random_indices(i)), movie_id(random_indices(i)))=1
  end
  
  %perform factorization, calculate error and store predicted values
  for m = 1:3
      [U3,V3, numiter, tEclapsed, finalResidual] = nmf(R_actual,k(m),w);
      product1 = U3*V3;
      sum_of_errors = 0
      for i = ((j-1)*10000 + 1): j*10000
        row3 = user_id(random_indices(i));
        col3 =  movie_id(random_indices(i));
        
      sum_of_errors = sum_of_errors + abs(product1(row3, col3) - R(row3, col3));
      
      %store predicated value
      R_predicted(row3, col3,m) = product1(row3, col3)
      end
      % now determine the absolute average value
      avg_err(j, m) = sum_of_errors / 1000
  end
end
% now we want to print out the average amongst 10 test for each of the k
% values
% for i=1:3
%     sprintf('For k = %d value', k(i))
%     
%     %Average error of 10 folds
%     sprintf('Average error = %f', mean(avg_err(:, i)))
%     
%     %Max error of 10 folds
%     sprintf('Max error = %f', max(avg_err(:, i)))
%     
%     %Min error of 10 folds
%     sprintf('Min error = %f', min(avg_err(:, i)))
% end
      
% define threshold value
threshold = linspace(0.1,5.0,50);
% create precision and recall matrix
precision = zeros(size(threshold,2),3);
% number of threshold values, three kinds of k
recall = zeros(size(threshold,2),3); 

for i=1:size(threshold, 2) % Loop over various threshold values
    for m = 1:3 % For k values = 10, 50, 100
        precision(i, m)=length(find((R_predicted(:, :, m)>threshold(1,i)) & (R>3)))/length(find(R_predicted(:, :, m)>threshold(1,i)));
        recall(i, m)=length(find((R_predicted(:, :, m)>threshold(1,i)) & (R>3)))/length(find(R>3));
    end
end
