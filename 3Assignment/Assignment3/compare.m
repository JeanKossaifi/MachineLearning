function compare

perfFun = 'mse';

lr = 0.1;

transFun = {'tansig', 'logsig','purelin', 'radbasn', 'softmax' };

trainFun = { 'trainlm', 'trainbfg', 'trainbr', 'traincgb', 'traingdm', 'traingdx', 'trainscg'}; 

nepocs = 15;
minneurons = 3;
neurIncr = 3;
maxneurons = 12;
for tn = 1:length(trainFun)
    
    multiNew.classRate = 0;
    singleNew.classRate = 0;
    multiNew.trainFun = trainFun(tn);
    singleNew.trainFun = trainFun(tn);
    multiMaxCr = 0;
    singleMaxCr = 0;
    
    for tf = 1:length(transFun)  
        for i=minneurons:neurIncr:maxneurons 
            for j = minneurons:neurIncr:maxneurons
                str = sprintf('results/perf_%s_%s_%d-%d.mat', transFun{tf}, trainFun{tn}, i, j);
                load(str);
                strTemp = ['single1' '= single;'];
                eval(strTemp);
                if ( multi.classRate > multiMaxCr )

                   multiMaxCr = multi.classRate;
                   multiNew.noNeurons = i;
                   multiNew.classRate = multi.classRate;
                   multiNew.learningRate = multi.learningRate;
                   multiNew.confMtrx = multi.confMtrx;
                   multiNew.recall = multi.recall;
                   multiNew.precision = multi.precision;
                   multiNew.transferFun = multi.transferFun;
                end

               
               if ( single1.classRate > singleMaxCr )

                   singleMaxCr = single1.classRate;
                   singleNew.noNeurons = i;
                   singleNew.classRate = single1.classRate;
                   singleNew.learningRate = single1.learningRate;
                   singleNew.confMtrx = single1.confMtrx;
                   singleNew.recall = single1.recall;
                   singleNew.precision = single1.precision;
                   singleNew.transferFun = single1.transferFun;
               end
           end
        end
        clear multi;
        clear single;
    end
    save(sprintf('%s.mat', trainFun{tn}), 'singleNew', 'multiNew');
    clear multiNew;
    clear singleNew;
end


