# =========================================================================
# load libraries

library(shiny)
library(shinydashboard)
library(knitr)
library(tidyverse)
library(plotly)
library(kableExtra)
library(RColorBrewer)
library(REDCapR)
library(readxl)

# =========================================================================
# source scripts

source("R/variables_and_labels.R")
source("R/generate_tables.R")
source("R/generate_tables_eligibility.R")
source("R/plotly_functions.R")

# =========================================================================
# load data

if ("complete_np_data.rds" %in% list.files("data")) {
  complete_np_data.df <- readRDS("data/complete_np_data.rds")
} else {
  source("R/cron_script.R")
  complete_np_data.df <- readRDS("data/complete_np_data.rds")
}

# if ("complete_eligibility_data.rds" %in% list.files("data")) {
#   complete_eligibility_data.df <- readRDS("data/complete_eligibility_data.rds")
# } else {
#   source("R/cron_script_eligibility.R")
#   complete_eligibility_data.df <- readRDS("data/complete_eligibility_data.rds")
# }

