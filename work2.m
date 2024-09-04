
clear
close all

% dat1=audioread('table_tap_70.wav');
% dat1=audioread('table_pentap_70_middle.wav');
% dat1=audioread('table_pentap_38_middle.wav');
% dat1=audioread('table_pentap_38.wav');
% dat1=audioread('table_tap_38_middle.wav');
% dat1=audioread('table_tap_38.wav');
dd='3cm_x';
files=dir(dd);
files=files(3:end);
f2=figure;
hold on
labels=[];
for file=files'
    if contains(file.name,'png')==1||contains(file.name,'DS_Store')==1
continue
    end
path=strcat(dd,'/',file.name);
dat1=audioread(path);

gt=ground_truth(file.name);

nchan=size(dat1,2);
if nchan>2
    dat1=dat1(:,1:2:end);
    nchan=size(dat1,2);
end

% f1=figure;
% hold on
seeback=500;

 try
    blocs=[];
    for num=1:nchan
        chan1=dat1(:,num);
        [locs,pks,locs2,pks2]=pkfinder(chan1,seeback);
        % plot(chan1)
        % scatter(locs,pks,'filled')
        % scatter(locs2,pks2,'filled')
        blocs=[blocs; locs2];
    end
    
    vals=[];
    for num=1:length(locs2)
    locs=blocs(:,num);
    locs=abs(locs-locs(1));
    vals=[vals mean(locs)];
    end
    
    [f,x]=ecdf(vals);
    euclidean=sqrt(gt(1).^2+gt(2).^2);

    if strcmp(sprintf("%.2f",euclidean),'0.05')==1||strcmp(sprintf("%.2f",euclidean),'0.07')==1
        l1=plot(x,f,'Color','red','LineWidth',2);
    elseif strcmp(sprintf("%.2f",euclidean),'0.10')==1
        l2=plot(x,f,'Color','green','LineWidth',2);
    elseif strcmp(sprintf("%.2f",euclidean),'0.13')==1||strcmp(sprintf("%.2f",euclidean),'0.14')==1||strcmp(sprintf("%.2f",euclidean),'0.15')==1
        l3=plot(x,f,'Color','black','LineWidth',2);
    elseif strcmp(sprintf("%.2f",euclidean),'0.18')==1
        l4=plot(x,f,'Color','blue','LineWidth',2);
    else
        plot(x,f);
    end
    % title(strcat(file.name,",",num2str(gt(1)),",",num2str(gt(2))));
    % title(strcat(num2str(gt(1)),",",num2str(gt(2))));
    % title(sprintf("%.2f",euclidean));
    labels=[labels sprintf("%.2f",euclidean)];
    ylabel('CDF')
    xlabel('Average difference between starting samples')
    xlim([0,250])
    % saveas(gcf,strcat(dd,'/',file.name,'.png'));
catch
% close all
end
end
legend([l1,l2,l3,l4],{'0.05-0.07','0.10','0.13-0.15','0.18'})