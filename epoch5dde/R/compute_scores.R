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
  
  np.df$np_gds <- sum(np.df[, Cs(
    gds1, gds2, gds3, gds4, gds5, gds6, gds7, gds8, gds9, 
    gds10, gds11, gds12, gds13, gds14, gds15, gds16, gds17, gds18, gds19, 
    gds20, gds21, gds22, gds23, gds24, gds25, gds26, gds27, gds28, gds29, 
    gds30
  )])
  
  np.df$np_gds_interpretation <- case_when(
    np.df$np_gds < 0 ~ "ERROR",
    np.df$np_gds < 10 ~ "Normal",
    np.df$np_gds < 20 ~ "Mildly Depressed",
    np.df$np_gds < 31 ~ "Severely Depressed",
    TRUE ~ "ERROR"
  )
  
  
  # Visuospatial Skills
  
  ## HVOT
  
  np.df$np_hvot.age <- case_when(
    np.df$np_age >= 50 & np.df$np_age <= 54 ~ "50-54",
    np.df$np_age >= 55 & np.df$np_age <= 59 ~ "55-59",
    np.df$np_age >= 60 & np.df$np_age <= 64 ~ "60-64",
    np.df$np_age >= 65 & np.df$np_age <= 110 ~ "65-110",
    TRUE ~ "ERROR"
  )
  
  np.df$np_hvot.raw <- ifelse(np.df$np_hvot > max(epoch5dde_hvot.lookup$raw), max(np.df$np_hvot.lookup$raw), np.df$np_hvot) %>%
    floor()
  np.df$np_hvot_tscore <- if (is.na(np.df$np_hvot.raw)) {
    NA
  } else {
    epoch5dde_hvot.lookup %>%
      filter(age == np.df$np_hvot.age & education == np.df$np_education & raw == np.df$np_hvot.raw) %>%
      pull(scaled)
  }
  
  np.df$np_hvot_zscore <- (np.df$np_hvot_tscore - 50) / 10
  
  
  # Attention/Executive Functioning/Information Processing
  
  ## DKEFS: Trail Making Test
  
  np.df$np_tmta.raw <- ifelse(np.df$np_tmta > max(epoch5dde_dkefs_trails_2.lookup$raw), max(epoch5dde_dkefs_trails_2.lookup$raw), np.df$np_tmta)
  np.df$np_tmta_sscore <- if (is.na(np.df$np_tmta.raw)) {
    NA
  } else {
    epoch5dde_dkefs_trails_2.lookup %>%
      filter(age == np.df$np_age & raw == np.df$np_tmta.raw) %>%
      pull(scaled)
  }
  
  np.df$np_tmta_seqerr.raw <- ifelse(np.df$np_tmta_seqerr > max(epoch5dde_num_sequencing_errors.lookup$raw), max(epoch5dde_num_sequencing_errors.lookup$raw), np.df$np_tmta_seqerr)
  np.df$np_tmta_cumperc_seqerr <- if (is.na(np.df$np_tmta_seqerr.raw)) {
    NA
  } else {
    epoch5dde_num_sequencing_errors.lookup %>%
      filter(age == np.df$np_age & raw == np.df$np_tmta_seqerr.raw) %>%
      pull(scaled)
  }
  
  np.df$np_tmta_seterr.raw <- ifelse(np.df$np_tmta_seterr > max(epoch5dde_num_setloss_errors.lookup$raw), max(epoch5dde_num_setloss_errors.lookup$raw), np.df$np_tmta_seterr)
  np.df$np_tmta_cumperc_seterr <- if (is.na(np.df$np_tmta_seterr.raw)) {
    NA
  } else {
    epoch5dde_num_setloss_errors.lookup %>%
      filter(age == np.df$np_age & raw == np.df$np_tmta_seterr.raw) %>%
      pull(scaled)
  }
  
  np.df$np_tmtb.raw <- ifelse(np.df$np_tmtb > max(epoch5dde_dkefs_trails_4.lookup$raw), max(epoch5dde_dkefs_trails_4.lookup$raw), np.df$np_tmtb)
  np.df$np_tmtb_sscore <- if (is.na(np.df$np_tmtb.raw)) {
    NA
  } else {
    epoch5dde_dkefs_trails_4.lookup %>%
      filter(age == np.df$np_age & raw == np.df$np_tmtb.raw) %>%
      pull(scaled)
  }
  
  np.df$np_tmtb_seqerr.raw <- ifelse(np.df$np_tmtb_seqerr > max(epoch5dde_num_letter_sequencing_errors.lookup$raw), max(epoch5dde_num_letter_sequencing_errors.lookup$raw), np.df$np_tmtb_seqerr)
  np.df$np_tmtb_cumperc_seqerr <- if (is.na(np.df$np_tmtb_seqerr.raw)) {
    NA
  } else {
    epoch5dde_num_letter_sequencing_errors.lookup %>%
      filter(age == np.df$np_age & raw == np.df$np_tmtb_seqerr.raw) %>%
      pull(scaled)
  }
  
  np.df$np_tmtb_seterr.raw <- ifelse(np.df$np_tmtb_seterr > max(epoch5dde_num_letter_setloss_errors.lookup$raw), max(epoch5dde_num_letter_setloss_errors.lookup$raw), np.df$np_tmtb_seterr)
  np.df$np_tmtb_cumperc_seterr <- if (is.na(np.df$np_tmtb_seterr.raw)) {
    NA
  } else {
    epoch5dde_num_letter_setloss_errors.lookup %>%
      filter(age == np.df$np_age & raw == np.df$np_tmtb_seterr.raw) %>%
      pull(scaled)
  }
  
  ## DKEFS: Color-Word
  
  np.df$np_color.raw <- ifelse(np.df$np_color > max(epoch5dde_color_naming_time.lookup$raw), max(epoch5dde_color_naming_time.lookup$raw), np.df$np_color)
  np.df$np_color_sscore <- if (is.na(np.df$np_color.raw)) {
    NA
  } else {
    epoch5dde_color_naming_time.lookup %>%
      filter(age == np.df$np_age & raw == np.df$np_color.raw) %>%
      pull(scaled)
  }
  
  np.df$np_word.raw <- ifelse(np.df$np_word > max(epoch5dde_word_reading_time.lookup$raw), max(epoch5dde_word_reading_time.lookup$raw), np.df$np_word)
  np.df$np_word_sscore <- if (is.na(np.df$np_word.raw)) {
    NA
  } else {
    epoch5dde_word_reading_time.lookup %>%
      filter(age == np.df$np_age & raw == np.df$np_word.raw) %>%
      pull(scaled)
  }
  
  np.df$np_inhibit.raw <- ifelse(np.df$np_inhibit > max(epoch5dde_inhibition_time.lookup$raw), max(epoch5dde_inhibition_time.lookup$raw), np.df$np_inhibit)
  np.df$np_inhibit_sscore <- if (is.na(np.df$np_inhibit.raw)) {
    NA
  } else {
    epoch5dde_inhibition_time.lookup %>%
      filter(age == np.df$np_age & raw == np.df$np_inhibit.raw) %>%
      pull(scaled)
  }
  
  ## COWA
  
  np.df$np_fas <- sum(c(np.df$np_fas_f, np.df$np_fas_a, np.df$np_fas_s))
  
  np.df$np_fas_zscore <- (np.df$np_fas_tscore - 50) / 10
  
  ## Tower Test
  
  np.df$np_tower <- sum(c(
    np.df$np_tower1, np.df$np_tower2, np.df$np_tower3, np.df$np_tower4, np.df$np_tower5, 
    np.df$np_tower6, np.df$np_tower7, np.df$np_tower8, np.df$np_tower9
  ))
  
  np.df$np_tower_sscore <- if (is.na(np.df$np_tower)) {
    NA
  } else {
    epoch5dde_tower_achievement.lookup %>%
      filter(age == np.df$np_age & raw == np.df$np_tower) %>%
      pull(scaled)
  }
  
  np.df$np_tower_ruleviol.raw <- ifelse(np.df$np_tower_ruleviol > max(epoch5dde_tower_total_rule_violations.lookup$raw), max(epoch5dde_tower_total_rule_violations.lookup$raw), np.df$np_tower_ruleviol)
  np.df$np_tower_ruleviol_cumperc <- if (is.na(np.df$np_tower_ruleviol.raw)) {
    NA
  } else {
    epoch5dde_tower_total_rule_violations.lookup %>%
      filter(age == np.df$np_age & raw == np.df$np_tower_ruleviol.raw) %>%
      pull(scaled)
  }
  
  ## Digit Symbol Coding
  
  np.df$np_digsymb.raw <- ifelse(np.df$np_digsymb > max(epoch5dde_digit_symbol.lookup$raw), max(epoch5dde_digit_symbol.lookup$raw), np.df$np_digsymb)
  np.df$np_digsymb_sscore <- if (is.na(np.df$np_digsymb.raw)) {
    NA
  } else {
    epoch5dde_digit_symbol.lookup %>%
      filter(age == np.df$np_age & raw == np.df$np_digsymb.raw) %>%
      pull(scaled)
  }
  
  # Mental Control
  
  np.df$np_mc1_accuracy_index <- 1 - (np.df$np_mc1_omissions + np.df$np_mc1_falsepos) / 20
  np.df$np_mc2_accuracy_index <- 1 - (np.df$np_mc2_omissions + np.df$np_mc2_falsepos) / 26
  np.df$np_mc3_accuracy_index <- 1 - (np.df$np_mc3_omissions + np.df$np_mc3_falsepos) / 14
  
  np.df$np_mc1_3_total <- sum(c(np.df$np_mc1_time, np.df$np_mc2_time, np.df$np_mc3_time))
  
  np.df$np_mc4_accuracy_index <- 1 - (np.df$np_mc4_omissions + np.df$np_mc4_falsepos) / 12
  np.df$np_mc5_accuracy_index <- 1 - (np.df$np_mc5_omissions + np.df$np_mc5_falsepos) / 12
  np.df$np_mc6_accuracy_index <- 1 - (np.df$np_mc6_omissions + np.df$np_mc6_falsepos) / 9
  np.df$np_mc7_accuracy_index <- 1 - (np.df$np_mc7_omissions + np.df$np_mc7_falsepos) / 11
  np.df$np_mc8_accuracy_index <- 1 - (np.df$np_mc8_omissions + np.df$np_mc8_falsepos) / 13
  
  np.df$np_mc_auto_mc_accuracy_index <- mean(
    c(np.df$np_mc1_accuracy_index, np.df$np_mc2_accuracy_index, np.df$np_mc3_accuracy_index, np.df$np_mc4_accuracy_index), 
    na.rm = FALSE
  )
  
  np.df$np_mc_nonauto_mc_accuracy_index <- mean(
    c(np.df$np_mc5_accuracy_index, np.df$np_mc6_accuracy_index, np.df$np_mc7_accuracy_index), 
    na.rm = FALSE
  )
  
  # WMS-IV Symbol Span
  
  np.df$np_symbol.raw <- ifelse(np.df$np_symbol > max(epoch5dde_symbol_span.lookup$raw), max(epoch5dde_symbol_span.lookup$raw), np.df$np_symbol)
  np.df$np_symbol_sscore <- if (is.na(np.df$np_symbol.raw)) {
    NA
  } else {
    epoch5dde_symbol_span.lookup %>%
      filter(age == np.df$np_age & raw == np.df$np_symbol.raw) %>%
      pull(scaled)
  }
  
  return(np.df)
}
