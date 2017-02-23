% Monthly diurnal trend of soil respiration in 2014 at EucFACE, daytime:
% 1. Modeled from extrapolating night Q10 
% 2. Measured 

% Hypothesis: standard eddy-covariance method over-estimate daytime CO2
% efflux (!! soil efflux is NOT respiration) 

% Goal: quantify this overestimation: 
% 1. For belowground CO2 efflux (soil)
% 2. For Aboveground CO2 efflux (leafs mostly) 

% Alexis script, 14/11/2016
% Thanks to: John Drake for his help and EucFACE soil respiration data

% Paper title: "Standard method of eddy-covariance processing over-estimate
% ecosystem CO2 efflux by X% (site?period?), hence also over-estimating GPP by the same amount. we propose an alternative
% method (nb. idea: constant/flat diurnal ER, f(T,SWC)"

figure;
Diurn_mean_Tsoil_r3c0 = nan(47,1);
Diurn_mean_Rsoil_r3c0_measure = nan(47,1);
Diurn_mean_Rsoil_r3c0_model = nan(47,1);
x = 0.25:0.5:23.25; % the first median value correspond to 00:00:00 to 00:30:00, hence we plot it on hour of the day = 0.25 (and then, 0.75, 1.25, etc)
for m = 1:12
    daytime1_m_day = nan;
    for i = 2:48 % start 1st half-hour of the day, hhour_t = 1 corresponding to flux 00:00:00 to 00:30:00, end at hhour_t = 47, corresponding to 23:00:00 to 23:30:00, i.e. we don't look 23:30:30 to 00:00:00 
        Condition = find(hhour_t_s == i-1 & month(datetime1) == m & year(datetime1) == 2014);
        Condition_d = find(daytime1 == 1 & month(datetime1) == m & year(datetime1) == 2014); %& VWC_r3c0 >= quantile(VWC_r3c0,0.5) & VWC_r3c0 < quantile(VWC_r3c0,0.75));
        Condition_n = find(daytime1 == 0 & month(datetime1) == m & year(datetime1) == 2014); %& VWC_r3c0 >= quantile(VWC_r3c0,0.5) & VWC_r3c0 < quantile(VWC_r3c0,0.75));
        MinT = nanmin(Tsoil_r3c0(month(datetime1) == m & daytime1 == 0 & year(datetime1) == 2014));
        MaxT = nanmax(Tsoil_r3c0(month(datetime1) == m & daytime1 == 0 & year(datetime1) == 2014));
        daytime1_m(i-1) = nanmean(daytime1(Condition)); 
        [beta_Q10,R_Q10,J_Q10,CovB_Q10,MSE_Q10,ErrorModelInfo_Q10,rsq_Q10,NEE_Q10_ALL,Tref,Rplot_y,Rplot_x] = Q10FIT(Tsoil_r3c0,Rsoil_r3c0,Condition_n,MinT,MaxT);
        Diurn_mean_Rsoil_r3c0_measure(i-1,m) = nanmean(Rsoil_r3c0(Condition));
        Diurn_mean_Rsoil_r3c0_model(i-1,m) = nanmean(NEE_Q10_ALL(Condition));
        Diurn_mean_Tsoil_r3c0(i-1,m) = nanmean(Tsoil_r3c0(Condition));
    end
    daytime1_m_day = find(daytime1_m == 1); % index which half-hour is daytime, for each month
    Day_begin(m) = daytime1_m_day(1)/2;
    Day_end(m) = daytime1_m_day(length(daytime1_m_day))/2;
end 

%%%%%%%%
figure;

for m = 1:12
    subplot(4,3,m);
    plot(x,Diurn_mean_Rsoil_r3c0_measure(:,m),'b','LineWidth',2); 
    hold on;
    plot(x,Diurn_mean_Rsoil_r3c0_model(:,m),'r--','LineWidth',2);
    x_p = [Day_begin(m) Day_end(m) Day_end(m) Day_begin(m)]; 
    y_p = [1 1 6 6];
    patch(x_p,y_p,'k','FaceAlpha',.2,'EdgeColor','none');
    axis([0 24 1 6]); 
    ax = gca; set(ax,'FontSize',12); box off; ax.XTick = 0:2:24;
    text(0.90,0.98,month_name(m),'Units', 'Normalized', 'VerticalAlignment', 'Top');
    ax1_pos = ax.Position; % position of first axes
    ax2 = axes('Position',ax1_pos,...
    'XAxisLocation','top',...
    'YAxisLocation','right',...
    'Color','none');
    line(x,Diurn_mean_Tsoil_r3c0(:,m),'Parent',ax2,'Color','k','LineStyle',':');
    axis([0 24 10 26]); set(ax2,'FontSize',12); ax2.YTick = 10:4:26;
    set(gca,'xticklabel',[]);
    % legend('Measured','Modeled (night Q10)','Daytime','Location','northoutside','Orientation','horizontal');
    % ylabel('Soil CO_2 efflux (\mumolm^-^2s^-^1)');
    % xlabel('Hour of the day');
    % set(gca,'xticklabel',[]);
    % ylabel('Soil temperature (°C)');
    % legend('Soil temperature (°C)');
end


figure; 

for m = 1:12
    subplot(4,3,m);
    plot(x,Diurn_mean_Tsoil_r3c0(:,m),'k','LineWidth',2);
    x_p = [Day_begin(m) Day_end(m) Day_end(m) Day_begin(m)]; 
    y_p = [10 10 26 26];
    patch(x_p,y_p,'r','FaceAlpha',.2,'EdgeColor','none');
    axis([0 24 10 26]); 
    ax = gca; set(ax,'FontSize',12); box off; ax.XTick = 0:2:24;
    text(0.90,0.98,month_name(m),'Units', 'Normalized', 'VerticalAlignment', 'Top');
    % legend('Measured','Modeled (night Q10)','Daytime');
    % ylabel('Soil CO_2 efflux (\mumolm^-^2s^-^1)');
    % xlabel('Hour of the day');
    % set(gca,'xticklabel',[]);
end


























% nb. create half-hour vector (1-48), starting at half-hour = 0
i = 1;
j = 0;
n = length(datetime1);
hhour_t_s = NaN(n,1);
while i < n + 1
    if j < 47
        hhour_t_s(i) = j;
        j = j + 1;
    else
        hhour_t_s(i) = 47;
        j = 0;
    end
    i = i + 1;
end