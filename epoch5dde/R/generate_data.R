generate_data_from_redcap_epoch5dde <- function() {
  output.df <- pull_from_redcap_epoch5dde()
  output.df <- output.df[!is.na(output.df$age), ]
  output.df <- output.df[grep("--1", output.df$map_id), ]
  
  output.df <- map_df(1:nrow(output.df), ~ compute_scores(data = output.df[., ]))
  
  return(output.df)
}
