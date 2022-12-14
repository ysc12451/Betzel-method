addpath(genpath('/storage08/shuchen/Betzel-method/GenLouvain-2.2.0'));
fprintf("Running run_Betzel\n")

% filename = '/storage08/shuchen/SimulationData/settingSSoS/n500-k10-p_in2btw4-p_out1btw1/r_time0-time_horizon8-r_subject0-num_subjects8/1/';
fprintf([filename,'\n']);

option = "ori";

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
elseif option == "opt"
    finished = exist([filename,'aris_opt.mat'], "file");
    if ~ finished
        fprintf("Not processed: optimal\n");
        analyze_optimal(string(filename), samplesTotal);
    else
        fprintf("Processed: optimal\n");
    end
end



