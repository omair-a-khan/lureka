# =============================================================================
# this script will generate the full NP data set by downloading the components
# from REDCap. It is intended to be run regularly as a cron job. This script
# can also be invoked on demand to update the data.

source("setup.R")
data.df <- generate_data_from_redcap(epoch = 1:5)
saveRDS(data.df, file = file.path("data/complete_np_data.rds"))
