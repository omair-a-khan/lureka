compute_scores <- function(data, vmac_id = NULL) {
  
  if (is.null(vmac_id)) {
    np.df = data
  } else {
    np.df <- data[data$vmac_id == vmac_id, ]
  }
  
  if (!any(np.df$age %in% 50:110)) {
    offending_rows <- which(!np.df$age %in% 50:110)
    stop(glue::glue("Age is out of bounds on rows {paste0(offending_rows, collapse = ', ')}.\n"))
  }
  
  if (!any(np.df$education %in% 0:22)) {
    offending_rows <- which(!np.df$education %in% 0:22)
    stop(glue::glue("Education is out of bounds on rows {paste0(offending_rows, collapse = ', ')}.\n"))
  }
  
  # replace invalid values with NA
  np.df[np.df == -6666] = NA
  np.df[np.df == -7777] = NA
  np.df[np.df == -8888] = NA
  np.df[np.df == -9999] = NA
  
  np.df$np_age = np.df$age
  np.df$np_education = np.df$education
  
  np.df$np_moca_interpretation = case_when(
    np.df$np_moca < 0 ~ "ERROR",
    np.df$np_moca < 23 ~ "Impaired",
    np.df$np_moca < 27 ~ "Borderline",
    np.df$np_moca < 31 ~ "Normal",
    TRUE ~ "ERROR"
  )
  
  np.df$np_srt_immed = sum(c(np.df$np_srt1, np.df$np_srt2, np.df$np_srt3, np.df$np_srt4, np.df$np_srt5, np.df$np_srt6))
  
  np.df$np_srt_immed_zscore = case_when(
    grepl("^male", np.df$sex, ignore.case = TRUE) & np.df$np_age >= 50 & np.df$np_age < 60 ~ (np.df$np_srt_immed - 43.71) / 8.8,
    grepl("^female", np.df$sex, ignore.case = TRUE) & np.df$np_age >= 50 & np.df$np_age < 60 ~ (np.df$np_srt_immed - 47.75) / 8.5,
    TRUE ~ NA_real_
  )
  
  np.df$np_srt_ldfr_zscore = case_when(
    grepl("^male", np.df$sex, ignore.case = TRUE) & np.df$np_age >= 50 & np.df$np_age < 60 ~ (np.df$np_srt_ldfr - 6.08) / 2.8,
    grepl("^female", np.df$sex, ignore.case = TRUE) & np.df$np_age >= 50 & np.df$np_age < 60 ~ (np.df$np_srt_ldfr - 7.84) / 2.5,
    TRUE ~ NA_real_
  )
  
  np.df$np_srt_recog_zscore = case_when(
    np.df$np_age >= 60 & np.df$np_age < 70 & np.df$np_education < 9 ~ (np.df$np_srt_recog - 10.9) / 1.9,
    np.df$np_age >= 60 & np.df$np_age < 70 & np.df$np_education >= 9 ~ (np.df$np_srt_recog - 11.4) / 1.2,
    np.df$np_age >= 70 & np.df$np_age < 80 & np.df$np_education < 9 ~ (np.df$np_srt_recog - 10.2) / 2,
    np.df$np_age >= 70 & np.df$np_age < 80 & np.df$np_education >= 9 ~ (np.df$np_srt_recog - 11.2) / 1.4,
    np.df$np_age >= 80 & np.df$np_education < 9 ~ (np.df$np_srt_recog - 9.1) / 2.3,
    np.df$np_age >= 80 & np.df$np_education >= 9 ~ (np.df$np_srt_recog - 10.8) / 2.1
  )
  
  np.df$np_srt_intrus_zscore  = case_when(
    np.df$np_age >= 60 & np.df$np_age < 70 & np.df$np_education < 9 ~ (np.df$np_srt_intrus - 1.6) / 2.7,
    np.df$np_age >= 60 & np.df$np_age < 70 & np.df$np_education >= 9 ~ (np.df$np_srt_intrus - 0.9) / 1.7,
    np.df$np_age >= 70 & np.df$np_age < 80 & np.df$np_education < 9 ~ (np.df$np_srt_intrus - 1.3) / 2.7,
    np.df$np_age >= 70 & np.df$np_age < 80 & np.df$np_education >= 9 ~ (np.df$np_srt_intrus - 0.6) / 1.3,
    np.df$np_age >= 80 & np.df$np_education < 9 ~ (np.df$np_srt_intrus - 1.3) / 2.1,
    np.df$np_age >= 80 & np.df$np_education >= 9 ~ (np.df$np_srt_intrus - 1.1) / 1.7
  )
  
  np.df$np_bvrt_education = max(np.df$education, 8)
  
  np.df$np_bvrt.lookup = eligibility_benton.lookup %>%
    filter(age == np.df$np_age & raw == np.df$np_bvrt_education) %>%
    pull(scaled)
  
  np.df$np_bvrt_zscore = (np.df$np_bvrt - np.df$np_bvrt.lookup) / 1.6
  
  np.df$np_digits = sum(c(np.df$np_digitsf, np.df$np_digitsb))
  
  np.df$np_digits_sscore = eligibility_digit_span.lookup %>%
    filter(age == np.df$np_age & raw == np.df$np_digits) %>%
    pull(scaled)
  
  np.df$np_digitsf_span_zscore = case_when(
    np.df$np_age >= 60 & np.df$np_age < 65 ~ (np.df$np_digitsf_span - 6.35) / 1.45,
    np.df$np_age >= 65 & np.df$np_age < 70 ~ (np.df$np_digitsf_span - 6.28) / 1.42,
    np.df$np_age >= 70 & np.df$np_age < 75 ~ (np.df$np_digitsf_span - 6.14) / 1.39,
    np.df$np_age >= 75 & np.df$np_age < 80 ~ (np.df$np_digitsf_span - 6.06) / 1.26,
    np.df$np_age >= 80 & np.df$np_age < 85 ~ (np.df$np_digitsf_span - 5.89) / 1.26,
    np.df$np_age >= 85 ~ (np.df$np_digitsf_span - 6.43) / 1.36,
    TRUE ~ NA_real_
  )
  
  np.df$np_digitsb_span_zscore = case_when(
    np.df$np_age >= 60 & np.df$np_age < 65 ~ (np.df$np_digitsb_span - 4.55) / 1.56,
    np.df$np_age >= 65 & np.df$np_age < 70 ~ (np.df$np_digitsb_span - 4.48) / 1.44,
    np.df$np_age >= 70 & np.df$np_age < 75 ~ (np.df$np_digitsb_span - 4.4) / 1.16,
    np.df$np_age >= 75 & np.df$np_age < 80 ~ (np.df$np_digitsb_span - 4.31) / 1.17,
    np.df$np_age >= 80 & np.df$np_age < 85 ~ (np.df$np_digitsb_span - 4.25) / 1.03,
    np.df$np_age >= 85 ~ (np.df$np_digitsb_span - 4.1) / 1.05,
    TRUE ~ NA_real_
  )
  
  np.df$np_rey = np.df$np_rey_recall + (np.df$np_rey_hits - np.df$np_rey_falsepos)
  
  np.df$np_rey_recog = np.df$np_rey_hits - np.df$np_rey_falsepos
  
  np.df$np_wrat_sscore = eligibility_wrat_std.lookup %>%
    filter(age == np.df$np_age & raw == np.df$np_wrat) %>%
    pull(scaled)
  
  np.df$np_wrat_grade = eligibility_wrat_edu.lookup %>%
    filter(age == np.df$np_age & raw == np.df$np_wrat) %>%
    pull(scaled)
  
  np.df$np_blocks_sscore = eligibility_block_design.lookup %>%
    filter(age == np.df$np_age & raw == np.df$np_blocks) %>%
    pull(scaled)
  
  np.df$np_bnt_zscore = case_when(
    grepl("^male", np.df$sex, ignore.case = TRUE) ~ (np.df$np_bnt - (25.49287807 + (0.61686473*1) + (-0.05142736*np.df$np_age) + (0.33669818*np.df$np_education))) / 2.992948,
    grepl("^female", np.df$sex, ignore.case = TRUE) ~ (np.df$np_bnt - (25.49287807 + (0.61686473*2) + (-0.05142736*np.df$np_age) + (0.33669818*np.df$np_education))) / 2.992948,
    TRUE ~ NA_real_
  )
  
  np.df$np_veg_zscore = case_when(
    grepl("^male", np.df$sex, ignore.case = TRUE) & np.df$np_age >= 50 & np.df$np_age < 60 ~ (np.df$np_veg - 11.7) / 1.7,
    grepl("^male", np.df$sex, ignore.case = TRUE) & np.df$np_age >= 60 & np.df$np_age < 70 ~ (np.df$np_veg - 11.8) / 2.8,
    grepl("^male", np.df$sex, ignore.case = TRUE) & np.df$np_age >= 70 & np.df$np_age < 110 ~ (np.df$np_veg - 12) / 3,
    grepl("^female", np.df$sex, ignore.case = TRUE) & np.df$np_age >= 50 & np.df$np_age < 60 ~ (np.df$np_veg - 17) / 3.8,
    grepl("^female", np.df$sex, ignore.case = TRUE) & np.df$np_age >= 60 & np.df$np_age < 70 ~ (np.df$np_veg - 15.4) / 3.8,
    grepl("^female", np.df$sex, ignore.case = TRUE) & np.df$np_age >= 70 & np.df$np_age < 110 ~ (np.df$np_veg - 14.2) / 3.5,
    TRUE ~ NA_real_
  )
  
  np.df$np_tmta_moans_sscore = case_when(
    grepl("^white", np.df$race, ignore.case = TRUE) ~ eligibility_trails_a_w.lookup %>%
      filter(age == np.df$np_age & raw == np.df$np_tmta) %>%
      pull(scaled),
    (!grepl("^white", np.df$race, ignore.case = TRUE)) ~ eligibility_trails_a_b.lookup %>%
      filter(age == np.df$np_age & raw == np.df$np_tmta) %>%
      pull(scaled),
    TRUE ~ NA_real_
  )
  
  np.df$np_tmtb_moans_sscore = case_when(
    grepl("^white", np.df$race, ignore.case = TRUE) ~ eligibility_trails_b_w.lookup %>%
      filter(age == np.df$np_age & raw == np.df$np_tmtb) %>%
      pull(scaled),
    (!grepl("^white", np.df$race, ignore.case = TRUE)) ~ eligibility_trails_b_b.lookup %>%
      filter(age == np.df$np_age & raw == np.df$np_tmtb) %>%
      pull(scaled),
    TRUE ~ NA_real_
  )
  
  np.df$np_tmta_tnt_sscore = case_when(
    np.df$np_age >= 50 & np.df$np_age < 55 & np.df$np_education <= 12 ~ -(np.df$np_tmta - 31.78) / 9.93, 
    np.df$np_age >= 50 & np.df$np_age < 55 & np.df$np_education > 12 ~ -(np.df$np_tmta - 31.78) / 9.93,
    
    np.df$np_age >= 55 & np.df$np_age < 60 & np.df$np_education <= 12 ~ -(np.df$np_tmta - 35.10) / 10.94,
    np.df$np_age >= 55 & np.df$np_age < 60 & np.df$np_education > 12 ~ -(np.df$np_tmta - 31.72) / 10.14,
    
    np.df$np_age >= 60 & np.df$np_age < 65 & np.df$np_education <= 12 ~ -(np.df$np_tmta - 33.22) / 9.10,
    np.df$np_age >= 60 & np.df$np_age < 65 & np.df$np_education > 12 ~ -(np.df$np_tmta - 31.32) / 6.96,
    
    np.df$np_age >= 65 & np.df$np_age < 70 & np.df$np_education <= 12 ~ -(np.df$np_tmta - 39.14) / 11.84,
    np.df$np_age >= 65 & np.df$np_age < 70 & np.df$np_education > 12 ~ -(np.df$np_tmta - 33.84) / 6.69,
    
    np.df$np_age >= 70 & np.df$np_age < 75 & np.df$np_education <= 12 ~ -(np.df$np_tmta - 42.47) / 15.15,
    np.df$np_age >= 70 & np.df$np_age < 75 & np.df$np_education > 12 ~ -(np.df$np_tmta - 40.13) / 14.48,
    
    np.df$np_age >= 75 & np.df$np_age < 80 & np.df$np_education <= 12 ~ -(np.df$np_tmta - 50.81) / 17.44,
    np.df$np_age >= 75 & np.df$np_age < 80 & np.df$np_education > 12 ~ -(np.df$np_tmta - 41.75) / 15.32,
    
    np.df$np_age >= 80 & np.df$np_age < 85 & np.df$np_education <= 12 ~ -(np.df$np_tmta - 58.19) / 23.31,
    np.df$np_age >= 80 & np.df$np_age < 85 & np.df$np_education > 12 ~ -(np.df$np_tmta - 55.32) / 21.28,
    
    np.df$np_age >= 85 & np.df$np_age < 110 & np.df$np_education <= 12 ~ -(np.df$np_tmta - 57.56) / 21.54,
    np.df$np_age >= 85 & np.df$np_age < 110 & np.df$np_education > 12 ~ -(np.df$np_tmta - 63.46) / 29.22,
    
    TRUE ~ NA_real_
  )
  
  np.df$np_tmtb_tnt_sscore = case_when(
    np.df$np_age >= 50 & np.df$np_age < 55 & np.df$np_education <= 12 ~ -(np.df$np_tmtb - 63.76) / 14.42,
    np.df$np_age >= 50 & np.df$np_age < 55 & np.df$np_education > 12 ~ -(np.df$np_tmtb - 63.76) / 14.42,
    
    np.df$np_age >= 55 & np.df$np_age < 60 & np.df$np_education <= 12 ~ -(np.df$np_tmtb - 78.84) / 19.09,
    np.df$np_age >= 55 & np.df$np_age < 60 & np.df$np_education > 12 ~ -(np.df$np_tmtb - 68.74) / 21.02,
    
    np.df$np_age >= 60 & np.df$np_age < 65 & np.df$np_education <= 12 ~ -(np.df$np_tmtb - 74.55) / 19.55,
    np.df$np_age >= 60 & np.df$np_age < 65 & np.df$np_education > 12 ~ -(np.df$np_tmtb - 64.58) / 18.59,
    
    np.df$np_age >= 65 & np.df$np_age < 70 & np.df$np_education <= 12 ~ -(np.df$np_tmtb - 91.32) / 28.89,
    np.df$np_age >= 65 & np.df$np_age < 70 & np.df$np_education > 12 ~ -(np.df$np_tmtb - 67.12) / 9.31,
    
    np.df$np_age >= 70 & np.df$np_age < 75 & np.df$np_education <= 12 ~ -(np.df$np_tmtb - 109.95) / 35.15,
    np.df$np_age >= 70 & np.df$np_age < 75 & np.df$np_education > 12 ~ -(np.df$np_tmtb - 86.27) / 24.07,
    
    np.df$np_age >= 75 & np.df$np_age < 80 & np.df$np_education <= 12 ~ -(np.df$np_tmtb - 130.61) / 45.74,
    np.df$np_age >= 75 & np.df$np_age < 80 & np.df$np_education > 12 ~ -(np.df$np_tmtb - 100.68) / 44.16,
    
    np.df$np_age >= 80 & np.df$np_age < 85 & np.df$np_education <= 12 ~ -(np.df$np_tmtb - 152.74) / 65.68,
    np.df$np_age >= 80 & np.df$np_age < 85 & np.df$np_education > 12 ~ -(np.df$np_tmtb - 132.15) / 42.95,
    
    np.df$np_age >= 85 & np.df$np_age < 110 & np.df$np_education <= 12 ~ -(np.df$np_tmtb - 167.69) / 78.50,
    np.df$np_age >= 85 & np.df$np_age < 110 & np.df$np_education > 12 ~ -(np.df$np_tmtb - 140.54) / 75.38,
    
    TRUE ~ NA_real_
  )
  
  np.df$np_strp_word_sscore = case_when(
    grepl("^white", np.df$race, ignore.case = TRUE) & np.df$np_age <= 55 ~ (np.df$np_strp_word - 101.9) / 14.4,
    grepl("^white", np.df$race, ignore.case = TRUE) & np.df$np_age > 55 ~ eligibility_stroop_word_w.lookup %>%
      filter(age == np.df$np_age & raw == np.df$np_strp_word) %>%
      pull(scaled),
    (!grepl("^white", np.df$race, ignore.case = TRUE)) & np.df$np_age <= 55 ~ (np.df$np_strp_word - 96.2) / 16.9,
    (!grepl("^white", np.df$race, ignore.case = TRUE)) & np.df$np_age > 55 ~ eligibility_stroop_word_b.lookup %>%
      filter(age == np.df$np_age & raw == np.df$np_strp_word) %>%
      pull(scaled),
    TRUE ~ NA_real_
  )
  
  np.df$np_strp_color_sscore = case_when(
    grepl("^white", np.df$race, ignore.case = TRUE) & np.df$np_age <= 55 ~ (np.df$np_strp_color - 76.4) / 10.8,
    grepl("^white", np.df$race, ignore.case = TRUE) & np.df$np_age > 55 ~ eligibility_stroop_color_w.lookup %>%
      filter(age == np.df$np_age & raw == np.df$np_strp_color) %>%
      pull(scaled),
    (!grepl("^white", np.df$race, ignore.case = TRUE)) & np.df$np_age <= 55 ~ (np.df$np_strp_color - 70.8) / 13.0,
    (!grepl("^white", np.df$race, ignore.case = TRUE)) & np.df$np_age > 55 ~ eligibility_stroop_color_b.lookup %>%
      filter(age == np.df$np_age & raw == np.df$np_strp_color) %>%
      pull(scaled),
    TRUE ~ NA_real_
  )
  
  np.df$np_strp_colorword_sscore = case_when(
    grepl("^white", np.df$race, ignore.case = TRUE) & np.df$np_age <= 55 ~ (np.df$np_strp_colorword - 45.0) / 9.5,
    grepl("^white", np.df$race, ignore.case = TRUE) & np.df$np_age > 55 ~ eligibility_stroop_colorword_w.lookup %>%
      filter(age == np.df$np_age & raw == np.df$np_strp_colorword) %>%
      pull(scaled),
    (!grepl("^white", np.df$race, ignore.case = TRUE)) & np.df$np_age <= 55 ~ (np.df$np_strp_colorword - 38.2) / 10.2,
    (!grepl("^white", np.df$race, ignore.case = TRUE)) & np.df$np_age > 55 ~ eligibility_stroop_colorword_b.lookup %>%
      filter(age == np.df$np_age & raw == np.df$np_strp_colorword) %>%
      pull(scaled),
    TRUE ~ NA_real_
  )
  
  np.df$np_cfl = sum(c(np.df$np_cfl_c, np.df$np_cfl_f, np.df$np_cfl_l))
  
  np.df$np_cfl_sscore = case_when(
    grepl("^white", np.df$race, ignore.case = TRUE) & np.df$np_age <= 55 ~ (np.df$np_cfl - 45.31) / 12.96,
    grepl("^white", np.df$race, ignore.case = TRUE) & np.df$np_age > 55 ~ eligibility_cowa_w.lookup %>% 
      filter(age == np.df$np_age & raw == np.df$np_cfl) %>% 
      pull(scaled),
    (!grepl("^white", np.df$race, ignore.case = TRUE)) & np.df$np_age <= 55 ~ (np.df$np_cfl - 45.31) / 12.96,
    (!grepl("^white", np.df$race, ignore.case = TRUE)) & np.df$np_age > 55 ~ eligibility_cowa_b.lookup %>% 
      filter(age == np.df$np_age & raw == np.df$np_cfl) %>% 
      pull(scaled),
    TRUE ~ NA_real_
  )
  
  np.df <- np.df[, setdiff(names(np.df), c("np_age", "np_education"))]
  
  return(np.df)
}

# cdr_score_interpretation = case_when(
#   cdr_score == 0 ~ "No Dementia",
#   cdr_score == 0.5 ~ "MCI",
#   cdr_score == 1 ~ "Mild Dementia",
#   cdr_score == 2 ~ "Moderate Dementia",
#   cdr_score == 3 ~ "Severe Dementia",
#   TRUE = "ERROR"
# )


# ,
# np.df$np_gds.interpretation = case_when( # variable?
#   np.df$np_gds < 0 ~ "ERROR",
#   np.df$np_gds < 10 ~ "Normal",
#   np.df$np_gds < 20 ~ "Mildly Depressed",
#   np.df$np_gds < 31 ~ "Severely Depressed",
#   TRUE ~ "ERROR"
# )
