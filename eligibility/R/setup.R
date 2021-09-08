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
source("eligibility/R/generate_tables.R")

# =========================================================================
# load data

if ("complete_eligibility_data.rds" %in% list.files("eligibility/data")) {
  complete_eligibility_data.df <- readRDS("eligibility/data/complete_eligibility_data.rds")
} else {
  source("eligibility/R/cron_script.R")
  complete_eligibility_data.df <- readRDS("eligibility/data/complete_eligibility_data.rds")
}
