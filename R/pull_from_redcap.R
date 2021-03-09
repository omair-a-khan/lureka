download_redcap_data <- function(token, api_uri = "https://redcap.vanderbilt.edu/api/") {
  data_part1.df <- REDCapR::redcap_read_oneshot(
    redcap_uri = api_uri,
    token = token,
    fields = np.var[!np.var %in% np_label.var],
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
  
  output.df$np_mc_kaplan_ss <- as.character(output.df$np_mc_kaplan_ss)
  output.df$epoch <- epoch
  
  return(output.df)
}
