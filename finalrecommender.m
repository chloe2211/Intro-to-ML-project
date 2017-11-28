% 3 values of lambda
lambda = [0.01,0.1,1];
 
% % Build matrix R and w (weights matrix)
 R5 = R;
 w5 = w;
 k = [10, 50, 100];

 for i=1:3
     [U51,V51,Iteration,tElapsed,finalRes511]=myclrule(R5, k(1), w5, lambda(i));
     [U52,V52,Iteration,tElapsed,finalRes512]=myclrule(R5, k(2), w5, lambda(i));
     [U53,V53,Iteration,tElapsed,finalRes513]=myclrule(R5, k(3), w5, lambda(i));
     
    % Compute and Store the errors
     lse31(1,i) = finalRes311; 
     lse31(2,i) = finalRes312; 
     lse31(3,i) = finalRes313; 
 end
% % Swapping R and W
 R52 = w5;
 w52 = R5;
% 
 lse32 = zeros(3,3);
% 
 for i=1:3
     [U51,V51,Iteration,tElapsed,finalRes521]=myclrule5(R52, k(1), w52, lambda(i));
     [U52,V52,Iteration,tElapsed,finalRes522]=myclrule(R52, k(2), w52, lambda(i));
     [U53,V53,Iteration,tElapsed,finalRes523]=myclrule(R52, k(3), w52, lambda(i));
     
%     % Compute and Store the errors
     lse32(1,i) = finalRes521; 
     lse32(2,i) = finalRes522; 
     lse32(3,i) = finalRes523; 
 end

% % Find the top L movies
for n = 1:3 % For 3 values of lambda
     for m = 1:3 % For 3 different k values = 10, 50, 100
         for i=1:size(R6, 1) % For each user
             % Sort the Predicted Ratings for each user
             [sorted_ratings, sorted_ratings_indices] = sort(R_Predictedf(i, :, m, n), 'descend');            
             for L = 1:1:20 % Now pick the top L movies, for which we KNOW the ratings
                 rec_movies = zeros(size(R6, 1), L, 3, 3); % [No. of Users, L, k=[10, 50, 100], lambda = [0.01, 0.1, 1]]
                 rec_movies_counter = 1; % Initialize counter to 1
                 for j=1:size(sorted_ratings_indices, 2)
 % Check if the ith user has given a rating for the jth movie
                     if R(i, sorted_ratings_indices(j)) == 1
%                         % add into the list of recommended movies
                         rec_movies(i, recommended_movies_counter, m, n) = (sorted_ratings_indices(j));
                         rec_movies_counter = recommended_movies_counter + 1;
                     end
%                     
%                     % Check if we have already found the top L movies
                     if recommended_movies_counter == L+1
% 
%                         % Calculate TP, TN, FP and FN
                         true_positive = length(find((R_Predictedf(i, recommended_movies(i, :, m, n), m, n)>threshold) & (R(i, recommended_movies(i, :, m, n))>2)));
                         true_negative = length(find((R_Predictedf(i, recommended_movies(i, :, m, n), m, n)<=threshold) & (R(i, recommended_movies(i, :, m, n))<=2)));
                         false_positive = length(find((R_Predictedf(i, recommended_movies(i, :, m, n), m, n)>threshold) & (R(i, recommended_movies(i, :, m, n))<=2)));
                         false_negative = length(find((R_Predictedf(i, recommended_movies(i, :, m, n), m, n)<=threshold) & (R(i, recommended_movies(i, :, m, n))>2)));
                         
                         % Calculate individual precision for the ith user, and
                         % mth value of k and nth value of lambda ONLY IF = 5
                         if L == 5
                             
                             individual_precision(i, m, n)= true_positive / length(find((R_Predictedf(i, recommended_movies(i, :, m, n), m, n)>threshold)));
                         end
                         
                         
                         % Calculate False Alarm Rate
                         individual_false_alarm_rate(i, L, m, n) = false_positive / (false_positive + true_negative);
                         
                         if false_positive == 0 & true_negative == 0
                             individual_false_alarm_rate(i, L, m, n) = 0;
                         end
                         
                         break;
                     end
                 end 
             end
         end
     end
 end
 

 
