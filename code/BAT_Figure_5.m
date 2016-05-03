%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %   
% % %   CODE FOR RECREATING AJP BAT MANUSCRIPT FIGURES
% % %   This .m file contains the script to recreate Figure 5 in the paper.
% % %   The script reads the necessary csv files from the ../tidy_data/ folder and
% % %   puts the png image in the  ../figures/ folder.
% % %   FIGURE 5 :  BAT - Thermoneutral vs. Cold values
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

%% Import data
run( sprintf('%s/Import_data_Fig5.m', mfile_folder) );

%% Create Matrix of all related variables for boxplots

HUs = [TN_CT_Mean; CA_CT_Mean; TN_CT_Mean_lowB; CA_CT_Mean_lowB; TN_CT_Mean_highB; CA_CT_Mean_highB];
SUV = [TN_PET_Mean; CA_PET_Mean; TN_PET_Mean_lowB; CA_PET_Mean_lowB; TN_PET_Mean_highB; CA_PET_Mean_highB];
FSF = [TN_FSF_Mean; CA_FSF_Mean; TN_FSF_Mean_lowB; CA_FSF_Mean_lowB; TN_FSF_Mean_highB; CA_FSF_Mean_highB];
R2s = [TN_R2s_Mean; CA_R2s_Mean; TN_R2s_Mean_lowB; CA_R2s_Mean_lowB; TN_R2s_Mean_highB; CA_R2s_Mean_highB];

%% Creat boxplot groups

sizeGrp  = size(TN_CT_Mean,1);
sizeLow  = size(TN_CT_Mean_lowB,1);
sizeHigh = size(TN_CT_Mean_highB,1);

labelGrp_TN  = zeros(1,sizeGrp);        % group label = 0     - position = 0.9
labelGrp_CA  = ones(1,sizeGrp);         % group label = 1     - position = 1.9
labelLow_TN  = zeros(1,sizeLow) + 5;    % group label = 5     - position = 1
labelLow_CA  = ones(1,sizeLow) + 5;     % group label = 6     - position = 2
labelHigh_TN = zeros(1,sizeHigh) + 10;  % group label = 10    - position = 1.1
labelHigh_CA = ones(1,sizeHigh) + 10;   % group label = 11    - position = 2.1

grp = [labelGrp_TN, labelGrp_CA, labelLow_TN, labelLow_CA, labelHigh_TN, labelHigh_CA];
pos = [0.9 1.4 1 1.5 1.1 1.6];

%% CT HU BoxPlot

h1 = figure(1); set(h1,'Position',[20 125 560 750],'Color',[1 1 1]);
bh = boxplot(HUs,grp, 'positions',pos,'symbol','k+','outliersize',10);
set(bh,'LineWidth',4,'Color','k');
xtix = {'Thermoneutral','Cold'};
xtixloc = [1 1.5];

ylim([-94 -46]);
ytix = {'-90 ','-80 ','-70 ','-60 ','-50 '};
ytixloc = [-90 -80 -70 -60 -50];

color = ['w','r','g','w','r','g'];
h = findobj(gca,'Tag','Box');
for jj = 1:length(h)
    patch(get(h(jj),'XData'),get(h(jj),'YData'),color(jj),'FaceAlpha',0.5);
end

set(gca,'XTickMode','auto','XTickLabel',xtix,'XTick',xtixloc,...
    'YTickLabel',ytix,'YTick',ytixloc,'TickLength',[0.02 0],'tickdir','out',...
    'FontName','Times New Roman','FontSize',30,'FontWeight','bold','linewidth',2);

title('CT [HU]','FontSize',30,'FontWeight','bold','FontName','Times New Roman');

box off

% Write out the figure
[im_hatch,colorlist] = applyhatch_pluscolor(gcf,'\x',0,1,[],200,3,5);
imwrite(im_hatch,sprintf('%s/Figure_5_CT.png',figure_path),'png')

pause(2)
clear im_hatch fr* im* hf*
close all

%% PET SUV BoxPlot

h1 = figure(1); set(h1,'Position',[20 125 560 750],'Color',[1 1 1]);
bh = boxplot(SUV,grp, 'positions',pos,'symbol','k+','outliersize',10);
set(bh,'LineWidth',4,'Color','k');
xtix = {'Thermoneutral','Cold'};
xtixloc = [1 1.5];

