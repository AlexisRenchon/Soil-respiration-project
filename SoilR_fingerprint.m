% 2. Create half-hour vector (0-47), starting at half-hour = 0
i = 1;
j = 0;
n = length(datetime1);
hhour_test = NaN(n,1);
while i < n + 1
    if j < 47
        hhour_test(i) = j;
        j = j + 1;
    else
        hhour_test(i) = 47;
        j = 0;
    end
    i = i + 1;
end

figure;
use = find (isnan(Rsoil_r3c0) == 0);
subplot(1,4,1); scatter(hhour_test(use),datenum(datetime1(use)),20,Rsoil_r3c0(use)); colormap(jet); caxis([1 5]);
axis([0 48 datenum(datetime(2014,01,01,00,00,00)) datenum(datetime(2015,01,01,00,00,00))]);
set(gca,'YTick',[datenum(datetime(2014,01,01,00,00,00)) datenum(datetime(2014,03,01,00,00,00)) datenum(datetime(2014,05,01,00,00,00)) ...
    datenum(datetime(2014,07,01,00,00,00)) datenum(datetime(2014,09,01,00,00,00)) datenum(datetime(2014,11,01,00,00,00)) datenum(datetime(2015,01,01,00,00,00))]);
set(gca,'YTickLabel',{'Jan','Mar','May','Jul','Sep','Nov','Jan'});
set(gca,'FontSize',14);
ylabel('Month of the year 2014');
h = colorbar;
h.Location = 'northoutside';
h.Label.FontSize = 14;
ylabel(h, 'R_s_o_i_l (\mumol m^-^2 s^-^1)');

use = find (isnan(Tsoil_r3c0) == 0);
subplot(1,4,2); scatter(hhour_test(use),datenum(datetime1(use)),20,Tsoil_r3c0(use)); 
axis([0 48 datenum(datetime(2014,01,01,00,00,00)) datenum(datetime(2015,01,01,00,00,00))]);
set(gca,'YTick',[datenum(datetime(2014,01,01,00,00,00)) datenum(datetime(2014,03,01,00,00,00)) datenum(datetime(2014,05,01,00,00,00)) ...
    datenum(datetime(2014,07,01,00,00,00)) datenum(datetime(2014,09,01,00,00,00)) datenum(datetime(2014,11,01,00,00,00)) datenum(datetime(2015,01,01,00,00,00))]);
set(gca,'YTickLabel',{'Jan','Mar','May','Jul','Sep','Nov','Jan'});
set(gca,'FontSize',14);
xlabel('Half-hour of the day');
h = colorbar;
h.Location = 'northoutside';
h.Label.FontSize = 14;
ylabel(h, 'T_s_o_i_l (°C)');


use = find (isnan(VWC_r3c0) == 0);
subplot(1,4,3); scatter(hhour_test(use),datenum(datetime1(use)),20,VWC_r3c0(use)); 
axis([0 48 datenum(datetime(2014,01,01,00,00,00)) datenum(datetime(2015,01,01,00,00,00))]);
set(gca,'YTick',[datenum(datetime(2014,01,01,00,00,00)) datenum(datetime(2014,03,01,00,00,00)) datenum(datetime(2014,05,01,00,00,00)) ...
    datenum(datetime(2014,07,01,00,00,00)) datenum(datetime(2014,09,01,00,00,00)) datenum(datetime(2014,11,01,00,00,00)) datenum(datetime(2015,01,01,00,00,00))]);
set(gca,'YTickLabel',{'Jan','Mar','May','Jul','Sep','Nov','Jan'});
set(gca,'FontSize',14);
h = colorbar;
h.Location = 'northoutside';
h.Label.FontSize = 14;
ylabel(h, 'VWC_s_o_i_l (m^3 m^-^3)');


use = find (isnan(FM_2014) == 0); 
subplot(1,4,4); scatter(hour_test(use),datenum(DateTime_FM(use)),20,FM_2014(use)); caxis([nanmin(FM_2014) quantile(FM_2014,0.75)]);
axis([0 24 datenum(datetime(2014,01,01,00,00,00)) datenum(datetime(2015,01,01,00,00,00))]);
set(gca,'YTick',[datenum(datetime(2014,01,01,00,00,00)) datenum(datetime(2014,03,01,00,00,00)) datenum(datetime(2014,05,01,00,00,00)) ...
    datenum(datetime(2014,07,01,00,00,00)) datenum(datetime(2014,09,01,00,00,00)) datenum(datetime(2014,11,01,00,00,00)) datenum(datetime(2015,01,01,00,00,00))]);
set(gca,'YTickLabel',{'Jan','Mar','May','Jul','Sep','Nov','Jan'});
set(gca,'FontSize',14);
h = colorbar;
h.Location = 'northoutside';
h.Label.FontSize = 14;
ylabel(h, 'Fuel moisture (%)');