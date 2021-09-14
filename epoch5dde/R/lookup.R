epoch5dde_lookup_excel.file <- "epoch5dde/data-raw/epoch5dde_lookup.xlsx"

epoch5dde_tower_achievement.lookup <- readxl::read_xlsx(epoch5dde_lookup_excel.file, sheet = "tower_achievement") %>%
  pivot_age_across_scale_num()
epoch5dde_symbol_span.lookup <- readxl::read_xlsx(epoch5dde_lookup_excel.file, sheet = "symbol_span") %>%
  pivot_raw_across_scale_num()
epoch5dde_dkefs_trails_2.lookup <- readxl::read_xlsx(epoch5dde_lookup_excel.file, sheet = "dkefs_trails_2") %>%
  pivot_age_across_scale_num()
epoch5dde_num_sequencing_errors.lookup <- readxl::read_xlsx(epoch5dde_lookup_excel.file, sheet = "num_sequencing_errors") %>%
  pivot_age_across_scale_num()
epoch5dde_num_setloss_errors.lookup <- readxl::read_xlsx(epoch5dde_lookup_excel.file, sheet = "num_setloss_errors") %>%
  pivot_age_across_scale_num()
epoch5dde_tower_achievement.lookup <- readxl::read_xlsx(epoch5dde_lookup_excel.file, sheet = "tower_achievement") %>%
  pivot_age_across_scale_num()
epoch5dde_dkefs_trails_4.lookup <- readxl::read_xlsx(epoch5dde_lookup_excel.file, sheet = "dkefs_trails_4") %>%
  pivot_age_across_scale_num()
epoch5dde_num_letter_sequencing_errors.lookup <- readxl::read_xlsx(epoch5dde_lookup_excel.file, sheet = "num_letter_sequencing_errors") %>%
  pivot_age_across_scale_num()
epoch5dde_num_letter_setloss_errors.lookup <- readxl::read_xlsx(epoch5dde_lookup_excel.file, sheet = "num_letter_setloss_errors") %>%
  pivot_age_across_scale_num()
epoch5dde_tmt_contrastdiff_ss.lookup <- readxl::read_xlsx(epoch5dde_lookup_excel.file, sheet = "tmt_contrastdiff_ss")
epoch5dde_color_naming_time.lookup <- readxl::read_xlsx(epoch5dde_lookup_excel.file, sheet = "color_naming_time") %>%
  pivot_age_across_scale_num()
epoch5dde_word_reading_time.lookup <- readxl::read_xlsx(epoch5dde_lookup_excel.file, sheet = "word_reading_time") %>%
  pivot_age_across_scale_num()
epoch5dde_inhibition_time.lookup <- readxl::read_xlsx(epoch5dde_lookup_excel.file, sheet = "inhibition_time") %>%
  pivot_age_across_scale_num()
epoch5dde_colorword_comp.lookup <- readxl::read_xlsx(epoch5dde_lookup_excel.file, sheet = "colorword_comp")
epoch5dde_inhibitcolor_contrast.lookup <- readxl::read_xlsx(epoch5dde_lookup_excel.file, sheet = "inhibitcolor_contrast")
epoch5dde_color_cumpercerr.lookup <- readxl::read_xlsx(epoch5dde_lookup_excel.file, sheet = "color_cumpercerr") %>%
  pivot_age_across_scale_num()
epoch5dde_word_cumpercerr.lookup <- readxl::read_xlsx(epoch5dde_lookup_excel.file, sheet = "word_cumpercerr") %>%
  pivot_age_across_scale_num()
epoch5dde_inhibit_cumpercscerr.lookup <- readxl::read_xlsx(epoch5dde_lookup_excel.file, sheet = "inhibit_cumpercscerr") %>%
  pivot_age_across_scale_num()
epoch5dde_inhibit_cumpercucerr.lookup <- readxl::read_xlsx(epoch5dde_lookup_excel.file, sheet = "inhibit_cumpercucerr") %>%
  pivot_age_across_scale_num()
epoch5dde_inhibit_cumpercerr.lookup <- readxl::read_xlsx(epoch5dde_lookup_excel.file, sheet = "inhibit_cumpercerr") %>%
  pivot_age_across_scale_num()
epoch5dde_tower_total_rule_violations.lookup <- readxl::read_xlsx(epoch5dde_lookup_excel.file, sheet = "tower_total_rule_violations") %>%
  pivot_age_across_scale_chr()
epoch5dde_digit_symbol.lookup <- readxl::read_xlsx(epoch5dde_lookup_excel.file, sheet = "digit_symbol") %>%
  pivot_age_across_scale_num()

epoch5dde_hvot_50_54.lookup <- readxl::read_xlsx(epoch5dde_lookup_excel.file, sheet = "hvot_50_54") %>%
  pivot_age_across_scale_num() %>%
  rename(education = age) %>%
  mutate(age = "50-54")
epoch5dde_hvot_55_59.lookup <- readxl::read_xlsx(epoch5dde_lookup_excel.file, sheet = "hvot_55_59") %>%
  pivot_age_across_scale_num() %>%
  rename(education = age) %>%
  mutate(age = "55-59")
epoch5dde_hvot_60_64.lookup <- readxl::read_xlsx(epoch5dde_lookup_excel.file, sheet = "hvot_60_64") %>%
  pivot_age_across_scale_num() %>%
  rename(education = age) %>%
  mutate(age = "60-64")
epoch5dde_hvot_65_110.lookup <- readxl::read_xlsx(epoch5dde_lookup_excel.file, sheet = "hvot_65_110") %>%
  pivot_age_across_scale_num() %>%
  rename(education = age) %>%
  mutate(age = "65-110")

epoch5dde_hvot.lookup <- bind_rows(epoch5dde_hvot_50_54.lookup, epoch5dde_hvot_55_59.lookup, epoch5dde_hvot_60_64.lookup, epoch5dde_hvot_65_110.lookup)

epoch5dde_hvot_tscore.lookup <- readxl::read_xlsx(epoch5dde_lookup_excel.file, sheet = "hvot_tscore")
epoch5dde_mental_control.lookup <- readxl::read_xlsx(epoch5dde_lookup_excel.file, sheet = "mental_control") %>%
  pivot_age_across_scale_num()

epoch5dde_heaton_scaled.lookup <- readxl::read_xlsx(epoch5dde_lookup_excel.file, sheet = "heaton_scaled")
epoch5dde_heaton_age.lookup <- readxl::read_xlsx(epoch5dde_lookup_excel.file, sheet = "heaton_age")
epoch5dde_heaton_education.lookup <- readxl::read_xlsx(epoch5dde_lookup_excel.file, sheet = "heaton_education")
epoch5dde_heaton_fas.lookup <- readxl::read_xlsx(epoch5dde_lookup_excel.file, sheet = "heaton_fas") %>%
  pivot_heaton()
epoch5dde_heaton_animals.lookup <- readxl::read_xlsx(epoch5dde_lookup_excel.file, sheet = "heaton_animals") %>%
  pivot_heaton()
