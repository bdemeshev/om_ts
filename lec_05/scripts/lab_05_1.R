# Esli russkie bukvi prevratilitis v krakozyabry, to...
# File - Reopen with encoding... - UTF-8 - Set as default - OK

# Временные ряды. Неделя 5. Скрипт 1.
# AR процессы

library(tidyverse) # обработка данных
library(fpp3) # куча плюшек для рядов
library(rio) # импорт данных

set.seed(777)
data = tibble(a = arima.sim(n = 100,
                    model = list(ar = 0.5)),
              b = arima.sim(n = 100,
                    model = list(ar = 0.9)),
      c = cumsum(rnorm(n = 100, mean = 0, sd = 1)))

data$year = 2001:2100
data = as_tsibble(data, index = year)

gg_tsdisplay(data, a, plot_type = 'partial')

gg_tsdisplay(data, b, plot_type = 'partial')

gg_tsdisplay(data, c, plot_type = 'partial')


train = filter(data, year < 2081)

mod_b = model(train, ar1 = ARIMA(b ~ pdq(1, 0, 0)),
              ma1 = ARIMA(b ~ pdq(0, 0, 1)),
              naive = NAIVE(b))

mod_c = model(train, ar1 = ARIMA(c ~ pdq(1, 0, 0)),
              ma1 = ARIMA(c ~ pdq(0, 0, 1)),
              naive = NAIVE(c))


fcst_b = forecast(mod_b, h = 20)
fcst_c = forecast(mod_c, h = 20)

autoplot(fcst_b, filter(data, year > 2050))

autoplot(fcst_c, filter(data, year > 2050))



