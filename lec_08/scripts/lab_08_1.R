library(fpp3)
library(imputeTS)

air = as_tsibble(AirPassengers)
gg_tsdisplay(air)

lair = log(AirPassengers)
lair_na = lair
where_na = c(5:6, 30:32, 70, 90:91, 110, 124)
lair_na[where_na] = NA

ggplot_na_distribution(lair_na)
ggplot_na_intervals(lair_na)

lair_int = na_interpolation(lair_na)
ggplot_na_imputations(lair_na, 
        lair_int, lair)

mod = arima(lair_na, 
  order = c(1, 1, 0),
  seasonal = list(order = c(0, 1, 0)))$model

lair_ar1 = na_kalman(lair_na, 
              model = mod)
ggplot_na_imputations(lair_na, 
                      lair_ar1, lair)


lair_ar2 = na_kalman(lair_na, 
          model = 'auto.arima')


ggplot_na_imputations(lair_na, 
                      lair_ar2, lair)

lair_seas = na_seadec(lair_na)

ggplot_na_imputations(lair_na, 
                      lair_seas, lair)

