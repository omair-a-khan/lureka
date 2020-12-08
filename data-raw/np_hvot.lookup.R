np_hvot_60_64_raw_corrected.lookup.original <- tibble::tribble(
  ~raw, ~`0`, ~`1`, ~`2`, ~`3`, ~`4`, ~`5`, ~`6`, ~`7`, ~`8`, ~`9`, ~`10`, ~`11`, ~`12`, ~`13`, ~`14`, ~`15`, ~`16`, ~`17`, ~`18`, ~`19`, ~`20`, ~`21`, ~`22`,
    0L,   4L,   4L,   4L,   4L,   4L,   4L,   4L,   4L,   3L,   3L,    3L,    2L,    2L,    2L,    1L,    1L,    0L,    0L,    0L,    0L,    0L,    0L,    0L,
    1L,   5L,   5L,   5L,   5L,   5L,   5L,   5L,   5L,   4L,   4L,    4L,    3L,    3L,    3L,    2L,    2L,    1L,    1L,    1L,    1L,    1L,    1L,    1L,
    2L,   6L,   6L,   6L,   6L,   6L,   6L,   6L,   6L,   5L,   5L,    5L,    4L,    4L,    3L,    3L,    3L,    2L,    2L,    2L,    2L,    2L,    2L,    2L,
    3L,   7L,   7L,   7L,   7L,   7L,   7L,   7L,   7L,   6L,   6L,    6L,    5L,    5L,    4L,    4L,    4L,    3L,    3L,    3L,    3L,    3L,    3L,    3L,
    4L,   8L,   8L,   8L,   8L,   8L,   8L,   8L,   8L,   7L,   7L,    7L,    6L,    6L,    5L,    5L,    5L,    4L,    4L,    4L,    4L,    4L,    4L,    4L,
    5L,   9L,   9L,   9L,   9L,   9L,   9L,   9L,   9L,   8L,   8L,    8L,    7L,    7L,    6L,    6L,    6L,    5L,    5L,    5L,    5L,    5L,    5L,    5L,
    6L,  10L,  10L,  10L,  10L,  10L,  10L,  10L,  10L,   9L,   9L,    8L,    8L,    8L,    7L,    7L,    7L,    6L,    6L,    6L,    6L,    6L,    6L,    6L,
    7L,  11L,  11L,  11L,  11L,  11L,  11L,  11L,  11L,  10L,  10L,    9L,    9L,    9L,    8L,    8L,    8L,    7L,    7L,    7L,    7L,    7L,    7L,    7L,
    8L,  12L,  12L,  12L,  12L,  12L,  12L,  12L,  12L,  11L,  11L,   10L,   10L,   10L,    9L,    9L,    9L,    8L,    8L,    8L,    8L,    8L,    8L,    8L,
    9L,  13L,  13L,  13L,  13L,  13L,  13L,  13L,  13L,  12L,  12L,   11L,   11L,   11L,   10L,   10L,   10L,    9L,    9L,    9L,    9L,    9L,    9L,    9L,
   10L,  14L,  14L,  14L,  14L,  14L,  14L,  14L,  13L,  13L,  13L,   12L,   12L,   12L,   11L,   11L,   11L,   10L,   10L,   10L,   10L,   10L,   10L,   10L,
   11L,  15L,  15L,  15L,  15L,  15L,  15L,  15L,  14L,  14L,  14L,   13L,   13L,   13L,   12L,   12L,   12L,   11L,   11L,   11L,   11L,   11L,   11L,   11L,
   12L,  16L,  16L,  16L,  16L,  16L,  16L,  16L,  15L,  15L,  15L,   14L,   14L,   14L,   13L,   13L,   13L,   12L,   12L,   12L,   12L,   12L,   12L,   12L,
   13L,  17L,  17L,  17L,  17L,  17L,  17L,  17L,  16L,  16L,  16L,   15L,   15L,   15L,   14L,   14L,   14L,   13L,   13L,   13L,   13L,   13L,   13L,   13L,
   14L,  18L,  18L,  18L,  18L,  18L,  18L,  18L,  17L,  17L,  17L,   16L,   16L,   16L,   15L,   15L,   15L,   14L,   14L,   14L,   14L,   14L,   14L,   14L,
   15L,  19L,  19L,  19L,  19L,  19L,  19L,  19L,  18L,  18L,  18L,   17L,   17L,   17L,   16L,   16L,   16L,   15L,   15L,   15L,   15L,   15L,   15L,   15L,
   16L,  20L,  20L,  20L,  20L,  20L,  20L,  20L,  19L,  19L,  19L,   18L,   18L,   18L,   17L,   17L,   17L,   16L,   16L,   16L,   16L,   16L,   16L,   16L,
   17L,  21L,  21L,  21L,  21L,  21L,  21L,  21L,  20L,  20L,  20L,   19L,   19L,   19L,   18L,   18L,   18L,   17L,   17L,   17L,   17L,   17L,   17L,   17L,
   18L,  22L,  22L,  22L,  22L,  22L,  22L,  22L,  21L,  21L,  21L,   20L,   20L,   20L,   19L,   19L,   19L,   18L,   18L,   18L,   18L,   18L,   18L,   18L,
   19L,  23L,  23L,  23L,  23L,  23L,  23L,  23L,  22L,  22L,  22L,   21L,   21L,   21L,   20L,   20L,   20L,   19L,   19L,   19L,   19L,   19L,   19L,   19L,
   20L,  24L,  24L,  24L,  24L,  24L,  24L,  24L,  23L,  23L,  23L,   22L,   22L,   22L,   21L,   21L,   20L,   20L,   20L,   20L,   20L,   20L,   20L,   20L,
   21L,  25L,  25L,  25L,  25L,  25L,  25L,  25L,  24L,  24L,  24L,   23L,   23L,   23L,   22L,   22L,   21L,   21L,   21L,   21L,   21L,   21L,   21L,   21L,
   22L,  26L,  26L,  26L,  26L,  26L,  26L,  26L,  25L,  25L,  25L,   24L,   24L,   24L,   23L,   23L,   22L,   22L,   22L,   22L,   22L,   22L,   22L,   22L,
   23L,  27L,  27L,  27L,  27L,  27L,  27L,  27L,  26L,  26L,  26L,   25L,   25L,   25L,   24L,   24L,   23L,   23L,   23L,   23L,   23L,   23L,   23L,   23L,
   24L,  28L,  28L,  28L,  28L,  28L,  28L,  28L,  27L,  27L,  27L,   26L,   26L,   25L,   25L,   25L,   24L,   24L,   24L,   24L,   24L,   24L,   24L,   24L,
   25L,  29L,  29L,  29L,  29L,  29L,  29L,  29L,  28L,  28L,  28L,   27L,   27L,   26L,   26L,   26L,   25L,   25L,   25L,   25L,   25L,   25L,   25L,   25L,
   26L,  30L,  30L,  30L,  30L,  30L,  30L,  30L,  29L,  29L,  29L,   28L,   28L,   27L,   27L,   27L,   26L,   26L,   26L,   26L,   26L,   26L,   26L,   26L,
   27L,  30L,  30L,  30L,  30L,  30L,  30L,  30L,  30L,  30L,  30L,   29L,   29L,   28L,   28L,   28L,   27L,   27L,   27L,   27L,   27L,   27L,   27L,   27L,
   28L,  30L,  30L,  30L,  30L,  30L,  30L,  30L,  30L,  30L,  30L,   30L,   30L,   29L,   29L,   29L,   28L,   28L,   28L,   28L,   28L,   28L,   28L,   28L,
   29L,  30L,  30L,  30L,  30L,  30L,  30L,  30L,  30L,  30L,  30L,   30L,   30L,   30L,   30L,   30L,   29L,   29L,   29L,   29L,   29L,   29L,   29L,   29L,
   30L,  30L,  30L,  30L,  30L,  30L,  30L,  30L,  30L,  30L,  30L,   30L,   30L,   30L,   30L,   30L,   30L,   30L,   30L,   30L,   30L,   30L,   30L,   30L
  )

