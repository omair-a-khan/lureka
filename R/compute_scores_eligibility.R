compute_scores_eligibility <- function(data, vmac_id = NULL) {
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
  
  np.df <- np.df %>%
    rowwise() %>%
    mutate(
      np_age = age,
      np_education = education,
      
      np_moca.interpretation = case_when(
        np_moca < 0 ~ "ERROR",
        np_moca < 23 ~ "Impaired",
        np_moca < 27 ~ "Borderline",
        np_moca < 31 ~ "Normal",
        TRUE ~ "ERROR"
      ),
      np_srt_immed = sum(c(np_srt1, np_srt2, np_srt3, np_srt4, np_srt5, np_srt6)),
      np_srt_immed_zscore = case_when(
        np_age >= 50 & np_age < 60 & np_education < 9 ~ (np_srt_immed - 53.13) / 5.99,
        np_age >= 50 & np_age < 60 & np_education >= 9 ~ (np_srt_immed - 53.13) / 5.99,
        np_age >= 60 & np_age < 70 & np_education < 9 ~ (np_srt_immed - 39.8) / 10.3,
        np_age >= 60 & np_age < 70 & np_education >= 9 ~ (np_srt_immed - 43.5) / 9.3,
        np_age >= 70 & np_age < 80 & np_education < 9 ~ (np_srt_immed - 31.8) / 9.5,
        np_age >= 70 & np_age < 80 & np_education >= 9 ~ (np_srt_immed - 39.8) / 9.8,
        np_age >= 80 & np_education < 9 ~ (np_srt_immed - 27.7) / 10.7,
        np_age >= 80 & np_education >= 9 ~ (np_srt_immed - 34.2) / 11.9,
        TRUE ~ NA_real_
      ),
      np_srt_ldfr_zscore = case_when(
        np_age >= 60 & np_age < 70 & np_education < 9 ~ (np_srt_ldfr - 5.3) / 2.8,
        np_age >= 60 & np_age < 70 & np_education >= 9 ~ (np_srt_ldfr - 6.7) / 2.8,
        np_age >= 70 & np_age < 80 & np_education < 9 ~ (np_srt_ldfr - 4.5) / 2.6,
        np_age >= 70 & np_age < 80 & np_education >= 9 ~ (np_srt_ldfr - 5.8) / 2.7,
        np_age >= 80 & np_education < 9 ~ (np_srt_ldfr - 2.8) / 2.5,
        np_age >= 80 & np_education >= 9 ~ (np_srt_ldfr - 4.9) / 2.9,
        TRUE ~ NA_real_
      ),
      np_srt_recog_zscore = case_when(
        np_age >= 60 & np_age < 70 & np_education < 9 ~ (np_srt_recog - 10.9) / 1.9,
        np_age >= 60 & np_age < 70 & np_education >= 9 ~ (np_srt_recog - 11.4) / 1.2,
        np_age >= 70 & np_age < 80 & np_education < 9 ~ (np_srt_recog - 10.2) / 2,
        np_age >= 70 & np_age < 80 & np_education >= 9 ~ (np_srt_recog - 11.2) / 1.4,
        np_age >= 80 & np_education < 9 ~ (np_srt_recog - 9.1) / 2.3,
        np_age >= 80 & np_education >= 9 ~ (np_srt_recog - 10.8) / 2.1
      ),
      np_srt_intrus_zscore  = case_when(
        np_age >= 60 & np_age < 70 & np_education < 9 ~ (np_srt_intrus - 1.6) / 2.7,
        np_age >= 60 & np_age < 70 & np_education >= 9 ~ (np_srt_intrus - 0.9) / 1.7,
        np_age >= 70 & np_age < 80 & np_education < 9 ~ (np_srt_intrus - 1.3) / 2.7,
        np_age >= 70 & np_age < 80 & np_education >= 9 ~ (np_srt_intrus - 0.6) / 1.3,
        np_age >= 80 & np_education < 9 ~ (np_srt_intrus - 1.3) / 2.1,
        np_age >= 80 & np_education >= 9 ~ (np_srt_intrus - 1.1) / 1.7
      ),
      np_bvrt_zscore = eligibility_benton.lookup %>%
        filter(age == np_age & raw == np_bvrt) %>%
        pull(scaled),
      
      np_digits = sum(c(np_digitsf, np_digitsb)),
      
      np_digits_sscore = eligibility_digit_span.lookup %>%
        filter(age == np_age & raw == np_digits) %>%
        pull(scaled),
      
      np_digitsf_span_zscore = case_when(
        np_age >= 60 & np_age < 65 ~ (np_digitsf_span - 6.35) / 1.45,
        np_age >= 65 & np_age < 70 ~ (np_digitsf_span - 6.28) / 1.42,
        np_age >= 70 & np_age < 75 ~ (np_digitsf_span - 6.14) / 1.39,
        np_age >= 75 & np_age < 80 ~ (np_digitsf_span - 6.06) / 1.26,
        np_age >= 80 & np_age < 85 ~ (np_digitsf_span - 5.89) / 1.26,
        np_age >= 85 ~ (np_digitsf_span - 6.43) / 1.36,
        TRUE ~ NA_real_
      ),
      np_digitsb_span_zscore = case_when(
        np_age >= 60 & np_age < 65 ~ (np_digitsb_span - 4.55) / 1.56,
        np_age >= 65 & np_age < 70 ~ (np_digitsb_span - 4.48) / 1.44,
        np_age >= 70 & np_age < 75 ~ (np_digitsb_span - 4.4) / 1.16,
        np_age >= 75 & np_age < 80 ~ (np_digitsb_span - 4.31) / 1.17,
        np_age >= 80 & np_age < 85 ~ (np_digitsb_span - 4.25) / 1.03,
        np_age >= 85 ~ (np_digitsb_span - 4.1) / 1.05,
        TRUE ~ NA_real_
      ),
      np_rey = np_rey_recall + (np_rey_hits - np_rey_falsepos),
      np_rey_recog = np_rey_hits - np_rey_falsepos,
      np_wrat_sscore = eligibility_wrat_std.lookup %>%
        filter(age == np_age & raw == np_wrat) %>%
        pull(scaled),
      np_wrat_grade = eligibility_wrat_edu.lookup %>%
        filter(age == np_age & raw == np_wrat) %>%
        pull(scaled),
      np_blocks_sscore = eligibility_block_design.lookup %>%
        filter(age == np_age & raw == np_blocks) %>%
        pull(scaled),
      np_bnt_zscore = case_when(
        sex == "Male" ~ (np_bnt - (25.49287807 + (0.61686473*1) + (-0.05142736*np_age) + (0.33669818*np_education))) / 2.992948,
        sex == "Female" ~ (np_bnt - (25.49287807 + (0.61686473*2) + (-0.05142736*np_age) + (0.33669818*np_education))) / 2.992948,
        TRUE ~ NA_real_
      ),
      np_veg_zscore = case_when(
        sex == "Male" & np_age >= 50 & np_age < 60 ~ (np_veg - 11.7) / 1.7,
        sex == "Male" & np_age >= 60 & np_age < 70 ~ (np_veg - 11.8) / 2.8,
        sex == "Male" & np_age >= 70 & np_age < 110 ~ (np_veg - 12) / 3,
        sex == "Female" & np_age >= 50 & np_age < 60 ~ (np_veg - 17) / 3.8,
        sex == "Female" & np_age >= 60 & np_age < 70 ~ (np_veg - 15.4) / 3.8,
        sex == "Female" & np_age >= 70 & np_age < 110 ~ (np_veg - 14.2) / 3.5,
        TRUE ~ NA_real_
      ),
      np_tmta_moans_sscore = case_when(
        race == "White" ~ eligibility_trails_a_w.lookup %>%
          filter(age == np_age & raw == np_tmta) %>%
          pull(scaled),
        race != "White" ~ eligibility_trails_a_b.lookup %>%
          filter(age == np_age & raw == np_tmta) %>%
          pull(scaled),
        TRUE ~ NA_real_
      ),
      np_tmtb_moans_sscore = case_when(
        race == "White" ~ eligibility_trails_b_w.lookup %>%
          filter(age == np_age & raw == np_tmtb) %>%
          pull(scaled),
        race != "White" ~ eligibility_trails_b_b.lookup %>%
          filter(age == np_age & raw == np_tmtb) %>%
          pull(scaled),
        TRUE ~ NA_real_
      ),
      np_tmta_tnt_sscore = case_when(
        np_age >= 50 & np_age < 55 & np_education <= 12 ~ (np_tmta - 31.78) / 9.93, 
        np_age >= 50 & np_age < 55 & np_education > 12 ~ (np_tmta - 31.78) / 9.93,
        
        np_age >= 55 & np_age < 60 & np_education <= 12 ~ (np_tmta - 35.10) / 10.94,
        np_age >= 55 & np_age < 60 & np_education > 12 ~ (np_tmta - 31.72) / 10.14,
        
        np_age >= 60 & np_age < 65 & np_education <= 12 ~ (np_tmta - 33.22) / 9.10,
        np_age >= 60 & np_age < 65 & np_education > 12 ~ (np_tmta - 31.32) / 6.96,
        
        np_age >= 65 & np_age < 70 & np_education <= 12 ~ (np_tmta - 39.14) / 11.84,
        np_age >= 65 & np_age < 70 & np_education > 12 ~ (np_tmta - 33.84) / 6.69,
        
        np_age >= 70 & np_age < 75 & np_education <= 12 ~ (np_tmta - 42.47) / 15.15,
        np_age >= 70 & np_age < 75 & np_education > 12 ~ (np_tmta - 40.13) / 14.48,
        
        np_age >= 75 & np_age < 80 & np_education <= 12 ~ (np_tmta - 50.81) / 17.44,
        np_age >= 75 & np_age < 80 & np_education > 12 ~ (np_tmta - 41.75) / 15.32,
        
        np_age >= 80 & np_age < 85 & np_education <= 12 ~ (np_tmta - 58.19) / 23.31,
        np_age >= 80 & np_age < 85 & np_education > 12 ~ (np_tmta - 55.32) / 21.28,
        
        np_age >= 85 & np_age < 110 & np_education <= 12 ~ (np_tmta - 57.56) / 21.54,
        np_age >= 85 & np_age < 110 & np_education > 12 ~ (np_tmta - 63.46) / 29.22,
        
        TRUE ~ NA_real_
      ),
      np_tmtb_tnt_sscore = case_when(
        np_age >= 50 & np_age < 55 & np_education <= 12 ~ (np_tmtb - 63.76) / 14.42,
        np_age >= 50 & np_age < 55 & np_education > 12 ~ (np_tmtb - 63.76) / 14.42,
        
        np_age >= 55 & np_age < 60 & np_education <= 12 ~ (np_tmtb - 78.84) / 19.09,
        np_age >= 55 & np_age < 60 & np_education > 12 ~ (np_tmtb - 68.74) / 21.02,
        
        np_age >= 60 & np_age < 65 & np_education <= 12 ~ (np_tmtb - 74.55) / 19.55,
        np_age >= 60 & np_age < 65 & np_education > 12 ~ (np_tmtb - 64.58) / 18.59,
        
        np_age >= 65 & np_age < 70 & np_education <= 12 ~ (np_tmtb - 91.32) / 28.89,
        np_age >= 65 & np_age < 70 & np_education > 12 ~ (np_tmtb - 67.12) / 9.31,
        
        np_age >= 70 & np_age < 75 & np_education <= 12 ~ (np_tmtb - 109.95) / 35.15,
        np_age >= 70 & np_age < 75 & np_education > 12 ~ (np_tmtb - 86.27) / 24.07,
        
        np_age >= 75 & np_age < 80 & np_education <= 12 ~ (np_tmtb - 130.61) / 45.74,
        np_age >= 75 & np_age < 80 & np_education > 12 ~ (np_tmtb - 100.68) / 44.16,
        
        np_age >= 80 & np_age < 85 & np_education <= 12 ~ (np_tmtb - 152.74) / 65.68,
        np_age >= 80 & np_age < 85 & np_education > 12 ~ (np_tmtb - 132.15) / 42.95,
        
        np_age >= 85 & np_age < 110 & np_education <= 12 ~ (np_tmtb - 167.69) / 78.50,
        np_age >= 85 & np_age < 110 & np_education > 12 ~ (np_tmtb - 140.54) / 75.38,
        
        TRUE ~ NA_real_
      ),
      np_strp_word_sscore = case_when(
        race == "White" & np_age <= 55 ~ (np_strp_word - 101.9) / 14.4,
        race == "White" & np_age > 55 ~ eligibility_stroop_word_w.lookup %>%
          filter(age == np_age & raw == np_strp_word) %>%
          pull(scaled),
        race != "White" & np_age <= 55 ~ (np_strp_word - 96.2) / 16.9,
        race != "White" & np_age > 55 ~ eligibility_stroop_word_b.lookup %>%
          filter(age == np_age & raw == np_strp_word) %>%
          pull(scaled),
        TRUE ~ NA_real_
      ),
      np_strp_color_sscore = case_when(
        race == "White" & np_age <= 55 ~ (np_strp_color - 76.4) / 10.8,
        race == "White" & np_age > 55 ~ eligibility_stroop_color_w.lookup %>%
          filter(age == np_age & raw == np_strp_color) %>%
          pull(scaled),
        race != "White" & np_age <= 55 ~ (np_strp_color - 70.8) / 13.0,
        race != "White" & np_age > 55 ~ eligibility_stroop_color_b.lookup %>%
          filter(age == np_age & raw == np_strp_color) %>%
          pull(scaled),
        TRUE ~ NA_real_
      ),
      np_strp_colorword_sscore = case_when(
        race == "White" & np_age <= 55 ~ (np_strp_colorword - 45.0) / 9.5,
        race == "White" & np_age > 55 ~ eligibility_stroop_colorword_w.lookup %>%
          filter(age == np_age & raw == np_strp_colorword) %>%
          pull(scaled),
        race != "White" & np_age <= 55 ~ (np_strp_colorword - 38.2) / 10.2,
        race != "White" & np_age > 55 ~ eligibility_stroop_colorword_b.lookup %>%
          filter(age == np_age & raw == np_strp_colorword) %>%
          pull(scaled),
        TRUE ~ NA_real_
      ),
      np_cfl = sum(c(np_cfl_c, np_cfl_f, np_cfl_l)),
      np_cfl_sscore = case_when(
        race == "White" & np_age <= 55 ~ (np_cfl - 45.31) / 12.96,
        race == "White" & np_age > 55 ~ eligibility_cowa_w.lookup %>% 
          filter(age == np_age & raw == np_cfl) %>% 
          pull(scaled),
        race != "White" & np_age <= 55 ~ (np_cfl - 45.31) / 12.96,
        race != "White" & np_age > 55 ~ eligibility_cowa_b.lookup %>% 
          filter(age == np_age & raw == np_cfl) %>% 
          pull(scaled),
        TRUE ~ NA_real_
      )
    ) %>% 
    ungroup %>%
    as.data.frame()
  
  return(np.df)
}

# cdr_score.interpretation = case_when( # variable?
#   cdr_score == 0 ~ "No Dementia",
#   cdr_score == 0.5 ~ "MCI",
#   cdr_score == 1 ~ "Mild Dementia",
#   cdr_score == 2 ~ "Moderate Dementia",
#   cdr_score == 3 ~ "Severe Dementia",
#   TRUE = "ERROR"
# ),



# ,
# np_gds.interpretation = case_when( # variable?
#   np_gds < 0 ~ "ERROR",
#   np_gds < 10 ~ "Normal",
#   np_gds < 20 ~ "Mildly Depressed",
#   np_gds < 31 ~ "Severely Depressed",
#   TRUE ~ "ERROR"
# )
