function partIV(x, y)
    [x2, y2] = ANNdata(x, y);
    
    % step 1: create a six-output NN
    totalnet = buildNetwork(10, 30, [0.7,0.15,0.15], x2, y2); 
    
    % step 2: create 6 one-output NN
    for i=1:size(y2,1)
        binaryNets{i} = buildNetwork(10, 30, [0.7,0.15,0.15], x2, y2(i,:));        
    end
    
    