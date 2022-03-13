library(fpp3)
library(tsibbledata)

head(vic_elec)

elec = index_by(vic_elec, Date) %>%
  summarise(dem = mean(Demand),
            temp = mean(Temperature))
gg_tsdisplay(elec)
gg_tsdisplay(tail(elec, 60))

elec_train = head(elec, -60)
elec_test = tail(elec, 60)

mods = model(elec_train, 
    naive = NAIVE(dem),
    arimaf = ARIMA(
      dem ~ fourier(K = 3) + PDQ(0, 0, 0)))
report(mods$arimaf[[1]])

fcst = forecast(mods, h = 60)

autoplot(fcst)

accuracy(fcst, elec)
