generate_tables_eligibility <- function(np.df) {
  tables.list <- list(
    metadata.df = tibble::tribble(
      ~ item, ~ value,
      "Epoch", as.character(np.df$epoch),
      "MAP ID", as.character(np.df$map_id),
      "VMAC ID", as.character(np.df$vmac_id),
      "Age", as.character(np.df$age),
      "Sex", as.character(np.df$sex),
      "Education", as.character(np.df$education),
      "Race", as.character(np.df$race),
      "Ethnicity", as.character(np.df$ethnicity),
      "Testing Date", as.character(np.df$np_date),
      "Examiner", as.character(np.df$np_examiner)
    ),
    
    metadata_wide.df = tibble::tribble(
      ~ a, ~ b, ~ c, ~ d, ~ e,
      "Epoch", "MAP ID", "VMAC ID", "Testing Date", "Examiner",
      as.character(np.df$epoch), as.character(np.df$map_id), as.character(np.df$vmac_id), as.character(np.df$np_date), as.character(np.df$np_examiner),
      "Age", "Sex", "Education", "Race", "Ethnicity",
      as.character(np.df$age), as.character(np.df$sex), as.character(np.df$education), as.character(np.df$race), as.character(np.df$ethnicity)
    ),
    
    moca.df = tibble::tribble(
      ~ item, ~ score, ~ interpretation,
      "Total", np.df$np_moca, np.df$np_moca.interpretation
    ),
    
    cdr.df = tibble::tribble(
      ~ item, ~ score, ~ interpretation,
      "Total", np.df$cdr_score, np.df$cdr_score.interpretation,
      "Sum of Scores", np.df$cdr_sum, NA
    ),
    
    srt.df = tibble::tribble(
      ~ item, ~ score, ~ scaled_score,
      "Trial 1", np.df$np_srt_1, NA,
      "Trial 2", np.df$np_srt_2, NA,
      "Trial 3", np.df$np_srt_3, NA,
      "Trial 4", np.df$np_srt_4, NA,
      "Trial 5", np.df$np_srt_5, NA,
      "Immediate Free Recall", np.df$np_srt_immed_recall_total, np.df$np_srt_immed_recall_total_z,
      "Cued Recall", np.df$np_srt_short_delay_cued, NA,
      "Delayed Recall",	np.df$np_srt_long_delay_free, np.df$np_srt_long_delay_free_z,
      "Delayed Recognition", np.df$np_srt_long_delay_recognition, np.df$np_srt_long_delay_recognition_z,
      "Intrusions",	np.df$np_srt_intrusions, np.df$np_srt_intrusions_z,
      "Repetitions", np.df$np_srt_repetitions, NA
    ),
    
    bvrt.df = tibble::tribble(
      ~ item, ~ score, ~ scaled_score,
      "Total Recall",	np.df$np_bvrt_total_score, np.df$np_bvrt_total_score_z,
      "Errors", np.df$np_bvrt_total_errors, NA
    ),
    
    digit_span.df = tibble::tribble(
      ~ item, ~ score, ~ scaled_score,
      "Forward Total", np.df$np_digits_fwd, NA,
      "Backward Total", np.df$np_digits_back, NA,
      "Digit Span Total", np.df$np_digits_total, np.df$np_digits_total_ss,
      "Forward Span", np.df$np_digits_fwd_span, np.df$np_digits_fwd_span_ss,
      "Backward Span", np.df$np_digits_back_span, np.df$np_digits_back_span_ss
    ),
    
    rey15.df = tibble::tribble(
      ~ item, ~ score,
      "Recall - Correct", np.df$np_rey_recall,
      "Recognition - Correct", np.df$np_rey_recognition_hits,
      "Recognition - False Postives", np.df$np_rey_recognition_false_positives,
      "Total", np.df$np_rey_total,
      "Rey Recognition Combination Score", np.df$np_rey_recognition_score
    ),
    
    wrat3_reading.df = tibble::tribble(
      ~ item, ~ score, ~ scaled_score, ~ grade,
      "Total", np.df$np_wrat_score, np.df$np_wrat_score_ss, np.df$np_wrat_grade
    ),
    
    block_design.df = tibble::tribble(
      ~ item, ~ score, ~ scaled_score,
      "Total", "???", np.df$np_blockdesign_ss
    ),
    
    bnt.df = tibble::tribble(
      ~ item, ~ score, ~ scaled_score,
      "Total", np.df$np_bnt, np.df$np_bnt_z
    ),
    
    vegetables.df = tibble::tribble(
      ~ item, ~ score, ~ scaled_score,
      "Total", np.df$np_vegetables_total, np.df$np_vegetables_total_z
    ),
    
    trail.df = tibble::tribble(
      ~ item, ~ score, ~ scaled_score,
      "TMT-A Time (MOANS)", np.df$np_tmt_a_time, np.df$np_tmt_a_ss_moans,
      "TMT-A Time (TNT)", np.df$np_tmt_a_time, np.df$np_tmt_a_ss_tnt,
      "TMT-A Sequencing Errors", np.df$np_tmt_a_errors_sequencing, NA,
      "TMT-A Set-Loss Errors", np.df$np_tmt_a_errors_setloss, NA,
      "TMT-B Time (MOANS)", np.df$np_tmt_b_time, np.df$np_tmt_b_ss_moans,
      "TMT-B Time (TNT)", np.df$np_tmt_b_time, np.df$np_tmt_b_ss_tnt,
      "TMT-B Sequencing Errors", np.df$np_tmt_b_errors_sequencing, NA,
      "TMT-B Set-Loss Errors", np.df$np_tmt_b_errors_setloss, NA
    ),
    
    stroop.df = tibble::tribble(
      ~ item, ~ score, ~ scaled_score,
      "Word Reading", np.df$np_stroop_word, np.df$np_stroop_word_ss,
      "Color Naming", np.df$np_stroop_color, np.df$np_stroop_color_ss,
      "Color-Word Reading", np.df$np_stroop_colorword, np.df$np_stroop_colorword_ss
    ),
    
    cowa.df = tibble::tribble(
      ~ item, ~ score, ~ scaled_score,
      "C - Total Words", NA, NA,
      "F - Total Words", NA, NA,
      "L - Total Words", NA, NA,
      "Total CFL Words", np.df$np_cfl_total, np.df$np_cfl_total_ss,
      "Total Intrusions", np.df$np_cfl_total_intrusions, NA,
      "Total Repetitions", np.df$np_cfl_total_repetitions, NA
    ),
    
    faq.df = tibble::tribble(
      ~ item, ~ score, ~ interpretation,
      "Total", np.df$faq_total, NA
    ),
    
    gds.df = tibble::tribble(
      ~ item, ~ score, ~ interpretation,
      "Total", np.df$np_gds_total, np.df$np_gds.interpretation
    )
  )
  
  return(tables.list)
}
