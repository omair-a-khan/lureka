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

source("common/R/plotly_functions.R")
source("common/R/variables_and_labels.R")
source("enrollment/R/generate_tables.R")

# =========================================================================
# load data

if ("complete_enrollment_data.rds" %in% list.files("data")) {
  complete_enrollment_data.df <- readRDS("enrollment/data/complete_enrollment_data.rds")
} else {
  source("enrollment/R/cron_script_enrollment.R")
  complete_enrollment_data.df <- readRDS("enrollment/data/complete_enrollment_data.rds)
}

