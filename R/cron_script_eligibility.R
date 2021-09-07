# =============================================================================
# this script will generate the full elig data set by downloading the components
# from REDCap. It is intended to be run regularly as a cron job. This script
# can also be invoked on demand to update the data.

source("R/variables_and_labels.R")
source("R/pivot_functions.R")
source("R/redcap_tokens.R")
source("R/pull_from_redcap.R")
source("R/compute_scores_eligibility.R")
source("R/generate_data.R")
source("data-raw/eligibility_lookup.R")

data.df <- generate_data_from_redcap_eligibility()
saveRDS(data.df, file = file.path("data/complete_eligibility_data.rds"))
