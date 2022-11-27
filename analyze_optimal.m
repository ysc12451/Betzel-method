function [] = analyze_optimal(cur_dir, samplesTotal)

    adj = readNPY(cur_dir+"\"+"adj_mus_dynamic.npy");
    z = readNPY(cur_dir+"\"+"z_mus_dynamic.npy");
    B = permute(adj, [3,4,1,2]);
    sizeB = size(B);
    A = reshape(B, sizeB(1),sizeB(2),sizeB(3)*sizeB(4),1);
    
    [N,~,T] = size(A);  % number of nodes/layers
    C = cell(T,1);      % create cell array
    for i = 1:T         % populate array
        C{i} = A(:,:,i); % i-th layer of A, 100*100
    end
    
    %     set some parameters
    gammarange = [0.0, 0.3];          % range of gamma values to consider
    omegarange = [0, 0.5];            % range of omega values to consider
    samplesPerStage = 250;              % number of samples per stage (ideally should be large) 250
    nstage = 5;                         % number of stages (ideally should be large) 5
    keep = 20;                          % number of nearest neighbors 20
    couplingtype = 'categorical';       % nature of interlayer coupling (could also be ordered)
    
    %     get initial estimate of boundaries
%     [gbound,obound,~] = ...    % run boundary estimator
%         fcn_get_bounds(C,gammarange,omegarange,samplesPerStage,nstage,keep,couplingtype);
    gbound = [0.1, 0.1, 0.2, 0.2];
    obound = [0, 0.5, 0.5, 0];
    
    %     sample from within those boundaries
    [S,G,O] = fcn_staged_multilayer(C,gbound,obound,samplesTotal,couplingtype);      
    
    zS = permute(S, [2,1,3]);
    zS = reshape(zS, sizeB(3),sizeB(4),sizeB(1),samplesTotal);
    
    sizeZ = size(zS);
    S = sizeZ(1);
    T = sizeZ(2);
    
    aris = zeros(S,T,samplesTotal);
    for s = 1:S
        disp(s);
        for t = 1:T
            for i = 1:samplesTotal
                aris(s,t,i) = rand_index(z(s,t,:), zS(s,t,:,i), "adjusted");
            end
        end
    end

    save(cur_dir+"/"+"z_pred_opt.mat", "zS");
    save(cur_dir+"/"+"G_opt.mat", "G");
    save(cur_dir+"/"+"O_opt.mat", "O");
    save(cur_dir+"/"+"aris_opt.mat", "aris");

end