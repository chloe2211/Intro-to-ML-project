A = importdata('u.data');
user_id = A(:, 1);
movie_id = A(:, 2);
rating = A(:, 3);
% initialize the result matrix and weight matrix
Res = zeros(943, 1682);
weight = zeros(943, 1682);
for i=1:100000
     R(user_id(i), movie_id(i)) = rating(i);
     w(user_id(i), movie_id(i)) = 1;
 end
 % we select three K values