np_hvot_65_110_raw_corrected.lookup.original <- tibble::tribble(
  ~raw, ~`0`, ~`1`, ~`2`, ~`3`, ~`4`, ~`5`, ~`6`, ~`7`, ~`8`, ~`9`, ~`10`, ~`11`, ~`12`, ~`13`, ~`14`, ~`15`, ~`16`, ~`17`, ~`18`, ~`19`, ~`20`, ~`21`, ~`22`,
    0L,   4L,   4L,   4L,   4L,   4L,   4L,   4L,   4L,   4L,   3L,    3L,    3L,    2L,    2L,    2L,    1L,    1L,    1L,    1L,    1L,    1L,    1L,    1L,
    1L,   5L,   5L,   5L,   5L,   5L,   5L,   5L,   5L,   5L,   4L,    4L,    4L,    3L,    3L,    3L,    2L,    2L,    2L,    2L,    2L,    2L,    2L,    2L,
    2L,   6L,   6L,   6L,   6L,   6L,   6L,   6L,   6L,   6L,   5L,    5L,    5L,    4L,    4L,    4L,    3L,    3L,    3L,    3L,    3L,    3L,    3L,    3L,
    3L,   7L,   7L,   7L,   7L,   7L,   7L,   7L,   7L,   7L,   6L,    6L,    6L,    5L,    5L,    5L,    4L,    4L,    4L,    4L,    4L,    4L,    4L,    4L,
    4L,   8L,   8L,   8L,   8L,   8L,   8L,   8L,   8L,   8L,   7L,    7L,    7L,    6L,    6L,    6L,    5L,    5L,    5L,    5L,    5L,    5L,    5L,    5L,
    5L,   9L,   9L,   9L,   9L,   9L,   9L,   9L,   9L,   9L,   8L,    8L,    8L,    7L,    7L,    7L,    6L,    6L,    6L,    6L,    6L,    6L,    6L,    6L,
    6L,  10L,  10L,  10L,  10L,  10L,  10L,  10L,  10L,  10L,   9L,    9L,    9L,    8L,    8L,    8L,    7L,    7L,    7L,    7L,    7L,    7L,    7L,    7L,
    7L,  11L,  11L,  11L,  11L,  11L,  11L,  11L,  11L,  11L,  10L,   10L,   10L,    9L,    9L,    9L,    8L,    8L,    8L,    8L,    8L,    8L,    8L,    8L,
    8L,  12L,  12L,  12L,  12L,  12L,  12L,  12L,  12L,  12L,  11L,   11L,   11L,   10L,   10L,    9L,    9L,    9L,    9L,    9L,    9L,    9L,    9L,    9L,
    9L,  13L,  13L,  13L,  13L,  13L,  13L,  13L,  13L,  13L,  12L,   12L,   12L,   11L,   11L,   10L,   10L,   10L,   10L,   10L,   10L,   10L,   10L,   10L,
   10L,  14L,  14L,  14L,  14L,  14L,  14L,  14L,  14L,  14L,  13L,   13L,   13L,   12L,   12L,   11L,   11L,   11L,   11L,   11L,   11L,   11L,   11L,   11L,
   11L,  15L,  15L,  15L,  15L,  15L,  15L,  15L,  15L,  15L,  14L,   14L,   14L,   13L,   13L,   12L,   12L,   12L,   12L,   12L,   12L,   12L,   12L,   12L,
   12L,  16L,  16L,  16L,  16L,  16L,  16L,  16L,  16L,  16L,  15L,   15L,   14L,   14L,   14L,   13L,   13L,   13L,   13L,   13L,   13L,   13L,   13L,   13L,
   13L,  17L,  17L,  17L,  17L,  17L,  17L,  17L,  17L,  17L,  16L,   16L,   15L,   15L,   15L,   14L,   14L,   14L,   14L,   14L,   14L,   14L,   14L,   14L,
   14L,  18L,  18L,  18L,  18L,  18L,  18L,  18L,  18L,  18L,  17L,   17L,   16L,   16L,   16L,   15L,   15L,   15L,   15L,   15L,   15L,   15L,   15L,   15L,
   15L,  19L,  19L,  19L,  19L,  19L,  19L,  19L,  19L,  18L,  18L,   18L,   17L,   17L,   17L,   16L,   16L,   16L,   16L,   16L,   16L,   16L,   16L,   16L,
   16L,  20L,  20L,  20L,  20L,  20L,  20L,  20L,  20L,  19L,  19L,   19L,   18L,   18L,   18L,   17L,   17L,   17L,   17L,   17L,   17L,   17L,   17L,   17L,
   17L,  21L,  21L,  21L,  21L,  21L,  21L,  21L,  21L,  20L,  20L,   20L,   19L,   19L,   19L,   18L,   18L,   18L,   18L,   18L,   18L,   18L,   18L,   18L,
   18L,  22L,  22L,  22L,  22L,  22L,  22L,  22L,  22L,  21L,  21L,   21L,   20L,   20L,   20L,   19L,   19L,   19L,   19L,   19L,   19L,   19L,   19L,   19L,
   19L,  23L,  23L,  23L,  23L,  23L,  23L,  23L,  23L,  22L,  22L,   22L,   21L,   21L,   21L,   20L,   20L,   20L,   20L,   20L,   20L,   20L,   20L,   20L,
   20L,  24L,  24L,  24L,  24L,  24L,  24L,  24L,  24L,  23L,  23L,   23L,   22L,   22L,   22L,   21L,   21L,   21L,   21L,   21L,   21L,   21L,   21L,   21L,
   21L,  25L,  25L,  25L,  25L,  25L,  25L,  25L,  25L,  24L,  24L,   24L,   23L,   23L,   23L,   22L,   22L,   22L,   22L,   22L,   22L,   22L,   22L,   22L,
   22L,  26L,  26L,  26L,  26L,  26L,  26L,  26L,  26L,  25L,  25L,   25L,   24L,   24L,   24L,   23L,   23L,   23L,   23L,   23L,   23L,   23L,   23L,   23L,
   23L,  27L,  27L,  27L,  27L,  27L,  27L,  27L,  27L,  26L,  26L,   26L,   25L,   25L,   25L,   24L,   24L,   24L,   24L,   24L,   24L,   24L,   24L,   24L,
   24L,  28L,  28L,  28L,  28L,  28L,  28L,  28L,  28L,  27L,  27L,   27L,   26L,   26L,   26L,   25L,   25L,   25L,   25L,   25L,   25L,   25L,   25L,   25L,
   25L,  29L,  29L,  29L,  29L,  29L,  29L,  29L,  29L,  28L,  28L,   28L,   27L,   27L,   27L,   26L,   26L,   25L,   25L,   25L,   25L,   25L,   25L,   25L,
   26L,  30L,  30L,  30L,  30L,  30L,  30L,  30L,  30L,  29L,  29L,   29L,   28L,   28L,   28L,   27L,   27L,   26L,   26L,   26L,   26L,   26L,   26L,   26L,
   27L,  30L,  30L,  30L,  30L,  30L,  30L,  30L,  30L,  30L,  30L,   30L,   29L,   29L,   29L,   28L,   28L,   27L,   27L,   27L,   27L,   27L,   27L,   27L,
   28L,  30L,  30L,  30L,  30L,  30L,  30L,  30L,  30L,  30L,  30L,   30L,   30L,   30L,   30L,   29L,   29L,   28L,   28L,   28L,   28L,   28L,   28L,   28L,
   29L,  30L,  30L,  30L,  30L,  30L,  30L,  30L,  30L,  30L,  30L,   30L,   30L,   30L,   30L,   30L,   30L,   29L,   29L,   29L,   29L,   29L,   29L,   29L,
   30L,  30L,  30L,  30L,  30L,  30L,  30L,  30L,  30L,  30L,  30L,   30L,   30L,   30L,   30L,   30L,   30L,   30L,   30L,   30L,   30L,   30L,   30L,   30L
  )

