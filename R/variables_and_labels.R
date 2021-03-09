# =========================================================================
# all neuropsych variables

np.var <- c(
  "map_id",
  "vmac_id",
  "age",
  "education",
  "np_date",
  "np_examiner",
  "ethnicity",
  "race",
  "sex",
  "np_notes",
  "np_moca",
  "np_cvlt1",
  "np_cvlt2",
  "np_cvlt3",
  "np_cvlt4",
  "np_cvlt5",
  "np_cvlt1z",
  "np_cvlt2z",
  "np_cvlt3z",
  "np_cvlt4z",
  "np_cvlt5z",
  "np_cvlt1to5",
  "np_cvlt1to5_tscore",
  "np_cvltb",
  "np_cvlt_sdfr",
  "np_cvlt_sdcr",
  "np_cvlt_ldfr",
  "np_cvlt_ldcr",
  "np_cvltrec_hits",
  "np_cvltrec_falsepos",
  "np_cvlt_reps",
  "np_cvlt_intrus",
  "np_cvltbz",
  "np_cvlt_sdfr_z",
  "np_cvlt_sdcr_z",
  "np_cvlt_ldfr_z",
  "np_cvlt_ldcr_z",
  "np_cvltrec_hits_z",
  "np_cvltrecog_falsepos_z",
  "np_cvlt_reps_z",
  "np_cvlt_intrus_z",
  "np_biber1",
  "np_biber2",
  "np_biber3",
  "np_biber4",
  "np_biber5",
  "np_biberb",
  "np_biber_sd",
  "np_biber_ld",
  "np_biber_hits",
  "np_biber_falsealarms",
  "np_biber_t1to5_persev",
  "np_biber_t1to5_extra",
  "np_bnt",
  "np_anim_tscore",
  "np_hvot",
  "np_tmta",
  "np_tmta_seqerr",
  "np_tmta_seterr",
  "np_tmtb",
  "np_tmtb_seqerr",
  "np_tmtb_seterr",
  "np_color",
  "np_word",
  "np_inhibit",
  "np_fas_f",
  "np_fas_a",
  "np_fas_s",
  "np_fas_tscore",
  "np_fas_intrus",
  "np_fas_rep",
  "np_tower_ruleviol",
  "np_digsymb",
  "np_mc1_time",
  "np_mc2_time",
  "np_mc3_time",
  "np_mc4_time",
  "np_mc5_time",
  "np_mc6_time",
  "np_mc7_time",
  "np_mc8_time",
  "np_mc1_omissions",
  "np_mc2_omissions",
  "np_mc3_omissions",
  "np_mc4_omissions",
  "np_mc5_omissions",
  "np_mc6_omissions",
  "np_mc7_omissions",
  "np_mc8_omissions",
  "np_mc1_falsepos",
  "np_mc2_falsepos",
  "np_mc3_falsepos",
  "np_mc4_falsepos",
  "np_mc5_falsepos",
  "np_mc6_falsepos",
  "np_mc7_falsepos",
  "np_mc8_falsepos",
  "np_mc_kaplan",
  "np_mc_kaplan_ss",
  "np_symbol",
  "np_symbol_trials"
)

np.var <- c(
  np.var,
  paste0("np_anim_q", 1:4),
  paste0("gds", 1:30),
  paste0("np_tower", formatC(1:9, width = 2, flag = "0"))
)

np_label.var <- c("np_examiner", "ethnicity", "race", "sex")

np_main.var <- c(
  "map_id",
  "vmac_id",
  "age",
  "education",
  "np_date",
  "np_examiner",
  "ethnicity",
  "race",
  "sex",
  "np_notes",
  "np_moca",
  "np_cvlt1",
  "np_cvlt2",
  "np_cvlt3",
  "np_cvlt4",
  "np_cvlt5",
  "np_cvlt1z",
  "np_cvlt2z",
  "np_cvlt3z",
  "np_cvlt4z",
  "np_cvlt5z",
  "np_cvlt1to5",
  "np_cvlt1to5_tscore",
  "np_cvltb",
  "np_cvlt_sdfr",
  "np_cvlt_sdcr",
  "np_cvlt_ldfr",
  "np_cvlt_ldcr",
  "np_cvltrec_hits",
  "np_cvltrec_falsepos",
  "np_cvlt_reps",
  "np_cvlt_intrus",
  "np_cvltbz",
  "np_cvlt_sdfr_z",
  "np_cvlt_sdcr_z",
  "np_cvlt_ldfr_z",
  "np_cvlt_ldcr_z",
  "np_cvltrec_hits_z",
  "np_cvltrecog_falsepos_z",
  "np_cvlt_reps_z",
  "np_cvlt_intrus_z",
  "np_biber1",
  "np_biber2",
  "np_biber3",
  "np_biber4",
  "np_biber5",
  "np_biberb",
  "np_biber_sd",
  "np_biber_ld",
  "np_biber_hits",
  "np_biber_falsealarms",
  "np_biber_t1to5_persev",
  "np_biber_t1to5_extra",
  "np_bnt",
  "np_anim_tscore",
  "np_hvot",
  "np_tmta",
  "np_tmta_seqerr",
  "np_tmta_seterr",
  "np_tmtb",
  "np_tmtb_seqerr",
  "np_tmtb_seterr",
  "np_color",
  "np_word",
  "np_inhibit",
  "np_fas_f",
  "np_fas_a",
  "np_fas_s",
  "np_fas_tscore",
  "np_fas_intrus",
  "np_fas_rep",
  "np_tower_ruleviol",
  "np_digsymb",
  "np_anim_q1",
  "np_anim_q2",
  "np_anim_q3",
  "np_anim_q4",
  "gds1",
  "gds2",
  "gds3",
  "gds4",
  "gds5",
  "gds6",
  "gds7",
  "gds8",
  "gds9",
  "gds10",
  "gds11",
  "gds12",
  "gds13",
  "gds14",
  "gds15",
  "gds16",
  "gds17",
  "gds18",
  "gds19",
  "gds20",
  "gds21",
  "gds22",
  "gds23",
  "gds24",
  "gds25",
  "gds26",
  "gds27",
  "gds28",
  "gds29",
  "gds30",
  "np_tower01",
  "np_tower02",
  "np_tower03",
  "np_tower04",
  "np_tower05",
  "np_tower06",
  "np_tower07",
  "np_tower08",
  "np_tower09"
)

