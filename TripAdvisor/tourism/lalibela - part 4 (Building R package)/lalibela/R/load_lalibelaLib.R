load_lalibelaLib <- function() {
  ## -------------------------------------------------------- ##
  ## <!-- Configure dependent packages.                 -->   ##
  ## -------------------------------------------------------- ##
  ## xml2
  if (!requireNamespace("xml2", quietly = TRUE)) {
    stop("Please install xml2: install.packages('xml2'); library(xml2)")
  }
  
  ## rvest
  if (!requireNamespace("rvest", quietly = TRUE)) {
    stop("Please install rvest: install.packages('rvest'); library(rvest)")
  }
  
  ## stringr
  if (!requireNamespace("stringr", quietly = TRUE)) {
    stop("Please install stringr: install.packages('stringr'); library(stringr)")
  }
  
  ## readr
  if (!requireNamespace("readr", quietly = TRUE)) {
    stop("Please install readr: install.packages('readr'); library(readr)")
  }
  
  ## dplyr
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop("Please install dplyr: install.packages('dplyr'); library(dplyr)")
  }
  
  ## magrittr
  if (!requireNamespace("magrittr", quietly = TRUE)) {
    stop("Please install magrittr: install.packages('magrittr'); library(magrittr)")
  }
  
  ## tidyverse
  if (!requireNamespace("tidyverse", quietly = TRUE)) {
    stop("Please install tidyverse: install.packages('tidyverse'); library(tidyverse)")
  }
  
  ## -- load all required libraries, after all pkgs are installed
  if (!requireNamespace("pacman", quietly = TRUE)) {
    stop("Please install pacman: install.packages('pacman'); library(pacman)")
  }
  
  pacman::p_load(xml2, rvest, stringr, readr, dplyr, magrittr, tidyverse)
}