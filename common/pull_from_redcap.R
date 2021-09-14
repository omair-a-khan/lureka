# main data

download_redcap_data <- function(token, var = np.var, api_uri = "https://redcap.vanderbilt.edu/api/") {
  data_part1.df <- REDCapR::redcap_read_oneshot(
    redcap_uri = api_uri,
    token = token,
    fields = var[!var %in% np_label.var],
    raw_or_label = "raw",
    verbose = FALSE
  )$data
  
  data_part2.df <- REDCapR::redcap_read_oneshot(
    redcap_uri = api_uri,
    token = token,
    fields = c("map_id", np_label.var),
    raw_or_label = "label",
    verbose = FALSE
  )$data
  
  data.df <- left_join(data_part1.df, data_part2.df, by = "map_id")
  
  return(data.df)
}

pull_from_redcap <- function(var = np.var, epoch) {
  if (epoch == 1) {
    main.df <- download_redcap_data(token = redcap_tokens.df[redcap_tokens.df$epoch == 1 & redcap_tokens.df$name == "main", "token"])
    addendum.df <- download_redcap_data(token = redcap_tokens.df[redcap_tokens.df$epoch == 1 & redcap_tokens.df$name == "addendum", "token"])
    
    main.df <- main.df[, np_main.var]
    addendum.df <- addendum.df[, np_addendum.var]
    
    output.df <- left_join(main.df, addendum.df, by = "map_id")
  } else if (epoch == 2) {
    output.df <- download_redcap_data(token = redcap_tokens.df[redcap_tokens.df$epoch == 2, "token"])
    output.df <- output.df[, var]
  } else if (epoch == 3) {
    output.df <- download_redcap_data(token = redcap_tokens.df[redcap_tokens.df$epoch == 3, "token"])
    output.df <- output.df[, var]
  } else if (epoch == 4) {
    output.df <- download_redcap_data(token = redcap_tokens.df[redcap_tokens.df$epoch == 4, "token"])
    output.df <- output.df[, var]
  } else if (epoch == 5) {
    output.df <- download_redcap_data(token = redcap_tokens.df[redcap_tokens.df$epoch == 5, "token"])
    output.df <- output.df[, var]
  } else {
    stop("Epoch must be 1, 2, 3, 4, or 5.\n\n")
  }

  output.df$np_mc_kaplan_sscore <- as.character(output.df$np_mc_kaplan_sscore)
  output.df$epoch <- epoch
  
  return(output.df)
}

# eligibility

download_redcap_data_eligibility <- function(token, var = np_eligibility.var, api_uri = "https://redcap.vanderbilt.edu/api/") {
  data_part1.df <- REDCapR::redcap_read_oneshot(
    redcap_uri = api_uri,
    token = token,
    fields = var[!var %in% np_label.var],
    raw_or_label = "raw",
    verbose = FALSE
  )$data
  
  data_part2.df <- REDCapR::redcap_read_oneshot(
    redcap_uri = api_uri,
    token = token,
    fields = c("vmac_id", np_label.var),
    raw_or_label = "label",
    verbose = FALSE
  )$data
  
  data.df <- left_join(data_part1.df, data_part2.df, by = "vmac_id")
  
  return(data.df)
}

pull_from_redcap_eligibility <- function(var = np_eligibility.var) {
  output.df <- download_redcap_data_eligibility(token = redcap_tokens_eligibility.df[redcap_tokens_eligibility.df$epoch == "elig", "token"], var = var)
  
  return(output.df)
}

# enrollment

#download_redcap_data_enrollment <- function(token, var = np.var, api_uri = "https://redcap.vanderbilt.edu/api/") {
download_redcap_data_epoch5dde <- function(api_uri = "https://redcap.vanderbilt.edu/api/") {
  data_part1a.df <- REDCapR::redcap_read_oneshot(
    redcap_uri = api_uri,
    token = redcap_tokens_epoch5dde.df[redcap_tokens_epoch5dde.df$name == "epoch5dde_1", token],
    fields = c('map_id', np_epoch5dde_1.var[np_epoch5dde_1.var %in% np_label.var]),
    raw_or_label = "label",
    verbose = FALSE
  )$data
  
  data_part1b.df <- REDCapR::redcap_read_oneshot(
    redcap_uri = api_uri,
    token = redcap_tokens_epoch5dde.df[redcap_tokens_epoch5dde.df$name == "epoch5dde_1", token],
    fields = np_epoch5dde_1.var[!np_epoch5dde_1.var %in% np_label.var],
    raw_or_label = "raw",
    verbose = FALSE
  )$data
  
  data_part2.df <- REDCapR::redcap_read_oneshot(
    redcap_uri = api_uri,
    token = redcap_tokens_epoch5dde.df[redcap_tokens_epoch5dde.df$name == "epoch5dde_2", token],
    fields = np_epoch5dde_2.var,
    raw_or_label = "raw",
    verbose = FALSE
  )$data
  
  data_part2.df <- data_part2.df[data_part2.df$redcap_event_name == "7year_followup_arm_1", ]

  data_part1.df <- left_join(data_part1a.df, data_part1b.df, by = "map_id")
  data.df <- left_join(data_part1.df, data_part2.df, by = "map_id")
  
  return(data.df)
}

pull_from_redcap_epoch5dde <- function() {
  output.df <- download_redcap_data_epoch5dde()
  
  return(output.df)
}
