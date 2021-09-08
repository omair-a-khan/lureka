generate_data_from_redcap_eligibility <- function() {
  output.df <- pull_from_redcap_eligibility(var = np_eligibility.var)
  output.df <- output.df[!is.na(output.df$age), ]
  
  output.df <- map_df(1:nrow(output.df), ~ compute_scores_eligibility(data = output.df[., ]))
  
  return(output.df)
}
