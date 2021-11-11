generate_data_from_redcap <- function() {
  output.df <- pull_from_redcap_eligibility(var = np_eligibility.var)
  output.df <- output.df[!is.na(output.df$age), ]
  output.df <- output.df[!(output.df$age %in% c(0, -9999, -8888, -7777, -6666)), ]
  output.df <- output.df[grep("--1", output.df$vmac_id), ]
  output.df$vmac_id <- gsub("--1", "", output.df$vmac_id)
  
  output.df <- map_df(1:nrow(output.df), ~ compute_scores(data = output.df[., ]))
  
  return(output.df)
}
