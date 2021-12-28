# Esli russkie bukvi prevratilitis v krakozyabry, to...
# File - Reopen with encoding... - UTF-8 - Set as default - OK

# Временные ряды. Неделя 4. Скрипт 2.
# MA процессы: оценка и прогнозы

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


rf = filter(marriages, code == 643)
gg_tsdisplay(rf, total)


rf_train = filter(rf, date < ymd('2019-09-01'))
tail(rf_train)
tail(rf)



mods = model(rf_train,
    snaive = SNAIVE(total),
    theta = THETA(total),
    ma12 = ARIMA(total ~ 1 + pdq(0, 0, 12) + PDQ(0, 0, 0)),
    stl_ma = decomposition_model(STL(total ~ season(window = Inf)),
        ARIMA(season_adjust ~ 1 + pdq(0, 0, 1:5) + PDQ(0, 0, 0)),
        SNAIVE(season_year)))

mods

report(mods$ma12[[1]])
report(mods$stl_ma[[1]])


fcst = forecast(mods, h = '2 year')
accuracy(fcst, rf)
