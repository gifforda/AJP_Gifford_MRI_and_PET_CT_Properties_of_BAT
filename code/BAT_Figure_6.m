%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %   
% % %   CODE FOR RECREATING AJP BAT MANUSCRIPT FIGURES
% % %   This .m file contains the script to recreate Figure 6 in the paper.
% % %   The script reads the necessary csv files from the ../tidy_data/ folder and
% % %   puts the png image in the  ../figures/ folder.
% % %   FIGURE 6 :  BAT v. WAT - Thermoneutral and Cold values
% % % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% clean slate
clear all; close all; clc;

code_path   = fileparts(mfilename('fullpath'));
data_path   = sprintf('%s/../data_output', code_path);
figure_path = sprintf('%s/../figures', code_path);

%% detect location of this m-file
[mfile_folder, mfile_name, mfile_ext] = fileparts( mfilename('fullpath') );

%% addpath to contrib utilities
addpath( sprintf('%s/contrib/applyhatch_pluscolor', mfile_folder) );

%% Import data:
run( sprintf('%s/Import_data_Fig6.m', mfile_folder) );

%% Create Matrix of all related variables for boxplots

HUs = [WAT_TN_CT_Mean; WAT_CA_CT_Mean; TN_CT_Mean; CA_CT_Mean];
FSF = [WAT_TN_FSF_Mean; WAT_CA_FSF_Mean; TN_FSF_Mean; CA_FSF_Mean];
R2s = [WAT_TN_R2s_Mean; WAT_CA_R2s_Mean; TN_R2s_Mean; CA_R2s_Mean];

%% Creat boxplot groups

sizeGrp  = size(TN_CT_Mean,1);
sizeWat_CA  = size(WAT_CA_CT_Mean,1);
sizeWat_TN  = size(WAT_TN_CT_Mean,1);

labelGrp_TN  = zeros(1,sizeGrp);        % group label = 0     - position = 0.9
labelGrp_CA  = ones(1,sizeGrp);         % group label = 1     - position = 1.9
labelWat_TN  = zeros(1,sizeWat_TN) + 5;
labelWat_CA  = ones(1,sizeWat_CA)  + 5;

grp = [labelWat_TN, labelWat_CA, labelGrp_TN, labelGrp_CA];
pos = [0.9 1.4 1 1.5];

%% CT HU BoxPlot

h1 = figure(1); set(h1,'Position',[20 125 560 750],'Color',[1 1 1]);
bh = boxplot(HUs,grp, 'positions',pos,'symbol','k+','outliersize',10);
set(bh,'LineWidth',4,'Color','k');
xtix = {'Warm','Cold'};
xtixloc = [0.95 1.45];

ylim([-117 -44]);
ytix = {'-110','-100','-90','-80','-70','-60','-50'};
ytixloc = [-110 -100 -90 -80 -70 -60 -50];

color = ['w','g','w','g'];
h = findobj(gca,'Tag','Box');
for jj = 1:length(h)
    patch(get(h(jj),'XData'),get(h(jj),'YData'),color(jj),'FaceAlpha',0.5);
end

set(gca,'XTickMode','auto','XTickLabel',xtix,'XTick',xtixloc,...
    'YTickLabel',ytix,'YTick',ytixloc,'TickLength',[0.02 0],'tickdir','out',...
    'FontName','Times New Roman','FontSize',30,'FontWeight','bold','linewidth',2);

title('CT [HU]','FontSize',30,'FontWeight','bold','FontName','Times New Roman');

box off

% Plot PET-Negative - CT data - BAT values
sizeNonCA = size(CA_NonA_HUs_Mean,1);
sizeNonTN = size(TN_NonA_HUs_Mean,1);

xlocCA = ones(sizeNonCA,1);
xlocCA = 1.45*xlocCA;
xlocTN = ones(sizeNonTN,1);
xlocTN = 0.95*xlocTN;

