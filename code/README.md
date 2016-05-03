code
====

This folder contains all necessary RStudio and MATLAB code to reproduce results. Additionally, there are scripts to download input and output data.

see also:
---------

### Figure creation scripts (results written to `../figures/`)
~~~~
List of figures
~~~~

### Index of data files to download ( **DO NOT EDIT** )
~~~~
./code/download_data_index.csv
~~~~

### Python data files download and verification script
~~~~
./code/download_data_all.py
~~~~

### Index of contributed code to download ( **DO NOT EDIT** )
~~~~
./code/download_contrib_index.csv
~~~~

### Python download and verification script
~~~~
./code/download_contrib_all.py
~~~~


### Steps to run scripts

cd("./code")

~~~~
Prior to running the MATLAB Scripts, it is necessary to run `./code/download_contrib.py`
~~~~

* RStudio (opened in repository top-level folder)
	+ Open `./code/RStudio_Figures_Create_All.R` and click source
	+ Optionally open and source individual `.R` scripts for figure panel(s) after changing working directory to `code` folder, e.g.,
		+ path_to_repository <- "/edit/this/path/to/match/your/path"
		+ setwd(paste0(path_to_repository,"/code",collapse=""))

* MATLAB (opened in repository top-level folder)
	+ To generate all figures at once, open and run: `./code/MATLAB_Figures_Create_All.m`
	+ Alternatively, open and run each figure script separately:
		+ BAT_Figure_4.m
		+ BAT_Figure_5.m
		+ BAT_Figure_6.m
