function [] = analyze_dvdbyT(cur_dir, samplesTotal)
    % for S*T adj matrix, divide them by T into T multi-subject networks
    % for each time T, and run Betzel separately.

    adj = readNPY(cur_dir+"/"+"adj_mus_dynamic.npy");
    z = readNPY(cur_dir+"/"+"z_mus_dynamic.npy");
    B = permute(adj, [3,4,1,2]);
    sizeB = size(B);
    % A = reshape(B, sizeB(1),sizeB(2),sizeB(3)*sizeB(4),1);
    
    S = sizeB(3);
    T = sizeB(4);
    zST = zeros(S, T,sizeB(1),samplesTotal); % store all S and T: S,T,500,100
    
    for t = 1:T
        fprintf('solving t=%d\n', t);
        A = B(:,:,:,t);
        % [N,~,T] = size(A);  % number of nodes/layers
        C = cell(S,1);      % create cell array
        for i = 1:S         % populate array
            C{i} = A(:,:,i); 
        end
    
        %     set some parameters           
        gammarange = [double(min(A(:))), double(max(A(:)))]; % range of gamma values to consider
        omegarange = [-0.5,1.5];            % range of omega values to consider
        samplesPerStage = 250;              % number of samples per stage (ideally should be large) 250
        nstage = 5;                         % number of stages (ideally should be large) 5
        keep = 20;                          % number of nearest neighbors 20
        couplingtype = 'categorical';       % nature of interlayer coupling (could also be ordered)
        
        %     get initial estimate of boundaries
        tic
        [gbound,obound,~] = ...    % run boundary estimator
            fcn_get_bounds(C,gammarange,omegarange,samplesPerStage,nstage,keep,couplingtype);
        fprintf('get initial estimate of boundaries: use time %.2f s\n',toc);
        
        %     sample from within those boundaries
        [zS,G,O] = fcn_staged_multilayer(C,gbound,obound,samplesTotal,couplingtype);      
        
        zS = permute(zS, [2,1,3]); % z for only one T
        zST(:,t,:,:) = zS;
        % zS = reshape(zS, S, T,sizeB(1),samplesTotal);
    end

    aris = zeros(S,T,samplesTotal);
    for s = 1:S
        disp(s);
        for t = 1:T
            for i = 1:samplesTotal
                aris(s,t,i) = rand_index(z(s,t,:), zST(s,t,:,i), "adjusted");
            end
        end
    end

    save(cur_dir+"/"+"z_dbt.mat", "zST");
    save(cur_dir+"/"+"G_dbt.mat", "G");
    save(cur_dir+"/"+"O_dbt.mat", "O");
    save(cur_dir+"/"+"aris_dbt.mat", "aris");
end