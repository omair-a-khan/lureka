# =============================================================================
# this script will generate the full NP data set by downloading the components
# from REDCap. It is intended to be run regularly as a cron job. This script
# can also be invoked on demand to update the data.

source("common/R/variables_and_labels.R")
source("common/R/pivot_functions.R")

lookup_tables.sources <- list.files(path = "main/data-raw", pattern = "*.R", full.names = TRUE)
purrr::walk(lookup_tables.sources, source)

source("common/R/redcap_tokens.R")
source("common/R/pull_from_redcap.R")
source("main/R/compute_scores.R")
source("main/R/generate_data.R")

data.df <- generate_data_from_redcap(epoch = 1:5)
saveRDS(data.df, file = file.path("main/data/complete_np_data.rds"))
