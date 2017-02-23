DOY_soil = day(datetime1,'dayofyear');
Month_soil = month(1:1:365,'monthofyear');

% Day R average vs Night R average plot
for i = 1:365
    Rsoil_DOY_day(i) = nanmean(Rsoil_r3c0(DOY_soil == i & daytime1 == 1 & year(datetime1) == 2014));
    Rsoil_DOY_night(i) = nanmean(Rsoil_r3c0(DOY_soil == i & daytime1 == 0 & year(datetime1) == 2014));
    Tsoil_DOY_day(i) = nanmean(Tsoil_r3c0(DOY_soil == i & daytime1 == 1 & year(datetime1) == 2014));
    Tsoil_DOY_night(i) = nanmean(Tsoil_r3c0(DOY_soil == i & daytime1 == 0 & year(datetime1) == 2014));
    VWCsoil_DOY_day(i) = nanmean(VWC_r3c0(DOY_soil == i & daytime1 == 1 & year(datetime1) == 2014));
    VWCsoil_DOY_night(i) = nanmean(VWC_r3c0(DOY_soil == i & daytime1 == 0 & year(datetime1) == 2014));
end
% all year
figure;
subplot(2,1,1);
hold on;
x = Rsoil_DOY_day;
y = Rsoil_DOY_night;
[x,y] = prepareCurveData(x,y);
%b1 = x\y; % the \ operator performs a least-squares regression
%yCalc1 = b1*x;
ft = fittype( 'poly1' );
[fitresult, gof] = fit( x, y, ft );
plot( fitresult, x, y, 'predobs');
plot([0 8],[0 8],'k','LineWidth',2);
plot(x,yCalc1,'r','LineWidth',2);
xlabel('Day-time soil respiration (\mumolm^-^2s^-^1)');
ylabel('Night-time soil respiration (\mumolm^-^2s^-^1)');
ax = gca; set(ax,'FontSize',12);
axis([0 8 0 8]);
subplot(2,1,2);
x = Tsoil_DOY_day;
y = Tsoil_DOY_night;
[x,y] = prepareCurveData(x,y);
b1 = x\y; % the \ operator performs a least-squares regression
yCalc1 = b1*x;
scatter(x,y,'k'); % axis([min(x) max(x) -4 4]);
hold on; %plot([min(x) max(x)], [0 0],'k');
plot([10 28],[10 28],'k','LineWidth',2);
plot(x,yCalc1,'r','LineWidth',2);
% xlabel('Day-time soil temperature (°C)');
% ylabel('Night-time soil temperature (°C)');
ax = gca; set(ax,'FontSize',12);
axis([10 28 10 28]);
    
    
    
    
% monthly
figure; 
for m = 1:12
    subplot(2,12,m);
    x = Rsoil_DOY_day(Month_soil == m);
    y = Rsoil_DOY_night(Month_soil == m);
    [x,y] = prepareCurveData(x,y);
    b1 = x\y; % the \ operator performs a least-squares regression
    yCalc1 = b1*x;
    scatter(x,y,'k'); % axis([min(x) max(x) -4 4]);
    hold on; %plot([min(x) max(x)], [0 0],'k');
    plot([0 8],[0 8],'k','LineWidth',2);
    plot(x,yCalc1,'r','LineWidth',2);
    % xlabel('Day-time soil respiration (\mumolm^-^2s^-^1)');
    % ylabel('Night-time soil respiration (\mumolm^-^2s^-^1)');
    ax = gca; set(ax,'FontSize',12);
    axis([min(x) max(y) min(x) max(y)]);
    subplot(2,12,m+12);
    x = Tsoil_DOY_day(Month_soil == m);
    y = Tsoil_DOY_night(Month_soil == m);
    [x,y] = prepareCurveData(x,y);
    b1 = x\y; % the \ operator performs a least-squares regression
    yCalc1 = b1*x;
    scatter(x,y,'k'); % axis([min(x) max(x) -4 4]);
    hold on; %plot([min(x) max(x)], [0 0],'k');
    plot([10 28],[10 28],'k','LineWidth',2);
    plot(x,yCalc1,'r','LineWidth',2);
    % xlabel('Day-time soil temperature (°C)');
    % ylabel('Night-time soil temperature (°C)');
    ax = gca; set(ax,'FontSize',12);
    axis([min(y) max(x) min(y) max(x)]);
end



