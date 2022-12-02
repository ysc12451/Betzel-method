function [] = plot_all_ari(main_dir, option, tuned)
    disp(main_dir);
    sub_dir = dir(main_dir);
    for i = 1:length(sub_dir)
        disp(i);
        if( isequal(sub_dir(i).name, '.' )||...
            isequal(sub_dir(i).name, '..'))
            continue;
        end
        
        cur_dir = char(sub_dir(i).name);
        char_dir = [main_dir, '/', cur_dir];

        if tuned   
            ari = load([main_dir, '/', cur_dir,'/0/aris_opt.mat']).aris;
            G = load([main_dir, '/',cur_dir,'/0/G_opt.mat']).G;
            O = load([main_dir, '/',cur_dir,'/0/O_opt.mat']).O;
        else
            ari = load([main_dir, '/', cur_dir,'/0/aris_ori.mat']).aris;
            G = load([main_dir, '/',cur_dir,'/0/G.mat']).G;
            O = load([main_dir, '/',cur_dir,'/0/O.mat']).O;
        end
        
        max_color_value = size(ari);
        max_color_value = max_color_value(3);
        cm = colormap(jet(max_color_value));
        mm_ari = squeeze(mean(mean(ari)));
        % col = ceil(mm_ari*max_color_value);
        sz = 20;
        temp = mean(ari,[1,2]);
        temp = reshape(temp,[length(G),1]);
        
        caxis([0, 1]);
        % sgtitle(main_dir(64:67));
        sgtitle(main_dir(42:45));
        subplot(9,3,i-2);
        
        if option == 1
            scatter(G,O,sz, mm_ari,"filled");
            xlim([0, 1]);
            ylim([-0.5, 1.5]);
            xlabel("gamma");
            ylabel("omega");
            colorbar;
        end

        if option == 2
            plot(temp);
            ylim([0,1]);
            xlabel("samples");
            ylabel("ARI");
        end

        if option == 3
            histogram(temp);
            xlim([0,1]);
            xlabel("samples");
            ylabel("ARI");
        end

        if option == 4
            ari_flat = ari(:);
            boxchart(ari_flat);
        end
        
        % char_count = 105;
        char_count = 83;
        para = ['r_t=0.' , char_dir(char_count) , ', r_s=0.' , char_dir(char_count+25) , ', T=' , char_dir(char_count+14)];
        title(para);

    end
end