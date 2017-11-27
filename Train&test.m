
 k = [10, 50, 100];
% 
 % Factorize using clrule
 [U11,V11,Iteration,tElapsed,finalRes11]=clrule(R, k(1), w);
 [U12,V12,Iteration,tElapsed,finalRes12]=clrule(R, k(2), w);
 [U13,V13,Iteration,tElapsed,finalRes13]=clrule(R, k(3), w);
 
 % lse is least error square
 lse(1,1) = finalRes11; 
 lse(2,1) = finalRes12; 
 lse(3,1) = finalRes13; 


 % Swap R and w
 temp = R;
 R2 = w;
 w2 = temp;
 
% % Three different values of k
 k = [10, 50, 100];
% 
% % Factorize using clrule
 [U21,V21,Iteration,tElapsed,finalRes21]=clrule(R2,k(1), w2);
 [U22,V22,Iteration,tElapsed,finalRes22]=clrule(R2,k(2), w2);
 [U23,V23,Iteration,tElapsed,finalRes23]=clrule(R2,k(3), w2);
 
 lse2(1,1) = finalRes21; 
 lse2(2,1) = finalRes22; 
 lse2(3,1) = finalRes23;
 
% least_squared_error2
% 
% % Final Residual Errors
% %    18.2706
% %    26.1834
% %    23.0279
