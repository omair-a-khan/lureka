generate_data_from_redcap_enrollment <- function() {
  output.df <- pull_from_redcap_enrollment(var = np.var)
  output.df <- output.df[!is.na(output.df$age), ]
  
  output.df <- map_df(1:nrow(output.df), ~ compute_scores_enrollment(data = output.df[., ]))
  
  return(output.df)
}
