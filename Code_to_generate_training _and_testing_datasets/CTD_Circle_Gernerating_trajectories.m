clearvars
close all;
clc;

% intialize seed 


Counter=0;
Complete_sequnce=[];
Complete_sequnce_dist_p1_p2=[];
Total_Number=100000;
while(Counter<Total_Number)
    
    
    N = 10000;  %number of arcs
    Rmax = 100; %maximal radius
    x0 = 1000*rand(N,1)-500; %center x0
    y0 = 1000*rand(N,1)-500; %center y0
    r = 10+rand(N,1)*(Rmax-10); %radius between 10 and 100
    initialAngle = rand(N,1)*2*pi; %initial arc angle
    initialDirection = sign(rand(N,1)-0.5); %clockwise (-1) or counterclockwise (1)
    arcLen = 7+rand(N,1)*93; %arc length between 7 and 100
    
    finalAngle = arcLen./r+initialDirection.*initialAngle;
    
    CpointsX = zeros(numel(x0),7);
    CpointsY = zeros(numel(x0),7);
    distance=zeros(numel(x0),1);
    for t=1:numel(x0)
        phi = linspace(initialAngle(t),finalAngle(t),7);
        CpointsX(t,:) = (r(t).*cos(phi)+x0(t));
        CpointsY(t,:) = (r(t).*sin(phi)+y0(t));
        distance(t)= sqrt((CpointsX(t,2)-CpointsX(t,1)).^2+(CpointsY(t,2)-CpointsY(t,1)).^2); %line length
    end
    
    ind = find(max(CpointsX,[],2)>500 | min(CpointsX,[],2)<-500 | max(CpointsY,[],2)>500 | min(CpointsY,[],2)<-500 | min(distance,[],2)> (sqrt(225))| max(distance,[],2)< 1);
    CpointsX(ind,:) = [];
    CpointsY(ind,:) = [];
    distance(ind,:) = [];
    
    Sequence = zeros(size(CpointsX,1),2*7);
    % Idea: sequence size keep track
    Sequence(:,1:2:end)=CpointsX(:,1:1:end);
    Sequence(:,2:2:end)=CpointsY(:,1:1:end);
    
    Complete_sequnce=cat(1,Complete_sequnce,Sequence);
    
    add_dist=distance;
    Complete_sequnce_dist_p1_p2=cat(1,Complete_sequnce_dist_p1_p2,add_dist);
    
    Counter=Counter+size(Sequence,1);
    disp(Counter);
    
end

Complete_sequnce=Complete_sequnce(1:100000,:);
Complete_sequnce_dist_p1_p2=Complete_sequnce_dist_p1_p2(1:100000,:);

figure(1)
for t=1:100%size(CpointsX,1)%
    plot(CpointsX(t,:),CpointsY(t,:),'.')
    hold on
end
xlim([-500 500])
ylim([-500 500])


%% save array to .csv file
Filename = sprintf('Circle_Sequence_%s.csv', datestr(now,'mm-dd-yyyy HH-MM'));
csvwrite(Filename, Complete_sequnce);


%% print histogram
figure(2)
dis_limt=15;
histogram(Complete_sequnce_dist_p1_p2,0:dis_limt)
title_string=strcat("histogram :",int2str(1));
title(title_string);
ylabel('number of trajectories');
xlabel('Absolute distance between first 2 points of trajectory');


% %%
% figure(3)
% for i=1:size(Complete_sequnce,1)
%     plot(Complete_sequnce(i,1:2:end),Complete_sequnce(i,2:2:end),'.')
%     hold on
%     plot(Complete_sequnce(i,1),Complete_sequnce(i,2),'r.')
% end
%
% xlim([-500 500])
% ylim([-500 500])