np_addendum.var <- c("map_id", np.var[!np.var %in% np_main.var])

# =========================================================================
# CVLT variables and labels

cvlt.var <- c(
  "np_cvlt1z",
  "np_cvlt2z",
  "np_cvlt3z",
  "np_cvlt4z",
  "np_cvlt5z",
  "np_cvlt1to5_tscore.z",
  "np_cvltbz",
  "np_cvlt_sdfr_z",
  "np_cvlt_sdcr_z",
  "np_cvlt_ldfr_z",
  "np_cvlt_ldcr_z",
  "np_cvltrec_hits_z",
  "np_cvltrecog_falsepos_z",
  "np_cvlt_reps_z",
  "np_cvlt_intrus_z"
)

cvlt.unscaled.var <- c(
  "np_cvlt1",
  "np_cvlt2",
  "np_cvlt3",
  "np_cvlt4",
  "np_cvlt5",
  "np_cvlt1to5",
  "np_cvltb",
  "np_cvlt_sdfr",
  "np_cvlt_sdcr",
  "np_cvlt_ldfr",
  "np_cvlt_ldcr",
  "np_cvltrec_hits",
  "np_cvltrec_falsepos",
  "np_cvlt_reps",
  "np_cvlt_intrus"
)

cvlt_learning.var <- c(
  "np_cvlt1z", 
  "np_cvlt2z", 
  "np_cvlt3z", 
  "np_cvlt4z", 
  "np_cvlt5z", 
  "np_cvlt1to5_tscore.z", 
  "np_cvltbz"
)

cvlt_recall.var <- c(
  "np_cvlt_sdfr_z", 
  "np_cvlt_sdcr_z", 
  "np_cvlt_ldfr_z", 
  "np_cvlt_ldcr_z"
)

cvlt_recognition.var <- c(
  "np_cvltrec_hits_z", 
  "np_cvltrecog_falsepos_z", 
  "np_cvlt_reps_z", 
  "np_cvlt_intrus_z"
)

cvlt.names <- c(
  "Trial 1",
  "Trial 2",
  "Trial 3",
  "Trial 4",
  "Trial 5",
  "Total T1-T5",
  "List B",
  "Short Delay Free Recall",
  "Short Delay Cued Recall",
  "Long Delay Free Recall",
  "Long Delay Cued Recall",
  "Total Recognition Hits",
  "Total False Positives",
  "Total Repetitions",
  "Total Intrusions"
)

cvlt_learning.names <- c(
  "Trial 1", 
  "Trial 2", 
  "Trial 3", 
  "Trial 4", 
  "Trial 5", 
  "Total T1-T5", 
  "List B"
)

cvlt_recall.names <- c(
  "Short Delay Free Recall", 
  "Short Delay Cued Recall", 
  "Long Delay Free Recall", 
  "Long Delay Cued Recall"
)

cvlt_recognition.names <- c(
  "Total Recognition Hits", 
  "Total False Positives", 
  "Total Repetitions", 
  "Total Intrusions"
)

# =========================================================================
# Biber variables and labels

biber.var <- c(
  "np_biber1.scaled",
  "np_biber2.scaled",
  "np_biber3.scaled",
  "np_biber4.scaled",
  "np_biber5.scaled",
  "np_biber_t1to5.scaled",
  "np_biberb.scaled",
  "np_biber_sd.scaled",
  "np_biber_ld.scaled"
)

biber.unscaled.var <- gsub(".scaled", "", biber.var)

biber_learning.var <- c(
  "np_biber1.scaled", 
  "np_biber2.scaled", 
  "np_biber3.scaled", 
  "np_biber4.scaled", 
  "np_biber5.scaled", 
  "np_biber_t1to5.scaled", 
  "np_biberb.scaled"
)

biber_recall.var <- c(
  "np_biber_sd.scaled", 
  "np_biber_ld.scaled"
)

biber_recognition.var <- c(
  "np_biber_hits", 
  "np_biber_falsealarms", 
  "np_biber_t1to5_persev", 
  "np_biber_t1to5_extra"
)

biber.names <- c(
  "Trial 1",
  "Trial 2",
  "Trial 3",
  "Trial 4",
  "Trial 5",
  "Total T1-T5",
  "Distractor Set",
  "Immediate Recall",
  "Delayed Recall"
)

biber_learning.names <- c(
  "Trial 1",
  "Trial 2",
  "Trial 3",
  "Trial 4",
  "Trial 5",
  "Total T1-T5",
  "Distractor Set"
)

biber_recall.names <- c(
  "Immediate Recall", 
  "Delayed Recall"
)

biber_recognition.names <- c(
  "Recognition - Hits", 
  "Recognition - Total False Alarm", 
  "Total Perseverations", 
  "Total Extraneous Responses"
)