ylim([-0.2 11]);
ytix = {'0 ','2 ','4 ','6 ','8 ','10 '};
ytixloc = [0 2 4 6 8 10];

color = ['w','r','g','w','r','g'];
h = findobj(gca,'Tag','Box');
for jj = 1:length(h)
    patch(get(h(jj),'XData'),get(h(jj),'YData'),color(jj),'FaceAlpha',0.5);
end

set(gca,'XTickMode','manual','XTickLabel',xtix,'XTick',xtixloc,...
    'YTickLabel',ytix,'YTick',ytixloc,'TickLength',[0.02 0],'tickdir','out',...
    'FontName','Times New Roman','FontSize',30,'FontWeight','bold','linewidth',2);

title('PET [SUV]','FontSize',30,'FontWeight','bold','FontName','Times New Roman');

box off

% Write out the figure
[im_hatch,colorlist] = applyhatch_pluscolor(gcf,'\x',0,1,[],200,3,5);
imwrite(im_hatch,sprintf('%s/Figure_5_PET.png',figure_path),'png')

pause(2)
clear im_hatch fr* im* hf*
close all

%% MRI FSF BoxPlot

h1 = figure(1); set(h1,'Position',[20 125 560 750],'Color',[1 1 1]);
bh = boxplot(FSF,grp, 'positions',pos,'symbol','k+','outliersize',10);
set(bh,'LineWidth',4,'Color','k');
xtix = {'Thermoneutral','Cold'};
xtixloc = [1 1.5];

ylim([46 84]);
ytix = {'50 ','60 ','70 ','80 '};
ytixloc = [50 60 70 80];

color = ['w','r','g','w','r','g'];
h = findobj(gca,'Tag','Box');
for jj = 1:length(h)
    patch(get(h(jj),'XData'),get(h(jj),'YData'),color(jj),'FaceAlpha',0.5);
end

set(gca,'XTickMode','manual','XTickLabel',xtix,'XTick',xtixloc,...
    'YTickLabel',ytix,'YTick',ytixloc,'TickLength',[0.02 0],'tickdir','out',...
    'FontName','Times New Roman','FontSize',30,'FontWeight','bold','linewidth',2);

title('MRI FSF [%]','FontSize',30,'FontWeight','bold','FontName','Times New Roman');

box off

% Write out figure
[im_hatch,colorlist] = applyhatch_pluscolor(gcf,'\x',0,1,[],200,3,5);
pause(2)
imwrite(im_hatch,sprintf('%s/Figure_5_MRI_FSF.png',figure_path),'png')
pause(2)
clear im_hatch fr* im* hf*
close all

%% MRI R2* BoxPlot

h1 = figure(1); set(h1,'Position',[20 125 560 750],'Color',[1 1 1]);
bh = boxplot(R2s,grp, 'positions',pos,'symbol','k+','outliersize',10);
set(bh,'LineWidth',4,'Color','k');
xtix = {'Thermoneutral','Cold'};
xtixloc = [1 1.5];

ylim([66 184]);
ytix = {'80 ','100 ','120 ','140 ','160 '};
ytixloc = [80 100 120 140 160];

color = ['w','r','g','w','r','g'];
h = findobj(gca,'Tag','Box');
for jj = 1:length(h)
    patch(get(h(jj),'XData'),get(h(jj),'YData'),color(jj),'FaceAlpha',0.5);
end

set(gca,'XTickMode','manual','XTickLabel',xtix,'XTick',xtixloc,...
    'YTickLabel',ytix,'YTick',ytixloc,'TickLength',[0.02 0],'tickdir','out',...
    'FontName','Times New Roman','FontSize',30,'FontWeight','bold','linewidth',2);

title('MRI R_{2}^{*} [s^{-1}]','FontSize',30,'FontWeight','bold','FontName','Times New Roman');

box off

% Write out figure
[im_hatch,colorlist] = applyhatch_pluscolor(gcf,'\x',0,1,[],200,3,5);
pause(2)
imwrite(im_hatch,sprintf('%s/Figure_5_MRI_R2s.png',figure_path),'png')
pause(2)
clear im_hatch fr* im* hf*
close all

%% clean slate
clear all; close all; clc;
