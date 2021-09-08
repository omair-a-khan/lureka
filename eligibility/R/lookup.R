eligibility_lookup_excel.file <- "eligibility/data-raw/eligibility_lookup.xlsx"

eligibility_block_design.lookup <- readxl::read_xlsx(eligibility_lookup_excel.file, sheet = "block_design") %>%
  pivot_raw_across_scale_num()
eligibility_benton.lookup <- readxl::read_xlsx(eligibility_lookup_excel.file, sheet = "benton") %>%
  pivot_raw_across_scale_num()
eligibility_digit_span.lookup <- readxl::read_xlsx(eligibility_lookup_excel.file, sheet = "digit_span") %>%
  pivot_raw_across_scale_num()
eligibility_trails_a_b.lookup <- readxl::read_xlsx(eligibility_lookup_excel.file, sheet = "trails_a_b") %>%
  pivot_raw_across_scale_num()
eligibility_trails_b_b.lookup <- readxl::read_xlsx(eligibility_lookup_excel.file, sheet = "trails_b_b") %>%
  pivot_raw_across_scale_num()
eligibility_trails_a_w.lookup <- readxl::read_xlsx(eligibility_lookup_excel.file, sheet = "trails_a_w") %>%
  pivot_raw_across_scale_num()
eligibility_trails_b_w.lookup <- readxl::read_xlsx(eligibility_lookup_excel.file, sheet = "trails_b_w") %>%
  pivot_raw_across_scale_num()
eligibility_cowa_b.lookup <- readxl::read_xlsx(eligibility_lookup_excel.file, sheet = "cowa_b") %>%
  pivot_raw_across_scale_num()
eligibility_cowa_w.lookup <- readxl::read_xlsx(eligibility_lookup_excel.file, sheet = "cowa_w") %>%
  pivot_raw_across_scale_num()
eligibility_stroop_word_b.lookup <- readxl::read_xlsx(eligibility_lookup_excel.file, sheet = "stroop_word_b") %>%
  pivot_raw_across_scale_num()
eligibility_stroop_color_b.lookup <- readxl::read_xlsx(eligibility_lookup_excel.file, sheet = "stroop_color_b") %>%
  pivot_raw_across_scale_num()
eligibility_stroop_colorword_b.lookup <- readxl::read_xlsx(eligibility_lookup_excel.file, sheet = "stroop_colorword_b") %>%
  pivot_raw_across_scale_num()
eligibility_stroop_word_w.lookup <- readxl::read_xlsx(eligibility_lookup_excel.file, sheet = "stroop_word_w") %>%
  pivot_raw_across_scale_num()
eligibility_stroop_color_w.lookup <- readxl::read_xlsx(eligibility_lookup_excel.file, sheet = "stroop_color_w") %>%
  pivot_raw_across_scale_num()
eligibility_stroop_colorword_w.lookup <- readxl::read_xlsx(eligibility_lookup_excel.file, sheet = "stroop_colorword_w") %>%
  pivot_raw_across_scale_num()
eligibility_wrat_std.lookup <- readxl::read_xlsx(eligibility_lookup_excel.file, sheet = "wrat_std") %>%
  pivot_raw_across_scale_chr()
eligibility_wrat_edu.lookup <- readxl::read_xlsx(eligibility_lookup_excel.file, sheet = "wrat_edu") %>%
  pivot_raw_across_scale_chr()
