DateTime_r3_c0 = datetime_soilE(collar == 0 & ring == 3 & RsoilCV <= 1.2);
Rsoil_r3_c0 = Rsoil(collar == 0 & ring == 3 & RsoilCV <= 1.2);
Tcham_r3_c0 = Tcham(collar == 0 & ring == 3 & RsoilCV <= 1.2);

n = length(t_met);
Rsoil_r3_c0_m = nan(n,1);
Tcham_r3_c0_m = nan(n,1);
[Lia,LocB] = ismember(t_met,DateTime_r3_c0);
for i = 1:n
    if LocB(i)>0
        Rsoil_r3_c0_m(i,1) = Rsoil_r3_c0(LocB(i),1);
        Tcham_r3_c0_m(i,1) = Tcham_r3_c0(LocB(i),1);
    end
end


month_name = {'Jan' 'Feb' 'Mar' 'Apr' 'May' 'Jun' 'Jul' 'Aug' 'Sep' 'Oct' 'Nov' 'Dec'};
figure;
for m = 1:12
    subplot(4,3,m);
    Condition_d = find(daytime1 == 1 & month(datetime1) == m); Condition_n = find(daytime1 == 0 & month(datetime1) == m);
    scatter(Tsoil_r3c0(Condition_n),Rsoil_r3c0(Condition_n),10,VWC_r3c0(Condition_n));
    hold on; scatter(Tsoil_r3c0(Condition_d),Rsoil_r3c0(Condition_d),10,VWC_r3c0(Condition_d),'+');
    minTd = min(Tsoil_r3c0(Condition_d)); maxTd = max(Tsoil_r3c0(Condition_d));
    [beta_Q10,R_Q10,J_Q10,CovB_Q10,MSE_Q10,ErrorModelInfo_Q10,rsq_Q10,NEE_Q10_ALL,Tref,Rplot_y,Rplot_x] = Q10FIT(Tsoil_r3c0,Rsoil_r3c0,Condition_n,minTd,maxTd);
    plot(Rplot_x,Rplot_y,'k','LineWidth',2);
    %binned_plot(Tsoil_r3c0(Condition_d),Rsoil_r3c0(Condition_d),10,'style','k','y_mean_std','on');
    [beta_Q10,R_Q10,J_Q10,CovB_Q10,MSE_Q10,ErrorModelInfo_Q10,rsq_Q10,NEE_Q10_ALL,Tref,Rplot_y,Rplot_x] = Q10FIT(Tsoil_r3c0,Rsoil_r3c0,Condition_d,minTd,maxTd);
    plot(Rplot_x,Rplot_y,'m--','LineWidth',2);
    % xlabel('Air temperature (°C)'); ylabel('Soil respiration (\mumolm^-^2s^-^1)');
    % legend('night data','day data','Q10 fitted on night data','Q10 fitted on daytime data');
    % ax = gca; set(ax,'FontSize',12); box off;
    % set(gca,'xticklabel',[]);
    % h = colorbar; ylabel(h, 'Volumetric Water Content');
    axis([5 30 0 8]); caxis([nanmin(VWC_r3c0) nanmax(VWC_r3c0)]); colormap(soilRmap);
    text(0.90,0.98,month_name(m),'Units', 'Normalized', 'VerticalAlignment', 'Top');
end

