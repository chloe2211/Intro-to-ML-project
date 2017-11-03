%% updating right now, please come back later
%%% we use LibSVM in this case
[trainlabels, trainfeatures,trainfeatures,trainfeatures] = libsvmread('u.data');
%% setting cost to c=1
model = svmtrain(trainlabels, trainfeatures,trainfeatures,trainfeatures, '-s 0 -t 0 -c 1');
w = model.SVs' * model.sv_coef;
b = -model.rho;
if (model.Label(1) == -1)
    w = -w; b = -b;
end

plot(w,b)
