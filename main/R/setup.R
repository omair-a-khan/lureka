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

source("common/plotly_functions.R")
source("common/variables_and_labels.R")
source("main/R/generate_tables.R")

# =========================================================================
# load data

if ("complete_np_data.rds" %in% list.files("main/data")) {
  complete_np_data.df <- readRDS("main/data/complete_np_data.rds")
} else {
  source("main/R/cron_script.R")
  complete_np_data.df <- readRDS("main/data/complete_np_data.rds")
}