figure;
subplot(2,2,1);
Condition_d = find(daytime1 == 1 & VWC_r3c0 < quantile(VWC_r3c0,0.25));
Condition_n = find(daytime1 == 0 & VWC_r3c0 < quantile(VWC_r3c0,0.25));
hold on; scatter(Tsoil_r3c0(Condition_d),Rsoil_r3c0(Condition_d),10,'r');
scatter(Tsoil_r3c0(Condition_n),Rsoil_r3c0(Condition_n),10,'b'); axis([5 30 0 8]);
text(0.02,0.98,'VWC < 0.032 (quantile 0-0.25)','Units', 'Normalized', 'VerticalAlignment', 'Top');
minTd = min(Tsoil_r3c0(Condition_d)); maxTd = max(Tsoil_r3c0(Condition_d));
[beta_Q10,R_Q10,J_Q10,CovB_Q10,MSE_Q10,ErrorModelInfo_Q10,rsq_Q10,NEE_Q10_ALL,Tref,Rplot_y,Rplot_x] = Q10FIT(Tsoil_r3c0,Rsoil_r3c0,Condition_n,minTd,maxTd);
plot(Rplot_x,Rplot_y,'g','LineWidth',2);
[beta_Q10,R_Q10,J_Q10,CovB_Q10,MSE_Q10,ErrorModelInfo_Q10,rsq_Q10,NEE_Q10_ALL,Tref,Rplot_y,Rplot_x] = Q10FIT(Tsoil_r3c0,Rsoil_r3c0,Condition_d,minTd,maxTd);
plot(Rplot_x,Rplot_y,'k--','LineWidth',2);

subplot(2,2,2);
Condition_d = find(daytime1 == 1 & VWC_r3c0 >= quantile(VWC_r3c0,0.25) & VWC_r3c0 < quantile(VWC_r3c0,0.5));
Condition_n = find(daytime1 == 0 & VWC_r3c0 >= quantile(VWC_r3c0,0.25) & VWC_r3c0 < quantile(VWC_r3c0,0.5));
hold on; scatter(Tsoil_r3c0(Condition_d),Rsoil_r3c0(Condition_d),10,'r');
scatter(Tsoil_r3c0(Condition_n),Rsoil_r3c0(Condition_n),10,'b'); axis([5 30 0 8]);
text(0.02,0.98,'VWC 0.032-0.041 (quantile 0.25-0.5)','Units', 'Normalized', 'VerticalAlignment', 'Top');
minTd = min(Tsoil_r3c0(Condition_d)); maxTd = max(Tsoil_r3c0(Condition_d));
[beta_Q10,R_Q10,J_Q10,CovB_Q10,MSE_Q10,ErrorModelInfo_Q10,rsq_Q10,NEE_Q10_ALL,Tref,Rplot_y,Rplot_x] = Q10FIT(Tsoil_r3c0,Rsoil_r3c0,Condition_n,minTd,maxTd);
plot(Rplot_x,Rplot_y,'g','LineWidth',2);
[beta_Q10,R_Q10,J_Q10,CovB_Q10,MSE_Q10,ErrorModelInfo_Q10,rsq_Q10,NEE_Q10_ALL,Tref,Rplot_y,Rplot_x] = Q10FIT(Tsoil_r3c0,Rsoil_r3c0,Condition_d,minTd,maxTd);
plot(Rplot_x,Rplot_y,'k--','LineWidth',2);

subplot(2,2,3);
Condition_d = find(daytime1 == 1 & VWC_r3c0 >= quantile(VWC_r3c0,0.5) & VWC_r3c0 < quantile(VWC_r3c0,0.75));
Condition_n = find(daytime1 == 0 & VWC_r3c0 >= quantile(VWC_r3c0,0.5) & VWC_r3c0 < quantile(VWC_r3c0,0.75));
hold on; scatter(Tsoil_r3c0(Condition_d),Rsoil_r3c0(Condition_d),10,'r');
scatter(Tsoil_r3c0(Condition_n),Rsoil_r3c0(Condition_n),10,'b'); axis([5 30 0 8]);
text(0.02,0.98,'VWC 0.041-0.082 (quantile 0.5-0.75)','Units', 'Normalized', 'VerticalAlignment', 'Top');
minTd = min(Tsoil_r3c0(Condition_d)); maxTd = max(Tsoil_r3c0(Condition_d));
[beta_Q10,R_Q10,J_Q10,CovB_Q10,MSE_Q10,ErrorModelInfo_Q10,rsq_Q10,NEE_Q10_ALL,Tref,Rplot_y,Rplot_x] = Q10FIT(Tsoil_r3c0,Rsoil_r3c0,Condition_n,minTd,maxTd);
plot(Rplot_x,Rplot_y,'g','LineWidth',2);
[beta_Q10,R_Q10,J_Q10,CovB_Q10,MSE_Q10,ErrorModelInfo_Q10,rsq_Q10,NEE_Q10_ALL,Tref,Rplot_y,Rplot_x] = Q10FIT(Tsoil_r3c0,Rsoil_r3c0,Condition_d,minTd,maxTd);
plot(Rplot_x,Rplot_y,'k--','LineWidth',2);

