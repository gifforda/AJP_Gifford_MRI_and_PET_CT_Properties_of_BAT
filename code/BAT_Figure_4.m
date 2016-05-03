%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %   
% % %   CODE FOR RECREATING AJP BAT MANUSCRIPT FIGURES
% % %   This .m file contains the script to recreate Figure 4 in the paper.
% % %   The script loads the necessary data files from the 
% % %   ../data_download/ folder and puts the png image in 
% % %   the  ../figures/ folder.
% % %   FIGURE 4: BAT - 
% % %             Axial comparison of normal weight and overweight subjects
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

%% Load Processed Data

data_output_MRI     = load(sprintf('%s/PET_positive_MRI_output.mat',data_path));

S05_FSF = data_output_MRI.S05_warmMRI_FSF_Registered;
S05_R2s = data_output_MRI.S05_warmMRI_R2s_Registered;

S10_FSF = data_output_MRI.S10_coldMRI_FSF_Registered;
S10_R2s = data_output_MRI.S10_coldMRI_R2s_Registered;

clear data_output_MRI

data_output_PET_CT  = load(sprintf('%s/PET_positive_PET_CT_output.mat',data_path));

S05_CT     = data_output_PET_CT.S05_coldCT_HU_Registered;
S05_PET    = data_output_PET_CT.S05_coldPET_SUV_Registered;
S10_CT     = data_output_PET_CT.S10_coldCT_HU_Registered;
S10_PET    = data_output_PET_CT.S10_coldPET_SUV_Registered;

clear data_output_PET_CT

%% Select the slice of interest for the figure

S05_slx = 2;
S10_slx = 9;

S05_FSF_slx = S05_FSF(:,:,S05_slx);
S05_R2s_slx = S05_R2s(:,:,S05_slx);
S10_FSF_slx = S10_FSF(:,:,S10_slx);
S10_R2s_slx = S10_R2s(:,:,S10_slx);

S05_FSF_slx = S05_FSF_slx./10;
S10_FSF_slx = S10_FSF_slx./10;

S05_CT_slx  = S05_CT(:,:,S05_slx+2);
S05_PET_slx = S05_PET(:,:,S05_slx+2);
S10_CT_slx  = S10_CT(:,:,S10_slx);
S10_PET_slx = S10_PET(:,:,S10_slx);

clear *_FSF *_R2s *_CT *_PET

%% Mask the CT image

msk_CT_S05 = ones(size(S05_PET_slx));
msk_CT_S05(S05_PET_slx < 0.25*graythresh(S05_PET_slx)) = 0;

S05_CT_slx = S05_CT_slx.*msk_CT_S05;
S05_CT_slx(msk_CT_S05 == 0) = -1000;

msk_CT_S10 = ones(size(S10_PET_slx));
msk_CT_S10(S10_PET_slx < 0.25*graythresh(S10_PET_slx)) = 0;

S10_CT_slx = S10_CT_slx.*msk_CT_S10;
S10_CT_slx(msk_CT_S10 == 0) = -1000;

clear msk_*

%% Create the images

fig_size_inches = 3;
fig_dpi = 300;
fig_pixels = fig_size_inches * fig_dpi;
FontSize = 32;
FontWeight = 'bold';
LineWidth = 2;

%% Subject 05 Images

rows_S05 = 225:370;
cols_S05 = 100:425;

hf = figure(1);
set(hf,'Color',[1 1 1],'Position',[100 100 fig_pixels*2.3 fig_pixels]);
imagesc(S05_CT_slx(rows_S05,cols_S05)); axis image; colormap(gray); caxis([-250 250]); axis off
hc = colorbar('southoutside');
set(hc,'box','off','LineWidth',LineWidth,'FontSize',FontSize);
ht = title('CT [HU]');
set(ht,'Color',[0 0 0],'FontSize',FontSize,'FontWeight',FontWeight);

hf = figure(2);
set(hf,'Color',[1 1 1],'Position',[100 100 fig_pixels*2.3 fig_pixels]);
imagesc(S05_PET_slx(rows_S05,cols_S05)); axis image; colormap(hot); caxis([0 5]); axis off
hc = colorbar('southoutside');
set(hc,'box','off','LineWidth',LineWidth,'FontSize',FontSize);
ht = title('PET [SUV]');
set(ht,'Color',[0 0 0],'FontSize',FontSize,'FontWeight',FontWeight);

