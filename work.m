
clear
close all

% dat1=audioread('table_tap_70.wav');
% dat1=audioread('table_pentap_70_middle.wav');
% dat1=audioread('table_pentap_38_middle.wav');
% dat1=audioread('table_pentap_38.wav');
% dat1=audioread('table_tap_38_middle.wav');
dat1=audioread('table_tap_38.wav');

chan1=dat1(:,1);
chan2=dat1(:,2);

seeback=500;

figure
hold on
[locs,pks,locs2,pks2]=pkfinder(chan1,seeback);
plot(chan1)
% scatter(locs,pks,'filled')
scatter(locs2,pks2,'filled')

[locs,pks,locs2,pks2]=pkfinder(chan2,seeback);
plot(chan2)
% scatter(locs,pks,'filled')
scatter(locs2,pks2,'filled')
