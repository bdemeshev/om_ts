library(fpp3)
library(ARDL)

denmark
glimpse(denmark)

den = as_tibble(denmark)
den2 = mutate(den, 
  quarter = yearquarter(time(denmark)))
den2
glimpse(den2)
den2 = as_tsibble(den2, index = quarter)

gg_tsdisplay(den2, LRM)


ardl1 = ardl(data = denmark,
        LRM ~ LRY + IBO + IDE,
        order = c(2, 1, 2, 2))
ardl1

ardl_many = auto_ardl(data = denmark,
      LRM ~ LRY + IBO + IDE,
      max_order = 3)
ardl_many

ardl_many$best_model
