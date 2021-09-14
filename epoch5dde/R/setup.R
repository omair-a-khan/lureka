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
source("epoch5dde/R/generate_tables.R")

# =========================================================================
# load data

if ("complete_epoch5dde_data.rds" %in% list.files("epoch5dde/data")) {
  complete_epoch5dde_data.df <- readRDS("epoch5dde/data/complete_epoch5dde_data.rds")
} else {
  source("epoch5dde/R/cron_script.R")
  complete_epoch5dde_data.df <- readRDS("epoch5dde/data/complete_epoch5dde_data.rds)
}

