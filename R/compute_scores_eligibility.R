compute_scores_eligibility <- function(data, map_id = NULL) {
  if (is.null(map_id)) {
    np.df <- data[, c(np.var, "epoch")]
  } else {
    np.df <- data[data$map_id == map_id, c(np.var, "epoch")]
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
  
  np_age <- age
  np_education <- education
  
  np.df <- np.df %>%
    mutate(
      np_moca.interpretation = case_when(
        np_moca < 0 ~ "ERROR",
        np_moca < 23 ~ "Impaired",
        np_moca < 27 ~ "Borderline",
        np_moca < 31 ~ "Normal",
        TRUE ~ "ERROR"
      ),
      cdr_score.interpretation = case_when(
        cdr_score == 0 ~ "No Dementia",
        cdr_score == 0.5 ~ "MCI",
        cdr_score == 1 ~ "Mild Dementia",
        cdr_score == 2 ~ "Moderate Dementia",
        cdr_score == 3 ~ "Severe Dementia",
        TRUE = "ERROR"
      ),
      np_srt_immed_recall_total = rowSums(.[c("np_srt_1", "np_srt_2", "np_srt_3", "np_srt_4", "np_srt_5", "np_srt_6")]),
      np_srt_immed_recall_total_z = case_when(
        np_age >= 50 & np_age < 60 ~ (np_srt_immed_recall_total - 53.13) / 5.99,
        np_age >= 60 & np_age < 70 ~ (np_srt_immed_recall_total - 39.8) / 10.3,
        np_age >= 70 & np_age < 80 ~ (np_srt_immed_recall_total - 53.13) / 5.99,
      ),
      np_srt_long_delay_free_z = ">??",
      np_srt_intrusions_z = "???",
      np_bvrt_total_score_z = eligibility_benton.lookup %>% 
        filter(age == np_age & raw == np_bvrt_total_score) %>% 
        pull(scaled),
      np_digits_total = rowSums(.[c("np_digits_fwd", "np_digits_back")]),
      np_digits_total_ss = eligibility_digit_span.lookup %>% 
        filter(age == np_age & raw == np_digits_total) %>% 
        pull(scaled),
      np_digits_fwd_span_ss = case_when( # new variable
        np_age >= 60 & np_age < 65 ~ (np_digits_fwd_span - 6.35) / 1.45,
        np_age >= 65 & np_age < 70 ~ (np_digits_fwd_span - 6.28) / 1.42,
        np_age >= 70 & np_age < 75 ~ (np_digits_fwd_span - 6.14) / 1.39,
        np_age >= 75 & np_age < 80 ~ (np_digits_fwd_span - 6.06) / 1.26,
        np_age >= 80 & np_age < 85 ~ (np_digits_fwd_span - 5.89) / 1.26,
        np_age >= 85 ~ (np_digits_fwd_span - 6.43) / 1.36,
        TRUE ~ NA_real_
      ),
      np_digits_back_span_ss = case_when( # new variable
        np_age >= 60 & np_age < 65 ~ (np_digits_back_span - 4.55) / 1.56,
        np_age >= 65 & np_age < 70 ~ (np_digits_back_span - 4.48) / 1.44,
        np_age >= 70 & np_age < 75 ~ (np_digits_back_span - 4.4) / 1.16,
        np_age >= 75 & np_age < 80 ~ (np_digits_back_span - 4.31) / 1.17,
        np_age >= 80 & np_age < 85 ~ (np_digits_back_span - 4.25) / 1.03,
        np_age >= 85 ~ (np_digits_back_span - 4.1) / 1.05
        TRUE ~ NA_real_
      ),
      np_rey_total = np_rey_recall + (np_rey_recognition_hits - np_rey_recognition_false_positives), # new variable
      np_rey_recognition_score = np_rey_recognition_hits - np_rey_recognition_false_positives, # new variable
      np_wrat_score_ss = eligibility_wrat_std.lookup %>% 
        filter(age == np_age & raw == np_wrat_score) %>% 
        pull(scaled),
      np_wrat_grade = eligibility_wrat_edu.lookup %>% 
        filter(age == np_age & raw == np_wrat_score) %>% 
        pull(scaled),
      np_blockdesign_ss = eligibility_block_design.lookup %>% 
        filter(age == np_age & raw == "???") %>% 
        pull(scaled),
      np_bnt_z = case_when(
        sex = "Male" ~ (np_bnt - (25.49287807 + (0.61686473*1) + (-0.05142736*np_age) + (0.33669818*np_education))) / 2.992948
        sex = "Female" ~ (np_bnt - (25.49287807 + (0.61686473*2) + (-0.05142736*np_age) + (0.33669818*np_education))) / 2.992948,
        TRUE ~ NA_real_
      ),
      np_vegetables_total_z = case_when(
        sex = "Male" & np_age >= 50 & np_age < 60 ~ (np_vegetables_total - 11.7) / 1.7,
        sex = "Male" & np_age >= 60 & np_age < 70 ~ (np_vegetables_total - 11.8) / 2.8,
        sex = "Male" & np_age >= 70 & np_age < 110 ~ (np_vegetables_total - 12) / 3,
        sex = "Female" & np_age >= 50 & np_age < 60 ~ (np_vegetables_total - 17) / 3.8,
        sex = "Female" & np_age >= 60 & np_age < 70 ~ (np_vegetables_total - 15.4) / 3.8,
        sex = "Female" & np_age >= 70 & np_age < 110 ~ (np_vegetables_total - 14.2) / 3.5,
        TRUE ~ NA_real_
      ),
      np_tmt_a_ss_moans = case_when(
        race == "White" ~ eligibility_trails_a_w.lookup %>% 
          filter(age == np_age & raw == np_tmt_a_time) %>% 
          pull(scaled),
        race != "White" ~ eligibility_trails_a_b.lookup %>% 
          filter(age == np_age & raw == np_tmt_a_time) %>% 
          pull(scaled),
        TRUE ~ NA_integer_
      ),
      np_tmt_b_ss_moans = case_when(
        race == "White" ~ eligibility_trails_b_w.lookup %>% 
          filter(age == np_age & raw == np_tmt_b_time) %>% 
          pull(scaled),
        race != "White" ~ eligibility_trails_b_b.lookup %>% 
          filter(age == np_age & raw == np_tmt_b_time) %>% 
          pull(scaled),
        TRUE ~ NA_integer_
      ),
      np_tmt_a_ss_tnt = case_when(
        np_age >= 50 & np_age < 55 & np_education <= 12 ~ (np_tmt_a_time - 31.78) / 9.93, # check education cutoff w/ Katie because the Excel file has <=12 and >13
        np_age >= 50 & np_age < 55 & np_education > 12 ~ (np_tmt_a_time - 31.78) / 9.93,
        
        np_age >= 55 & np_age < 60 & np_education <= 12 ~ (np_tmt_a_time - 35.10) / 10.94,
        np_age >= 55 & np_age < 60 & np_education > 12 ~ (np_tmt_a_time - 31.72) / 10.14,
        
        np_age >= 60 & np_age < 65 & np_education <= 12 ~ (np_tmt_a_time - 33.22) / 9.10,
        np_age >= 60 & np_age < 65 & np_education > 12 ~ (np_tmt_a_time - 31.32) / 6.96,
        
        np_age >= 65 & np_age < 70 & np_education <= 12 ~ (np_tmt_a_time - 39.14) / 11.84,
        np_age >= 65 & np_age < 70 & np_education > 12 ~ (np_tmt_a_time - 33.84) / 6.69,
        
        np_age >= 70 & np_age < 75 & np_education <= 12 ~ (np_tmt_a_time - 42.47) / 15.15,
        np_age >= 70 & np_age < 75 & np_education > 12 ~ (np_tmt_a_time - 40.13) / 14.48,
        
        np_age >= 75 & np_age < 80 & np_education <= 12 ~ (np_tmt_a_time - 50.81) / 17.44,
        np_age >= 75 & np_age < 80 & np_education > 12 ~ (np_tmt_a_time - 41.75) / 15.32,
        
        np_age >= 80 & np_age < 85 & np_education <= 12 ~ (np_tmt_a_time - 58.19) / 23.31,
        np_age >= 80 & np_age < 85 & np_education > 12 ~ (np_tmt_a_time - 55.32) / 21.28,
        
        np_age >= 85 & np_age < 110 & np_education <= 12 ~ (np_tmt_a_time - 57.56) / 21.54,
        np_age >= 85 & np_age < 110 & np_education > 12 ~ (np_tmt_a_time - 63.46) / 29.22, # check. the subtracted mean is higher than the one for lower education. does not match other calculations
        
        TRUE ~ NA_real_
      ),
      
      np_tmt_b_ss_tnt = case_when(
        np_age >= 50 & np_age < 55 & np_education <= 12 ~ (np_tmt_b_time - 63.76) / 14.42, # check education cutoff w/ Katie because the Excel file has <=12 and >13
        np_age >= 50 & np_age < 55 & np_education > 12 ~ (np_tmt_b_time - 63.76) / 14.42,
        
        np_age >= 55 & np_age < 60 & np_education <= 12 ~ (np_tmt_b_time - 78.84) / 19.09,
        np_age >= 55 & np_age < 60 & np_education > 12 ~ (np_tmt_b_time - 68.74) / 21.02,
        
        np_age >= 60 & np_age < 65 & np_education <= 12 ~ (np_tmt_b_time - 74.55) / 19.55,
        np_age >= 60 & np_age < 65 & np_education > 12 ~ (np_tmt_b_time - 64.58) / 18.59,
        
        np_age >= 65 & np_age < 70 & np_education <= 12 ~ (np_tmt_b_time - 91.32) / 28.89,
        np_age >= 65 & np_age < 70 & np_education > 12 ~ (np_tmt_b_time - 67.12) / 9.31,
        
        np_age >= 70 & np_age < 75 & np_education <= 12 ~ (np_tmt_b_time - 109.95) / 35.15,
        np_age >= 70 & np_age < 75 & np_education > 12 ~ (np_tmt_b_time - 86.27) / 24.07,
        
        np_age >= 75 & np_age < 80 & np_education <= 12 ~ (np_tmt_b_time - 130.61) / 45.74,
        np_age >= 75 & np_age < 80 & np_education > 12 ~ (np_tmt_b_time - 100.68) / 44.16,
        
        np_age >= 80 & np_age < 85 & np_education <= 12 ~ (np_tmt_b_time - 152.74) / 65.68,
        np_age >= 80 & np_age < 85 & np_education > 12 ~ (np_tmt_b_time - 132.15) / 42.95,
        
        np_age >= 85 & np_age < 110 & np_education <= 12 ~ (np_tmt_b_time - 167.69) / 78.50,
        np_age >= 85 & np_age < 110 & np_education > 12 ~ (np_tmt_b_time - 140.54) / 75.38,
        
        TRUE ~ NA_real_
      ),
      np_stroop_word_ss = case_when(
        race == "White" & age <= 55 ~ (np_stroop_word - 101.9) / 14.4,
        race == "White" & age > 55 ~ eligibility_stroop_word_w.lookup %>% 
          filter(age == np_age & raw == np_stroop_word) %>% 
          pull(scaled),
        race != "White" & age <= 55 ~ (np_stroop_word - 96.2) / 16.9,
        race != "White" & age > 55 ~ eligibility_stroop_word_b.lookup %>% 
          filter(age == np_age & raw == np_stroop_word) %>% 
          pull(scaled),
        TRUE ~ NA_real_
      ),
      np_stroop_color_ss = case_when(
        race == "White" & age <= 55 ~ (np_stroop_color - 76.4) / 10.8,
        race == "White" & age > 55 ~ eligibility_stroop_color_w.lookup %>% 
          filter(age == np_age & raw == np_stroop_color) %>% 
          pull(scaled),
        race != "White" & age <= 55 ~ (np_stroop_color - 70.8) / 13.0,
        race != "White" & age > 55 ~ eligibility_stroop_color_b.lookup %>% 
          filter(age == np_age & raw == np_stroop_color) %>% 
          pull(scaled),
        TRUE ~ NA_real_
      ),
      np_stroop_colorword_ss = case_when(
        race == "White" & age <= 55 ~ (np_stroop_colorword - 45.0) / 9.5,
        race == "White" & age > 55 ~ eligibility_stroop_colorword_w.lookup %>% 
          filter(age == np_age & raw == np_stroop_colorword) %>% 
          pull(scaled),
        race != "White" & age <= 55 ~ (np_stroop_colorword - 38.2) / 10.2,
        race != "White" & age > 55 ~ eligibility_stroop_colorword_b.lookup %>% 
          filter(age == np_age & raw == np_stroop_colorword) %>% 
          pull(scaled),
        TRUE ~ NA_real_
      ),
      np_cfl_total = "???",
      np_cfl_total_ss = case_when(
        race == "White" & age <= 55 ~ (np_cfl_total - 45.31) / 12.96
        race == "White" & age > 55 ~ eligibility_cowa_w.lookup %>% 
          filter(age == np_age & raw == np_cfl_total) %>% 
          pull(scaled),
        race != "White" & age <= 55 ~ (np_cfl_total - 45.31) / 12.96
        race != "White" & age > 55 ~ eligibility_cowa_b.lookup %>% 
          filter(age == np_age & raw == np_cfl_total) %>% 
          pull(scaled),
        TRUE ~ NA_real_
      ),
      np_gds.interpretation = case_when(
        np_gds < 0 ~ "ERROR",
        np_gds < 10 ~ "Normal",
        np_gds < 20 ~ "Mildly Depressed",
        np_gds < 31 ~ "Severely Depressed",
        TRUE ~ "ERROR"
      )
    )
  
  return(np.df)
}
