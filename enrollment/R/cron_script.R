# =============================================================================
# this script will generate the full enrollment data set by downloading the components
# from REDCap. It is intended to be run regularly as a cron job. This script
# can also be invoked on demand to update the data.

source("common/variables_and_labels.R")
source("common/pivot_functions.R")
source("common/redcap_tokens.R")
source("common/pull_from_redcap.R")
source("enrollment/R/compute_scores.R")
source("enrollment/R/generate_data.R")
source("enrollment/R/lookup.R")

data.df <- generate_data_from_redcap_enrollment()
saveRDS(data.df, file = file.path("eligibility/data/complete_enrollment_data.rds"))
