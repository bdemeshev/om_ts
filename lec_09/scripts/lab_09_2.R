library(fpp3) # пакеты для работы с временными рядами

n_obs = 30
sales = tibble(t = 1:n_obs, 
          volume = rpois(n = n_obs, 1.2))
sales
sales_tsibble = as_tsibble(sales, 
                index = t)

models = model(sales_tsibble, 
        crost = CROSTON(volume))
models$crost[[1]]

fcst = forecast(models, h = 5)
fcst

autoplot(fcst)
