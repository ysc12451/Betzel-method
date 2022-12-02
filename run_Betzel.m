addpath(genpath('/storage08/shuchen/Betzel-method/GenLouvain-2.2.0'));
fprintf("Running run_Betzel\n")

% filename = '/storage08/shuchen/SimulationData/settingSSoS/n500-k10-p_in2btw4-p_out1btw1/r_time0-time_horizon2-r_subject0-num_subjects8/0/';
fprintf([filename,'\n']);

filename = string(filename);
samplesTotal = 100;

% traverse_files(filename, samplesTotal);
analyze_origin(filename, samplesTotal);