clearvars
close all;
clc;


% Line_filename1="LTD_train_Nov5.csv";
% Circle_filename2="CTD_train_Nov5.csv";
% Parabola_filename3="PTD_train_Nov5.csv";
Line_filename1="LTD_train_Apr23v1.csv";
Circle_filename2="CTD_train_Apr23.csv";
Parabola_filename3="PTD_train_Apr23.csv";


Line_csv1 = csvread(Line_filename1);
Circle_csv2 = csvread(Circle_filename2);
Parabola_csv3 = csvread(Parabola_filename3);

total_trajec=100000;

Line_csv1= Line_csv1(1:total_trajec,:);
Circle_csv2=Circle_csv2(1:total_trajec,:);
Parabola_csv3=Parabola_csv3(1:total_trajec,:);

num=100000;

Combined=[];
Combined(1:num,:)=Line_csv1(1:num,:);
Combined(size(Combined,1)+1:size(Combined,1)+num,:)=Circle_csv2(1:num,:);
Combined(size(Combined,1)+1:size(Combined,1)+num,:)=Parabola_csv3(1:num,:);

% radomized shuffling of rows
x=Combined;
Combined_x = x(randperm(size(x, 1)), :);


Lines="Lines_S23.csv";
Circles="Circles_S23.csv";
Parabolas="Parabolas_S23.csv";
% Combined_LCP="MTD_train_Nov5.csv"; 
Combined_LCP="MTD_train_Dec19.csv";
% csvwrite(Lines,Line_csv1);
% csvwrite(Circles,Circle_csv2);
% csvwrite(Parabolas,Parabola_csv3);
csvwrite(Combined_LCP,Combined_x);

%%
dataset=Combined_x;
figure(3)
for i=1:size(dataset,1)-299900
    plot(dataset(i,1:2:end),dataset(i,2:2:end),'.')
    hold on
    
end

xlim([-500 500])
ylim([-500 500])