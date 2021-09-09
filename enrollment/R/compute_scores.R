compute_scores <- function(data, map_id = NULL) {
  if (is.null(map_id)) {
    np.df <- data
  } else {
    np.df <- data[data$map_id == map_id, ]
  }
  
  if (!any(np.df$age %in% 50:110)) {
    offending_rows <- which(!np.df$age %in% 60:110)
    stop(glue::glue("Age is out of bounds on rows {paste0(offending_rows, collapse = ', ')}.\n"))
  }
  
  if (!any(np.df$education %in% 0:22)) {
    offending_rows <- which(!np.df$education %in% 0:22)
    stop(glue::glue("Education is out of bounds on rows {paste0(offending_rows, collapse = ', ')}.\n"))
  }
  
  # replace invalid values with NA
  np.df[np.df == -6666] <- NA
  np.df[np.df == -7777] <- NA
  np.df[np.df == -8888] <- NA
  np.df[np.df == -9999] <- NA
  
  np.df$np_age = np.df$age
  np.df$np_education = np.df$education
  
  # Global Cognition
  
  ## MOCA
  
  np.df$np_moca_interpretation <- case_when(
    np.df$np_moca < 0 ~ "ERROR",
    np.df$np_moca < 23 ~ "Impaired",
    np.df$np_moca < 27 ~ "Borderline",
    np.df$np_moca < 31 ~ "Normal",
    TRUE ~ "ERROR"
  )
  
  # Learning & Memory
  
  ## CVLT-II
  
  np.df$np_cvlt1to5_zscore <- (np.df$np_cvlt1to5_tscore - 50) / 10
  
  ## Biber
  
  np.df$np_biber1_zscore <- (np.df$np_biber1 - 13.7) / 5.9
  np.df$np_biber2_zscore <- (np.df$np_biber2 - 20.4) / 7.4
  np.df$np_biber3_zscore <- (np.df$np_biber3 - 24.5) / 7
  np.df$np_biber4_zscore <- (np.df$np_biber4 - 26.7) / 8.4
  np.df$np_biber5_zscore <- (np.df$np_biber5 - 29.6) / 6.8
  
  np.df$np_biber_t1to5 <- sum(c(np.df$np_biber1, np.df$np_biber2, np.df$np_biber3, np.df$np_biber4, np.df$np_biber5))
  np.df$np_biber_t1to5_zscore <- (np.df$np_biber_t1to5 - 114.5) / 34.7
  
  np.df$np_biberb_zscore <- (np.df$np_biberb - 8.5) / 5
  np.df$np_biber_sd_zscore <- (np.df$np_biber_sd - 26.4) / 7
  np.df$np_biber_ld_zscore <- (np.df$np_biber_ld - 28) / 7
  
  np.df$np_cvlt1to5_zscore <- (np.df$np_cvlt1to5_tscore - 50) / 10
  
  # Language
  
  ## BNT-30 item (even)
  
  np.df$np_bnt_zscore <- (np.df$np_bnt - 26) / 3.4
  
  ## Animals
  
  np.df$np_anim <- sum(c(np.df$np_anim_q1, np.df$np_anim_q2, np.df$np_anim_q3, np.df$np_anim_q4))
  
  np.df$np_anim_zscore <- (np.df$np_anim_tscore - 50) / 10
  
  # Mood
  
  ## GDS
  
  np.df$np_gds <- sum(c(
    gds1, gds2, gds3, gds4, gds5, gds6, gds7, gds8, gds9, 
    gds10, gds11, gds12, gds13, gds14, gds15, gds16, gds17, gds18, gds19, 
    gds20, gds21, gds22, gds23, gds24, gds25, gds26, gds27, gds28, gds29, 
    gds30
  ))
  
  np.df$np_gds.interpretation <- case_when(
    np.df$np_gds < 0 ~ "ERROR",
    np.df$np_gds < 10 ~ "Normal",
    np.df$np_gds < 20 ~ "Mildly Depressed",
    np.df$np_gds < 31 ~ "Severely Depressed",
    TRUE ~ "ERROR"
  )
  
  # Visuospatial Skills
  
  ## HVOT
  
  np.df$np_hvot.age <- case_when(
    np.df$np_age >= 60 & np.df$np_age <= 64 ~ "60-64",
    np.df$np_age >= 65 & np.df$np_age <= 110 ~ "65-110",
    TRUE ~ "ERROR"
  )
  
  np.df$np_hvot.raw <- ifelse(np.df$np_hvot > max(np.df$np_hvot.lookup$raw), max(np.df$np_hvot.lookup$raw), np.df$np_hvot) %>%
    floor()
  np.df$np_hvot_tscore <- np.df$np_hvot.lookup %>%
    filter(age == np.df$np_hvot.age & education == np.df$np_education & raw == np.df$np_hvot.raw) %>%
    pull(scaled)
  
  np.df$np_hvot_zscore <- (np.df$np_hvot_tscore - 50) / 10
  
  
  # Attention/Executive Functioning/Information Processing
  
  ## DKEFS: Trail Making Test
  
  np.df$np_tmta.raw <- ifelse(np.df$np_tmta > max(np.df$np_tmta.lookup$raw), max(np.df$np_tmta.lookup$raw), np.df$np_tmta)
  np.df$np_tmta_sscore <- np.df$np_tmta.lookup %>%
    filter(age == np.df$np_age & raw == np.df$np_tmta.raw) %>%
    pull(scaled)
  
  np.df$np_tmta_seqerr.raw <- ifelse(np.df$np_tmta_seqerr > max(np.df$np_tmta_seqerr.lookup$raw), max(np.df$np_tmta_seqerr.lookup$raw), np.df$np_tmta_seqerr)
  np.df$np_tmta_cumperc_seqerr <- np.df$np_tmta_seqerr.lookup %>%
    filter(age == np.df$np_age & raw == np.df$np_tmta_seqerr.raw) %>%
    pull(scaled)
  
  np.df$np_tmta_seterr.raw <- ifelse(np.df$np_tmta_seterr > max(np.df$np_tmta_seterr.lookup$raw), max(np.df$np_tmta_seterr.lookup$raw), np.df$np_tmta_seterr)
  np.df$np_tmta_cumperc_seterr <- np.df$np_tmta_seterr.lookup %>%
    filter(age == np.df$np_age & raw == np.df$np_tmta_seterr.raw) %>%
    pull(scaled)
  
  np.df$np_tmtb.raw <- ifelse(np.df$np_tmtb > max(np.df$np_tmtb.lookup$raw), max(np.df$np_tmtb.lookup$raw), np.df$np_tmtb)
  np.df$np_tmtb_sscore <- np.df$np_tmtb.lookup %>%
    filter(age == np.df$np_age & raw == np.df$np_tmtb.raw) %>%
    pull(scaled)
  
  np.df$np_tmtb_seqerr.raw <- ifelse(np.df$np_tmtb_seqerr > max(np.df$np_tmtb_seqerr.lookup$raw), max(np.df$np_tmtb_seqerr.lookup$raw), np.df$np_tmtb_seqerr)
  np.df$np_tmtb_cumperc_seqerr <- np.df$np_tmtb_seqerr.lookup %>%
    filter(age == np.df$np_age & raw == np.df$np_tmtb_seqerr.raw) %>%
    pull(scaled)
  
  np.df$np_tmtb_seterr.raw <- ifelse(np.df$np_tmtb_seterr > max(np.df$np_tmtb_seterr.lookup$raw), max(np.df$np_tmtb_seterr.lookup$raw), np.df$np_tmtb_seterr)
  np.df$np_tmtb_cumperc_seterr <- np.df$np_tmtb_seterr.lookup %>%
    filter(age == np.df$np_age & raw == np.df$np_tmtb_seterr.raw) %>%
    pull(scaled)
  
  ## DKEFS: Color-Word
  
  np.df$np_color.raw <- ifelse(np.df$np_color > max(np.df$np_color.lookup$raw), max(np.df$np_color.lookup$raw), np.df$np_color)
  np.df$np_color_sscore <- np.df$np_color.lookup %>%
    filter(age == np.df$np_age & raw == np.df$np_color.raw) %>%
    pull(scaled)
  
  np.df$np_word.raw <- ifelse(np.df$np_word > max(np.df$np_word.lookup$raw), max(np.df$np_word.lookup$raw), np.df$np_word)
  np.df$np_word_sscore <- np.df$np_word.lookup %>%
    filter(age == np.df$np_age & raw == np.df$np_word.raw) %>%
    pull(scaled)
  
  np.df$np_inhibit.raw <- ifelse(np.df$np_inhibit > max(np.df$np_inhibit.lookup$raw), max(np.df$np_inhibit.lookup$raw), np.df$np_inhibit)
  np.df$np_inhibit_sscore <- np.df$np_inhibit.lookup %>%
    filter(age == np.df$np_age & raw == np.df$np_inhibit.raw) %>%
    pull(scaled)
  
  ## COWA
  
  np.df$np_fas <- sum(c(np.df$np_fas_f, np.df$np_fas_a, np.df$np_fas_s))
  
  np.df$np_fas_tscore.z <- (np.df$np_fas_tscore - 50) / 10
  
  ## Tower Test
  
  np.df$np_tower <- sum(c(
    np.df$np_tower1, np.df$np_tower2, np.df$np_tower3, np.df$np_tower4, np.df$np_tower5, 
    np.df$np_tower6, np.df$np_tower7, np.df$np_tower8, np.df$np_tower9
  ))
  
  np.df$np_tower_sscore <- np.df$np_tower.lookup %>%
    filter(age == np.df$np_age & raw == np.df$np_tower) %>%
    pull(scaled)
  
  np.df$np_tower_ruleviol.raw <- ifelse(np.df$np_tower_ruleviol > max(np.df$np_tower_ruleviol.lookup$raw), max(np.df$np_tower_ruleviol.lookup$raw), np.df$np_tower_ruleviol)
  np.df$np_tower_ruleviol_cumperc <- np.df$np_tower_ruleviol.lookup %>%
    filter(age == np.df$np_age & raw == np.df$np_tower_ruleviol.raw) %>%
    pull(scaled)
  
  ## Digit Symbol Coding
  
  np.df$np_digsymb.raw <- ifelse(np.df$np_digsymb > max(np.df$np_digsymb.lookup$raw), max(np.df$np_digsymb.lookup$raw), np.df$np_digsymb)
  np.df$np_digsymb_sscore <- np.df$np_digsymb.lookup %>%
    filter(age == np.df$np_age & raw == np.df$np_digsymb.raw) %>%
    pull(scaled)
  
  # Mental Control
  
  np.df$np_mc1.accuracy.index <- 1 - (np.df$np_mc1_omissions + np.df$np_mc1_falsepos) / 20
  np.df$np_mc2.accuracy.index <- 1 - (np.df$np_mc2_omissions + np.df$np_mc2_falsepos) / 26
  np.df$np_mc3.accuracy.index <- 1 - (np.df$np_mc3_omissions + np.df$np_mc3_falsepos) / 14
  
  np.df$np_mc1_3.total <- sum(c(np.df$np_mc1_time, np.df$np_mc2_time, np.df$np_mc3_time))
  
  np.df$np_mc4.accuracy.index <- 1 - (np.df$np_mc4_omissions + np.df$np_mc4_falsepos) / 12
  np.df$np_mc5.accuracy.index <- 1 - (np.df$np_mc5_omissions + np.df$np_mc5_falsepos) / 12
  np.df$np_mc6.accuracy.index <- 1 - (np.df$np_mc6_omissions + np.df$np_mc6_falsepos) / 9
  np.df$np_mc7.accuracy.index <- 1 - (np.df$np_mc7_omissions + np.df$np_mc7_falsepos) / 11
  np.df$np_mc8.accuracy.index <- 1 - (np.df$np_mc8_omissions + np.df$np_mc8_falsepos) / 13
  
  np.df$np_mc_auto_mc.accuracy.index <- mean(
    c(np.df$np_mc1.accuracy.index, np.df$np_mc2.accuracy.index, np.df$np_mc3.accuracy.index, np.df$np_mc4.accuracy.index), 
    na.rm = FALSE
  )
  
  np.df$np_mc_nonauto_mc.accuracy.index <- mean(
    c(np.df$np_mc5.accuracy.index, np.df$np_mc6.accuracy.index, np.df$np_mc7.accuracy.index), 
    na.rm = FALSE
  )
  
  # WMS-IV Symbol Span
  
  np.df$np_symbol.raw <- ifelse(np.df$np_symbol > max(np.df$np_symbol.lookup$raw), max(np.df$np_symbol.lookup$raw), np.df$np_symbol)
  np.df$np_symbol_sscore <- np.df$np_symbol.lookup %>%
    filter(age == np.df$np_age & raw == np.df$np_symbol.raw) %>%
    pull(scaled)
  
  return(np.df)
}
