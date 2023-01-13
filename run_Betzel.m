addpath(genpath('/storage08/shuchen/Betzel-method/GenLouvain-2.2.0'));
fprintf("Running run_Betzel\n")

% filename = '/storage08/shuchen/SimulationData/settingSSoS/n500-k10-p_in2btw4-p_out1btw1/r_time0-time_horizon8-r_subject0-num_subjects8/1/';
fprintf([filename,'\n']);

option = "dbt";

samplesTotal = 100;
% traverse_files(filename, samplesTotal);

if option == "ori"
    finished = exist([filename,'aris_ori.mat'], "file");
    if ~ finished
        fprintf("Not processed: original\n");
        analyze_origin(string(filename), samplesTotal);
    else
        fprintf("Processed: original\n");
    end
elseif option == "dbt"
    finished = exist([filename,'aris_dbt.mat'], "file");
    if ~ finished
        fprintf("Not processed: divided by T\n");
        analyze_optimal(string(filename), samplesTotal);
    else
        fprintf("Processed: divided by T\n");
    end
end



