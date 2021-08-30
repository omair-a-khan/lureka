# =============================================================================
# this script will generate the full NP data set by downloading the components
# from REDCap. It is intended to be run regularly as a cron job. This script
# can also be invoked on demand to update the data.

source("R/variables_and_labels.R")
source("R/pivot_functions.R")

lookup_tables.sources <- list.files(path = "data-raw", pattern = "*.R", full.names = TRUE)
purrr::walk(lookup_tables.sources, source)

source("R/redcap_tokens.R")
source("R/pull_from_redcap.R")
source("R/compute_scores.R")
source("R/generate_data.R")

data.df <- generate_data_from_redcap(epoch = 1:5)
saveRDS(data.df, file = file.path("data/complete_np_data.rds"))
