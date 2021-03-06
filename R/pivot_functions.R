pivot_raw_across_scale_num <- function(lookup.df) {
  lookup.df %>%
    pivot_longer(
      cols = matches("\\d", perl = TRUE),
      names_to = "raw",
      values_to = "scaled",
      values_transform = list(scaled = as.numeric)
    ) %>%
    mutate(
      age = as.integer(age),
      raw = as.integer(raw)
    ) %>%
    select(
      age, raw, scaled
    ) %>%
    arrange(
      age, raw
    )
}

pivot_raw_across_scale_chr <- function(lookup.df) {
  lookup.df %>%
    pivot_longer(
      cols = matches("\\d", perl = TRUE),
      names_to = "raw",
      values_to = "scaled",
      values_transform = list(scaled = as.character)
    ) %>%
    mutate(
      age = as.integer(age),
      raw = as.integer(raw)
    ) %>%
    select(
      age, raw, scaled
    ) %>%
    arrange(
      age, raw
    )
}

pivot_age_across_scale_num <- function(lookup.df) {
  lookup.df %>%
    pivot_longer(
      cols = matches("\\d", perl = TRUE),
      names_to = "age",
      values_to = "scaled",
      values_transform = list(scaled = as.numeric)
    ) %>%
    mutate(
      age = as.integer(age),
      raw = as.integer(raw)
    ) %>%
    select(
      age, raw, scaled
    ) %>%
    arrange(
      age, raw
    )
}

pivot_age_across_scale_chr <- function(lookup.df) {
  lookup.df %>%
    pivot_longer(
      cols = matches("\\d", perl = TRUE),
      names_to = "age",
      values_to = "scaled",
      values_transform = list(scaled = as.character)
    ) %>%
    mutate(
      age = as.integer(age),
      raw = as.integer(raw)
    ) %>%
    select(
      age, raw, scaled
    ) %>%
    arrange(
      age, raw
    )
}

pivot_heaton <- function(lookup.df) {
  lookup.df %>%
    pivot_longer(
      cols = matches("\\/", perl = TRUE),
      names_to = "heaton_code",
      values_to = "tscore",
      values_transform = list(scaled = as.character)
    ) %>%
    separate(
      col = heaton_code,
      into = c("sex", "education_code", "age_code", "ethnicity"),
      sep = "/"
    )
}
