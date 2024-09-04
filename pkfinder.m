function [locs,pks,locs3,pks3]=pkfinder(chan1,seekback)

[pks,locs,w,p]=findpeaks(chan1,'MinPeakProminence',0.01,'MinPeakDistance',5000);
pks2=[];
locs2=[];

for i=1:length(locs)
    for j=locs(i)-seekback:locs(i)
        if chan1(j)>pks(i)*.02
            pks2=[pks2 chan1(j)];
            locs2=[locs2 j];
            break
        end
    end
end

locs3=[];
pks3=[];
for i=1:length(locs2)
temp=chan1(locs2(i):locs2(i)+5);
[m,idx]=max(temp);
locs3=[locs3 idx+locs2(i)-1];
pks3=[pks3 m];
end

end