figure(1); hold on;
plot(xlocCA,CA_NonA_HUs_Mean,'ko','MarkerSize',14,'LineWidth',4)
figure(1); hold on;
plot(xlocTN,TN_NonA_HUs_Mean,'ko','MarkerSize',14,'LineWidth',4)


% Plot PET-Negative - CT data - WAT values
sizeNonCA_WAT = size(WAT_Non_A_CT_Mean_CA,1);
sizeNonTN_WAT = size(WAT_Non_A_CT_Mean_TN,1);

xlocCA_WAT = ones(sizeNonCA_WAT,1);
xlocCA_WAT = 1.55*xlocCA_WAT;
xlocTN_WAT = ones(sizeNonTN_WAT,1);
xlocTN_WAT = 1.05*xlocTN_WAT;

figure(1); hold on;
plot(xlocCA_WAT,WAT_Non_A_CT_Mean_CA,'kx','MarkerSize',14,'LineWidth',4)
figure(1); hold on;
plot(xlocTN_WAT,WAT_Non_A_CT_Mean_TN,'kx','MarkerSize',14,'LineWidth',4)

% Write out the figure
[im_hatch,colorlist] = applyhatch_pluscolor(gcf,'\',0,1,[],200,3,5);
pause(2);
imwrite(im_hatch,sprintf('%s/Figure_6_CT_HU.png',figure_path),'png')
pause(2);
clear im_hatch fr* im* hf*
close all

%% MRI FSF BoxPlot

h1 = figure(1); set(h1,'Position',[20 125 560 750],'Color',[1 1 1]);
bh = boxplot(FSF,grp, 'positions',pos,'symbol','k+','outliersize',10);
set(bh,'LineWidth',4,'Color','k');
xtix = {'Warm','Cold'};
xtixloc = [0.95 1.45];

ylim([45 101]);
ytix = {'50','60','70','80','90','100'};
ytixloc = [50 60 70 80 90 100];

color = ['w','g','w','g'];
h = findobj(gca,'Tag','Box');
for jj = 1:length(h)
    patch(get(h(jj),'XData'),get(h(jj),'YData'),color(jj),'FaceAlpha',0.5);
end

set(gca,'XTickMode','manual','XTickLabel',xtix,'XTick',xtixloc,...
    'YTickLabel',ytix,'YTick',ytixloc,'TickLength',[0.02 0],'tickdir','out',...
    'FontName','Times New Roman','FontSize',30,'FontWeight','bold','linewidth',2);

title('MRI FSF [%]','FontSize',30,'FontWeight','bold','FontName','Times New Roman');

box off

% Plot PET-Negative - MRI FSF data - BAT values
sizeNonCA_MRI = size(CA_NonA_FSF_Mean,1);
sizeNonTN_MRI = size(TN_NonA_FSF_Mean,1);

xlocCA_MRI = ones(sizeNonCA_MRI,1);
xlocCA_MRI = 1.45*xlocCA_MRI;
xlocTN_MRI = ones(sizeNonTN_MRI,1);
xlocTN_MRI = 0.95*xlocTN_MRI;

figure(1); hold on; 
plot(xlocCA_MRI,CA_NonA_FSF_Mean,'ko','MarkerSize',14,'LineWidth',4)
figure(1); hold on; 
plot(xlocTN_MRI,CA_NonA_FSF_Mean,'ko','MarkerSize',14,'LineWidth',4)

% Plot PET-Negative - MRI FSF data - WAT values
sizeNonCA_WAT_MRI = size(WAT_Non_A_FSF_Mean_CA,1);
sizeNonTN_WAT_MRI = size(WAT_Non_A_FSF_Mean_TN,1);

xlocCA_WAT_MRI = ones(sizeNonCA_WAT_MRI,1);
xlocCA_WAT_MRI = 1.55*xlocCA_WAT_MRI;
xlocTN_WAT_MRI = ones(sizeNonTN_WAT_MRI,1);
xlocTN_WAT_MRI = 1.05*xlocTN_WAT_MRI;

figure(1); hold on; 
plot(xlocCA_WAT_MRI,WAT_Non_A_FSF_Mean_CA,'kx','MarkerSize',14,'LineWidth',4)
figure(1); hold on; 
plot(xlocTN_WAT_MRI,WAT_Non_A_FSF_Mean_TN,'kx','MarkerSize',14,'LineWidth',4)

% Write out the figure
[im_hatch,colorlist] = applyhatch_pluscolor(gcf,'\',0,1,[],200,3,5);
pause(2);
imwrite(im_hatch,sprintf('%s/Figure_6_MRI_FSF.png',figure_path),'png')
pause(2);
clear im_hatch fr* im* hf*
close all

%% R2* BoxPlot

h1 = figure(1); set(h1,'Position',[20 125 560 750],'Color',[1 1 1]);
bh = boxplot(R2s,grp, 'positions',pos,'symbol','k+','outliersize',10);
set(bh,'LineWidth',4,'Color','k');
xtix = {'Warm','Cold'};
xtixloc = [.95 1.45];

ylim([36 184]);
ytix = {'40','60','80','100','120','140','160'};
ytixloc = [40 60 80 100 120 140 160];

color = ['w','g','w','g'];
h = findobj(gca,'Tag','Box');
for jj = 1:length(h)
    patch(get(h(jj),'XData'),get(h(jj),'YData'),color(jj),'FaceAlpha',0.5);
end

set(gca,'XTickMode','manual','XTickLabel',xtix,'XTick',xtixloc,...
    'YTickLabel',ytix,'YTick',ytixloc,'TickLength',[0.02 0],'tickdir','out',...
    'FontName','Times New Roman','FontSize',30,'FontWeight','bold','linewidth',2);

title('MRI R_{2}^{*} [s^{-1}]','FontSize',30,'FontWeight','bold','FontName','Times New Roman');

box off

% Plot PET-Negative - MRI R2s data - BAT values
sizeNonCA_MRI = size(CA_NonA_R2s_Mean,1);
sizeNonTN_MRI = size(TN_NonA_R2s_Mean,1);

xlocCA_MRI = ones(sizeNonCA_MRI,1);
xlocCA_MRI = 1.45*xlocCA_MRI;
xlocTN_MRI = ones(sizeNonTN_MRI,1);
xlocTN_MRI = 0.95*xlocTN_MRI;

figure(1); hold on; 
plot(xlocCA_MRI,CA_NonA_R2s_Mean,'ko','MarkerSize',14,'LineWidth',4)
figure(1); hold on; 
plot(xlocTN_MRI,CA_NonA_R2s_Mean,'ko','MarkerSize',14,'LineWidth',4)

% Plot PET-Negative - MRI R2s data - WAT values
sizeNonCA_WAT_MRI = size(WAT_Non_A_R2s_Mean_CA,1);
sizeNonTN_WAT_MRI = size(WAT_Non_A_R2s_Mean_TN,1);

xlocCA_WAT_MRI = ones(sizeNonCA_WAT,1);
xlocCA_WAT_MRI = 1.55*xlocCA_WAT_MRI;
xlocTN_WAT_MRI = ones(sizeNonTN_WAT,1);
xlocTN_WAT_MRI = 1.05*xlocTN_WAT_MRI;

figure(1); hold on; 
plot(xlocCA_WAT_MRI,WAT_Non_A_R2s_Mean_CA,'kx','MarkerSize',14,'LineWidth',4)
figure(1); hold on; 
plot(xlocTN_WAT_MRI,WAT_Non_A_R2s_Mean_TN,'kx','MarkerSize',14,'LineWidth',4)

% Write out the figure
[im_hatch,colorlist] = applyhatch_pluscolor(gcf,'\',0,1,[],200,3,5);
pause(2);
imwrite(im_hatch,sprintf('%s/Figure_6_MRI_R2s.png',figure_path),'png')
pause(2);
clear im_hatch fr* im* hf*
close all

%%
clear all; close all; clc;