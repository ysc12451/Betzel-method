function[] = plot_ari_scatter_para(main_dir)

%     zS = load(main_dir+data_dir+"z_pred.mat").zS;
    G = load(main_dir+"G.mat").G;
    O = load(main_dir+"O.mat").O;
    ari = load(main_dir+"aris.mat").aris;
    
    max_color_value = size(ari);
    max_color_value = max_color_value(3);
    cm = colormap(jet(max_color_value));
    mm_ari = squeeze(mean(mean(ari)));
    % col = ceil(mm_ari*max_color_value);
    sz = 50;
    
    scatter(G,O,sz, mm_ari,"filled");
    colorbar;
end