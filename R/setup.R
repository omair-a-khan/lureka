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

lookup_tables.sources <- list.files(path = "data-raw", pattern = "*.R", full.names = TRUE)
purrr::walk(lookup_tables.sources, source)

source("R/variables_and_labels.R")
source("R/redcap_tokens.R")
source("R/pull_from_redcap.R")
source("R/compute_scores.R")
source("R/generate_data.R")
source("R/generate_tables.R")
source("R/plotly_functions.R")

# =========================================================================
# load data

if ("complete_np_data.rds" %in% list.files("data")) {
  complete_np_data.df <- readRDS("data/complete_np_data.rds")
} else {
  source("R/cron_script.R")
  complete_np_data.df <- readRDS("data/complete_np_data.rds")
}

