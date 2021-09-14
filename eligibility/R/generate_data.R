generate_data_from_redcap <- function(epoch = 5) {
  output.df <- pull_from_redcap_eligibility(var = np_eligibility.var)
  output.df <- output.df[!is.na(output.df$age), ]
  output.df <- output.df[grep("--1", output.df$vmac_id), ]
  output.df$vmac_id <- gsub("--1", "", output.df$vmac_id)
  
  output.df <- map_df(1:nrow(output.df), ~ compute_scores(data = output.df[., ]))
  
  return(output.df)
}
