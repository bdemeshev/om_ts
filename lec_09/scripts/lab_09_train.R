library(fpp3)

# q1
autoplot(bank_calls)

calls_with_t = mutate(bank_calls, t = row_number())
calls_ts = as_tsibble(calls_with_t, index = t)
calls_ts

model = model(calls_ts, 
    stl = STL(Calls ~ season(period = 169) +
          season(period = 5 * 169))
  ) 

components(model)

autoplot(components(model))

# q2
n_obs = 50
demand = tibble(t = 1:n_obs, 
                volume = rpois(n = n_obs, lambda = 1) * 3.2)
demand_ts = as_tsibble(demand, index = t)


model = model(demand_ts, 
              crost = CROSTON(volume)) 

fcst = forecast(model, h = 5)
fcst

# q3

dm_test = forecast::dm.test
?dm_test
?forecast::dm_test



library(mlRFinance)

Dmat = matrix(runif(1000) - 0.3, ncol=10)
bvec = runif(100)
hansen.spa(Dmat, bvec, B=1000)
white.spa(Dmat, bvec, B=1000)

hansen.spa
