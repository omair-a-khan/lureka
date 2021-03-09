generate_tables <- function(np.df) {
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
    
    cvlt.df = tibble::tribble(
      ~ item, ~ score, ~ scaled_score,
      "Trial 1", np.df$np_cvlt1, np.df$np_cvlt1z,
      "Trial 2", np.df$np_cvlt2, np.df$np_cvlt2z,
      "Trial 3", np.df$np_cvlt3, np.df$np_cvlt3z,
      "Trial 4", np.df$np_cvlt4, np.df$np_cvlt4z,
      "Trial 5", np.df$np_cvlt5, np.df$np_cvlt5z,
      "Total T1-T5", np.df$np_cvlt1to5, np.df$np_cvlt1to5_tscore,
      "List B", np.df$np_cvltb, np.df$np_cvltbz,
      "Short Delay Free Recall", np.df$np_cvlt_sdfr, np.df$np_cvlt_sdfr_z,
      "Short Delay Cued Recall", np.df$np_cvlt_sdcr, np.df$np_cvlt_sdcr_z,
      "Long Delay Free Recall", np.df$np_cvlt_ldfr, np.df$np_cvlt_ldfr_z,
      "Long Delay Cued Recall", np.df$np_cvlt_ldcr, np.df$np_cvlt_ldcr_z,
      "Total Recognition Hits", np.df$np_cvltrec_hits, np.df$np_cvltrec_hits_z,
      "Total False Positives", np.df$np_cvltrec_falsepos, np.df$np_cvltrecog_falsepos_z,
      "Total Repetitions", np.df$np_cvlt_reps, np.df$np_cvlt_reps_z,
      "Total Intrusions", np.df$np_cvlt_intrus, np.df$np_cvlt_intrus_z
    ),
    
    biber.df = tibble::tribble(
      ~ item, ~ score, ~ scaled_score,
      "Trial 1", np.df$np_biber1, np.df$np_biber1.scaled,
      "Trial 2", np.df$np_biber2, np.df$np_biber2.scaled,
      "Trial 3", np.df$np_biber3, np.df$np_biber3.scaled,
      "Trial 4", np.df$np_biber4, np.df$np_biber4.scaled,
      "Trial 5", np.df$np_biber5, np.df$np_biber5.scaled,
      "Total T1-T5", np.df$np_biber_t1to5, np.df$np_biber_t1to5.scaled,
      "Distractor Set", np.df$np_biberb, np.df$np_biberb.scaled,
      "Immediate Recall", np.df$np_biber_sd, np.df$np_biber_sd.scaled,
      "Delayed Recall", np.df$np_biber_ld, np.df$np_biber_ld.scaled,
      "Recognition - Hits", np.df$np_biber_hits, NA,
      "Recognition - Total False Alarm", np.df$np_biber_falsealarms, NA,
      "Total Perseverations", np.df$np_biber_t1to5_persev, NA,
      "Total Extraneous Responses", np.df$np_biber_t1to5_extra, NA
    ),
    
    bnt.df = tibble::tribble(
      ~ item, ~ score, ~ scaled_score,
      "Total", np.df$np_bnt, np.df$np_bnt.scaled
    ),
    
    animals.df = tibble::tribble(
      ~ item, ~ score, ~ scaled_score,
      "Total", np.df$np_anim, np.df$np_anim_tscore
    ),
    
    gds.df = tibble::tribble(
      ~ item, ~ score, ~ interpretation,
      "Total", np.df$np_gds, np.df$np_gds.interpretation
    ),
    
    hvot.df = tibble::tribble(
      ~ item, ~ score, ~ scaled_score,
      "Total", np.df$np_hvot, np.df$np_hvot.scaled
    ),
    
    dkefs_trail.df = tibble::tribble(
      ~ item, ~ score, ~ scaled_score,
      "Number Sequencing: Time", np.df$np_tmta, np.df$np_tmta.scaled,
      "Number Sequencing: Errors (%)", np.df$np_tmta_seqerr, np.df$np_tmta_seqerr.scaled,
      "Number Sequencing: Set-Loss Errors (%)", np.df$np_tmta_seterr, np.df$np_tmta_seterr.scaled,
      "Number-Letter: Time", np.df$np_tmtb, np.df$np_tmtb.scaled,
      "Number-Letter: Sequencing Errors (%)", np.df$np_tmtb_seqerr, np.df$np_tmtb_seqerr.scaled,
      "Number-Letter: Set-Loss Errors (%)", np.df$np_tmtb_seterr, np.df$np_tmtb_seterr.scaled
    ),
    
    dkefs_color.df = tibble::tribble(
      ~ item, ~ score, ~ scaled_score,
      "Color Naming Time", np.df$np_color, np.df$np_color.scaled,
      "Word Reading Time", np.df$np_word, np.df$np_word.scaled,
      "Inhibition Time", np.df$np_inhibit, np.df$np_inhibit.scaled
    ),
    
    cowa.df = tibble::tribble(
      ~ item, ~ score, ~ scaled_score,
      "F - Total Words", np.df$np_fas_f, NA,
      "A - Total Words", np.df$np_fas_a, NA,
      "S - Total Words", np.df$np_fas_s, NA,
      "Total FAS Words", np.df$np_fas, np.df$np_fas_tscore,
      "Total Intrusions", np.df$np_fas_intrus, NA,
      "Total Repetitions", np.df$np_fas_rep, NA
    ),
    
    tower.df = tibble::tribble(
      ~ item, ~ score, ~ scaled_score_chr,
      "Achievement Score", np.df$np_tower, as.character(np.df$np_tower.scaled),
      "Total Rule Violations (%)", np.df$np_tower_ruleviol, as.character(np.df$np_tower_ruleviol.scaled)
    ),
    
    digit_symbol.df = tibble::tribble(
      ~ item, ~ score, ~ scaled_score,
      "Total", np.df$np_digsymb, np.df$np_digsymb.scaled
    ),
    
    mc1.df = tibble::tribble(
      ~ item, ~ time, ~ omissions, ~ false_positives, ~ accuracy_index,
      "Item 1", np.df$np_mc1_time, np.df$np_mc1_omissions, np.df$np_mc1_falsepos, np.df$np_mc1.accuracy.index,
      "Item 2", np.df$np_mc2_time, np.df$np_mc2_omissions, np.df$np_mc2_falsepos, np.df$np_mc2.accuracy.index,
      "Item 3", np.df$np_mc3_time, np.df$np_mc3_omissions, np.df$np_mc3_falsepos, np.df$np_mc3.accuracy.index,
      "Item 4", np.df$np_mc4_time, np.df$np_mc4_omissions, np.df$np_mc4_falsepos, np.df$np_mc4.accuracy.index,
      "Item 5", np.df$np_mc5_time, np.df$np_mc5_omissions, np.df$np_mc5_falsepos, np.df$np_mc5.accuracy.index,
      "Item 6", np.df$np_mc6_time, np.df$np_mc6_omissions, np.df$np_mc6_falsepos, np.df$np_mc6.accuracy.index,
      "Item 7", np.df$np_mc7_time, np.df$np_mc7_omissions, np.df$np_mc7_falsepos, np.df$np_mc7.accuracy.index,
      "Item 8", np.df$np_mc8_time, np.df$np_mc8_omissions, np.df$np_mc8_falsepos, np.df$np_mc8.accuracy.index
    ),
    
    mc2.df = tibble::tribble(
      ~ item, ~ score, ~ scaled_score_chr,
      "Item 1-3 Total Score", np.df$np_mc1_3.total, NA,
      "Automatized MC", np.df$np_mc_auto_mc.accuracy.index, NA,
      "Non-Automatized MC", np.df$np_mc_nonauto_mc.accuracy.index, NA,
      "Kaplan", np.df$np_mc_kaplan, np.df$np_mc_kaplan_ss
    ),
    
    symbol_span.df = tibble::tribble(
      ~ item, ~ score, ~ scaled_score,
      "Total Raw Score", np.df$np_symbol, np.df$np_symbol.scaled,
      "# Correct Trials", np.df$np_symbol_trials, NA
    )
  )
  
  return(tables.list)
}