np_hvot.lookup.original <- tibble::tribble(
  ~corrected, ~scaled,
          0L,    104L,
          1L,    102L,
          2L,    100L,
          3L,     98L,
          4L,     96L,
          5L,     93L,
          6L,     91L,
          7L,     89L,
          8L,     87L,
          9L,     85L,
         10L,     83L,
         11L,     81L,
         12L,     79L,
         13L,     77L,
         14L,     75L,
         15L,     73L,
         16L,     70L,
         17L,     68L,
         18L,     66L,
         19L,     64L,
         20L,     62L,
         21L,     60L,
         22L,     58L,
         23L,     56L,
         24L,     54L,
         25L,     52L,
         26L,     50L,
         27L,     47L,
         28L,     45L,
         29L,     43L,
         30L,     41L
  )

np_hvot_60_64_raw_corrected.lookup <- np_hvot_60_64_raw_corrected.lookup.original %>%
  pivot_longer(
    cols = matches("\\d", perl = TRUE),
    names_to = "education",
    values_to = "corrected"
  ) %>%
  mutate(
    age = "60-64",
    education = as.integer(education)
  ) %>%
  select(
    age, education, raw, corrected
  ) %>%
  arrange(
    education, raw
  ) %>%
  left_join(
    np_hvot.lookup.original, by = "corrected"
  )

np_hvot_65_110_raw_corrected.lookup <- np_hvot_65_110_raw_corrected.lookup.original %>%
  pivot_longer(
    cols = matches("\\d", perl = TRUE),
    names_to = "education",
    values_to = "corrected"
  ) %>%
  mutate(
    age = "65-110",
    education = as.integer(education)
  ) %>%
  select(
    age, education, raw, corrected
  ) %>%
  arrange(
    education, raw
  ) %>%
  left_join(
    np_hvot.lookup.original, by = "corrected"
  )

np_hvot.lookup <- bind_rows(
  np_hvot_60_64_raw_corrected.lookup, 
  np_hvot_65_110_raw_corrected.lookup
)
