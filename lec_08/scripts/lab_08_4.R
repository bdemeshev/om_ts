library(fpp3) # работа с рядами
library(bsts) # байесовская структурная модель

plot(AirPassengers)
str(AirPassengers)

air = log(AirPassengers)
plot(air)

model = list()
model = AddLocalLinearTrend(model, y = air)
model = AddTrig(model, y = air,
        period = 12, frequencies = 1:2)

poster = bsts(air, 
  state.specification = model, niter = 2000)

poster

plot(poster, 'components')

fcst = predict(poster, horizon = 24, 
      quantiles = c(0.05, 0.95), burn = 1000)
fcst$mean
plot(fcst)
