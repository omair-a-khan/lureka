redcap_tokens.df <- tibble::tribble(
  ~ epoch, ~ name, ~ token,
  1, "main", "A11D20A69B7F80961EE02A706C633C11",
  1, "addendum", "9FE940171236D4F03059BB1113467D7A",
  2, "main", "0461DD2B15820D0A7D5299AE52CA2BB0",
  3, "main", "6EED98B9928A10DB73820CDAB77404DA",
  4, "main", "65F9A95FD428008CBFF8617C3F516960",
  5, "main", "1254B8C019BC41AE0412B7D2E0059766"
) %>%
  as.data.frame()

redcap_tokens_eligibility.df <- tibble::tribble(
  ~ epoch, ~ name, ~ token,
  "elig", "eligibility", "0E3DD266A63093684B28132F3733E1DE"
) %>%
  as.data.frame()

redcap_tokens_enrollment.df <- tibble::tribble(
  ~ epoch, ~ name, ~ token,
  "enrol", "enrollment", "104D4175E6168E28A74CD815167AB99D"
) %>%
  as.data.frame()


