#!/usr/bin/env Rscript

### CODE FOR RECREATING AJP BAT PAPER FIGURE STATISTICS IN RStudio ################################

# enable plots when executing from command line
X11()

# @return full path to this script
get_script_path <- function() {
  cmdArgs = commandArgs(trailingOnly = FALSE)
  needle = "--file="
  match = grep(needle, cmdArgs)
  if (length(match) > 0) {
    # Rscript
    return(normalizePath(sub(needle, "", cmdArgs[match])))
  } else {
    ls_vars = ls(sys.frames()[[1]])
    if ("fileName" %in% ls_vars) {
      # Source'd via RStudio
      return(normalizePath(sys.frames()[[1]]$fileName)) 
    } else {
      # Source'd via R console
      return(normalizePath(sys.frames()[[1]]$ofile))
    }
  }
}

repo_code_folder <- dirname( get_script_path() )

# Figure 5 and 6 Statistics
source(paste0(repo_code_folder,'/BAT_Figure_5_and_6_Statistics.R',collapse=""), chdir = TRUE)

# Figure 7 Statistics
source(paste0(repo_code_folder,'/BAT_Figure_7.R',collapse=""), chdir = TRUE)

# Table 1 Statistics
source(paste0(repo_code_folder,'/BAT_Table_1_Statistics.R',collapse=""), chdir = TRUE)

