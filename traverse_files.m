function [] = traverse_files(cur_dir, samplesTotal)  
    disp(cur_dir);
    sub_dir = dir(cur_dir);
    for i = 1:length(sub_dir)
        if( isequal(sub_dir(i).name, '.' )||...
            isequal(sub_dir(i).name, '..'))
            continue;
        end

        if sub_dir(i).isdir
            dir_name = sub_dir(i).name;
            disp(dir_name);

            analyze_origin(cur_dir+dir_name, samplesTotal);            
        end
    end
end