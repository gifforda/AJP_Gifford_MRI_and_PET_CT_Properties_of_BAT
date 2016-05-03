%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %   
% % %   CODE FOR RECREATING AJP BAT MANUSCRIPT FIGURES
% % %   This .m file calls scripts to recreate Figures 4, 5 and 6 in the paper.
% % % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% detect location of this m-file
[mfile_folder, mfile_name, mfile_ext] = fileparts( mfilename('fullpath') );

%% run script to create Figure 4
run( sprintf('%s/BAT_Figure_4.m', mfile_folder) );

%% detect location of this m-file
[mfile_folder, mfile_name, mfile_ext] = fileparts( mfilename('fullpath') );

%% run script to create Figure 5
run( sprintf('%s/BAT_Figure_5.m', mfile_folder) );

%% detect location of this m-file
[mfile_folder, mfile_name, mfile_ext] = fileparts( mfilename('fullpath') );

%% run script to create Figure 6
run( sprintf('%s/BAT_Figure_6.m', mfile_folder) );