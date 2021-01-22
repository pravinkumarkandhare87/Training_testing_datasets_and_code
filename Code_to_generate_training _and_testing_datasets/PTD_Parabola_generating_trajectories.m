
clearvars
close all;
clc;

tic
%rng('shuffle');
Counter=0;
Complete_sequnce=[];
%% number of trajectories 
Total_Number=100000;
Complete_sequnce_dist_p1_p2=[];
while(Counter<Total_Number)
    
    N = 1;  %number of arcs
    x0 = 1000*rand(N,1)-500; %center x0
    y0 = 1000*rand(N,1)-500; %center y0
    initialDirection = sign(rand(N,1)-0.5); %clockwise (-1) or counterclockwise (1)
    Direction_up_down = sign(rand(N,1)-0.5); %clockwise (-1) or counterclockwise (1)
    % choose any starting point on parabota where t is between -3 to 3
    inital_point_parabola=rand(N,1)*3.*initialDirection;
    
    % choose random focus
    % y^2=4*a*t
    a = rand(N,1)*20.*Direction_up_down; % value a
    arcLen = 7+rand(N,1)*93; %arc length between 7 and 100
    
    CpointsX = zeros(numel(x0),7);
    CpointsY = zeros(numel(x0),7);
    distance=zeros(numel(x0),1);
    % Arc_length = zeros(numel(x0),7);
    
    
    for i=1:numel(x0)
        j=1;
        t_initial=inital_point_parabola(i);
        %     disp(i);
        while(j<=7)
            if(j>1)
                t_initial=t_next_sol;
            end
            syms t t_next
            % sqrt((dx/dt)^2 +(dy/dt)^2) and x= x0+2*a*t and y =y0+a*t.^2
            % dx/dt= 2*a and dy/dt= 2*a*t
            %(dx/dt)^2=4*a^2
            %(dy/dt)^2=4*a^2*t^2
            %             f = sqrt(4*a(i)*a(i)*(1+t.^2));
            %             equ=int(f, t, t_initial, t_next);
            equ = abs(a(i))*(t_next*sqrt(t_next^2+1)+asinh(t_next))-...
                abs(a(i))*(t_initial*sqrt(t_initial^2+1)+asinh(t_initial));
            % length= integration [t_intilial t_next=t_unknown]
            equ1 = equ == arcLen(i)/6; % arcLen(i)/6 desired distance between 2 points on parabola
            t_next_sol= vpasolve(equ1,t_next);% find t_next interval
            
            % Derive points on parabola
            CpointsX(i,j) = round(x0(i)+2*a(i)*t_next_sol); %a(i)*t_next_sol.^2
            CpointsY(i,j) = round(y0(i)+a(i)*t_next_sol.^2); % 2*a(i)*t_next_sol
            
            %Sequence(i,2*j-1)= round(x0(i)+2*a(i)*t_next_sol);
            %Sequence(i,2*j)= round(y0(i)+a(i)*t_next_sol.^2);
            
            j=j+1;
        end
    distance(i)= sqrt((CpointsX(i,2)-CpointsX(i,1)).^2+(CpointsY(i,2)-CpointsY(i,1)).^2); %line length    
    end
    
    
    ind = find(max(CpointsX,[],2)>500 | min(CpointsX,[],2)<-500 | max(CpointsY,[],2)>500 | min(CpointsY,[],2)<-500| min(distance,[],2)> (sqrt(200)));
    CpointsX(ind,:) = [];
    CpointsY(ind,:) = [];
    distance(ind,:) = [];
    Sequence = zeros(size(CpointsY,1),2*7);
    % Idea: sequence size keep track
    Sequence(:,1:2:end)=CpointsX(:,1:1:end);
    Sequence(:,2:2:end)=CpointsY(:,1:1:end);
    
    Complete_sequnce=cat(1,Complete_sequnce,Sequence);
    
    add_dist=distance;
    Complete_sequnce_dist_p1_p2=cat(1,Complete_sequnce_dist_p1_p2,add_dist);
    
    Counter=Counter+size(Sequence,1);
    disp(Counter);
end

toc

%% save array to .csv file
Filename = sprintf('Parabola_Sequence_%s.csv', datestr(now,'mm-dd-yyyy HH-MM'));
csvwrite(Filename, Complete_sequnce);


%% plot

% figure(2)
% for i=1:size(CpointsX,1)
%     plot(CpointsX(i,:),CpointsY(i,:),'.')
%     hold on
%
% end
%
% xlim([-500 500])
% ylim([-500 500])
%
figure(3)
for i=1:size(Complete_sequnce,1)
    plot(Complete_sequnce(i,1:2:end),Complete_sequnce(i,2:2:end),'.')
    hold on
%     plot(Complete_sequnce(i,1),Complete_sequnce(i,2),'r.')
end

xlim([-500 500])
ylim([-500 500])

%% Elapsed time
