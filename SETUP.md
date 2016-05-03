AJP Gifford BAT MRI, PET & CT
=============================

Requirements:
-------------
* R or RStudio - for figure creation and statistical analysis
	+ Required packages `ggplot2` and `plyr`, to install packages from the `R` prompt type

~~~~
install.packages("ggplot2")
install.packages("plyr")
~~~~

* MATLAB  - for figure creation
* Python - for file download and MD5 checksum verification of data files and publicly available contributed code

Tested Configuration:
---------------------
* Mac OS X 10.7.5 (Lion)
* R 3.1.0
* RStudio 0.98.1091
* MATLAB R2014a
* Python 2.7.10

Installation Options:
---------------------
* Click the `Download ZIP` button on the lower right hand side of the repository to download the code to your local machine
* OR clone the git repository to your local machine
* OR fork to your own GitHub repository and then clone the git repository to your local machine

Usage:
------
* See [./code/README.md](./code/README.md)

Example Files:
--------

* Input Data :  `PET_positive_MRI_input.mat` : Input original complex MRI data.

* Registered MRI Images : `PET_positive_MRI_output.ma` : Final processed and registered MRI data - Thermoneutral and Cold - for each PET positive subject.
* Registered PET and CT Images : `PET_positive_PET_CT_output.mat` : Final processed and registered PET and CT images - Thermoneutral and Cold - for each PET positive subject.
* Resulting BAT masks : `PET_positive_BAT_masks.mat` : Final registered BAT masks as binary images for each PET positive subject.

* Figure File : `Figure_7_Volume_v_BMI.png` : Figure_7_Volume_v_BMI.png is reproduced from the above (and other) reconstructed images.

Notes:
------
* To obtain publicly available code utilized by this repository, the `download_contrib_all.py` script available in `./code/` should be executed to download and verify MD5 hash values for all contributed code files.
* To obtain data files stored in the `./data_input/` and `./data_output/` folders, the `download_data_all.py` script available in `./code/` should be executed to download and verify  MD5 hash values for all data files.
* Files in `./data_input/`, `./data_output/`, and `./figures/` (other than `README.md`) are ignored when performing `git commit`.
