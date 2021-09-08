pull_map_freeze <- function(data.list = MAPfreeze.list, var = np.var, epoch) {
  if (epoch == 1) {
    main.var <- var[var %in% names(data.list[["epoch_1"]][["data"]][["main"]])]
    addendum.var <- var[!var %in% main.var]
    
    if (!all(addendum.var %in% names(data.list[["epoch_1"]][["data"]][["addendum"]]))) {
      stop("Check that all specified variables are in the Epoch 1 data.\n\n")
    }
    
    main.df <- data.list[["epoch_1"]][["data"]][["main"]]
    main.df <- main.df[, main.var]
    
    addendum.df <- data.list[["epoch_1"]][["data"]][["addendum"]]
    addendum.df <- addendum.df[, c("map_id", addendum.var)]
    
    output.df <- left_join(main.df, addendum.df, by = "map_id")
  } else {
    output.df <- data.list[[paste0("epoch_", epoch)]][["data"]][["main"]]
    output.df <- output.df[, var]
  }
  
  output.df$np_mc_kaplan_sscore <- as.character(output.df$np_mc_kaplan_sscore)
  output.df$epoch <- epoch
  
  return(output.df)
}
