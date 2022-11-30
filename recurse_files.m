function [] = recurse_files(cur_dir,samplesTotal)   
    disp(cur_dir);
    sub_dir = dir(cur_dir);
    for i = 1:length(sub_dir)
        if( isequal(sub_dir(i).name, '.' )||...
            isequal(sub_dir(i).name, '..'))
            continue;
        end

        if sub_dir(i).isdir
            recurse_files(cur_dir+"\"+sub_dir(i).name);
        end
        
        file_name = sub_dir(i).name;
        if contains(file_name, "adj_mus_dynamic") % && ~exist(cur_dir+"\"+"z_pred_opt.mat", "file")
            analyze_selfchoice(cur_dir, samplesTotal);
        end
    end
end