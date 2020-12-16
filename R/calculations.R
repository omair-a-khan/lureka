attach(data)

if (!age %in% 60:110) {
  stop("Age is out of bounds.")
}

if (!education %in% 0:22) {
  stop("Education is out of bounds.")
}

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

np_biber_t1to5 <- with(data, sum(c(np_biber1, np_biber2, np_biber3, np_biber4, np_biber5)))
np_biber_t1to5.scaled <- (np_biber_t1to5 - 114.5) / 34.7

np_biberb.scaled <- (np_biberb - 8.5) / 5
np_biber_sd.scaled <- (np_biber_sd - 26.4) / 7
np_biber_ld.scaled <- (np_biber_ld - 28) / 7

# Language

## BNT-30 item (even)

np_bnt.scaled <- (np_bnt - 26) / 3.4

## Animals

#! Manual coding of scaled scores

# Mood

## GDS

np_gds.var <- paste0("gds", formatC(1:30, width = 2, flag = "0"))

np_gds <- apply(np_gds.var, 1, function(v) {
  if (all(is.na(v))) NA else sum(v, na.rm = FALSE)
})

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
  age >= 60 & age <= 64 ~ "60-64",
  age >= 65 & age <= 110 ~ "65-110",
  TRUE ~ "ERROR"
)

np_hvot.raw <- ifelse(np_hvot > max(np_hvot.lookup$raw), max(np_hvot.lookup$raw), np_hvot)

np_hvot.scaled <- np_hvot.lookup %>%
  filter(age == np_hvot.age & education == education & raw == np_hvot.raw) %>%
  pull(scaled)

# Attention/Executive Functioning/Information Processing

## DKEFS: Trail Making Test

np_tmta.raw <- ifelse(np_tmta > max(np_tmta.lookup$raw), max(np_tmta.lookup$raw), np_tmta)
np_tmta.scaled <- np_tmta.lookup %>%
  filter(age == age & raw == np_tmta.raw) %>%
  pull(scaled)

np_tmta_seqerr.raw <- ifelse(np_tmta_seqerr > max(np_tmta_seqerr.lookup$raw), max(np_tmta_seqerr.lookup$raw), np_tmta_seqerr)
np_tmta_seqerr.scaled <- np_tmta_seqerr.lookup %>%
  filter(age == age & raw == np_tmta_seqerr.raw) %>%
  pull(scaled)

np_tmta_seterr.scaled <- np_tmta_seterr.lookup %>%
  filter(age == age & raw == np_tmta_seterr) %>%
  pull(scaled)

np_tmtb.scaled <- np_tmtb.lookup %>%
  filter(age == age & raw == np_tmtb) %>%
  pull(scaled)

np_tmtb_seqerr.scaled <- np_tmtb_seqerr.lookup %>%
  filter(age == age & raw == np_tmtb_seqerr) %>%
  pull(scaled)

np_tmtb_seterr.scaled <- np_tmtb_seterr.lookup %>%
  filter(age == age & raw == np_tmtb_seterr) %>%
  pull(scaled)

## DKEFS: Color-Word

np_color.scaled <- np_color.lookup %>%
  filter(age == age & raw == np_color) %>%
  pull(scaled)

np_word.scaled <- np_word.lookup %>%
  filter(age == age & raw == np_word) %>%
  pull(scaled)

np_inhibit.scaled <- np_inhibit.lookup %>%
  filter(age == age & raw == np_inhibit) %>%
  pull(scaled)

## COWA

np_fas <- with(data, sum(c(np_fas_f, np_fas_a, np_fas_s)))

## Tower Test

np_tower.var <- paste0("np_tower", formatC(1:9, width = 2, flag = "0"))

np_tower <- apply(np_tower.var, 1, function(v) {
  if (all(is.na(v))) NA else sum(v, na.rm = TRUE)
})

np_tower.scaled <- np_tower.lookup %>%
  filter(age == age & raw == np_tower) %>%
  pull(scaled)

np_tower_ruleviol.scaled <- np_tower_ruleviol.lookup %>%
  filter(age == age & raw == np_tower_ruleviol) %>%
  pull(scaled)

# Mental Control

np_mc1.accuracy.index <- 1 - (np_mc1_omissions + np_mc1_falsepos) / 20
np_mc2.accuracy.index <- 1 - (np_mc2_omissions + np_mc2_falsepos) / 26
np_mc3.accuracy.index <- 1 - (np_mc3_omissions + np_mc3_falsepos) / 14

#! np_mc1_3.total

np_mc4.accuracy.index <- 1 - (np_mc4_omissions + np_mc4_falsepos) / 12
np_mc5.accuracy.index <- 1 - (np_mc5_omissions + np_mc5_falsepos) / 12
np_mc6.accuracy.index <- 1 - (np_mc6_omissions + np_mc6_falsepos) / 9
np_mc7.accuracy.index <- 1 - (np_mc7_omissions + np_mc7_falsepos) / 11
np_mc8.accuracy.index <- 1 - (np_mc8_omissions + np_mc8_falsepos) / 13

np_mc_auto_mc.accuracy.index <- mean(c(np_mc1.accuracy.index, np_mc2.accuracy.index, np_mc3.accuracy.index, np_mc4.accuracy.index), na.rm = FALSE)

#! this formula does not align with what is in rVMAP::derive_pvlt()
np_mc_nonauto_mc.accuracy.index <- mean(c(np_mc5.accuracy.index, np_mc6.accuracy.index, np_mc7.accuracy.index, np_mc8.accuracy.index), na.rm = FALSE)

# WMS-IV Symbol Span

np_symbol.scaled <- np_symbol.lookup %>%
  filter(age == age & raw == np_symbol) %>%
  pull(scaled)


