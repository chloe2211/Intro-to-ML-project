%% updating right now, please come back later
%%% Training
dataset=read_dataset('../ml-100k/u3.base',0);
save('dataset','dataset');

train_ratings=zeros(943,1682);

for i=1:1682
    for j=1:943
        ind=find((dataset(1,:)==j) & (dataset(2,:)==i));
        if isempty(ind)
            train_ratings(j,i)=0;
        else
            train_ratings(j,i)=dataset(3,ind);
        end
    end
    if (mod(i,50)==0)
        disp(i);
    end
end
save('train_ratings','train_ratings');
%%%Testing
testset=read_dataset('../ml-100k/u3.test',0);
save('testset','testset');
test_ratings=zeros(943,1682);
for i=1:1682
    for j=1:943
        ind=find((testset(1,:)==j) & (testset(2,:)==i));
        if isempty(ind)
            test_ratings(j,i)=0;
        else
            test_ratings(j,i)=testset(3,ind);
        end
    end
    if (mod(i,50)==0)
        disp(i);
    end
end
save('test_ratings','test_ratings');