hf = figure(3);
set(hf,'Color',[1 1 1],'Position',[100 100 fig_pixels*2.3 fig_pixels]);
imagesc(S05_FSF_slx(rows_S05,cols_S05)); axis image; colormap(IDLrainbow2); caxis([0 100]); axis off
hc = colorbar('southoutside');
set(hc,'box','off','LineWidth',LineWidth,'FontSize',FontSize);
ht = title('MRI FSF [%]');
set(ht,'Color',[0 0 0],'FontSize',FontSize,'FontWeight',FontWeight);

hf = figure(4);
set(hf,'Color',[1 1 1],'Position',[100 100 fig_pixels*2.3 fig_pixels]);
imagesc(S05_R2s_slx(rows_S05,cols_S05)); axis image; colormap(gray); caxis([0 300]); axis off
hc = colorbar('southoutside');
set(hc,'box','off','LineWidth',LineWidth,'FontSize',FontSize);
ht = title('MRI R_{2}^{*} [S^{-1}]');
set(ht,'Color',[0 0 0],'FontSize',FontSize,'FontWeight',FontWeight);

%% Subject 10 Images

rows_S10 = 190:325;
cols_S10 = 100:410;

hf = figure(5);
set(hf,'Color',[1 1 1],'Position',[100 100 fig_pixels*2.3 fig_pixels]);
imagesc(S10_CT_slx(rows_S10,cols_S10)); axis image; colormap(gray); caxis([-250 250]); axis off
hc = colorbar('southoutside');
set(hc,'box','off','LineWidth',LineWidth,'FontSize',FontSize);
ht = title('CT [HU]');
set(ht,'Color',[0 0 0],'FontSize',FontSize,'FontWeight',FontWeight);

hf = figure(6);
set(hf,'Color',[1 1 1],'Position',[100 100 fig_pixels*2.3 fig_pixels]);
imagesc(S10_PET_slx(rows_S10,cols_S10)); axis image; colormap(hot); caxis([0 5]); axis off
hc = colorbar('southoutside');
set(hc,'box','off','LineWidth',LineWidth,'FontSize',FontSize);
ht = title('PET [SUV]');
set(ht,'Color',[0 0 0],'FontSize',FontSize,'FontWeight',FontWeight);

hf = figure(7);
set(hf,'Color',[1 1 1],'Position',[100 100 fig_pixels*2.3 fig_pixels]);
imagesc(S10_FSF_slx(rows_S10,cols_S10)); axis image; colormap(IDLrainbow2); caxis([0 100]); axis off
hc = colorbar('southoutside');
set(hc,'box','off','LineWidth',LineWidth,'FontSize',FontSize);
ht = title('MRI FSF [%]');
set(ht,'Color',[0 0 0],'FontSize',FontSize,'FontWeight',FontWeight);

hf = figure(8);
set(hf,'Color',[1 1 1],'Position',[100 100 fig_pixels*2.3 fig_pixels]);
imagesc(S10_R2s_slx(rows_S10,cols_S10)); axis image; colormap(gray); caxis([0 300]); axis off
hc = colorbar('southoutside');
set(hc,'box','off','LineWidth',LineWidth,'FontSize',FontSize);
ht = title('MRI R_{2}^{*} [S^{-1}]');
set(ht,'Color',[0 0 0],'FontSize',FontSize,'FontWeight',FontWeight);

%% Make a montage image

fr1 = getframe(figure(1));
im1 = frame2im(fr1);

fr2 = getframe(figure(2));
im2 = frame2im(fr2);

fr3 = getframe(figure(3));
im3 = frame2im(fr3);

fr4 = getframe(figure(4));
im4 = frame2im(fr4);

fr5 = getframe(figure(5));
im5 = frame2im(fr5);

fr6 = getframe(figure(6));
im6 = frame2im(fr6);

fr7 = getframe(figure(7));
im7 = frame2im(fr7);

fr8 = getframe(figure(8));
im8 = frame2im(fr8);

imwrite([im1 im2 im3 im4; im5 im6 im7 im8],sprintf('%s/Figure_4_Axial_Images.png',figure_path));

%%

close all
