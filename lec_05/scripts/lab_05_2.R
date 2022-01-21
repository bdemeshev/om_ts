# Esli russkie bukvi prevratilitis v krakozyabry, to...
# File - Reopen with encoding... - UTF-8 - Set as default - OK

# Временные ряды. Неделя 5. Скрипт 2.
# MA, AR, ARMA процессы: оценка и прогнозы

library(tidyverse) # обработка данных
library(fpp3) # куча плюшек для рядов
library(rio) # импорт данных

m = import('marriages.csv')
glimpse(m)

m2 = mutate(m, date_round = floor_date(date, unit = 'year'),
            year = year(date_round))
glimpse(m2)

m3 = select(m2, -date, -date_round)
m_agg = group_by(m3, code, name, year) %>%
    summarise(sum = sum(total),
              max = max(total),
              .groups = 'keep')
glimpse(m_agg)


rfy = filter(m_agg, code == 643)

rfy = as_tsibble(rfy, index = year)

gg_tsdisplay(rfy, sum, plot_type = 'partial')


train = filter(rfy, year < 2018)

models = model(train,
             ar1 = ARIMA(sum ~ pdq(1, 0, 0)),
             ma1 = ARIMA(sum ~ pdq(0, 0, 1)),
             naive = NAIVE(sum),
             arma11 = ARIMA(sum ~ pdq(1, 0, 1)))

models
report(models$ar1[[1]])

nrow(train)
nrow(rfy)

fcst = forecast(models, h = 4)


accuracy(fcst, rfy)