subplot(2,2,4);
Condition_d = find(daytime1 == 1 & VWC_r3c0 > quantile(VWC_r3c0,0.75));
Condition_n = find(daytime1 == 0 & VWC_r3c0 > quantile(VWC_r3c0,0.75));
hold on; scatter(Tsoil_r3c0(Condition_d),Rsoil_r3c0(Condition_d),10,'r');
scatter(Tsoil_r3c0(Condition_n),Rsoil_r3c0(Condition_n),10,'b'); axis([5 30 0 8]);
text(0.02,0.98,'VWC > 0.082 (quantile 0.75-1)','Units', 'Normalized', 'VerticalAlignment', 'Top');
minTd = min(Tsoil_r3c0(Condition_d)); maxTd = max(Tsoil_r3c0(Condition_d));
[beta_Q10,R_Q10,J_Q10,CovB_Q10,MSE_Q10,ErrorModelInfo_Q10,rsq_Q10,NEE_Q10_ALL,Tref,Rplot_y,Rplot_x] = Q10FIT(Tsoil_r3c0,Rsoil_r3c0,Condition_n,minTd,maxTd);
plot(Rplot_x,Rplot_y,'g','LineWidth',2);
[beta_Q10,R_Q10,J_Q10,CovB_Q10,MSE_Q10,ErrorModelInfo_Q10,rsq_Q10,NEE_Q10_ALL,Tref,Rplot_y,Rplot_x] = Q10FIT(Tsoil_r3c0,Rsoil_r3c0,Condition_d,minTd,maxTd);
plot(Rplot_x,Rplot_y,'k--','LineWidth',2);

% legend('day data','night data','night Q10', 'day Q10');






% With CUP NEE night data... 
figure;
for m = 1:12
    subplot(4,3,m); hold on;
    Condition = find(qc == 0 & qc_Sc ~= 2 & AGC_c == 0 & u > 0.2 & daytime == 0 & month(t_s) == m & year(t_s) == 2014);
    if isnan(NEE_c(Condition)) == 0 
        scatter(Ts_surf(Condition),NEE_c(Condition),10,'k');
        minTd = min(Ts_surf(Condition)); maxTd = max(Ts_surf(Condition)); % max night Ts here
        [beta_Q10,R_Q10,J_Q10,CovB_Q10,MSE_Q10,ErrorModelInfo_Q10,rsq_Q10,NEE_Q10_ALL,Tref,Rplot_y,Rplot_x] = Q10FIT(Ts_surf,NEE_c,Condition,minTd,maxTd);
        plot(Rplot_x,Rplot_y,'k','LineWidth',2);
        axis([5 30 0 8]);
        %caxis([nanmin(VWC_r3c0) nanmax(VWC_r3c0)]); colormap(soilRmap);
        text(0.90,0.98,month_name(m),'Units', 'Normalized', 'VerticalAlignment', 'Top');
    end
end




% load 2014 data, ring3 collar 0
% year 2014 continuous timestamp
daytime1 = daytime(find(year(t_s) == 2014));
datetime1 = t_s(find(year(t_s) == 2014));

% save data on continuous timestep
[Lia,LocB] = ismember(datetime1,datetime);
n = length(datetime1);
Rsoil_r3c0 = nan(n,1);
VWC_r3c0 = nan(n,1);
Tsoil_r3c0 = nan(n,1);
for i = 1:n
if LocB(i)>0
Rsoil_r3c0(i,1) = Rsoil1(LocB(i),1);
VWC_r3c0(i,1) = VWC(LocB(i),1);
Tsoil_r3c0(i,1) = Tsoil(LocB(i),1);
end
end