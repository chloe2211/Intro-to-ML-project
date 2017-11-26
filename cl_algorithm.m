function [A,B,Iteration,tElapsed,finalRes]=clrule(X, k, W, lambda, option)
% X is a matrix with each column being the sample and each row being the
% feature. 
% k is the # of clusters
% A is the basis matrix; B is the coefficient matrix
% iteration is the number of iteration; tElapsed is the computing time used
% finalres is the fitting residual 
% option.distance: ls: euclidean distance; kl is the KL divergence



tStart=tic;
optionDefault.distance = 'ls';
optionDefault.iter=1000;
optionDefault.dis=true;
optionDefault.residual=1000;

if Margin<5
   option=optionDefault;
else
    option=mergeOption(option,optionDefault);
end
 W=isnan(X);
 X(W)=0;
 W=~W;
 W=~(X==0);
 
[f,s]=size(X); 
% s is the number of samples 
% f is the number of features
B=rand(k,s);
B=max(B,eps);
A=X/B;
A=max(A,eps);
XfitPrevious=Inf;
%'ls': Euclidean distance
% 'kl': KL divergence.
for i=1:option.iter
    switch option.distance
        case 'ls'
            % Modified this formula for regularization
            A=A.*(((W.*X)*B')./(lambda*A + (W.*(A*B))*B')) ;
                A=max(A,eps);
            B=B.*((A'*(W.*X))./(lambda*B + A'*(W.*(A*B))));
                B=max(B,eps);
        case 'kl'
            A=(A./(W*B')) .* ( ((W.*X)./(A*B))*B');
            A=max(A,eps);
            B=(B./(A'*W)) .* (A'*((W.*X)./(AY)));
            B=max(B,eps);
        otherwise
            error('ERROR');
    end
    if mod(i,100)==0 || i==option.iter
        if option.dis
            disp(['Iterating >>>>>> ', num2str(i),'th']);
        end
        XfitThis=A*B;
        fitRes=matrixNorm(W.*(XfitPrevious-XfitThis));
        XfitPrevious=XfitThis;
        curRes=norm(W.*(X-XfitThis),'fro');
        if option.tof>=fitRes || option.residual>=curRes || i==option.iter
 
            Iteration=i;
            finalRes=curRes;
            break;
        end
    end
end
tElapsed=toc(tStart);
end
