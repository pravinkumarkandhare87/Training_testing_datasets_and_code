clearvars
close all;
clc;

for run=1:1:1
    clc;
    clearvars -except run
    s = rng;
    Total_Number=100000;
    dis_limt=15;
    Counter=0;
    Complete_sequnce=[];
    Complete_sequnce_dist_p1_p2=[];
    
    while(Counter<=Total_Number)
        N=10000;
        % distance = 1+rand(N,1)*(15);
        
        Angle = rand(N,1)*2*pi; %initial arc angle
        initialDirection = sign(rand(N,1)-0.5); %clockwise (-1) or counterclockwise (1)
        finalAngle = initialDirection.*Angle;
        
        
        %initial random co-ordinates
        x0=1000*rand(N,1)-500;
        y0=1000*rand(N,1)-500;
        distance=zeros(numel(x0),1);
        
        % x and y sequences
        x = zeros(numel(x0),7);
        y = zeros(numel(x0),7);
        
        dist = 1+rand(N,1)*dis_limt; %dist between first two points on trajectory btweeen 1 and 15
        
        % angle to vector
        w = [cos(finalAngle),sin(finalAngle)];
        
        t = 0:6; % create a vector of t values
        x = x0 + dist*t.*w(:,1); %  x
        y = y0 + dist*t.*w(:,2); %  y
        for i=1:numel(x0)
            distance(i)= sqrt((x(i,2)-x(i,1)).^2+(y(i,2)-y(i,1)).^2); % measure distance between two points
        end
        ind = find(max(x,[],2)>500 | min(x,[],2)<-500 | max(y,[],2)>500 | min(y,[],2)<-500| min(distance,[],2)> (sqrt(225)));
        % ind = find(max(X,[],2)>500 | min(X,[],2)<-500 | max(Y,[],2)>500 | min(Y,[],2)<-500| min(distance,[],2)> (sqrt(225)));
        x(ind,:) = [];
        y(ind,:) = [];
        distance(ind,:) = [];
        
        % store sequences into Complete_sequnce
        Sequence = zeros(size(x,1),2*7);
        % Idea: sequence size keep track
        Sequence(:,1:2:end)=x(:,1:1:end);
        Sequence(:,2:2:end)=y(:,1:1:end);
        Complete_sequnce=cat(1,Complete_sequnce,Sequence);
        
        % store distances between two points to Complete_sequnce Complete_sequnce_dist_p1_p2
        add_dist=distance;
        Complete_sequnce_dist_p1_p2=cat(1,Complete_sequnce_dist_p1_p2,add_dist);
        Counter=Counter+size(Sequence,1);
    end
    
    Complete_sequnce=Complete_sequnce(1:Total_Number,:);
    Complete_sequnce_dist_p1_p2=Complete_sequnce_dist_p1_p2(1:Total_Number,:);
    
    
    %% save array to .csv file
    Filename = sprintf('Line_Sequence_%s.csv', datestr(now,'mm-dd-yyyy HH-MM'));
    csvwrite(Filename, Complete_sequnce);
    
    %% print only 200 lines
    figure(1)
    for i=1:200%size(Complete_sequnce,1)-99800
        plot(Complete_sequnce(i,1:2:end),Complete_sequnce(i,2:2:end),'.','MarkerSize',20)
        hold on
        %     plot(Complete_sequnce(i,1),Complete_sequnce(i,2),'r.') % plot first point of trajectory with red to show traj direction
        
    end
    title('Sample Line Dataset');
    xlabel('x - coordinate');
    ylabel('y - coordinate');
    xlim([-500 500])
    ylim([-500 500])
    
    %% print histogram
    figure(2)
    histogram(Complete_sequnce_dist_p1_p2,0:dis_limt)
    title_string=strcat("histogram (without discarding trajectories) :");
    % title_string=strcat("histogram (discarding trajectories) :");
    title(title_string);
    ylabel('number of trajectories');
    xlabel('Absolute distance between first 2 points of trajectory');
end