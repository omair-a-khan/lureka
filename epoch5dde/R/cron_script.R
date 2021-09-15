# =============================================================================
# this script will generate the full epoch5dde data set by downloading the components
# from REDCap. It is intended to be run regularly as a cron job. This script
# can also be invoked on demand to update the data.

library(knitr)
library(tidyverse)
library(readxl)
library(kableExtra)
library(REDCapR)
library(Hmisc)

source("common/variables_and_labels.R")
source("common/pivot_functions.R")
source("common/redcap_tokens.R")
source("common/pull_from_redcap.R")
source("epoch5dde/R/compute_scores.R")
source("epoch5dde/R/generate_data.R")
source("epoch5dde/R/lookup.R")

data.df <- generate_data_from_redcap_epoch5dde()
saveRDS(data.df, file = file.path("epoch5dde/data/complete_epoch5dde_data.rds"))
