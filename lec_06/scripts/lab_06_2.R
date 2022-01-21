# Esli russkie bukvi prevratilitis v krakozyabry, to...
# File - Reopen with encoding... - UTF-8 - Set as default - OK

# Временные ряды. Неделя 6. Скрипт 2.
# Автоматическая ARIMA

library(tidyverse) # обработка данных
library(fpp3) # куча плюшек для рядов
library(rio) # импорт данных

m = import('marriages.csv')
glimpse(m)

m2 = mutate(m, date = yearmonth(date))
glimpse(m2)

marriages = as_tsibble(m2, index = date,
                       key = c('code', 'name'))
marriages

marr_rf = filter(marriages, code == 643)

gg_tsdisplay(marr_rf, total,
      lag_max = 30, plot_type = 'partial')

tail(marr_rf)

train = filter(marr_rf, date < ymd('2019-10-01'))
tail(train)

models = model(train,
    naive = SNAIVE(total),
    theta = THETA(total),
    auto = ARIMA(total),
    sarima111_x11 = ARIMA(total ~ 0 + pdq(1, 1, 1) +
                            PDQ(0:1, 1, 1)))
report(models$auto[[1]])

report(models$sarima111_x11[[1]])

fcst = forecast(models, h = '2 years')
accuracy(fcst, marr_rf)


marr_slide = slide_tsibble(marr_rf,
    .size = 60, .step = 4)
marr_slide



models_slide = model(marr_slide,
               naive = SNAIVE(total),
               theta = THETA(total),
               auto = ARIMA(total))
mod_aggr = mutate(models_slide,
                average3 = (auto + naive + theta) / 3,
                auto_theta = (auto + theta) / 2,
                naive_theta = (naive + theta) / 2)


fcst_slide = forecast(mod_aggr, h = 1)

accuracy(fcst_slide, marr_rf)

