compute_scores <- function(data, map_id) {
  np.df <- data[data$map_id == map_id, np.var]
  
  if (!np.df$age %in% 60:110) {
    stop("Age is out of bounds.\n")
  }
  
  if (!np.df$education %in% 0:22) {
    stop("Education is out of bounds.\n")
  }
  
  # replace invalid values with NA
  np.df[np.df %in% -9999 | np.df %in% "-9999"] <- NA

  np.df <- within(np.df, {
    np_age <- age
    np_education <- education
    
    # Global Cognition
    
    ## MOCA
    
    np_moca.interpretation <- case_when(
      np_moca < 0 ~ "ERROR",
      np_moca < 23 ~ "Impaired",
      np_moca < 27 ~ "Borderline",
      np_moca < 31 ~ "Normal",
      TRUE ~ "ERROR"
    )
    
    # Learning & Memory
    
    ## CVLT-II
    
    #! Manual coding of scaled scores
    
    ## Biber
    
    np_biber1.scaled <- (np_biber1 - 13.7) / 5.9
    np_biber2.scaled <- (np_biber2 - 20.4) / 7.4
    np_biber3.scaled <- (np_biber3 - 24.5) / 7
    np_biber4.scaled <- (np_biber4 - 26.7) / 8.4
    np_biber5.scaled <- (np_biber5 - 29.6) / 6.8
    
    np_biber_t1to5 <- sum(c(np_biber1, np_biber2, np_biber3, np_biber4, np_biber5))
    np_biber_t1to5.scaled <- (np_biber_t1to5 - 114.5) / 34.7
    
    np_biberb.scaled <- (np_biberb - 8.5) / 5
    np_biber_sd.scaled <- (np_biber_sd - 26.4) / 7
    np_biber_ld.scaled <- (np_biber_ld - 28) / 7
    
    # Language
    
    ## BNT-30 item (even)
    
    np_bnt.scaled <- (np_bnt - 26) / 3.4
    
    ## Animals
    
    np_anim <- sum(c(np_anim_q1, np_anim_q2, np_anim_q3, np_anim_q4))
    
    #! Manual coding of scaled scores
    
    # Mood
    
    ## GDS
    
    np_gds <- sum(c(
      gds1, gds2, gds3, gds4, gds5, gds6, gds7, gds8, gds9, 
      gds10, gds11, gds12, gds13, gds14, gds15, gds16, gds17, gds18, gds19, 
      gds20, gds21, gds22, gds23, gds24, gds25, gds26, gds27, gds28, gds29, 
      gds30
    ))
    
    np_gds.interpretation <- case_when(
      np_gds < 0 ~ "ERROR",
      np_gds < 10 ~ "Normal",
      np_gds < 20 ~ "Mildly Depressed",
      np_gds < 31 ~ "Severely Depressed",
      TRUE ~ "ERROR"
    )
    
    # Visuospatial Skills
    
    ## HVOT
    
    np_hvot.age <- case_when(
      np_age >= 60 & np_age <= 64 ~ "60-64",
      np_age >= 65 & np_age <= 110 ~ "65-110",
      TRUE ~ "ERROR"
    )
    
    np_hvot.raw <- ifelse(np_hvot > max(np_hvot.lookup$raw), max(np_hvot.lookup$raw), np_hvot) %>%
      floor()
    np_hvot.scaled <- np_hvot.lookup %>%
      filter(age == np_hvot.age & education == np_education & raw == np_hvot.raw) %>%
      pull(scaled)
    
    # Attention/Executive Functioning/Information Processing
    
    ## DKEFS: Trail Making Test
    
    np_tmta.raw <- ifelse(np_tmta > max(np_tmta.lookup$raw), max(np_tmta.lookup$raw), np_tmta)
    np_tmta.scaled <- np_tmta.lookup %>%
      filter(age == np_age & raw == np_tmta.raw) %>%
      pull(scaled)
    
    np_tmta_seqerr.raw <- ifelse(np_tmta_seqerr > max(np_tmta_seqerr.lookup$raw), max(np_tmta_seqerr.lookup$raw), np_tmta_seqerr)
    np_tmta_seqerr.scaled <- np_tmta_seqerr.lookup %>%
      filter(age == np_age & raw == np_tmta_seqerr.raw) %>%
      pull(scaled)
    
    np_tmta_seterr.raw <- ifelse(np_tmta_seterr > max(np_tmta_seterr.lookup$raw), max(np_tmta_seterr.lookup$raw), np_tmta_seterr)
    np_tmta_seterr.scaled <- np_tmta_seterr.lookup %>%
      filter(age == np_age & raw == np_tmta_seterr.raw) %>%
      pull(scaled)
    
    np_tmtb.raw <- ifelse(np_tmtb > max(np_tmtb.lookup$raw), max(np_tmtb.lookup$raw), np_tmtb)
    np_tmtb.scaled <- np_tmtb.lookup %>%
      filter(age == np_age & raw == np_tmtb.raw) %>%
      pull(scaled)
    
    np_tmtb_seqerr.raw <- ifelse(np_tmtb_seqerr > max(np_tmtb_seqerr.lookup$raw), max(np_tmtb_seqerr.lookup$raw), np_tmtb_seqerr)
    np_tmtb_seqerr.scaled <- np_tmtb_seqerr.lookup %>%
      filter(age == np_age & raw == np_tmtb_seqerr.raw) %>%
      pull(scaled)
    
    np_tmtb_seterr.raw <- ifelse(np_tmtb_seterr > max(np_tmtb_seterr.lookup$raw), max(np_tmtb_seterr.lookup$raw), np_tmtb_seterr)
    np_tmtb_seterr.scaled <- np_tmtb_seterr.lookup %>%
      filter(age == np_age & raw == np_tmtb_seterr.raw) %>%
      pull(scaled)
    
    ## DKEFS: Color-Word
    
    np_color.raw <- ifelse(np_color > max(np_color.lookup$raw), max(np_color.lookup$raw), np_color)
    np_color.scaled <- np_color.lookup %>%
      filter(age == np_age & raw == np_color.raw) %>%
      pull(scaled)
    
    np_word.raw <- ifelse(np_word > max(np_word.lookup$raw), max(np_word.lookup$raw), np_word)
    np_word.scaled <- np_word.lookup %>%
      filter(age == np_age & raw == np_word.raw) %>%
      pull(scaled)
    
    np_inhibit.raw <- ifelse(np_inhibit > max(np_inhibit.lookup$raw), max(np_inhibit.lookup$raw), np_inhibit)
    np_inhibit.scaled <- np_inhibit.lookup %>%
      filter(age == np_age & raw == np_inhibit.raw) %>%
      pull(scaled)
    
    ## COWA
    
    np_fas <- sum(c(np_fas_f, np_fas_a, np_fas_s))
    
    ## Tower Test
    
    np_tower <- sum(c(
      np_tower01, np_tower02, np_tower03, np_tower04, np_tower05, 
      np_tower06, np_tower07, np_tower08, np_tower09
    ))
    
    np_tower.scaled <- np_tower.lookup %>%
      filter(age == np_age & raw == np_tower) %>%
      pull(scaled)
    
    np_tower_ruleviol.raw <- ifelse(np_tower_ruleviol > max(np_tower_ruleviol.lookup$raw), max(np_tower_ruleviol.lookup$raw), np_tower_ruleviol)
    np_tower_ruleviol.scaled <- np_tower_ruleviol.lookup %>%
      filter(age == np_age & raw == np_tower_ruleviol.raw) %>%
      pull(scaled)
    
    ## Digit Symbol Coding
    
    np_digsymb.raw <- ifelse(np_digsymb > max(np_digsymb.lookup$raw), max(np_digsymb.lookup$raw), np_digsymb)
    np_digsymb.scaled <- np_digsymb.lookup %>%
      filter(age == np_age & raw == np_digsymb.raw) %>%
      pull(scaled)
    
    # Mental Control
    
    np_mc1.accuracy.index <- 1 - (np_mc1_omissions + np_mc1_falsepos) / 20
    np_mc2.accuracy.index <- 1 - (np_mc2_omissions + np_mc2_falsepos) / 26
    np_mc3.accuracy.index <- 1 - (np_mc3_omissions + np_mc3_falsepos) / 14
    
    np_mc1_3.total <- sum(c(np_mc1_time, np_mc2_time, np_mc3_time))
    
    np_mc4.accuracy.index <- 1 - (np_mc4_omissions + np_mc4_falsepos) / 12
    np_mc5.accuracy.index <- 1 - (np_mc5_omissions + np_mc5_falsepos) / 12
    np_mc6.accuracy.index <- 1 - (np_mc6_omissions + np_mc6_falsepos) / 9
    np_mc7.accuracy.index <- 1 - (np_mc7_omissions + np_mc7_falsepos) / 11
    np_mc8.accuracy.index <- 1 - (np_mc8_omissions + np_mc8_falsepos) / 13
    
    np_mc_auto_mc.accuracy.index <- mean(
      c(np_mc1.accuracy.index, np_mc2.accuracy.index, np_mc3.accuracy.index, np_mc4.accuracy.index), 
      na.rm = FALSE
    )
    
    np_mc_nonauto_mc.accuracy.index <- mean(
      c(np_mc5.accuracy.index, np_mc6.accuracy.index, np_mc7.accuracy.index), 
      na.rm = FALSE
    )
    
    # WMS-IV Symbol Span
    
    np_symbol.raw <- ifelse(np_symbol > max(np_symbol.lookup$raw), max(np_symbol.lookup$raw), np_symbol)
    np_symbol.scaled <- np_symbol.lookup %>%
      filter(age == np_age & raw == np_symbol.raw) %>%
      pull(scaled)
    
  })
  
  return(np.df)
}
