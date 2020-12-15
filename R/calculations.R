# Global Cognition

## MOCA

np_moca.interpretation <- case_when(
  data$np_moca < 0 ~ "NA",
  data$np_moca < 23 ~ "Impaired",
  data$np_moca < 27 ~ "Borderline",
  data$np_moca < 31 ~ "Normal",
  TRUE ~ "ERROR"
)

# Learning & Memory

## CVLT-II

#! Manual coding of scaled scores

## Biber

np_biber1.scaled <- (data$np_biber1 - 13.7) / 5.9
np_biber2.scaled <- (data$np_biber2 - 20.4) / 7.4
np_biber3.scaled <- (data$np_biber3 - 24.5) / 7
np_biber4.scaled <- (data$np_biber4 - 26.7) / 8.4
np_biber5.scaled <- (data$np_biber5 - 29.6) / 6.8

np_biber_t1to5 <- with(data, sum(c(np_biber1, np_biber2, np_biber3, np_biber4, np_biber5)))
np_biber_t1to5.scaled <- (np_biber_t1to5 - 114.5) / 34.7

np_biberb.scaled <- (data$np_biberb - 8.5) / 5
np_biber_sd.scaled <- (data$np_biber_sd - 26.4) / 7
np_biber_ld.scaled <- (data$np_biber_ld - 28) / 7

# Language

## BNT-30 item (even)

np_bnt.scaled <- (data$np_bnt - 26) / 3.4

## Animals

#! Manual coding of scaled scores

# Mood

## GDS

gds.interpretation <- case_when(
  data$gds < 0 ~ "NA",
  data$gds < 10 ~ "Normal",
  data$gds < 20 ~ "Mildly Depressed",
  data$gds < 31 ~ "Severely Depressed",
  TRUE ~ "ERROR"
)

# Visuospatial Skills

## HVOT

np_hvot.age <- case_when(
  data$age >= 60 & data$age <= 64 ~ "60-64",
  data$age >= 65 & data$age <= 110 ~ "65-110",
  TRUE ~ "ERROR"
)

np_hvot.scaled <- np_hvot.lookup %>%
  filter(age == np_hvot.age & education == data$education & raw == data$np_hvot) %>%
  pull(scaled)

# Attention/Executive Functioning/Information Processing

## DKEFS: Trail Making Test

np_tmta.scaled <- np_tmta.lookup %>%
  filter(age == data$age & raw == data$np_tmta) %>%
  pull(scaled)

np_tmta_seqerr.scaled <- np_tmta_seqerr.lookup %>%
  filter(age == data$age & raw == data$np_tmta_seqerr) %>%
  pull(scaled)

np_tmta_seterr.scaled <- np_tmta_seterr.lookup %>%
  filter(age == data$age & raw == data$np_tmta_seterr) %>%
  pull(scaled)

np_tmtb.scaled <- np_tmtb.lookup %>%
  filter(age == data$age & raw == data$np_tmtb) %>%
  pull(scaled)

np_tmtb_seqerr.scaled <- np_tmtb_seqerr.lookup %>%
  filter(age == data$age & raw == data$np_tmtb_seqerr) %>%
  pull(scaled)

np_tmtb_seterr.scaled <- np_tmtb_seterr.lookup %>%
  filter(age == data$age & raw == data$np_tmtb_seterr) %>%
  pull(scaled)

## DKEFS: Color-Word

np_color.scaled <- np_color.lookup %>%
  filter(age == data$age & raw == data$np_color) %>%
  pull(scaled)

np_word.scaled <- np_word.lookup %>%
  filter(age == data$age & raw == data$np_word) %>%
  pull(scaled)

np_inhibit.scaled <- np_inhibit.lookup %>%
  filter(age == data$age & raw == data$np_inhibit) %>%
  pull(scaled)

## COWA

np_fas <- with(data, sum(c(np_fas_f, np_fas_a, np_fas_s)))

## Tower Test

np_tower.var <- paste0("np_tower", formatC(1:9, width = 2, flag = "0"))

np_tower <- apply(data[, np_tower.var], 1, function(v) {
  if (all(is.na(v))) NA else sum(v, na.rm = TRUE)
})

np_tower.scaled <- np_tower.lookup %>%
  filter(age == data$age & raw == data$np_tower) %>%
  pull(scaled)

np_tower_ruleviol.scaled <- np_tower_ruleviol.lookup %>%
  filter(age == data$age & raw == data$np_tower_ruleviol) %>%
  pull(scaled)

# Mental Control

np_mc1.accuracy.index <- 1 - (data$np_mc1_omissions + data$np_mc1_falsepos) / 20
np_mc2.accuracy.index <- 1 - (data$np_mc2_omissions + data$np_mc2_falsepos) / 26
np_mc3.accuracy.index <- 1 - (data$np_mc3_omissions + data$np_mc3_falsepos) / 14

np_mc1_3.total

np_mc4.accuracy.index <- 1 - (data$np_mc4_omissions + data$np_mc4_falsepos) / 12
np_mc5.accuracy.index <- 1 - (data$np_mc5_omissions + data$np_mc5_falsepos) / 12
np_mc6.accuracy.index <- 1 - (data$np_mc6_omissions + data$np_mc6_falsepos) / 9
np_mc7.accuracy.index <- 1 - (data$np_mc7_omissions + data$np_mc7_falsepos) / 11
np_mc8.accuracy.index <- 1 - (data$np_mc8_omissions + data$np_mc8_falsepos) / 13

np_mc_auto_mc.accuracy.index <- mean(c(np_mc1.accuracy.index, np_mc2.accuracy.index, np_mc3.accuracy.index, np_mc4.accuracy.index), na.rm = FALSE)

#! this formula does not align with what is in rVMAP::derive_pvlt()
np_mc_auto_mc.accuracy.index <- mean(c(np_mc5.accuracy.index, np_mc6.accuracy.index, np_mc7.accuracy.index, np_mc8.accuracy.index), na.rm = FALSE)

# WMS-IV Symbol Span

np_symbol.scaled <- np_symbol.lookup %>%
  filter(age == data$age & raw == data$np_symbol) %>%
  pull(scaled)


