% R soil survey CUP hello
DateTime_RsoilCUP(1:8) = datetime(2015,10,23,12,00,00);
DateTime_RsoilCUP(9:16) = datetime(2015,10,30,12,00,00);
DateTime_RsoilCUP(17:24) = datetime(2015,11,06,12,00,00);
DateTime_RsoilCUP(25:32) = datetime(2015,11,24,12,00,00);
DateTime_RsoilCUP(33:40) = datetime(2015,12,03,12,00,00);
DateTime_RsoilCUP(41:48) = datetime(2016,01,21,12,00,00);
DateTime_RsoilCUP(49:56) = datetime(2016,01,28,12,00,00);
DateTime_RsoilCUP(57:64) = datetime(2016,02,05,12,00,00);
DateTime_RsoilCUP(65:72) = datetime(2016,02,17,12,00,00);
DateTime_RsoilCUP(73:80) = datetime(2016,03,02,12,00,00);
DateTime_RsoilCUP(81:88) = datetime(2016,04,07,12,00,00);
DateTime_RsoilCUP(89:96) = datetime(2016,05,12,12,00,00);
DateTime_RsoilCUP(97:104) = datetime(2016,08,01,12,00,00);
DateTime_RsoilCUP(105:112) = datetime(2016,08,30,12,00,00);

Tsoil_RsoilCUP(1:8) = tsoil(t_s == DateTime_RsoilCUP(1));
Tsoil_RsoilCUP=Tsoil_RsoilCUP';
Tsoil_RsoilCUP(9:16) = tsoil(t_s == DateTime_RsoilCUP(9));
Tsoil_RsoilCUP(17:24) = tsoil(t_s == DateTime_RsoilCUP(17));
Tsoil_RsoilCUP(25:32) = tsoil(t_s == DateTime_RsoilCUP(25));
Tsoil_RsoilCUP(33:40) = tsoil(t_s == DateTime_RsoilCUP(33));
Tsoil_RsoilCUP(41:48) = tsoil(t_s == DateTime_RsoilCUP(41));
Tsoil_RsoilCUP(49:56) = tsoil(t_s == DateTime_RsoilCUP(49));
Tsoil_RsoilCUP(57:64) = tsoil(t_s == DateTime_RsoilCUP(57));
Tsoil_RsoilCUP(65:72) = tsoil(t_s == DateTime_RsoilCUP(65));
Tsoil_RsoilCUP(73:80) = tsoil(t_s == DateTime_RsoilCUP(73));
Tsoil_RsoilCUP(81:88) = tsoil(t_s == DateTime_RsoilCUP(81));
Tsoil_RsoilCUP(89:96) = 17.53; % read from .csv slow_met
Tsoil_RsoilCUP(97:104) = 11.78; % read from .csv slow_met
Tsoil_RsoilCUP(105:112) = 12.20; % read from .csv slow_met

SWC_RsoilCUP(1:8) = SWC_s(t_s == DateTime_RsoilCUP(1));
SWC_RsoilCUP = SWC_RsoilCUP';
SWC_RsoilCUP(9:16) = SWC_s(t_s == DateTime_RsoilCUP(9));
SWC_RsoilCUP(17:24) = SWC_s(t_s == DateTime_RsoilCUP(17));
SWC_RsoilCUP(25:32) = SWC_s(t_s == DateTime_RsoilCUP(25));
SWC_RsoilCUP(33:40) = SWC_s(t_s == DateTime_RsoilCUP(33));
SWC_RsoilCUP(41:48) = SWC_s(t_s == DateTime_RsoilCUP(41));
SWC_RsoilCUP(49:56) = SWC_s(t_s == DateTime_RsoilCUP(49));
SWC_RsoilCUP(57:64) = SWC_s(t_s == DateTime_RsoilCUP(57));
SWC_RsoilCUP(65:72) = SWC_s(t_s == DateTime_RsoilCUP(65));
SWC_RsoilCUP(73:80) = SWC_s(t_s == DateTime_RsoilCUP(73));
SWC_RsoilCUP(81:88) = SWC_s(t_s == DateTime_RsoilCUP(81));
SWC_RsoilCUP(89:96) = 18.7; % read from .csv slow_met
SWC_RsoilCUP(97:104) = 11.95; % read from .csv slow_met
SWC_RsoilCUP(105:112) = 13.2; % read from .csv slow_met


figure; subplot(3,1,1); plot(DateTime_RsoilCUP,Rsoil_CUP,'LineStyle','none','Marker','o','MarkerEdgeColor','k');
axis([datenum(DateTime_RsoilCUP(1)) datenum(DateTime_RsoilCUP(112)) 0 7]);
set(gca,'xticklabel',[]);
ax = gca; set(ax,'FontSize',12);
ylabel('Soil respiration (\mumolm^-^2s^-^1)');
subplot(3,1,2); plot(t_s,tsoil,'c'); hold on;
plot(DateTime_RsoilCUP,Tsoil_RsoilCUP,'LineStyle','none','Marker','o','MarkerEdgeColor','k');
axis([datenum(DateTime_RsoilCUP(1)) datenum(DateTime_RsoilCUP(112)) 10 30]);
ax = gca; set(ax,'FontSize',12);
ylabel('Soil temperature _5_c_m (°C)');
set(gca,'xticklabel',[]);
subplot(3,1,3); plot(t_s,SWC_s,'c'); hold on;
plot(DateTime_RsoilCUP,SWC_RsoilCUP,'LineStyle','none','Marker','o','MarkerEdgeColor','k');
axis([datenum(DateTime_RsoilCUP(1)) datenum(DateTime_RsoilCUP(112)) 0 40]);
ax = gca; set(ax,'FontSize',12);
ylabel('SWC _0_-_8_c_m (%)');

