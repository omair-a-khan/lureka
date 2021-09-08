generate_tables <- function(np.df) {
  tables.list <- list(
    metadata.df = tibble::tribble(
      ~ item, ~ value,
      "Epoch", "Eligibility",
      "MAP ID", NA,
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
      "Eligibility", NA, as.character(np.df$vmac_id), as.character(np.df$np_date), as.character(np.df$np_examiner),
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
      "Trial 1", np.df$np_srt1, NA,
      "Trial 2", np.df$np_srt2, NA,
      "Trial 3", np.df$np_srt3, NA,
      "Trial 4", np.df$np_srt4, NA,
      "Trial 5", np.df$np_srt5, NA,
      "Immediate Free Recall", np.df$np_srt_immed, np.df$np_srt_immed_zscore,
      "Cued Recall", np.df$np_srt_sdcr, NA,
      "Delayed Recall",	np.df$np_srt_ldfr, np.df$np_srt_ldfr_zscore,
      "Delayed Recognition", np.df$np_srt_recog, np.df$np_srt_recog_zscore,
      "Intrusions",	np.df$np_srt_intrus, np.df$np_srt_intrus_zscore,
      "Repetitions", np.df$np_srt_reps, NA
    ),
    
    bvrt.df = tibble::tribble(
      ~ item, ~ score, ~ scaled_score,
      "Total Recall",	np.df$np_bvrt, np.df$np_bvrt_zscore,
      "Errors", np.df$np_bvrt_err, NA
    ),
    
    digit_span.df = tibble::tribble(
      ~ item, ~ score, ~ scaled_score,
      "Forward Total", np.df$np_digitsf, NA,
      "Backward Total", np.df$np_digitsb, NA,
      "Digit Span Total", np.df$np_digits, np.df$np_digits_sscore,
      "Forward Span", np.df$np_digitsf_span, np.df$np_digitsf_span_zscore,
      "Backward Span", np.df$np_digitsb_span, np.df$np_digitsb_span_zscore
    ),
    
    rey15.df = tibble::tribble(
      ~ item, ~ score,
      "Recall - Correct", np.df$np_rey_recall,
      "Recognition - Correct", np.df$np_rey_hits, 
      "Recognition - False Postives", np.df$np_rey_falsepos,
      "Total", np.df$np_rey,
      "Rey Recognition Combination Score", np.df$np_rey_recog
    ),
    
    wrat3_reading.df = tibble::tribble(
      ~ item, ~ score, ~ scaled_score, ~ grade,
      "Total", np.df$np_wrat, np.df$np_wrat_sscore, np.df$np_wrat_grade
    ),
    
    block_design.df = tibble::tribble(
      ~ item, ~ score, ~ scaled_score,
      "Total", np.df$np_blocks, np.df$np_blocks_sscore
    ),
    
    bnt.df = tibble::tribble(
      ~ item, ~ score, ~ scaled_score,
      "Total", np.df$np_bnt, np.df$np_bnt_zscore
    ),
    
    vegetables.df = tibble::tribble(
      ~ item, ~ score, ~ scaled_score,
      "Total", np.df$np_veg, np.df$np_veg_zscore
    ),
    
    trail.df = tibble::tribble(
      ~ item, ~ score, ~ scaled_score,
      "TMT-A Time (MOANS)", np.df$np_tmta, np.df$np_tmta_moans_sscore,
      "TMT-A Time (TNT)", np.df$np_tmta, np.df$np_tmta_tnt_sscore,
      "TMT-A Sequencing Errors", np.df$np_tmta_seqerr, NA,
      "TMT-A Set-Loss Errors", np.df$np_tmta_seterr, NA,
      "TMT-B Time (MOANS)", np.df$np_tmtb, np.df$np_tmtb_moans_sscore,
      "TMT-B Time (TNT)", np.df$np_tmtb, np.df$np_tmtb_tnt_sscore,
      "TMT-B Sequencing Errors", np.df$np_tmtb_seqerr, NA,
      "TMT-B Set-Loss Errors", np.df$np_tmtb_seterr, NA
    ),
    
    stroop.df = tibble::tribble(
      ~ item, ~ score, ~ scaled_score,
      "Word Reading", np.df$np_strp_word, np.df$np_strp_word_sscore,
      "Color Naming", np.df$np_strp_color, np.df$np_strp_color_sscore,
      "Color-Word Reading", np.df$np_strp_colorword, np.df$np_strp_colorword_sscore
    ),
    
    cowa.df = tibble::tribble(
      ~ item, ~ score, ~ scaled_score,
      "C - Total Words", np.df$np_cfl_c, NA,
      "F - Total Words", np.df$np_cfl_f, NA,
      "L - Total Words", np.df$np_cfl_l, NA,
      "Total CFL Words", np.df$np_cfl, np.df$np_cfl_sscore,
      "Total Intrusions", np.df$np_cfl_intrus, NA,
      "Total Repetitions", np.df$np_cfl_reps, NA
    ),
    
    faq.df = tibble::tribble(
      ~ item, ~ score, ~ interpretation,
      "Total", np.df$faq, NA # variable?
    ),
    
    gds.df = tibble::tribble(
      ~ item, ~ score, ~ interpretation,
      "Total", np.df$np_gds, np.df$np_gds.interpretation
    )
  )
  
  return(tables.list)
}
