generate_data_from_freeze <- function(epoch = 1:5) {
  output.df <- map_df(epoch, ~ pull_map_freeze(epoch = .))
  output.df <- output.df[output.df$age != 0, ]
  output.df <- map_df(1:nrow(output.df), ~compute_scores(output.df[., ]))
  
  return(output.df)
}

# generate_data_from_redcap
